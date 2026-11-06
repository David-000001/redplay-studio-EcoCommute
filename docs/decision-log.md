# Project decision log
| Ref | Proposal | Status |
|---|---|---|
| D-01 | SDG 13.3 primary; 12.3 secondary | Lecturer approved, **as reported by leader on 2 Nov 2026**; approval correspondence not attached |
| D-02 | App named UM FoodLoop | Provisional |
| D-03 | Java + XML for Android | Leader requested migration on 7 Nov; replaces the provisional Flutter scaffold |
| D-04 | Firebase Authentication/Firestore/Storage | Auth and Firestore provisioned and verified 6 Nov; Storage remains proposed |
| D-05 | Climate footprint is indicative, not verified avoided emissions | Proposed methodology |
| D-06 | Six-member workstream ownership | Confirmed at kickoff **as reported by leader on 2 Nov 2026**; member acceptance record not attached |
| D-07 | Repository visibility | Currently **public**; owner must decide if private |
| D-08 | Kickoff meeting | Completed **as reported by leader on 2 Nov 2026**; actual meeting date/minutes not attached |

The date above is the date of the leader's status report, **not necessarily the decision/meeting date**. Attach the actual lecturer response and approved minutes when available. D-02 through D-05 and D-07 remain open decisions where noted.

## 6 November 2026 live Firebase configuration
The project lead selected Singapore (`asia-southeast1`). The existing app uses the default Firestore database, so Standard/native mode was provisioned to preserve that contract. The project remains on its existing free plan. The administrator belongs to the project lead; credentials remain private. Live backend tests and their limits are recorded in `live-firebase-verification.md`.


## 7 November 2026 — Java and XML Views
The leader requested migration from Flutter to Java/XML in Android Studio based on the supplied practical review. This is a course-aligned choice, not a claim Java is compulsory. Preserve project um-foodloop and profiles contract. Historical Flutter implementation remains at cea7f8a; active development and CI now use native Android.
