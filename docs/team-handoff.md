# Team handoff

Prepared 4 November 2026 for RedPlay Studio. Start here before implementing a module.

## What is ready
Flutter Android app, shared theme and navigation, email/password authentication, student profiles, vendor approval requests, administrator approval, role rules and automated tests. Local Firebase development is available without a cloud account. Listings, browsing, reservations, climate features and notifications are still assigned work, not completed features.

## First run without a Firebase account
Install Flutter 3.47.9 (the CI baseline), Android Studio with an Android emulator, Node.js 22 and JDK 21. Run `flutter doctor` and resolve Android toolchain errors. Use an Android emulator for the commands below; physical-phone setup is not assumed.

From the repository root:
```sh
git clone https://github.com/David-000001/redplay-studio-foodloop.git
cd redplay-studio-foodloop
flutter pub get
npm install --prefix security
npm --prefix security run emulators
```
Leave that terminal open. In a second terminal at the repository root:
```sh
npm --prefix security run seed
flutter devices
flutter run --dart-define=USE_FIREBASE_EMULATORS=true
```
Choose the Android emulator if prompted. The app reaches the host computer through `10.0.2.2`. Firebase emulators bind only to localhost. No Firebase login, billing account or cloud project is required. Stop the app completely before changing between local and cloud modes.

Open Authentication & Roles. All sample accounts use `FoodLoop-local-2026!`:

| Email | Role / use |
|---|---|
| student@foodloop.test | Request vendor approval |
| pending@foodloop.test | Already awaiting approval |
| vendor@foodloop.test | Approved vendor |
| admin@foodloop.test | Review pending applications |

These are synthetic local accounts, not real users. Seeding resets these four profiles and passwords; it does not delete other local users. Emulator data is temporary by default. Never use these accounts/passwords in a cloud project. Reset email links appear in the emulator terminal rather than being delivered.

For a UI-only run, `flutter run` shows the deliberate unconfigured-auth state. For actual cloud accounts see [Firebase setup](firebase-setup.md) and issue #24.

## Your work
Issue numbers below link to the existing backlog; do not create duplicate tasks.

| Member | Start here | Implementation boundary | Evidence to return |
|---|---|---|---|
| Maliha Chowdhury | [#3](https://github.com/David-000001/redplay-studio-foodloop/issues/3), [#5](https://github.com/David-000001/redplay-studio-foodloop/issues/5), [#11](https://github.com/David-000001/redplay-studio-foodloop/issues/11) | Student research, browse/list detail/filter UX in `lib/src/features/browse/`; coordinate claim action with Riptanto | Anonymized findings, screens, empty/error/expired-state tests |
| HAN YUNUO | [#4](https://github.com/David-000001/redplay-studio-foodloop/issues/4), [#6](https://github.com/David-000001/redplay-studio-foodloop/issues/6), [#10](https://github.com/David-000001/redplay-studio-foodloop/issues/10) | Vendor research, verification details and listing CRUD in `lib/src/features/listings/` | Posting/editing validation, ownership tests, screenshots; schema agreed with Zhou |
| ZHOU RUILIN | [#7](https://github.com/David-000001/redplay-studio-foodloop/issues/7), [#18](https://github.com/David-000001/redplay-studio-foodloop/issues/18) | Schema, Firestore rules, indexes and trusted backend; transaction contract with Riptanto | Versioned schema, permission tests and repeatable concurrency evidence |
| Riptanto Athaillah Zacky Putra | [#12](https://github.com/David-000001/redplay-studio-foodloop/issues/12), [#13](https://github.com/David-000001/redplay-studio-foodloop/issues/13) | Claim and pickup UI in `lib/src/features/claims/`; atomic backend with Zhou | No overbooking, retry-safe pickup, expiry/cancellation and token privacy tests |
| Rasha Kultsum Mahdiyah | [#14](https://github.com/David-000001/redplay-studio-foodloop/issues/14), [#15](https://github.com/David-000001/redplay-studio-foodloop/issues/15), [#16](https://github.com/David-000001/redplay-studio-foodloop/issues/16), [#19](https://github.com/David-000001/redplay-studio-foodloop/issues/19) | Climate awareness, notification preferences, aggregate reporting and test coordination in `lib/src/features/impact/` and `notifications/` | Sources, opt-in tests, anonymized export, measured performance/usability results |
| Avijit Chandra Dey | [#24](https://github.com/David-000001/redplay-studio-foodloop/issues/24), [#20](https://github.com/David-000001/redplay-studio-foodloop/issues/20), [#22](https://github.com/David-000001/redplay-studio-foodloop/issues/22) | Shared foundation/auth, integration reviews, cloud provisioning, demo/report coordination | Passing integration checks, reviewed PRs and final deliverables after modules exist |

AI classifier #17 is optional stretch work for Zhou after core flows are complete. The current vendor request stores only approval status; HAN owns verification fields and Zhou their access policy. Notification preferences belong to Rasha. No module should assume those fields already exist.

## Branch and review workflow
Your GitHub usernames are not known yet. You can start immediately by forking this public repository and sending a PR, or give Avijit your username so he can invite you as a collaborator. Account invitations are not complete.

```sh
git switch main
git pull --ff-only
git switch -c feat/11-student-browse
```
Use your own issue number and feature name. Implement one small slice, run the checks below, push to your fork or feature branch, then open a PR targeting this repository's `main`. Link the issue, requirements, test evidence and AI log. Avijit reviews shared routes and integration. Zhou reviews schema/security changes. Do not edit another member's feature in the same PR without coordinating.

## Before requesting review
```sh
flutter analyze
flutter test
npm --prefix security run verify
flutter build apk --debug
```
The security verification command starts temporary emulators; stop manually running emulators first to avoid port conflicts. Android integration tests run in GitHub Actions. Its `foodloop-local-development-apk` artifact contains the normal app compiled for local emulators, saved before the test runner replaces build outputs. Tests use synthetic data and do not demonstrate cloud provisioning or real stakeholder validation.

Acceptance: relevant FR IDs implemented; loading/empty/error states handled; tests and screenshots attached; no personal data/credentials in commits; AI usage recorded; source understood by its author. Green CI alone does not mean the whole feature is accepted.

## Integration sequence
1. Zhou publishes schema and callable/transaction contracts (#7); others can build UI with test repositories meanwhile.
2. HAN delivers valid vendor listings; Maliha reads them using the agreed query contract.
3. Riptanto and Zhou implement atomic reservation and exactly-once collection.
4. Rasha consumes verified collection data for metrics and reporting; notifications require a separate backend implementation.
5. Avijit merges reviewed slices and runs the complete vendor ? student ? pickup ? impact scenario.

See [architecture and contracts](architecture.md), [delivery plan](delivery-plan.md) and [leader status](leader-progress.md).
