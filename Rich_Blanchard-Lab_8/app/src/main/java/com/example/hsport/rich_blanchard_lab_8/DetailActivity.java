package com.example.hsport.rich_blanchard_lab_8;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

public class DetailActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_detail);

        //get reference to the hero detail fragment
        TeamsFragment teamFragment = (TeamsFragment)
                getFragmentManager().findFragmentById(R.id.fragment_container);
        int leagueID = (int) getIntent().getExtras().get("id");

        teamFragment.setLeague(leagueID);

    }
}
