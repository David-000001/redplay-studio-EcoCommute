package com.example.um_ecocommute;

import android.app.Application;
import com.example.um_ecocommute.auth.AuthRepository;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.firestore.FirebaseFirestore;
import com.google.firebase.firestore.FirebaseFirestoreSettings;
import com.google.firebase.firestore.MemoryCacheSettings;

public class EcoCommuteApplication extends Application {
    private AuthRepository repository;
    @Override public void onCreate() {
        super.onCreate();
        FirebaseApp app;
        if (BuildConfig.USE_EMULATORS && BuildConfig.DEBUG) {
            app = FirebaseApp.initializeApp(this, new FirebaseOptions.Builder()
                .setProjectId("demo-foodloop-auth")
                .setApplicationId("1:1234567890:android:foodlooplocal")
                .setApiKey("fake-api-key-for-local-emulators").build(), "foodloop-local");
        } else {
            app = FirebaseApp.initializeApp(this);
        }
        if (app == null) return; // No configuration means no account operations.
        FirebaseAuth auth = FirebaseAuth.getInstance(app);
        FirebaseFirestore db = FirebaseFirestore.getInstance(app);
        if (BuildConfig.USE_EMULATORS && BuildConfig.DEBUG) {
            auth.useEmulator("10.0.2.2", 9099);
            db.useEmulator("10.0.2.2", 8080);
        }
        // Avoid retaining another person's profile on a shared development phone.
        db.setFirestoreSettings(new FirebaseFirestoreSettings.Builder()
            .setLocalCacheSettings(MemoryCacheSettings.newBuilder().build()).build());
        repository = new AuthRepository(auth, db);
    }
    public AuthRepository repository() { return repository; }
}
