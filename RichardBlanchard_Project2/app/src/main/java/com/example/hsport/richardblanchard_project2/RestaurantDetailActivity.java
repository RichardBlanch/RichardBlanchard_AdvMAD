package com.example.hsport.richardblanchard_project2;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.app.Activity;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.ListView;
import android.content.Context;

public class RestaurantDetailActivity extends Activity {
    private Restauraunt restauraunt;
    private String string_details;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_restaurant_detail);
        Intent intent = getIntent();
        restauraunt = Restauraunt.boulder_restauraunts[intent.getIntExtra("restClicked",0)];
        ArrayAdapter<String> listAdapter =  listAdapter = new ArrayAdapter<String>(this, android.R.layout.simple_list_item_1, Restauraunt.rest_details(restauraunt));

        AdapterView.OnItemClickListener itemClickListener = new AdapterView.OnItemClickListener() {
            public void onItemClick(AdapterView<?> listView, View view, int position, long id) {
                if (id == 3) {
                    openURLForRestarauntInBrowser();
                } else if (id == 2) {
                    goToMaps();
                }
            }
        };
        //get the list view
        ListView listview = (ListView) findViewById(R.id.listView);
        //add listener to the list view
        listview.setOnItemClickListener(itemClickListener);
        listview.setAdapter(listAdapter);

        ImageView bulbImage = (ImageView)findViewById(R.id.imageView);
        bulbImage.setImageResource(restauraunt.getImageResourceID());
    }
    protected void openURLForRestarauntInBrowser() {
        //Code from - http://stackoverflow.com/questions/2201917/how-can-i-open-a-url-in-androids-web-browser-from-my-application
        String url = restauraunt.getURL();
        Intent i = new Intent(Intent.ACTION_VIEW);
        i.setData(Uri.parse(url));
        startActivity(i);
    }
    protected void goToMaps() {
        Intent intent = new Intent(RestaurantDetailActivity.this, MapsActivity.class);
        intent.putExtra("lng", restauraunt.getLng());
        intent.putExtra("lat", restauraunt.getLat());
        intent.putExtra("name", restauraunt.getName());
        startActivity(intent);
    }

}
