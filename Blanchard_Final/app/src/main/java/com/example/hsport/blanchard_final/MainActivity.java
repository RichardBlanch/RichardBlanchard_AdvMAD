package com.example.hsport.blanchard_final;

import android.app.Activity;
import android.app.ListActivity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ListView;

import java.util.ArrayList;
import java.util.List;

public class MainActivity extends ListActivity {
    private ArrayAdapter<Atmosphere> atmosphereAdapter;
    List atmosphereArray = new ArrayList<>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        AdapterView.OnItemClickListener itemClickListener = new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                Intent intent = new Intent(MainActivity.this, AtmosphereActivity.class);
                intent.putExtra("atmosphereID", (int) id);
                startActivity(intent);
            }
        };
        ListView listview = getListView();

        //add listener to the list view
        listview.setOnItemClickListener(itemClickListener);


        atmosphereAdapter = new ArrayAdapter<Atmosphere>(this, android.R.layout.simple_list_item_1, Atmosphere.mountains);

        listview.setAdapter(atmosphereAdapter);
    }
}
