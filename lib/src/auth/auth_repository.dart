/// Authentication contract. Only trusted backend data grants privileged roles.
class AuthIdentity {
  const AuthIdentity({required this.uid, required this.email});
  final String uid;
  final String email;
}

enum FoodLoopRole { student, vendor, admin }

enum VendorStatus { none, pending, approved, rejected }

class UserProfile {
  const UserProfile({
    required this.uid,
    required this.displayName,
    required this.role,
    required this.vendorStatus,
  });

  final String uid;
  final String displayName;
  final FoodLoopRole role;
  final VendorStatus vendorStatus;

  bool get canPostListings =>
      role == FoodLoopRole.vendor && vendorStatus == VendorStatus.approved;
  bool get canReviewVendors => role == FoodLoopRole.admin;

  factory UserProfile.fromData(String uid, Map<String, dynamic> data) {
    final roleName = data['role'] as String? ?? 'student';
    final vendorName = data['vendorStatus'] as String? ?? 'none';
    return UserProfile(
      uid: uid,
      displayName: data['displayName'] as String? ?? '',
      role: FoodLoopRole.values.firstWhere(
        (role) => role.name == roleName,
        orElse: () => FoodLoopRole.student,
      ),
      vendorStatus: VendorStatus.values.firstWhere(
        (status) => status.name == vendorName,
        orElse: () => VendorStatus.none,
      ),
    );
  }
}

abstract class AuthRepository {
  bool get isConfigured;
  Stream<AuthIdentity?> authStateChanges();
  Stream<UserProfile?> watchProfile(String uid);

  Future<void> signIn({required String email, required String password});
  Future<void> registerStudent({
    required String email,
    required String password,
    required String displayName,
  });
  Future<void> sendPasswordReset(String email);
  Future<void> signOut();
  Future<void> requestVendorApproval(String uid);
  Future<void> approveVendor(String uid);
}

class UnavailableAuthRepository implements AuthRepository {
  const UnavailableAuthRepository();
  @override
  bool get isConfigured => false;
  @override
  Stream<AuthIdentity?> authStateChanges() => Stream.value(null);
  @override
  Stream<UserProfile?> watchProfile(String uid) => Stream.value(null);
  Never _unavailable() => throw StateError('Firebase is not configured.');
  @override
  Future<void> signIn({required String email, required String password}) async =>
      _unavailable();
  @override
  Future<void> registerStudent({
    required String email,
    required String password,
    required String displayName,
  }) async => _unavailable();
  @override
  Future<void> sendPasswordReset(String email) async => _unavailable();
  @override
  Future<void> signOut() async => _unavailable();
  @override
  Future<void> requestVendorApproval(String uid) async => _unavailable();
  @override
  Future<void> approveVendor(String uid) async => _unavailable();
}
