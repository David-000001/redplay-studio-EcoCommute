# UM EcoCommute team handoff

**RedPlay Studio · WIA2007 · Tutorial Group 9**  
**Lead:** Avijit Chandra Dey

Start with [Android Studio setup](mobile-setup.md). Clone [the repository](https://github.com/David-000001/redplay-studio-EcoCommute), open the `android/` folder in Android Studio, and select `localDebug`. From the repository root run `npm install --prefix security`, then `npm --prefix security run emulators`. In another terminal run `npm --prefix security run seed`. Launch the app on an Android emulator. Sign in with the local fixture `student@foodloop.test` and password `FoodLoop-local-2026!`. The account and navigation screens are the starting point. The mobility screens are ready for assigned feature work.

## First assignments

| Member | Start here | First result for the team |
|---|---|---|
| Maliha Chowdhury | [#3 commuter research](https://github.com/David-000001/redplay-studio-EcoCommute/issues/3) and [#5 history UX](https://github.com/David-000001/redplay-studio-EcoCommute/issues/5) | Draft the commuter questions and history/filter wireframe. Use Zhou’s trip fields for [#11](https://github.com/David-000001/redplay-studio-EcoCommute/issues/11). |
| HAN YUNUO | [#6 journey form](https://github.com/David-000001/redplay-studio-EcoCommute/issues/6) | Sketch date, mode and distance entry with validation. Coordinate with Zhou before implementing [#10](https://github.com/David-000001/redplay-studio-EcoCommute/issues/10). Run mobility interviews under [#4](https://github.com/David-000001/redplay-studio-EcoCommute/issues/4). |
| ZHOU RUILIN | [#7 schema and access rules](https://github.com/David-000001/redplay-studio-EcoCommute/issues/7) | Post the trip fields, units and owner-only access contract on the issue so HAN, Maliha and Riptanto can use it. Verify access and retries under [#18](https://github.com/David-000001/redplay-studio-EcoCommute/issues/18). |
| Riptanto Athaillah Zacky Putra | [#12 emissions comparisons](https://github.com/David-000001/redplay-studio-EcoCommute/issues/12) | Bring one sourced mode factor with its units and a worked example at a fixed distance. Coordinate factor versions with Zhou and Rasha, then build [#13 trends](https://github.com/David-000001/redplay-studio-EcoCommute/issues/13). |
| Rasha Kultsum Mahdiyah | [#14 climate learning](https://github.com/David-000001/redplay-studio-EcoCommute/issues/14) | Draft one cited commuting lesson and a quiz with answer explanations. Subsequent work covers [reminders](https://github.com/David-000001/redplay-studio-EcoCommute/issues/15), [aggregate reporting](https://github.com/David-000001/redplay-studio-EcoCommute/issues/16) and [testing](https://github.com/David-000001/redplay-studio-EcoCommute/issues/19). |
| Avijit Chandra Dey | Integration and review | Review the trip contract and member PRs; assemble the first student sign-in → journey entry → personal history demo. Collect evidence for [the video](https://github.com/David-000001/redplay-studio-EcoCommute/issues/20) and [the report](https://github.com/David-000001/redplay-studio-EcoCommute/issues/22). |

## Returning work

1. Reply to the team email with your GitHub username, first issue and local sign-in result. If setup fails, include the command and error text with credentials removed.
2. Branch from current `main` or use a fork if you have read-only access. Open a PR against this repository’s `main`. Link the issue and describe the change, how you tested it and any remaining limitations. Include a screenshot for visible changes.
3. Record actual contribution hours and any AI assistance. Keep participant identities, private Firebase configuration and personal credentials out of GitHub.

The first proposed integration checkpoint is **22 November 2026** for an owned journey created by HAN’s form and visible in Maliha’s history. Zhou owns the shared contract. See the [requirements](requirements.md), [test plan](testing-plan.md) and [delivery dates](delivery-plan.md).
