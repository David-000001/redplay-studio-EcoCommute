package com.example.um_ecocommute.auth;
import org.junit.Test;
import java.util.HashMap;
import java.util.Map;
import static org.junit.Assert.*;
public class UserProfileTest {
 private UserProfile profile(Object role, Object status) {
   Map<String,Object> data=new HashMap<>(); data.put("role",role);data.put("vendorStatus",status);
   return new UserProfile("uid",data);
 }
 @Test public void unknownAndMalformedRolesFailClosed() {
   for(Object role:new Object[]{null,7,"owner","ADMIN","student"}) {
     assertFalse(profile(role,"approved").canReviewVendors());
     assertFalse(profile(role,"approved").canPostListings());
   }
 }
 @Test public void approvalRequiresBothVendorRoleAndApprovedState() {
   assertFalse(profile("vendor","pending").canPostListings());
   assertFalse(profile("student","approved").canPostListings());
   assertTrue(profile("vendor","approved").canPostListings());
   assertTrue(profile("admin","none").canReviewVendors());
 }
 @Test public void requestsOnlyAllowedForEligibleStudents() {
   assertTrue(profile("student","none").canRequestVendor());
   assertTrue(profile("student","rejected").canRequestVendor());
   assertFalse(profile("student","pending").canRequestVendor());
   assertFalse(profile("admin","none").canRequestVendor());
 }
 @Test public void displayNameBoundaryAndNormalization() {
   assertEquals("Avijit",UserProfile.validatedName("  Avijit  "));
   assertEquals(80,UserProfile.validatedName("a".repeat(80)).length());
   assertThrows(IllegalArgumentException.class,()->UserProfile.validatedName("   "));
   assertThrows(IllegalArgumentException.class,()->UserProfile.validatedName("a".repeat(81)));
 }
}
