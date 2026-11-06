# Testing and validation plan

1. Trace FR-01–FR-15 to at least one documented pass/fail test each.
2. Concurrent claims: launch many simultaneous claims for the final portion and verify no overselling.
3. Collection idempotency: repeating a verified scan cannot double-increment recovered portions or climate impact.
4. Permissions: students cannot approve vendors, change other people's listings or read personal claim data; unapproved vendors cannot publish.
5. Listing expiry: ensure expired pickup windows disappear and outstanding claims behave predictably.
6. NFR performance: 100-client load simulation, publish hardware/region/network details, sample size, p95 latency and errors.
7. NFR privacy/security: record rules tests and anonymized export inspection.
8. User study: capture vendor and student feedback, usability observations and optional pre/post climate comprehension scores.
9. AI (if implemented): use held-out, consented UM cafeteria image sample with labeled classes; report per-class errors and manual correction rate.

Backend live results from 6 November and native Android migration CI are recorded separately. All unfinished-feature, performance and user-study findings remain pending until those tests are actually run.
