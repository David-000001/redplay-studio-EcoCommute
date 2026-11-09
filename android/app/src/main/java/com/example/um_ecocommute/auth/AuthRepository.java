package com.example.um_ecocommute.auth;

import com.google.android.gms.tasks.Task;
import com.google.android.gms.tasks.Tasks;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.firestore.DocumentReference;
import com.google.firebase.firestore.FieldValue;
import com.google.firebase.firestore.FirebaseFirestore;
import com.google.firebase.firestore.Query;
import java.util.HashMap;
import java.util.Map;

/** Client presentation never grants roles; deployed Firestore rules authorize every write. */
public final class AuthRepository {
    public final FirebaseAuth auth;
    private final FirebaseFirestore db;
    public AuthRepository(FirebaseAuth auth, FirebaseFirestore db) { this.auth = auth; this.db = db; }
    public DocumentReference profile(String uid) { return db.collection("profiles").document(uid); }
    public Task<Void> signIn(String email, String password) {
        return auth.signInWithEmailAndPassword(email.trim(), password).onSuccessTask(result -> Tasks.forResult(null));
    }
    public Task<Void> register(String email, String password, String name) {
        final String displayName;
        try { displayName = UserProfile.validatedName(name); }
        catch (IllegalArgumentException e) { return Tasks.forException(e); }
        return auth.createUserWithEmailAndPassword(email.trim(), password).onSuccessTask(result -> {
            FirebaseUser user = result.getUser();
            if (user == null) return Tasks.forException(new IllegalStateException("Account creation failed."));
            Map<String, Object> data = new HashMap<>();
            data.put("displayName", displayName); data.put("role", "student");
            data.put("vendorStatus", "none"); data.put("createdAt", FieldValue.serverTimestamp());
            return profile(user.getUid()).set(data).continueWithTask(write -> {
                if (write.isSuccessful()) return Tasks.forResult(null);
                Exception failure = write.getException();
                return user.delete().continueWithTask(deleted -> {
                    auth.signOut();
                    if (!deleted.isSuccessful()) return Tasks.forException(new IllegalStateException(
                        "Profile could not be saved. Your account may remain; contact the project lead before registering again.", failure));
                    return Tasks.forException(new IllegalStateException("Profile could not be saved. Please register again when connected.", failure));
                });
            });
        });
    }
    public Task<Void> resetPassword(String email) { return auth.sendPasswordResetEmail(email.trim()); }
    public void signOut() { auth.signOut(); }
    public Task<Void> updateName(String name) {
        if (auth.getCurrentUser() == null) return Tasks.forException(new IllegalStateException("Sign in first."));
        try { return profile(auth.getCurrentUser().getUid()).update("displayName", UserProfile.validatedName(name)); }
        catch (IllegalArgumentException e) { return Tasks.forException(e); }
    }
    public Task<Void> requestVendor() {
        if (auth.getCurrentUser() == null) return Tasks.forException(new IllegalStateException("Sign in first."));
        return profile(auth.getCurrentUser().getUid()).update("vendorStatus", "pending");
    }
    public Query pendingVendors() { return db.collection("profiles").whereEqualTo("vendorStatus", "pending"); }
    public Task<Void> approveVendor(String uid) {
        return profile(uid).update("role", "vendor", "vendorStatus", "approved");
    }
}
