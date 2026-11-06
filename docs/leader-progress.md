# Leader progress log — Avijit Chandra Dey
## 2 November 2026
- Verified GitHub repository and existing project charter, SDG 13.3 requirements and 21 tasks.
- Assigned issues #1, #2, #8, #9, #20 and #22 to connected account `David-000001` after leader confirmed this is their account.
- Added first-week sprint plan, kickoff agenda, decision log, navigation source scaffold and widget-test template.
- Leader subsequently confirmed that SDG 13.3 lecturer approval, kickoff meeting and team workstream acceptance are done. This is self-reported and does not yet include lecturer correspondence, meeting date or minutes.
- **Issue #8 Flutter foundation verified:** generated and committed `android/`; passed `flutter analyze` and widget tests, built debug APK, installed app on Android emulator, and passed integration navigation test [run #41415696320](https://github.com/David-000001/redplay-studio-foodloop/actions/runs/41415696320). Corrected a duplicate-title assertion after the first emulator test failure.
- Pending: archiving approval and meeting records, other members' GitHub usernames, backend provisioning and food workflow implementation (authentication was subsequently merged in #23).

## Integrity
Do not mark interviews, lecturer approval, tests, code compilation or member contributions complete without actual evidence. Maintain AI usage log and human review of all generated drafts and code.

## 4 November 2026 team handoff
- Prepared per-member issue map, setup commands, sample local accounts, review process and integration dependencies in `team-handoff.md`.
- Added debug-only local Firebase startup, fixed demo project, account seeder, Android repository integration test and display-name editing.
- Fixed release Android internet permission and removed the obsolete bootstrap workflow that wrote directly to main.
- Pinned Flutter 3.47.9, refreshed architecture to match `profiles` and recorded unfinished data/transaction contracts for Zhou.
- Prepared proposed internal checkpoints and report/video coordination in `delivery-plan.md`; no final submission or member work is marked complete.
- Validation evidence is recorded in [PR #26](https://github.com/David-000001/redplay-studio-foodloop/pull/26) and its CI checks.
- User confirmed no Firebase project ID or teammate GitHub usernames are available. #24 remains open; teammates can fork and develop locally meanwhile.
- Remaining leader responsibilities: cloud setup when an account is available, collaborator invitations when usernames arrive, real meeting/approval records, ongoing integration reviews and eventual video/report submission.

## 6 November 2026 live backend
- Recovered the already registered `um-foodloop` project and Android configuration from earlier work; this supersedes the 4 November note that no project ID was available.
- Project lead completed Firebase CLI sign-in and selected Singapore. Created the default Standard Firestore database on the free tier and deployed the current rules.
- Provisioned the owner app administrator with the trusted Admin SDK; verified nine live authentication/authorization check groups and removed all temporary verification users/profiles/listings.
- Private admin sign-in details and mobile config supplied locally; no credentials or student identifiers committed.
- See `live-firebase-verification.md` and its JSON evidence for scope and limitations.


## 7 November — native Android migration
Leader requested Java + XML to match the supplied course practicals. Ported account/role features and module navigation, replaced Flutter build/CI, preserved the existing Firebase project and rules, and updated handoff paths. See [migration scope](java-migration.md). Full feature completion remains dependent on teammate implementations and real testing evidence.
