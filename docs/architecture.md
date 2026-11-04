# Architecture and integration contracts

## Implemented foundation
Flutter Android is the current repository baseline, with Firebase Auth and Cloud Firestore. This records the code in use, not an invented team vote. Cloud Functions and Storage remain proposed services for feature owners to implement.

`main.dart` calls `bootstrapAuth()` once. That initializes cloud services only with supplied local configuration, or connects both services to the fixed `demo-foodloop-auth` project in debug emulator mode. `FoodLoopApp` receives one `AuthRepository`; `AppRoutes` passes it to authentication. Feature screens should receive dependencies through constructors using this same pattern, so widget tests can inject fakes.

Do not initialize Firebase separately inside screens. UI roles control presentation; backend authorization remains mandatory. Keep route names `/`, `/auth`, `/listings`, `/claims`, `/climate`, `/reports` stable. Avijit coordinates route integration. Use feature folders described in the handoff; placeholders are explicit unfinished screens.

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
