package com.example.hsport.lab_7_rich_blanchard;

import android.app.ListActivity;
import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.app.ActionBar;

public class TypeOfFoodOrDrinkActivity extends ListActivity {
    private String food_or_drinks;

    public boolean onCreateOptionsMenu(Menu menu){
        getMenuInflater().inflate(R.menu.main_menu, menu);
        return super.onCreateOptionsMenu(menu);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);



        //create new intent
        Intent i = getIntent();
        food_or_drinks = i.getStringExtra("food_or_drinks");

        //get the list view
        ListView listBulbs = getListView();

        //define an array adapter
        ArrayAdapter<TypeOfFoodOrDrinks> listAdapter;

        //initialize the array adapter with the right list of bulbs
        switch (food_or_drinks){
            case "Drink":
                listAdapter = new ArrayAdapter<TypeOfFoodOrDrinks>(this, android.R.layout.simple_list_item_1, TypeOfFoodOrDrinks.drinks);
                break;
            case "Food":
                listAdapter = new ArrayAdapter<TypeOfFoodOrDrinks>(this, android.R.layout.simple_list_item_1, TypeOfFoodOrDrinks.foods);
                break;
            default: listAdapter = new ArrayAdapter<TypeOfFoodOrDrinks>(this, android.R.layout.simple_list_item_1, TypeOfFoodOrDrinks.drinks);
        }

        //set the array adapter on the list view
        listBulbs.setAdapter(listAdapter);

        ActionBar actionBar = getActionBar();
       // actionBar.setDisplayHomeAsUpEnabled(true);
    }


    @Override
    public void onListItemClick(ListView listView, View view, int position, long id){
        Intent intent = new Intent(TypeOfFoodOrDrinkActivity.this, BrandFoodDriknActivity.class);
        intent.putExtra("brand_id", (int) id);
        TypeOfFoodOrDrinks type_of_food_or_drink = (TypeOfFoodOrDrinks) listView.getItemAtPosition(position);
        String food_or_drink = type_of_food_or_drink.getName();
        intent.putExtra("food_or_drinks", food_or_drink);
        startActivity(intent);
    }

}
