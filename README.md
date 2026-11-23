# DataBank IMX - Training Shared Resources

## License and Support

This repository is provided under the [MIT License](LICENSE). You are free to use, copy, modify, merge, publish, distribute, sublicense, and/or sell the materials in this repository, subject to the terms of that license.

This repository is provided for training and reference purposes only. DataBank IMX does not provide warranties, guarantees, maintenance, troubleshooting, implementation assistance, or technical support for this code or its use. Use it in any way permitted by the MIT License, but you are responsible for evaluating, adapting, testing, and supporting any use of it in your own environment.

---

## What is this repository for?

*Edit: describe the repository in one or two bullets. Name what it contains and who it serves.*

- Template for new DataBank IMX training repositories: the standard `.github` folder (CODEOWNERS, Dependabot, Copilot instructions, and the SonarQube workflow), plus this README, the `.gitignore`, and the `LICENSE`
- Shared source for the README sections that appear in every training repository
- Contains no lessons or course content

---

## Who is this for?

*Edit: name the people who will read or use this repository, and what they should already know.*

- Developers and DevOps staff who create or maintain DataBank IMX training repositories
- Anyone who needs to change a section that is repeated across the training repositories

---

## About

*Edit: author and purpose. Keep the author line as it is unless the author changes.*

- **Author:** [Scott McLean](mailto:smclean@databankimx.com)
- **Purpose:** Keeps the shared training repository content in one place

---

## DataBank Responsibilities for Custom Code

All DataBank employees - including those working with AI-assisted tools - are bound by the Development Rules of Engagement, published as the [development-rules-of-engagement.pdf](https://databankimx.sharepoint.com/:b:/r/sites/Hub-PS/DevTools/Policies/development-rules-of-engagement.pdf?d=w1c01477e09e048acbe4c96eba851a183&csf=1&web=1&e=uL7JEw). That document defines the rules for quoting, approving, developing, reviewing, scanning, storing, and delivering custom code for client work.

Key obligations that apply to everyone on every custom code engagement:

- **You own the code you deliver.** This applies equally to hand-written code, AI-assisted code, and AI-generated code. "The AI wrote it" is not an acceptable explanation for a production issue, a failed review, a security finding, or a support problem.
- **Code must be reviewed before delivery.** Review is interactive and must confirm that the code works, meets DataBank standards, is maintainable, and that the developer understands it well enough to explain, debug, and maintain it. Polished or well-formatted output - including AI-generated output - is not evidence of correctness.
- **Code must be in source control before delivery.** All custom code must be committed to the appropriate DataBank GitHub Enterprise repository before it is delivered to a client, regardless of whether the client receives source code, compiled binaries, or deployed functionality.
- **CI scanning must pass before delivery.** Required checks are the standards policy scan, SonarQube, and Snyk. A passing local build is not a substitute.
- **All third-party dependencies must be license-vetted.** The license must permit closed-source commercial use. Copyleft or unclear licensing must be escalated before use. Dependencies must not be added simply because an AI tool suggested them.
- **Only approved AI tools may be used.** Use only IT-approved tools through company accounts. All data entered into AI systems is subject to the [DataBank AI Acceptable Use Policy](https://workforcenow.adp.com/mascsr/wfncontenttools/file-management/file/JTJGc3RhdGljJTJGY2xpZW50cyUyRmNvbnRlbnQlMkZBSStBY2NlcHRhYmxlK1VzZStQb2xpY3kucGRmJTNGMTc3MTM0NzA4NjE4MQ==) and must be treated as confidential by default.
- **Custom code is billable work.** Code must be tied to an approved quote or engagement before commitment or delivery. Development quotes require approval from the Development Director or delegated development leadership before being sent externally.
- **Exceptions require explicit approval.** Time pressure alone is not a reason to bypass quote approval, source control, review, or CI scanning.

See the Development Rules of Engagement linked above for the full policy, including billing and quoting rules, source-code delivery rules, the delivery readiness checklist, and the exception process.

> Policy document links point to DataBank internal locations. They may not open for readers outside DataBank IMX.

---

## Setup and requirements

*Edit: list the tools a reader needs and any commands to run. Use PowerShell (`pwsh`) for every command block.*

- Windows 10 or Windows 11
- PowerShell 7 (`pwsh`)

---

## Repository structure

*Edit: show the top-level layout and a one-line description of each folder.*

```
training-shared/
|- .github/                      - Standard .github folder for training repositories
|- .gitignore
|- LICENSE
|- README.md
```

---

## Known conflicts and compatibility notes

*Edit: list platform limits, version constraints, and anything that does not behave as a reader expects. Remove this section only if the repository has nothing to report, and then say so.*

- This repository is written for Windows with PowerShell (`pwsh`). Other platforms are untested.

---

## Authorship note

*Edit: a short first-person note from the author about who made the material and how. Keep the sign-off line.*

This repository holds the pieces that DataBank IMX training repositories share. I used generative AI in places for drafting and cleanup, as with the other training repositories.

~ Scott McLean, 2026

---

## Release version

*Edit: add a row for each release. Date format is MM/DD/YYYY.*

| Date | Changes |
|---|---|
| 11/23/2026 | Initial version: license, README, `.gitignore`, and the standard `.github` folder |

---

## Contact

- [Scott McLean](mailto:smclean@databankimx.com)
- [Dev Team](mailto:development@databankimx.com)
