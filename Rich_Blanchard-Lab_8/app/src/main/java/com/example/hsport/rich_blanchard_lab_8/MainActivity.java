package com.example.hsport.rich_blanchard_lab_8;

import android.app.Activity;
import android.os.Bundle;
import android.app.FragmentTransaction;
import android.view.View;
import android.content.Intent;
import android.widget.ImageView;

public class MainActivity extends Activity implements LeagueFragment.ListenerForLeagueSelected,
        TeamsFragment.ButtonClickListener {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    @Override
    public void addHeroClicked(View view) {
        TeamsFragment fragment = (TeamsFragment) getFragmentManager().findFragmentById(R.id.fragment_container);
        fragment.addTeam();
    }

    @Override
    public void itemClicked(long id) {
        TeamsFragment new_fragment = new TeamsFragment();
        View fragmentContainer = findViewById(R.id.fragment_container);

        if (fragmentContainer != null) {
            FragmentTransaction fragTrans = getFragmentManager().beginTransaction();

            new_fragment.setLeague(id);

            fragTrans.replace(R.id.fragment_container, new_fragment);

            fragTrans.addToBackStack(null);

            fragTrans.setTransition(FragmentTransaction.TRANSIT_FRAGMENT_FADE);

            fragTrans.commit();
        } else{ //app is running on a device with a smaller screen
            Intent intent = new Intent(this, DetailActivity.class);
            intent.putExtra("id", (int) id);
            startActivity(intent);
        }
    }

    @Override
    public void onBackPressed() {
        if (getFragmentManager().getBackStackEntryCount() > 0) {
            getFragmentManager().popBackStack();
        } else {
            super.onBackPressed();
        }
    }
}
