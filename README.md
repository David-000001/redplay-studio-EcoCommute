# UM FoodLoop 🌱
**RedPlay Studio | WIA2007 Mobile Application Development | Universiti Malaya | Semester 1, 2026/2027**

> **Status: Kickoff completed (reported by group leader on 2 Nov 2026).** The leader reports that the lecturer approved **SDG 13, Target 13.3** and that member roles were accepted. Approval correspondence and actual meeting minutes have not yet been attached to this repository. This does not establish UM institutional support or vendor participation.

## Start here

**Teammates: read the [team handoff guide](docs/team-handoff.md)** for local setup without a Firebase account, sample logins, your issues and the PR workflow. See the [delivery plan](docs/delivery-plan.md) for integration and submission checkpoints.

## Vision
A mobile-first campus marketplace helping participating UM cafeteria vendors and event organizers offer **safe, eligible unsold surplus food** for student collection, while explaining the climate consequences of food waste and supporting institutional sustainability reporting.

## Core flow
Vendor submits eligible surplus food listing → student browses → student claims a portion → vendor verifies pickup → completed collection updates food recovery and indicative climate impact dashboards.

## Proposed modules (5 × 3 functional requirements)
1. **Authentication and roles:** sign in; vendor approval request; profile and notification management. Admin access is provisioned, **not** self-registered.
2. **Surplus listings:** create with photo, food details, allergens, portion quantity, weight and pickup window; edit/withdraw; auto-expire.
3. **Browse, claim and collect:** filter active listings; claim available portions atomically and receive a pickup code; vendor verifies collection before impact credit.
4. **Climate awareness and measurement:** compute transparent indicative emissions-associated metric; show per-user recovered portions; provide short climate education with source/method notes.
5. **Notifications and admin reporting:** opt-in listing/pickup alerts; authorized impact dashboard by campus area/date; export anonymized aggregate CSV.

## Safety and evidence principles
- Food safety is never inferred from a photograph or guaranteed by AI. Vendors must attest suitability, handling and time limits.
- Avoid overclaiming **CO₂e avoided**. A food-weight × emission-factor estimate is an *indicative emissions-associated figure*, not automatically verified avoided emissions.
- No personal or student ID numbers in this public repository. Keep participant surveys and personal data private.
- Real UM stakeholder interviews, photos, and any claimed environmental outcomes must be documented rather than invented.

## Current stack
Flutter/Dart Android app with Firebase Authentication and Firestore. Storage and Cloud Functions remain proposed for the assigned feature workstreams. The code baseline does not establish a recorded team/lecturer stack decision.

## Dates
- Week 1 kickoff: **2–8 Nov 2026**
- Video (10–15 min): **3 Jan 2027 at 12:00 PM**
- Report (maximum 15 pages and 2,500 words): **10 Jan 2027 at 12:00 PM**

## Team
RedPlay Studio, Tutorial Group 9; group leader: **Avijit Chandra Dey**. The group leader reports that the listed workstream responsibilities were confirmed at kickoff; collaborator GitHub usernames are still needed to make account assignments. See [team roles](docs/team-roles.md).

## Authentication (Issue #9)
- Firebase student account registration, sign-in/sign-out and password reset have been implemented in source code.
- Vendor approval requests and admin approval UI are backed by restrictive Firestore rules.
- A debug-only local emulator mode lets the team develop without a cloud project; see the handoff guide.
- Live development backend `um-foodloop` is configured and verified; see [live Firebase evidence](docs/live-firebase-verification.md). Obtain the ignored local configuration from Avijit. With neither local mode nor cloud configuration, the app still fails closed. Credentials are not in this repository.
- [Firebase provisioning and deployment guide](docs/firebase-setup.md) · [Firestore rules](firestore.rules) · [Security tests](security/tests/roles.test.cjs)

## Project documentation
- [Project charter](docs/project-charter.md)
- [Requirements](docs/requirements.md)
- [SDG 13.3 and climate measurement](docs/climate-methodology.md)
- [Design and architecture](docs/architecture.md)
- [Verification plan](docs/testing-plan.md)
- [Stakeholder research](docs/stakeholder-validation.md)
- [AI usage log template](docs/ai-usage-log.md)
- [Contribution policy](CONTRIBUTING.md)
- [Kanban workflow](docs/project-board.md)

**Academic integrity:** AI may assist brainstorming and code refinement, but each member must understand, test, attribute and log AI-assisted work in line with the WIA2007 brief.
