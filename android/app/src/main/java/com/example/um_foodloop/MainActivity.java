package com.example.um_foodloop;

import android.os.Bundle;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;
import androidx.fragment.app.Fragment;
import com.example.um_foodloop.auth.AuthFragment;
import com.example.um_foodloop.databinding.ActivityMainBinding;
import com.example.um_foodloop.home.HomeFragment;
import com.example.um_foodloop.modules.ModuleFragment;

public class MainActivity extends AppCompatActivity {
    @Override public void onCreate(Bundle state) {
        super.onCreate(state);
        ActivityMainBinding binding = ActivityMainBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());
        ViewCompat.setOnApplyWindowInsetsListener(binding.getRoot(), (view, insets) -> {
            Insets bars = insets.getInsets(WindowInsetsCompat.Type.systemBars() | WindowInsetsCompat.Type.ime());
            view.setPadding(bars.left, bars.top, bars.right, bars.bottom);
            return insets;
        });
        if (state == null) getSupportFragmentManager().beginTransaction()
            .replace(R.id.screen_container, new HomeFragment()).commit();
    }
    public void navigate(String route) {
        Fragment screen = "/auth".equals(route) ? new AuthFragment() : ModuleFragment.forRoute(route);
        getSupportFragmentManager().beginTransaction().replace(R.id.screen_container, screen)
            .addToBackStack(route).commit();
    }
}
