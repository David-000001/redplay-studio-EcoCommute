package com.example.um_ecocommute.home;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;
import com.example.um_ecocommute.BuildConfig;
import com.example.um_ecocommute.MainActivity;
import com.example.um_ecocommute.R;
import com.example.um_ecocommute.databinding.FragmentHomeBinding;

public class HomeFragment extends Fragment {
    @Override public View onCreateView(@NonNull LayoutInflater inflater, ViewGroup parent, Bundle state) {
        FragmentHomeBinding b = FragmentHomeBinding.inflate(inflater, parent, false);
        b.environment.setText(BuildConfig.USE_EMULATORS ? R.string.local_mode : R.string.cloud_mode);
        b.accounts.setOnClickListener(v -> open("/auth"));
        b.journeys.setOnClickListener(v -> open("/journeys"));
        b.history.setOnClickListener(v -> open("/history"));
        b.climate.setOnClickListener(v -> open("/climate"));
        b.reports.setOnClickListener(v -> open("/reports"));
        return b.getRoot();
    }
    private void open(String route) { ((MainActivity) requireActivity()).navigate(route); }
}
