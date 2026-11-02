# Preliminary application architecture (subject to team agreement)

Mobile client (Flutter) → authenticated backend (Firebase proposed) → database and image storage. Security rules enforce student/vendor/admin access. Backend transactions ensure a listing cannot be over-claimed. Cloud Functions (or equivalent) issue notifications and aggregate verified collection results. An optional model suggests food categories from vendor images, but vendors must confirm categories, mass and suitability.

## Suggested records
Users: uid, role, approvedVendor, campusArea, preferences.
Listings: vendorId, category, description, allergens, stock, reserved, collected, massPerPortion, location, pickupStart/end, state, timestamps.
Claims: userId, listingId, portions, tokenHash, status, expiry, collectedAt.
ImpactLedger: claimId, verifiedMass, category, factorVersion, indicativeMetric, timestamp.

Personal information and collection tokens must not be publicly queryable. The admin dashboard queries access-controlled aggregate data.
