package com.example.um_foodloop.home;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;
import com.example.um_foodloop.BuildConfig;
import com.example.um_foodloop.MainActivity;
import com.example.um_foodloop.R;
import com.example.um_foodloop.databinding.FragmentHomeBinding;

public class HomeFragment extends Fragment {
    @Override public View onCreateView(@NonNull LayoutInflater inflater, ViewGroup parent, Bundle state) {
        FragmentHomeBinding b = FragmentHomeBinding.inflate(inflater, parent, false);
        b.environment.setText(BuildConfig.USE_EMULATORS ? R.string.local_mode : R.string.cloud_mode);
        b.accounts.setOnClickListener(v -> open("/auth"));
        b.listings.setOnClickListener(v -> open("/journeys"));
        b.claims.setOnClickListener(v -> open("/history"));
        b.climate.setOnClickListener(v -> open("/climate"));
        b.reports.setOnClickListener(v -> open("/reports"));
        return b.getRoot();
    }
    private void open(String route) { ((MainActivity) requireActivity()).navigate(route); }
}
