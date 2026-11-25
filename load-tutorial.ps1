<#
.SYNOPSIS
    Downloads a DataBank IMX training repository and starts its setup.

.DESCRIPTION
    Identical for every training repository. It needs the repository URL, and takes an optional branch:

      1. Git, installed with winget when it's missing. Git can't be skipped.
      2. The repository, cloned into <BaseDirectory>\<repository name>. An existing clone is reused.

    Then it runs the clone's setup.ps1 with the same base directory, and that script does the rest.

    setup.ps1 contains the same steps, so it also works when it is downloaded on its own. In a clone, it
    skips these steps, because setup.json is next to it.

    Works in Windows PowerShell 5.1 and PowerShell 7.

.PARAMETER RepoUrl
    The repository to download, for example https://github.com/databankimx/training-python.git

.PARAMETER BaseDirectory
    Folder for the repositories and the logs. Default: C:\Development\training. Created when missing.

.PARAMETER Branch
    Optional. The branch to download and set up, for example dev. Without it, the repository's default
    branch is used, and setup.json's "branch" setting applies as usual.

.EXAMPLE
    .\load-tutorial.ps1 -RepoUrl https://github.com/databankimx/training-python.git

.EXAMPLE
    .\load-tutorial.ps1 -RepoUrl https://github.com/databankimx/training-markdown.git -Branch dev
#>
param(
    [Parameter(Mandatory = $true)]
    [string]$RepoUrl,
    [string]$BaseDirectory = "C:\Development\training",
    [string]$Branch = ""
)

$ErrorActionPreference = "Continue"
$WingetFallback = "winget isn't available on this computer. Install 'App Installer' from the Microsoft Store (or follow the winget setup steps in QUICKSTART.md of the tutorial), then run this script again. QUICKSTART.md also lists manual setup options."

# Finds a working PowerShell 7. A winget install can land in the user profile (a WindowsApps alias) or in
# Program Files, so every PATH entry is tried, then Program Files. The version property isn't used: the
# WindowsApps alias reports 0.0.0.0. Each candidate must run and print a version.
function Find-Pwsh {
    $candidates = @()
    foreach ($command in @(Get-Command pwsh -All -ErrorAction SilentlyContinue)) {
        if ($command.Source) { $candidates += $command.Source }
    }
    $candidates += "$env:ProgramFiles\PowerShell\7\pwsh.exe"
    foreach ($candidate in $candidates) {
        if (-not (Test-Path -LiteralPath $candidate)) { continue }
        try {
            $version = & $candidate -NoProfile -Command '$PSVersionTable.PSVersion.ToString()' 2>$null
            if ($LASTEXITCODE -eq 0 -and (($version -join "") -match '^\d+\.\d+')) { return $candidate }
        } catch {
            # Try the next candidate.
        }
    }
    return $null
}

function Update-SessionPath {
    $machine = [Environment]::GetEnvironmentVariable("Path", "Machine")
    $user = [Environment]::GetEnvironmentVariable("Path", "User")
    $env:Path = "$machine;$user"
}

function Write-Step([string]$Text) {
    Write-Host ""
    Write-Host $Text -ForegroundColor Yellow
}

function Get-RepoName([string]$Url) {
    $last = ($Url.TrimEnd('/') -split '/')[-1]
    return ($last -replace '\.git$', '')
}

$base = [System.IO.Path]::GetFullPath($BaseDirectory)
New-Item -ItemType Directory -Force -Path $base | Out-Null

# 1. Git
Write-Step "1. Git"
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Update-SessionPath
}
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
        Write-Host $WingetFallback -ForegroundColor Red
        exit 1
    }
    Write-Host "   Git is missing: installing it with winget."
    & winget install -e --id Git.Git --silent --accept-package-agreements --accept-source-agreements
    $code = $LASTEXITCODE
    Update-SessionPath
    if (@(0, 3010, -1978335189) -notcontains $code) {
        Write-Host "winget couldn't install Git (exit code $code). Install Git by hand from git-scm.com, then run this script again." -ForegroundColor Red
        exit 1
    }
}
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "Git was installed, but git.exe can't be found yet. Open a new PowerShell window and run this script again." -ForegroundColor Red
    exit 1
}
Write-Host ("   " + (& git --version))

# 2. Repository
Write-Step "2. Repository"
$target = Join-Path $base (Get-RepoName $RepoUrl)
if (Test-Path -LiteralPath (Join-Path $target ".git")) {
    Write-Host "   Already cloned at $target. Using that copy."
    if ($Branch) {
        $current = (& git -C $target rev-parse --abbrev-ref HEAD 2>$null | Out-String).Trim()
        if ($current -ne $Branch) {
            $changes = (& git -C $target status --porcelain 2>$null | Out-String).Trim()
            if ($changes) {
                Write-Host "   The clone is on '$current' and has uncommitted changes, so it wasn't switched to '$Branch'. Commit or stash them, then run this script again." -ForegroundColor Red
                exit 1
            }
            & git -C $target checkout $Branch 2>&1 | Out-Null
            if ($LASTEXITCODE -ne 0) {
                & git -C $target checkout -t ("origin/" + $Branch) 2>&1 | Out-Null
            }
            if ($LASTEXITCODE -ne 0) {
                Write-Host "   Couldn't switch the clone to '$Branch'. Check that the branch exists on origin." -ForegroundColor Red
                exit 1
            }
            Write-Host "   Switched the clone to '$Branch'."
        }
    }
} else {
    $cloneArgs = @()
    if ($Branch) { $cloneArgs += @("-b", $Branch) }
    Write-Host "   Cloning $RepoUrl into $target"
    & git clone @cloneArgs $RepoUrl $target
    if ($LASTEXITCODE -ne 0) {
        Write-Host "git clone failed (exit code $LASTEXITCODE). Check the address, your access to the repository, and the branch name." -ForegroundColor Red
        exit 1
    }
}

# 3. Hand off to the repository's own setup
Write-Step "3. Setup"
$child = Join-Path $target "setup.ps1"
if (-not (Test-Path -LiteralPath $child)) {
    Write-Host "The repository has no setup.ps1 at $child." -ForegroundColor Red
    exit 1
}
$shell = Find-Pwsh
if (-not $shell) { $shell = "powershell.exe" }
& $shell -NoProfile -ExecutionPolicy Bypass -File $child -BaseDirectory $base
exit $LASTEXITCODE
