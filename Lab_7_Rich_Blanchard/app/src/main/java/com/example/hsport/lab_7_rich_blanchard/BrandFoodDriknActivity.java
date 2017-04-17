package com.example.hsport.lab_7_rich_blanchard;

import android.app.ActionBar;
import android.app.ListActivity;
import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.util.Log;
import android.view.Menu;

/**
 * Created by gig_r on 4/10/17.
 */

public class BrandFoodDriknActivity extends ListActivity {
    private String value_clicked;
    private int food_or_water_clicked;

    public boolean onCreateOptionsMenu(Menu menu){
        getMenuInflater().inflate(R.menu.main_menu, menu);
        return super.onCreateOptionsMenu(menu);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        ActionBar actionBar = getActionBar();
        actionBar.setDisplayHomeAsUpEnabled(true);

        ListView brand_list_view = getListView();

        ArrayAdapter<TypeOfFoodOrDrinks> listAdapter;

        Intent i = getIntent();
        value_clicked = i.getStringExtra("food_or_drinks");
        food_or_water_clicked = TypeOfFoodOrDrinks.getDefaultIntegerValue(value_clicked);

        Log.d("myTag", value_clicked);
        Log.d("myTagTwo", "value = " + food_or_water_clicked);

        if(food_or_water_clicked == 0) {
            switch (value_clicked) {
                case "Breakfast":
                    listAdapter = new ArrayAdapter<TypeOfFoodOrDrinks>(this, android.R.layout.simple_list_item_1, TypeOfFoodOrDrinks.breakfast);
                    break;
                case "Lunch":
                    listAdapter = new ArrayAdapter<TypeOfFoodOrDrinks>(this, android.R.layout.simple_list_item_1, TypeOfFoodOrDrinks.lunch);
                    break;
                case "Dinner":
                    listAdapter = new ArrayAdapter<TypeOfFoodOrDrinks>(this, android.R.layout.simple_list_item_1, TypeOfFoodOrDrinks.dinner);


                default: listAdapter = new ArrayAdapter<TypeOfFoodOrDrinks>(this, android.R.layout.simple_list_item_1, TypeOfFoodOrDrinks.dinner);
            }


        }else {
            switch (value_clicked) {
                case "Water":
                    listAdapter = new ArrayAdapter<TypeOfFoodOrDrinks>(this, android.R.layout.simple_list_item_1, TypeOfFoodOrDrinks.water);
                    break;
                case "Soda":
                    listAdapter = new ArrayAdapter<TypeOfFoodOrDrinks>(this, android.R.layout.simple_list_item_1, TypeOfFoodOrDrinks.soda);
                    break;
                case "Alcoholic":
                    listAdapter = new ArrayAdapter<TypeOfFoodOrDrinks>(this, android.R.layout.simple_list_item_1, TypeOfFoodOrDrinks.alcoholic);
                    break;

                default: listAdapter = new ArrayAdapter<TypeOfFoodOrDrinks>(this, android.R.layout.simple_list_item_1, TypeOfFoodOrDrinks.water);
            }
        }


        brand_list_view.setAdapter(listAdapter);







    }



}
