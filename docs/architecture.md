# Architecture and integration contracts

## Implemented foundation
Native Java + XML Views is the current baseline following the leader's 7 November migration request. Android Studio opens `android/`; Groovy Gradle builds it without Flutter or Kotlin application sources. `MainActivity` hosts fragments in a ConstraintLayout. XML layouts use Material Components; the admin application list uses RecyclerView and View Binding.

`FoodLoopApplication` initializes one Firebase app/repository. `localDebug` uses fixed local emulator endpoints with a separate package and named Firebase app; `cloudDebug` loads ignored `google-services.json` for the existing package. Missing cloud configuration disables account actions. Only local debug permits cleartext. Firestore uses memory caching to avoid retaining profile records on shared development devices.

`AuthRepository` owns Firebase operations; `UserProfile` validates names and computes presentation permissions. `AuthFragment` observes auth/profile changes only while started and removes listeners when stopped. Registration creates only student profiles; failed profile creation attempts Auth rollback and signs out. Firebase rules, never button visibility, grant permissions. Errors and in-progress state are visible; passwords are not persisted in view state.

Feature owners add Java packages under `com.example.um_foodloop.features` and XML layouts under `res/layout`. Reuse the application repository; do not initialize another Firebase instance. Preserve navigation route keys `/auth`, `/listings`, `/claims`, `/climate`, `/reports`; Avijit replaces the explicit `ModuleFragment` extension points as features arrive. Those screens do not claim to implement any food/impact workflow.

## Existing profile contract
Collection: `profiles/{Firebase Auth UID}` (not `users`). Fields: `displayName` (1?80 characters), `role` (`student`, `vendor`, `admin`), `vendorStatus` (`none`, `pending`, `approved`, `rejected`), `createdAt` (server timestamp).

Clients create only their own student profile. They can update their display name or request pending vendor status. Only an existing admin approves a pending student into an approved vendor. Admin status is provisioned with trusted server tools; never selectable in registration. A missing profile grants no privileges. Firebase Auth owns passwords and email; neither belongs in public listing documents.

The current UI implements password recovery, display-name editing and approval requests, but not notification preferences or a verification-details form. Coordinate these with HAN and Rasha; do not mark all of FR-02/FR-03 complete merely because sign-in works.

## Feature contract proposal for Zhou to finalize in #7
The following is a starting contract, not deployed schema or security enforcement.

| Record | Required concepts | Writer |
|---|---|---|
| listings | vendorId, food details/allergens, massPerPortionGrams, available/reserved/collected portions, campusArea, pickupStart/end, state, timestamps | Approved owner; protected counters through trusted transactions |
| claims | listingId, studentId, portions, status, expiry, collectedAt | Transaction service; participant-scoped reads |
| collection tokens | Random token/hash and attempt/expiry controls, isolated from browse records | Trusted backend, never public listing reads |
| impact ledger | Unique claimId, verified mass, factor/version/source, indicative metric | Exactly-once collection transaction/backend |
| preferences | Area subscriptions and notification consent, private device tokens | Owner with validated updates |
| aggregates | Area/date counts and qualified metrics, no personal identities | Trusted backend; authorized reporting |

Use server timestamps and UTC storage, displaying Asia/Kuala_Lumpur campus time. Define units explicitly: integer portions and grams. A claim must atomically verify active pickup window and remaining stock. Retry with an idempotency key; collection must change state and credit metrics once. Define cancellation/expiry stock release before implementing claims.

Maliha's browse query must agree with the published rules and indexes; client filtering is not an authorization control. HAN must not change quantities below already reserved amounts. Rasha must read verified ledger/aggregate results, not compute authoritative credits on the phone.

## Current security boundary
Existing rules protect profiles and gate listing creation by approved vendor ownership. Listing field validation is NOT complete; any signed-in user can currently read listing documents. Listing updates/deletes and all claims/impact paths are denied. Therefore use synthetic data only until Zhou completes #7/#18. Never put private vendor or student details into listings.

## Required integration evidence
A single reproducible scenario must register a student, request/approve a vendor, publish an eligible listing, browse, claim concurrently without overselling, verify pickup once, and show one aggregate increment. Owner tests each slice; Avijit reviews the integrated scenario. Only auth/role pieces exist at this handoff.
