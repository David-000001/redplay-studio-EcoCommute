# UM EcoCommute requirements

## M1 Accounts and preferences

- FR-01 Register and sign in as a student.
- FR-02 Recover access and edit the display name.
- FR-03 Manage opt-in reminders and sign out.

## M2 Journey logging

- FR-04 Enter trip date, mode and distance in kilometres.
- FR-05 Edit an owned journey and validate a positive finite distance.
- FR-06 Delete an owned journey and handle retries without duplicate records.

## M3 Comparison and personal history

- FR-07 Filter personal trip history by period and mode.
- FR-08 Compare modes at equal distance using versioned factors.
- FR-09 Show personal distance and estimated emissions trends; recompute totals after edits or deletions.

## M4 Climate awareness

- FR-10 Read a sourced lesson connecting mobility choices to climate mitigation.
- FR-11 Take a quiz and view score and answer explanations.
- FR-12 Join a commuting challenge and review personal progress.

## M5 Administration and reporting

- FR-13 Restrict aggregate reporting to provisioned administrators.
- FR-14 Filter anonymized totals by period and transport mode, suppressing small groups.
- FR-15 Export the same permitted aggregates as CSV without identifiers or precise routes.

## Non-functional requirements

- NFR-01 Target 95% of trip-save and history operations within three seconds in a documented 100-concurrent-user workload. Record device, network, dataset and measured results.
- NFR-02 Deny unauthorized access to personal trips, quiz progress and privileged reporting. Verify permissions with two student accounts and an administrator.
