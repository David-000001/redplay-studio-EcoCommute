package com.example.um_foodloop.auth;

import android.os.Bundle;
import android.util.Patterns;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;
import com.example.um_foodloop.FoodLoopApplication;
import com.example.um_foodloop.R;
import com.example.um_foodloop.databinding.FragmentAuthBinding;
import com.google.android.gms.tasks.Task;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.firestore.ListenerRegistration;

public class AuthFragment extends Fragment {
    private FragmentAuthBinding binding;
    private AuthRepository repository;
    private FirebaseAuth.AuthStateListener authListener;
    private ListenerRegistration profileListener;
    private boolean busy;
    private UserProfile profile;

    @Override public View onCreateView(@NonNull LayoutInflater inflater, ViewGroup parent, Bundle state) {
        binding = FragmentAuthBinding.inflate(inflater, parent, false);
        repository = ((FoodLoopApplication) requireActivity().getApplication()).repository();
        binding.back.setOnClickListener(v -> requireActivity().getOnBackPressedDispatcher().onBackPressed());
        binding.signIn.setOnClickListener(v -> {
            if (validEmail() && validPassword(false)) run(repository.signIn(value(binding.email), value(binding.password)), R.string.signed_in, R.string.auth_failed);
        });
        binding.register.setOnClickListener(v -> {
            if (!validEmail() || !validPassword(true)) return;
            try { UserProfile.validatedName(value(binding.registerName)); }
            catch (IllegalArgumentException e) { binding.registerName.setError(e.getMessage()); return; }
            run(repository.register(value(binding.email), value(binding.password), value(binding.registerName)), R.string.registered, R.string.registration_failed);
        });
        binding.reset.setOnClickListener(v -> {
            if (validEmail()) run(repository.resetPassword(value(binding.email)), R.string.reset_sent, R.string.operation_failed);
        });
        binding.saveName.setOnClickListener(v -> {
            try { UserProfile.validatedName(value(binding.profileName)); }
            catch (IllegalArgumentException e) { binding.profileName.setError(e.getMessage()); return; }
            run(repository.updateName(value(binding.profileName)), R.string.saved, R.string.operation_failed);
        });
        binding.signOut.setOnClickListener(v -> { repository.signOut(); binding.message.setText(""); });
        if (repository == null) binding.message.setText(R.string.config_missing);
        renderEnabled();
        return binding.getRoot();
    }
    private static String value(android.widget.EditText field) { return field.getText().toString(); }
    private boolean validEmail() {
        if (Patterns.EMAIL_ADDRESS.matcher(value(binding.email).trim()).matches()) return true;
        binding.email.setError(getString(R.string.enter_email)); return false;
    }
    private boolean validPassword(boolean register) {
        if (value(binding.password).isEmpty()) { binding.password.setError(getString(R.string.enter_password)); return false; }
        if (register && value(binding.password).length() < 6) { binding.password.setError(getString(R.string.password_length)); return false; }
        return true;
    }
    @Override public void onStart() {
        super.onStart();
        if (repository != null) {
            authListener = auth -> observeAccount(auth.getCurrentUser());
            repository.auth.addAuthStateListener(authListener);
        }
    }
    private void observeAccount(FirebaseUser user) {
        stopProfileListeners(); profile = null;
        binding.signedInPanel.setVisibility(user == null ? View.GONE : View.VISIBLE);
        binding.signedOutPanel.setVisibility(user == null ? View.VISIBLE : View.GONE);
        binding.profileSummary.setText(R.string.loading_profile);
        binding.profileName.setText("");
        if (user != null) {
            binding.password.setText("");
            profileListener = repository.profile(user.getUid()).addSnapshotListener((snapshot, error) -> {
                if (binding == null) return;
                if (error != null || snapshot == null || !snapshot.exists()) {
                    profile = null;
                    binding.profileSummary.setText(error == null ? R.string.missing_profile : R.string.operation_failed);
                    renderEnabled(); return;
                }
                profile = new UserProfile(snapshot.getId(), snapshot.getData());
                binding.profileSummary.setText(getString(R.string.account_summary, profile.displayName, "admin".equals(profile.role) ? "admin" : "student"));
                if (!binding.profileName.hasFocus()) binding.profileName.setText(profile.displayName);
                renderEnabled();
            });
        }
        renderEnabled();
    }
    private void run(Task<Void> task, int success, int failure) {
        busy = true; binding.message.setText(""); renderEnabled();
        FragmentAuthBinding original = binding;
        task.addOnCompleteListener(result -> {
            if (binding == null || binding != original) return;
            busy = false;
            binding.message.setText(result.isSuccessful() ? success : failure);
            renderEnabled();
        });
    }
    private void renderEnabled() {
        if (binding == null) return;
        boolean ready = repository != null && !busy;
        binding.progress.setVisibility(busy ? View.VISIBLE : View.GONE);
        binding.signIn.setEnabled(ready); binding.register.setEnabled(ready); binding.reset.setEnabled(ready);
        binding.signOut.setEnabled(ready); binding.saveName.setEnabled(ready && profile != null);
    }
    private void stopProfileListeners() {
        if (profileListener != null) { profileListener.remove(); profileListener = null; }
    }
    @Override public void onStop() {
        if (repository != null && authListener != null) repository.auth.removeAuthStateListener(authListener);
        stopProfileListeners(); super.onStop();
    }
    @Override public void onDestroyView() { binding = null; busy = false; super.onDestroyView(); }
}
