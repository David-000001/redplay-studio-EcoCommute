package com.example.um_foodloop.modules;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;
import com.example.um_foodloop.R;
import com.example.um_foodloop.databinding.FragmentModuleBinding;

/** Explicit extension points for the assigned feature owners; no fake food or impact figures. */
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
            case "/listings": title=R.string.listings; description=R.string.listings_pending; break;
            case "/claims": title=R.string.claims; description=R.string.claims_pending; break;
            case "/climate": title=R.string.climate; description=R.string.climate_pending; break;
            case "/reports": title=R.string.reports; description=R.string.reports_pending; break;
            default: title=R.string.unavailable; description=R.string.module_pending;
        }
        b.title.setText(title); b.description.setText(description);
        b.back.setOnClickListener(v -> requireActivity().getOnBackPressedDispatcher().onBackPressed());
        return b.getRoot();
    }
}
