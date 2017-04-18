package com.example.hsport.richardblanchard_project2;

import android.app.Activity;
import android.app.ListActivity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;

public class RestaurauntMainActivity extends ListActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        ListView listView = getListView();
        ArrayAdapter<Restauraunt> listAdapter = new ArrayAdapter<Restauraunt>(this, android.R.layout.simple_list_item_1, Restauraunt.boulder_restauraunts);
        listView.setAdapter(listAdapter);
    }
    @Override
    public void onListItemClick(ListView listView, View view, int position, long id){
        Intent intent = new Intent(RestaurauntMainActivity.this, RestaurantDetailActivity.class);
        intent.putExtra("restClicked", (int) id);
        startActivity(intent);
    }
}
