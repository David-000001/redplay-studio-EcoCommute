# Delivery plan and evidence collection

Working coordination plan prepared 4 November 2026; dates below are proposed internal checkpoints, not recorded team commitments. Official submission dates come from the supplied WIA2007 brief.

| Internal checkpoint | Deliverable | Lead |
|---|---|---|
| 8 Nov | Everyone runs the app; schema draft and anonymized research plan | Avijit / Zhou / Maliha / HAN |
| 22 Nov | Vendor listing and browse vertical slice | HAN / Maliha / Zhou |
| 6 Dec | Atomic claims and pickup verification | Riptanto / Zhou |
| 13 Dec | Climate awareness, aggregates and opt-in notifications | Rasha |
| 20 Dec | Integrated feature freeze and functional/NFR evidence | All; Avijit integrates |
| 27 Dec | Demo rehearsal, report draft and AI log review | All; Avijit coordinates |
| 3 Jan 2027, 12 PM Malaysia time | Submit 10?15 minute video | Avijit |
| 10 Jan 2027, 12 PM Malaysia time | Submit report | Avijit |

## Video plan (13 minutes)
- 0:00?1:30 Avijit: UM problem, SDG 13.3, architecture and authentication.
- 1:30?3:30 HAN: vendor workflow and actual vendor feedback.
- 3:30?5:30 Maliha: student browse UX and actual survey findings.
- 5:30?7:30 Riptanto: reservation and collection.
- 7:30?9:30 Zhou: transactions, security and concurrency evidence.
- 9:30?11:30 Rasha: awareness, notifications, aggregates and test results.
- 11:30?13:00 Avijit: integrated results, limitations and future adoption.

Record real app behavior after implementation. Each person explains their own code. Include two measured NFRs; do not replace measurements with promises. Existing scaffold footage is not the final demonstration.

## Report assembly plan
Maximum 15 pages excluding appendices AND 2,500 words; Times New Roman 12 pt, double spacing except tables. Aim for 2,250 words to leave editing room.

| Section | Word budget | Inputs |
|---|---|---|
| Introduction/problem | 250 | Actual UM evidence, SDG target, scope |
| Requirements | 400 | Study findings; 5 modules ? 3 FRs; 2 NFRs |
| Architecture/design | 300 | Actual final schema, UI and architecture diagram |
| Implementation | 450 | Representative code and screenshots; AI statement |
| Testing/validation | 350 | Test environment, method, results and limitations |
| Impact/limitations | 200 | Qualified impact, privacy and adoption limitations |
| Roles/contributions | 150 | Commit/PR evidence and actual time logs |
| References | 150 | Sources cited consistently; reallocate if required |

Collect source inputs in PRs, not invented prose. Keep raw surveys and identifiable interviews private. Append the accurate AI usage log. Avijit's final report and video tasks remain open until real member contributions and measurements exist.

## Review checklist for Avijit
- Map each PR to FR IDs and the accountable member.
- Check schema changes with Zhou before merging dependent UI.
- Require passing native Android and security checks plus relevant screenshots.
- Re-run integrated Android checks for shared auth/navigation changes.
- Record actual decisions, feedback, tests and human review.
- Archive genuine lecturer approval and kickoff minutes when available.
- Obtain teammate GitHub usernames; forks allow work meanwhile.
- Cloud setup #24 is complete; preserve its evidence and separately verify each new Android feature.
