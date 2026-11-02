import 'package:flutter_test/flutter_test.dart';
import 'package:um_foodloop/src/auth/auth_repository.dart';

void main() {
  test('new student profile has no vendor or admin permissions', () {
    final profile = UserProfile.fromData('student', {
      'displayName': 'Test Student',
      'role': 'student',
      'vendorStatus': 'none',
    });
    expect(profile.canPostListings, false);
    expect(profile.canReviewVendors, false);
  });

  test('pending vendor application cannot post listings', () {
    final profile = UserProfile.fromData('vendor', {
      'displayName': 'Vendor',
      'role': 'student',
      'vendorStatus': 'pending',
    });
    expect(profile.canPostListings, false);
  });

  test('only approved vendor gets vendor UI access', () {
    final profile = UserProfile.fromData('vendor', {
      'displayName': 'Vendor',
      'role': 'vendor',
      'vendorStatus': 'approved',
    });
    expect(profile.canPostListings, true);
    expect(profile.canReviewVendors, false);
  });

  test('only admin role gets approval UI access', () {
    final profile = UserProfile.fromData('admin', {
      'displayName': 'Administrator',
      'role': 'admin',
      'vendorStatus': 'none',
    });
    expect(profile.canReviewVendors, true);
    expect(profile.canPostListings, false);
  });

  test('unknown role never grants privileged UI access', () {
    final profile = UserProfile.fromData('unknown', {
      'displayName': 'Unknown',
      'role': 'superuser',
      'vendorStatus': 'approved',
    });
    expect(profile.role, FoodLoopRole.student);
    expect(profile.canPostListings, false);
    expect(profile.canReviewVendors, false);
  });
}
