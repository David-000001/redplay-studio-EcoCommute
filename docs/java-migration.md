# Java/XML migration — 7 November 2026

> Historical record of the earlier FoodLoop project. For current EcoCommute assignments and acceptance criteria, use the [team handoff](team-handoff.md) and [requirements](requirements.md).

## Decision and source boundaries
Avijit requested a native Java/XML implementation after supplying a course review: Practical 4 describes `.java` and `View.OnClickListener`; Practical 3 describes `res/layout/activity_main.xml` and ConstraintLayout. The supplied review says the 2026/2027 brief does not mandate Java or Kotlin and the practical handouts show 2025/2026. This migration aligns with those examples; it does not invent a lecturer mandate or claim a fresh inspection of the private Spectrum course.

User-supplied references: [Practical 4](https://spectrum.um.edu.my/mod/resource/view.php?id=892849), [Practical 3](https://spectrum.um.edu.my/mod/resource/view.php?id=1022199), [project brief](https://spectrum.um.edu.my/mod/resource/view.php?id=892368). Implementation references: [Android XML layouts](https://developer.android.com/develop/ui/views/layout/declaring-layout), [Firebase Android setup](https://firebase.google.com/docs/android/setup), [AGP 9.2 compatibility](https://developer.android.com/build/releases/agp-9-2-0-release-notes).

## Scope
- Replace Flutter implementation/build dependencies with standalone Java, XML Views, ConstraintLayout, Material Components, fragments and RecyclerView.
- Port leader-owned registration, login/logout, password reset, display-name editing, vendor requests and administrator approval.
- Keep the existing Firebase project, package, profiles schema, users and deployed rules. No new backend provisioning or privileged role migration is needed.
- Replace Flutter CI with native unit/lint/build/instrumentation checks. Keep backend rules tests.
- Update setup, module ownership and AI evidence; leave teammates' unfinished features as explicit extension points.

Previous Flutter implementation and evidence remain in Git history at `cea7f8a61c4ba328f1133bf6532cecc794192e7f`. Old results prove that historical version only. This migration does not mark all 15 FRs complete; vendor verification detail fields, notifications, listings, transactions, education and impact remain assigned work.

## Course requirements retained
The register retains five modules, three detailed FRs each, and exactly two justified NFRs. Climate education is explicit and measurable through sourced lessons and a pre/post assessment; indicative impact needs qualified methods and verified collection. Testing, actual member contributions and AI usage must be documented. In-app AI remains optional.

## Validation
Native build/test results are recorded in the migration PR and GitHub Actions. Historical live backend checks are in `live-firebase-verification.md`; they do not substitute for tests of the new Java UI. No real stakeholder participation or cloud Android UI verification is inferred from emulator results.
