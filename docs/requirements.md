# Initial requirements register (draft)

Functional requirements are proposed and must be refined after UM stakeholder interviews.

## M1 Authentication and roles
- FR-01 Users shall sign in with appropriately authorized student/vendor/admin access.
- FR-02 Vendors shall submit profile and verification details for authorized approval before posting.
- FR-03 Users shall manage profile, password recovery and opt-in notification settings.

## M2 Listing management
- FR-04 Approved vendors shall post eligible food with photo, food type, allergens, quantity, estimated weight, pickup location and window.
- FR-05 Vendors shall edit or withdraw their own listing, respecting already claimed portions.
- FR-06 The app shall hide expired or sold-out listings from active browsing.

## M3 Browse, claim and collect
- FR-07 Students shall browse/filter active listings by location, availability and food type.
- FR-08 Students shall reserve available portions; the system shall prevent over-allocation and create a unique collection token.
- FR-09 Vendors shall verify collection, update stock and record a completed pickup exactly once.

## M4 Climate education and impact
- FR-10 The app shall display a clearly qualified indicative climate impact metric with method/source notes.
- FR-11 The app shall count verified collected portions and show cumulative student statistics.
- FR-12 Students shall complete source-backed food-waste/climate lessons and a short pre/post assessment; the app shall display the change in correct answers without claiming that this alone proves lasting behaviour change. No assessment results are claimed until measured.

## M5 Alerts and institutional reporting
- FR-13 Students shall opt in to new-listing notifications for selected UM areas (with pickup reminders where supported).
- FR-14 Authorized administrators shall view aggregate food recovery and climate metrics by date and campus area.
- FR-15 Administrators shall export anonymized aggregate CSV reports.

## Non-functional requirements (two)
- NFR-01 Performance: 95% of browse-and-claim operations complete within 3 seconds under a reproducible 100-concurrent-user test workload on the agreed environment (measurement required).
- NFR-02 Privacy/security: a tested role-based access policy must deny cross-role modification of protected resources; no private student data in aggregate reports (security tests required).

## Critical acceptance
No climate-impact credit until vendor-verified collection. CO₂e estimates are not automatically emissions avoided.
