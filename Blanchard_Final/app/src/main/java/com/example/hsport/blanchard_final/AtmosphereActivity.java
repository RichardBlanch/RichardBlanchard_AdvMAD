package com.example.hsport.blanchard_final;

import android.app.Activity;
import android.app.ListActivity;
import android.content.Intent;
import android.os.Bundle;
import android.widget.ArrayAdapter;

import java.util.ArrayList;

public class AtmosphereActivity extends ListActivity {

    private int atmosphereSelected;
    private ArrayAdapter<String > arrayAdapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Intent intent = getIntent();
        atmosphereSelected = intent.getIntExtra("atmosphereID",0);
        loadDataIfNil();
        setUpListView();
    }
    void loadDataIfNil() {
        if (Atmosphere.mountains[0].getActivities().size() == 0) {
            Atmosphere.mountains[0].loadMountains(getApplicationContext(),0);
        }
        if (Atmosphere.mountains[1].getActivities().size() == 0) {
            Atmosphere.mountains[1].loadMountains(getApplicationContext(),1);
        }
    }
    void setUpListView() {
        ArrayList<String> actList = new ArrayList<String>();
        actList = Atmosphere.mountains[atmosphereSelected].getActivities();

        arrayAdapter = new ArrayAdapter<String>(this, android.R.layout.simple_list_item_1, actList);
        getListView().setAdapter(arrayAdapter);
    }
}
