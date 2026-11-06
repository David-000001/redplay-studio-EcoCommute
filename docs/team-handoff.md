# Team handoff

Updated 7 November 2026 for RedPlay Studio. Start here before implementing a module.

## What is ready
Native Java/XML Android app, shared theme and navigation, email/password authentication, student profiles, vendor approval requests, administrator approval, role rules and automated tests. Local Firebase development is available without a cloud account. Listings, browsing, reservations, climate features and notifications are still assigned work, not completed features.

## First run
Follow [native Android setup](mobile-setup.md). Open `android/` in Android Studio; choose **localDebug**, start and seed the Firebase emulators, then run on an Android emulator. No Flutter installation, cloud account or billing setup is needed.

Open Accounts and roles. Local sample accounts all use `FoodLoop-local-2026!`:

| Email | Use |
|---|---|
| student@foodloop.test | Student profile and vendor request |
| pending@foodloop.test | Pending vendor approval |
| vendor@foodloop.test | Approved vendor |
| admin@foodloop.test | Review pending applications |

These synthetic credentials only work locally. Seeding resets those four local profiles; emulator data is temporary by default. Reset links appear in its terminal. For cloudDebug obtain `google-services.json` from Avijit; create your own account and do not share the leader's administrator login.

## Your work
Issue numbers below link to the existing backlog; do not create duplicate tasks.

| Member | Start here | Implementation boundary | Evidence to return |
|---|---|---|---|
| Maliha Chowdhury | [#3](https://github.com/David-000001/redplay-studio-foodloop/issues/3), [#5](https://github.com/David-000001/redplay-studio-foodloop/issues/5), [#11](https://github.com/David-000001/redplay-studio-foodloop/issues/11) | Student research, browse/list detail/filter UX in Java package `features.browse` and XML layouts; coordinate claim action with Riptanto | Anonymized findings, screens, empty/error/expired-state tests |
| HAN YUNUO | [#4](https://github.com/David-000001/redplay-studio-foodloop/issues/4), [#6](https://github.com/David-000001/redplay-studio-foodloop/issues/6), [#10](https://github.com/David-000001/redplay-studio-foodloop/issues/10) | Vendor research, verification details and listing CRUD in Java package `features.listings` and XML layouts | Posting/editing validation, ownership tests, screenshots; schema agreed with Zhou |
| ZHOU RUILIN | [#7](https://github.com/David-000001/redplay-studio-foodloop/issues/7), [#18](https://github.com/David-000001/redplay-studio-foodloop/issues/18) | Schema, Firestore rules, indexes and trusted backend; transaction contract with Riptanto | Versioned schema, permission tests and repeatable concurrency evidence |
| Riptanto Athaillah Zacky Putra | [#12](https://github.com/David-000001/redplay-studio-foodloop/issues/12), [#13](https://github.com/David-000001/redplay-studio-foodloop/issues/13) | Claim and pickup UI in Java package `features.claims` and XML layouts; atomic backend with Zhou | No overbooking, retry-safe pickup, expiry/cancellation and token privacy tests |
| Rasha Kultsum Mahdiyah | [#14](https://github.com/David-000001/redplay-studio-foodloop/issues/14), [#15](https://github.com/David-000001/redplay-studio-foodloop/issues/15), [#16](https://github.com/David-000001/redplay-studio-foodloop/issues/16), [#19](https://github.com/David-000001/redplay-studio-foodloop/issues/19) | Climate awareness, notification preferences, aggregate reporting and test coordination in Java packages `features.impact` and `features.notifications`, with XML layouts | Sources, opt-in tests, anonymized export, measured performance/usability results |
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
Run Android build, unit tests and lint using [these commands](mobile-setup.md), plus the security suite for backend changes. Run relevant Android instrumentation tests and attach screenshots. Java sources belong under `android/app/src/main/java/com/example/um_foodloop/`; layouts belong under `android/app/src/main/res/layout/`.

Acceptance: relevant FR IDs implemented; loading/empty/error states handled; test evidence attached; no private data or credentials committed; AI assistance recorded and understood. Green CI alone does not mean the whole feature is accepted. Do not use the retired Dart folders; the last Flutter version remains in Git history at `cea7f8a`.

## Integration sequence
1. Zhou publishes schema and callable/transaction contracts (#7); others can build UI with test repositories meanwhile.
2. HAN delivers valid vendor listings; Maliha reads them using the agreed query contract.
3. Riptanto and Zhou implement atomic reservation and exactly-once collection.
4. Rasha consumes verified collection data for metrics and reporting; notifications require a separate backend implementation.
5. Avijit merges reviewed slices and runs the complete vendor ? student ? pickup ? impact scenario.

See [architecture and contracts](architecture.md), [delivery plan](delivery-plan.md) and [leader status](leader-progress.md).
