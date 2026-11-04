import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:um_foodloop/src/auth/bootstrap_auth.dart';
import 'package:um_foodloop/src/auth/firebase_environment.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Android Firebase repository registers, signs in and approves vendors',
      (tester) async {
    expect(FirebaseEnvironment.useEmulators, isTrue,
        reason: 'Run only with --dart-define=USE_FIREBASE_EMULATORS=true');
    final repository = await bootstrapAuth();
    final email = 'android-${DateTime.now().microsecondsSinceEpoch}@example.test';
    const password = 'Local-test-password-2026!';
    await repository.registerStudent(
        email: email, password: password, displayName: 'Android student');
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final profile = await repository.watchProfile(uid).first;
    expect(profile!.canPostListings, isFalse);
    await expectLater(
      FirebaseFirestore.instance.collection('profiles').doc(uid)
          .update({'role': 'admin'}),
      throwsA(isA<FirebaseException>().having(
          (error) => error.code, 'code', 'permission-denied')),
    );
    await repository.requestVendorApproval(uid);
    await repository.sendPasswordReset(email);
    await repository.signOut();
    await repository.signIn(email: email, password: password);
    expect(FirebaseAuth.instance.currentUser!.uid, uid);
    await repository.signOut();
    await repository.signIn(
        email: 'admin@foodloop.test', password: 'FoodLoop-local-2026!');
    final pending = await repository.pendingVendorRequests().first;
    expect(pending.any((profile) => profile.uid == uid), isTrue);
    await repository.approveVendor(uid);
    await repository.signOut();
    await repository.signIn(email: email, password: password);
    final approved = await repository.watchProfile(uid).first;
    expect(approved!.canPostListings, isTrue);
    await repository.signOut();
  });
}
