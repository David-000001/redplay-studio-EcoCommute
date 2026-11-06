package com.example.um_foodloop.auth;

import java.util.Map;

public final class UserProfile {
    public final String uid, displayName, role, vendorStatus;
    public UserProfile(String uid, Map<String, Object> data) {
        this.uid = uid;
        displayName = string(data.get("displayName"));
        role = string(data.get("role"));
        vendorStatus = string(data.get("vendorStatus"));
    }
    private static String string(Object value) { return value instanceof String ? (String) value : ""; }
    public boolean canReviewVendors() { return "admin".equals(role); }
    public boolean canPostListings() { return "vendor".equals(role) && "approved".equals(vendorStatus); }
    public boolean canRequestVendor() {
        return "student".equals(role) && ("none".equals(vendorStatus) || "rejected".equals(vendorStatus));
    }
    public static String validatedName(String name) {
        String value = name.trim();
        if (value.isEmpty() || value.length() > 80) throw new IllegalArgumentException("Enter a name between 1 and 80 characters.");
        return value;
    }
}
