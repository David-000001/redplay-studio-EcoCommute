import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth_repository.dart';

/// Production repository; Firebase Auth handles passwords and sessions.
/// Firestore security rules, not this Dart code, enforce authorization.
class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
  }) : _auth = auth, _db = firestore;

  final FirebaseAuth _auth;
  final FirebaseFirestore _db;

  @override
  bool get isConfigured => true;

  @override
  Stream<AuthIdentity?> authStateChanges() =>
      _auth.authStateChanges().map((user) => user == null
          ? null
          : AuthIdentity(uid: user.uid, email: user.email ?? ''));

  @override
  Stream<UserProfile?> watchProfile(String uid) => _db
      .collection('profiles')
      .doc(uid)
      .snapshots()
      .map((snapshot) => snapshot.exists && snapshot.data() != null
          ? UserProfile.fromData(uid, snapshot.data()!)
          : null);

  @override
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
  }

  @override
  Future<void> registerStudent({
    required String email,
    required String password,
    required String displayName,
  }) async {
    final normalizedName = displayName.trim();
    if (normalizedName.isEmpty || normalizedName.length > 80) {
      throw ArgumentError('Enter a name between 1 and 80 characters.');
    }
    final result = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    final user = result.user;
    if (user == null) throw StateError('No Firebase user was created.');
    try {
      await _db.collection('profiles').doc(user.uid).set({
        'displayName': normalizedName,
        'role': 'student',
        'vendorStatus': 'none',
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (_) {
      // Avoid leaving a privileged-role-unassigned account if profile fails.
      try {
        await user.delete();
      } catch (_) {
        await _auth.signOut();
      }
      rethrow;
    }
  }

  @override
  Future<void> sendPasswordReset(String email) =>
      _auth.sendPasswordResetEmail(email: email.trim());

  @override
  Future<void> signOut() => _auth.signOut();

  @override
  Future<void> requestVendorApproval(String uid) async {
    final current = _auth.currentUser;
    if (current == null || current.uid != uid) {
      throw StateError('Sign in to request vendor approval.');
    }
    await _db.collection('profiles').doc(uid).update({
      'vendorStatus': 'pending',
    });
  }

  @override
  Stream<List<UserProfile>> pendingVendorRequests() => _db
      .collection('profiles')
      .where('vendorStatus', isEqualTo: 'pending')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => UserProfile.fromData(doc.id, doc.data()))
          .toList());

  @override
  Future<void> approveVendor(String uid) async {
    // Firebase rules authorize only an existing, server-provisioned admin.
    await _db.collection('profiles').doc(uid).update({
      'role': 'vendor',
      'vendorStatus': 'approved',
    });
  }
}
