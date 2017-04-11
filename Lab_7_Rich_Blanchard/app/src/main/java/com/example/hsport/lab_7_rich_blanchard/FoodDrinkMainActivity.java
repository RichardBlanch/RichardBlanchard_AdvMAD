package com.example.hsport.lab_7_rich_blanchard;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;

public class FoodDrinkMainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_food_drink_main);

        //create listener

        AdapterView.OnItemClickListener itemClickListener = new AdapterView.OnItemClickListener() {
            public void onItemClick(AdapterView<?> listView, View view, int position, long id) {
                String food_or_drinks = (String) listView.getItemAtPosition(position);
                //create new intent
                Intent intent = new Intent(FoodDrinkMainActivity.this, TypeOfFoodOrDrinkActivity.class);

                //add bulbtype to intent
                intent.putExtra("food_or_drinks", food_or_drinks);

                //start intent
                startActivity(intent);
            }
        };

        //get the list view
        ListView listview = (ListView) findViewById(R.id.listView);

        //add listener to the list view
        listview.setOnItemClickListener(itemClickListener);
    }
}
