package com.example.hsport.project2_rich_blanchard;

import android.app.Activity;
import android.app.ListActivity;
import android.os.Bundle;
import android.widget.ArrayAdapter;
import android.widget.ListView;

public class RestaurauntMainActivity extends ListActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_restauraunt_main);

        ArrayAdapter<Restaurant> listAdapter  = new ArrayAdapter<Restaurant>(this, android.R.layout.simple_list_item_2, Restaurant.boulder_restauraunts);
        ListView listHeroes = (ListView) view.findViewById(R.id.herolistView);
       // ListView listView = getListView();
       // listView.setAdapter(listAdapter);

    }

}
