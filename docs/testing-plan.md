# UM EcoCommute verification

| Scenario | Expected evidence |
|---|---|
| Account access | Registration, sign-in, recovery and sign-out, with student/admin boundaries |
| Trip lifecycle | Valid trip persists; invalid distance rejected; retries create one trip; edits and deletion update history |
| Two students | Each can access only their own journeys and learning progress |
| Calculation | Known fixture distance × factor matches expected result; missing factor remains unknown |
| Comparisons | Alternatives use equal distances and compatible units; weekly totals match displayed trips |
| Learning | Quiz scoring and repeat attempts are consistent; challenges show recorded progress |
| Reporting | Students denied; small groups suppressed; export contains no identifiers or routes |
| Performance | Measure the workload in NFR-01 and report observed percentiles |

Trace FR-01–15 to actual results. Keep emulator evidence distinct from live deployment evidence.
