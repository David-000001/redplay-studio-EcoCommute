package com.example.um_ecocommute.modules;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;
import com.example.um_ecocommute.R;
import com.example.um_ecocommute.databinding.FragmentModuleBinding;

/** Explicit extension points for the assigned feature owners; mobility features in development. */
public class ModuleFragment extends Fragment {
    public static ModuleFragment forRoute(String route) {
        ModuleFragment f = new ModuleFragment();
        Bundle args = new Bundle(); args.putString("route", route); f.setArguments(args); return f;
    }
    @Override public View onCreateView(@NonNull LayoutInflater inflater, ViewGroup parent, Bundle state) {
        FragmentModuleBinding b = FragmentModuleBinding.inflate(inflater, parent, false);
        String route = requireArguments().getString("route", "");
        int title, description;
        switch (route) {
            case "/journeys": title=R.string.journeys; description=R.string.journeys_pending; break;
            case "/history": title=R.string.history; description=R.string.history_pending; break;
            case "/climate": title=R.string.climate; description=R.string.climate_pending; break;
            case "/reports": title=R.string.reports; description=R.string.reports_pending; break;
            default: title=R.string.unavailable; description=R.string.module_pending;
        }
        b.title.setText(title); b.description.setText(description);
        b.back.setOnClickListener(v -> requireActivity().getOnBackPressedDispatcher().onBackPressed());
        return b.getRoot();
    }
}
