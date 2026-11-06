# AI usage log (complete this throughout the project)

| Date | Tool/model | Prompt/query summary | Output used | Human changes/verification | Member |
|---|---|---|---|---|---|
| 2026-11-02 | ChatGPT | Brainstorm project setup, initial requirements and SDG 13.3 documentation | Initial documentation drafts | Pending group review, source verification and refinement | Project lead |
| 2026-11-02 | ChatGPT | Implement my group-leader Issue #9: Flutter Firebase email/password authentication, student/vendor/admin permission flow, security rules and test automation | Auth repository, UI, Firestore rules, Node emulator tests, Firebase setup guide and CI drafts | Automated Flutter and Firestore emulator tests on GitHub; review Firebase project integration and independently inspect each generated component before submission | Avijit (leader-owned workstream) |

Keep the accurate original prompts/queries where required by the WIA2007 instructions, and document testing and independent human modifications. Never submit generated work unreviewed.

## 4 November 2026 handoff work
- Tool: Codex. Exact user request: "so your job is  to complete all the task needed as a group leader Avijit chandra dey , so i can send the repo to others and let them finish their job ."
- User clarification: no Firebase project ID or teammate GitHub usernames available.
- AI-assisted output: debug emulator bootstrap, synthetic account seeder, Android auth integration coverage, CI improvements, architecture/handoff/delivery documentation.
- Verification: see the handoff PR and CI runs for actual automated results. Human review by Avijit and the relevant owners is still pending; no human testing or understanding is claimed on their behalf.
- Human follow-up: read/explain the generated changes, run the documented flow, record corrections and actual individual time.

## 6 November 2026 issue 24
- Tool: Codex with Firebase CLI, Admin SDK and client SDK. User request: "do this yourself: #24 ? Finish Live Firebase Setup"; user then authorized continuation, completed Google sign-in, and selected "Singapore (asia-southeast1), near UM".
- Work: inspected existing project/app configuration, created the default database, deployed existing repository rules, provisioned the owner administrator and ran live authentication/authorization tests with temporary users.
- Automated verification: nine check groups passed; temporary test data cleaned up. See `live-firebase-verification.md`. Android UI against live cloud and external reset-mail delivery were not tested.
- Human action observed: account sign-in approval and region selection. Independent human code review and other team contributions are not claimed.


## 7 November 2026 — Java/XML migration
Tool: Codex. User request: modify FoodLoop to Java/XML in Android Studio to match the supplied practical review. AI ported leader-owned Firebase account and role flows, XML screens/navigation, Gradle setup, tests/CI and handoff documentation. Existing deployed rules and cloud accounts were preserved. Official Android/Firebase setup and Maven versions were consulted. Test results belong to the migration PR/CI; no human code review, lecturer language mandate, stakeholder study or cloud Android UI run is fabricated. Each member must understand, verify and explain any reused code.
