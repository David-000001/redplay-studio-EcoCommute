# UM EcoCommute architecture

Native Java/XML Android fragments run in `MainActivity`. Firebase Authentication identifies users. Cloud Firestore currently supports the existing profile infrastructure. Use `localDebug` with emulators for feature work. The live Firebase project and Android application ID remain stable.

## Planned contracts

- `users/{uid}/trips/{tripId}`: trip date, mode, distance in km, factor version and estimate status. Use a stable ID across retries. Only the owner reads and changes personal trips.
- Versioned mode factors carry value, units, transport boundary, source, geography and effective date. Missing factors produce an unavailable estimate.
- Personal quiz and challenge progress is owner-scoped. Provision administrators through the existing trusted process.
- Trusted aggregation publishes only eligible period/mode summaries. Reports must never expose private trip documents to other students or administrators through a broad collection rule.

New mobility collections require tested rules before cloud deployment. Existing profile fields from the earlier implementation may remain for compatibility.
