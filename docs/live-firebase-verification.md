# Live Firebase verification

> Historical record of the earlier FoodLoop project. For current EcoCommute assignments and acceptance criteria, use the [team handoff](team-handoff.md) and [requirements](requirements.md).

Completed 6 November 2026 for issue #24. These results concern the live development backend, not the local emulators.

## Provisioned resources
- Project: `um-foodloop`; project owner for this team: Avijit Chandra Dey.
- Android package: `com.example.um_foodloop`.
- Android Firebase app: `1:150828310212:android:916bd5ee22a57ad8ba3391`.
- Firestore database: `(default)`, Standard edition, native mode, Singapore (`asia-southeast1`). Region chosen by the project lead. Standard matches the existing default-database app configuration.
- Database creation returned `freeTier: true`; no billing upgrade was performed.
- Email/password sign-in works against the live Auth service.
- Repository `firestore.rules` compiled and was released to the live project by the authenticated Firebase CLI.
- The leader's app administrator was provisioned through the trusted Firebase Admin SDK. Its password sign-in and live admin profile were verified. Private account details are held locally by the leader, not in this public repository.
- `firebase.local.json` was recovered, checked against the registered Android app, placed in the working checkout and verified as Git-ignored.

## Tests performed
All nine check groups passed. The [machine-readable evidence](evidence/firebase-live-2026-11-06.json) records timestamps, source commit, rules digest and cleanup.

1. Provision owner administrator and read the server-granted role.
2. Register a new student through the Firebase client SDK and create the restricted profile with a server timestamp.
3. Update the student's own display name.
4. Deny student-to-admin escalation, reading another profile and unapproved listing creation.
5. Sign out, deny anonymous profile access, then sign in again with the password.
6. Accept a password-reset request; generate a reset link through the Admin SDK, validate/redeem its code and sign in with the new password.
7. Accept a vendor application while denying self-approval.
8. Sign in as a temporary administrator, query pending applications, approve the student as a vendor, permit the vendor's own listing and deny forged ownership.
9. Sign in with the actual owner administrator account and confirm its admin profile through the client SDK.

Tests used the real Firebase JavaScript client SDK against live Auth and Firestore, with the Admin SDK used for provisioning and cleanup. They did not run the Android UI against the live backend. The Android repository/navigation tests previously passed against local emulators in PR #26. Password-reset code redemption was tested; delivery to an external mailbox was not.

## Cleanup and data handling
Both temporary verification accounts and their profiles, plus the temporary listing, were deleted using the trusted Admin SDK. The actual leader administrator remains. No real stakeholder records were used. Passwords, tokens, service-account keys and student identifiers are excluded from the evidence and repository.

Development retention procedure: use synthetic records for testing; remove them after each test. Keep only required team accounts during development. The leader handles account/profile removal requests through trusted administration, and reviews/removes unused development data at project completion. This is a development procedure, not a claim of UM institutional policy or an implemented in-app deletion flow.

## Team use
**Updated for Java/XML on 7 November:** obtain `google-services.json` from Avijit, save it in `android/app/`, open `android/` in Android Studio and select `cloudDebug`. See [native setup](mobile-setup.md). The 6 November verification above remains a historical backend SDK test, not a Java UI test.
Restart fully when switching from local emulator mode. Register your own student account. Vendor access requires an admin's approval. The local sample passwords in the handoff do not apply to cloud accounts. Do not share the leader's admin password with the team.

This completes the cloud setup/authentication scope of #24. Full listing validation, claims, notification delivery, impact reporting and campus-eligibility verification remain separate feature tasks. The current database is for development, not a claim of a finished campus launch.
