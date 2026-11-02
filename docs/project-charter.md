# Project Charter — UM FoodLoop (Draft v0.2)

**Team:** RedPlay Studio · Tutorial Group 9 · WIA2007 · Semester 1 2026/2027
**Leader:** Avijit Chandra Dey
**Status:** Proposed; SDG 13.3 and stakeholder access require lecturer/team confirmation.

## Problem and opportunity
Campus vendors may have safe, unsold prepared foods. Whether, where and how much is discarded at UM must be established through field observation and interviews. FoodLoop proposes collection and climate-awareness features to reduce avoidable food disposal and support climate literacy.

## Aim
Prototype, test and demonstrate a UM-relevant mobile app that helps participating vendors list eligible surplus food, enables fair student collection and communicates evidence-qualified climate impact to students and administrators.

## Primary target
**SDG 13, target 13.3:** improve climate education, awareness and institutional capacity. Food-waste reduction aligns secondarily with SDG 12.3; this alone does not prove SDG 13.3 outcomes.

## SMART acceptance criteria
1. Five modules with at least three functional requirements each, traced to tests.
2. Demo full listing → browsing → claim → vendor verification → collection/impact update cycle.
3. Prevent overclaiming through transaction-safe stock handling.
4. Two nonfunctional requirements tested: representative browse/claim performance and role-based data access.
5. Collect documented feedback from UM student and vendor stakeholders where feasible; assess climate-awareness comprehension.
6. Each member contributes code and testing evidence; at least 20 hours of recorded work per person.
7. Produce 10–15-minute demo video and report within 15 pages and 2,500 words, with AI usage log.

## Scope
**In:** Student, vendor, authorized admin roles; approved listings with food safety disclosures, quantity and pickup deadline; browsing/claiming and verification; opt-in notifications; informative climate insights; indicative impact metrics; mobile admin dashboard; aggregate export.

**Out for MVP:** Payments, food delivery, nutritional/food safety certification by AI, production-wide vendor deployment, precise measurement of avoided lifecycle emissions, standalone web portal.

## Assumptions/dependencies
- Lecturer accepts the SDG 13.3 framing.
- Participating vendors can be engaged; no vendor partnership is yet confirmed.
- Stack proposed: Flutter + Firebase, subject to team and lecturer approval.
- Real user data and institution branding handled only with required permissions.

## Roles (proposed, pending confirmation)
Avijit — lead/integration; Maliha — UX/student discovery; HAN YUNUO — vendor flows; ZHOU RUILIN — backend/data; Riptanto — reservation/collection; Rasha — notifications/testing. All members code and test.

## Milestones
Kickoff/approval: Nov 2026; architecture and foundation: 2–15 Nov; core app: 16–29 Nov; integration: 30 Nov–13 Dec; testing and documentation: 14–27 Dec; recorded demo due **3 Jan 2027 12 PM**; final report due **10 Jan 2027 12 PM**.

## Risks and controls
- **SDG fit:** Obtain written lecturer approval and demonstrate climate-literacy outcome.
- **Food safety:** Vendor confirmation and pickup limits; no AI safety assurance.
- **Data privacy:** Minimal personal data, secure permissions and aggregation.
- **Inflated impact claims:** Publish carbon method, data sources and uncertainties.
- **Double claims:** Atomic server transaction and verified pickup.
- **Late integration:** Weekly reviews, pull requests and milestone demos.

## Approval
Draft prepared for team review. Final scope, roles and targets require recorded team agreement and lecturer feedback.
