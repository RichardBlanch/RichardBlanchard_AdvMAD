package com.example.hsport.richardblanchard_project2;

import android.app.Activity;
import android.app.ListActivity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.app.Dialog;
import android.widget.EditText;
import android.widget.Button;
import android.view.MenuItem;

import java.lang.reflect.Array;
import java.util.List;
import java.util.ArrayList;
import java.util.Set;
import java.util.Arrays;
import java.util.Arrays;


public class RestaurauntMainActivity extends ListActivity  {
     private ArrayList<Restauraunt> rest = new ArrayList<Restauraunt>();
     private ArrayAdapter<Restauraunt> listAdapter;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        ListView listView = getListView();

        // Loop over our array and add each element separately.
        for (Restauraunt element : Restauraunt.boulder_restauraunts) {
            if (element != null) {
                rest.add(element);
            }

        }
        listAdapter = new ArrayAdapter<Restauraunt>(this, android.R.layout.simple_list_item_1, rest);
        listView.setAdapter(listAdapter);

    }
    @Override
    public void onListItemClick(ListView listView, View view, int position, long id){
        Intent intent = new Intent(RestaurauntMainActivity.this, RestaurantDetailActivity.class);
        intent.putExtra("restClicked", (int) id);
        Restauraunt restPicked = rest.get((int) id);
        intent.putExtra("Editing", restPicked);
        startActivity(intent);
    }
    public void addRest(){
        final Dialog dialog = new Dialog(this);
        dialog.setContentView(R.layout.dialog);
        dialog.setTitle("Add Restaraunt");
        dialog.setCancelable(true);
        final EditText editName = (EditText) dialog.findViewById(R.id.editRestName);
        final EditText editAddress = (EditText) dialog.findViewById(R.id.editRestAddress);
        final EditText editHours = (EditText) dialog.findViewById(R.id.editRestHours);
        final EditText editURL = (EditText) dialog.findViewById(R.id.editRestURL);
        final EditText editPhoneNumber = (EditText) dialog.findViewById(R.id.editRestPhoneNumber);

        Button button = (Button) dialog.findViewById(R.id.addButton);
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                ListView listView = getListView();
                String name = editName.getText().toString();
                String address = editAddress.getText().toString();
                String hours = editHours.getText().toString();
                String url = editURL.getText().toString();
                String phoneNumber = editPhoneNumber.getText().toString();


                Restauraunt new_rest = new Restauraunt(name, address, hours, url, phoneNumber,R.drawable.oak_14th,40.018153,-105.277073);
                rest.add(new_rest);
                 listAdapter.notifyDataSetChanged();
                dialog.dismiss();

            }
        });
        dialog.show();
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return super.onCreateOptionsMenu(menu);
    }
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()){
            case R.id.create_order:
               addRest();
            default:
                return super.onOptionsItemSelected(item);
        }
    }
}
