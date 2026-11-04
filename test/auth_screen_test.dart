import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:um_foodloop/src/app.dart';
import 'package:um_foodloop/src/auth/auth_repository.dart';

class FakeAuthRepository implements AuthRepository {
  FakeAuthRepository({this.identity, this.profile});
  final AuthIdentity? identity;
  final UserProfile? profile;
  String? registeredEmail;
  String? resetEmail;
  String? requestedUid;
  String? approvedUid;
  String? updatedName;

  @override
  bool get isConfigured => true;
  @override
  Stream<AuthIdentity?> authStateChanges() => Stream.value(identity);
  @override
  Stream<UserProfile?> watchProfile(String uid) => Stream.value(profile);
  @override
  Stream<List<UserProfile>> pendingVendorRequests() => Stream.value([
        const UserProfile(
          uid: 'pending-vendor',
          displayName: 'Potential Vendor',
          role: FoodLoopRole.student,
          vendorStatus: VendorStatus.pending,
        ),
      ]);

  @override
  Future<void> signIn(
      {required String email, required String password}) async {}
  @override
  Future<void> registerStudent({
    required String email,
    required String password,
    required String displayName,
  }) async {
    registeredEmail = email;
  }

  @override
  Future<void> sendPasswordReset(String email) async {
    resetEmail = email;
  }

  @override
  Future<void> signOut() async {}
  @override
  Future<void> updateDisplayName(String uid, String displayName) async {
    updatedName = displayName;
  }

  @override
  Future<void> requestVendorApproval(String uid) async {
    requestedUid = uid;
  }

  @override
  Future<void> approveVendor(String uid) async {
    approvedUid = uid;
  }
}

Future<void> openAuth(WidgetTester tester, FakeAuthRepository repo) async {
  await tester.pumpWidget(FoodLoopApp(authRepository: repo));
  await tester.tap(find.text('Authentication & Roles'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('profile edit rejects empty names and saves a valid name',
      (tester) async {
    final fake = FakeAuthRepository(
      identity:
          const AuthIdentity(uid: 'student', email: 'student@example.test'),
      profile: const UserProfile(
          uid: 'student',
          displayName: 'Student',
          role: FoodLoopRole.student,
          vendorStatus: VendorStatus.none),
    );
    await openAuth(tester, fake);
    await tester.tap(find.text('Edit display name'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField), '');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(fake.updatedName, isNull);
    expect(find.text('Enter a name (1-80 characters).'), findsOneWidget);
    await tester.enterText(find.byType(TextFormField), ' Updated Student ');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();
    expect(fake.updatedName, 'Updated Student');
  });
  testWidgets('student registration passes form data to auth service',
      (tester) async {
    final fake = FakeAuthRepository();
    await openAuth(tester, fake);
    await tester.tap(find.text('Create account'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), 'Test Student');
    await tester.enterText(
        find.byType(TextFormField).at(1), 'student@example.test');
    await tester.enterText(find.byType(TextFormField).at(2), 'long-password');
    await tester.tap(find.text('Register'));
    await tester.pumpAndSettle();
    expect(fake.registeredEmail, 'student@example.test');
  });

  testWidgets('password reset invokes auth service', (tester) async {
    final fake = FakeAuthRepository();
    await openAuth(tester, fake);
    await tester.tap(find.text('Forgot password?'));
    await tester.pumpAndSettle();
    await tester.enterText(
        find.byType(TextFormField).first, 'student@example.test');
    await tester.tap(find.text('Send reset email'));
    await tester.pumpAndSettle();
    expect(fake.resetEmail, 'student@example.test');
  });

  testWidgets('student can request vendor approval', (tester) async {
    final fake = FakeAuthRepository(
      identity:
          const AuthIdentity(uid: 'student', email: 'student@example.test'),
      profile: const UserProfile(
        uid: 'student',
        displayName: 'Student',
        role: FoodLoopRole.student,
        vendorStatus: VendorStatus.none,
      ),
    );
    await openAuth(tester, fake);
    await tester.tap(find.text('Request vendor approval'));
    await tester.pumpAndSettle();
    expect(fake.requestedUid, 'student');
  });

  testWidgets('admin can approve a pending vendor from review UI',
      (tester) async {
    final fake = FakeAuthRepository(
      identity: const AuthIdentity(uid: 'admin', email: 'admin@example.test'),
      profile: const UserProfile(
        uid: 'admin',
        displayName: 'Administrator',
        role: FoodLoopRole.admin,
        vendorStatus: VendorStatus.none,
      ),
    );
    await openAuth(tester, fake);
    await tester.tap(find.text('Approve'));
    await tester.pumpAndSettle();
    expect(fake.approvedUid, 'pending-vendor');
  });
}
