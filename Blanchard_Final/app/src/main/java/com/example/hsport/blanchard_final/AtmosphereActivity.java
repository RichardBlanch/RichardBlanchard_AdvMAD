package com.example.hsport.blanchard_final;

import android.app.Activity;
import android.app.Dialog;
import android.app.ListActivity;
import android.content.Intent;
import android.os.Bundle;
import android.view.ContextMenu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;

import java.util.ArrayList;
import java.util.List;

public class AtmosphereActivity extends Activity {

    private int atmosphereSelected;

    private ArrayAdapter<String > arrayAdapter;
    List activityArray = new ArrayList<>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_atmosphere);
        Intent intent = getIntent();
        atmosphereSelected = intent.getIntExtra("atmosphereID",0);
        loadDataIfNil();
        setUpListView();

        Button button = (Button) findViewById(R.id.addButton);
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                showDialog();
            }
        });
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

        for (String activity : actList) {
            activityArray.add(activity);
        }

        arrayAdapter = new ArrayAdapter<String>(this, android.R.layout.simple_list_item_1, activityArray);
        ListView listView = (ListView) findViewById(R.id.mainListView);
        listView.setAdapter(arrayAdapter);
        registerForContextMenu(listView);
    }
    void showDialog() {
        final Dialog dialog = new Dialog(AtmosphereActivity.this);
        dialog.setContentView(R.layout.dialog);
        dialog.setTitle("Add Activity");
        dialog.setCancelable(true);
        final EditText editText = (EditText) dialog.findViewById(R.id.editTextActivity);
        Button button = (Button) dialog.findViewById(R.id.addButton);
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String new_activity = editText.getText().toString();
                activityArray.add(new_activity);
                arrayAdapter.notifyDataSetChanged();
                Atmosphere.mountains[atmosphereSelected].storeHeroes(AtmosphereActivity.this, atmosphereSelected, activityArray);
                //Atmosphere.mountains[atmosphereSelected].storeHeroes(AtmosphereActivity.this, atmosphereSelected);
                dialog.dismiss();
            }
        });
        dialog.show();
    }
    @Override public void onCreateContextMenu(ContextMenu menu, View view, ContextMenu.ContextMenuInfo menuInfo){
        super.onCreateContextMenu(menu, view, menuInfo);
        AdapterView.AdapterContextMenuInfo adapterContextMenuInfo = (AdapterView.AdapterContextMenuInfo) menuInfo;
        String activity_name = arrayAdapter.getItem(adapterContextMenuInfo.position);
        //set the menu title
        menu.setHeaderTitle("Delete " + activity_name + "?");
        //add the choices to the menu
        menu.add(1, 1, 1, "Yes");
        menu.add(2, 2, 2, "No");
    }

    @Override public boolean onContextItemSelected(MenuItem item){
        //get the id of the item
        int itemId = item.getItemId();
        if (itemId == 1) { //if yes menu item was pressed
            //get the position of the menu item
            AdapterView.AdapterContextMenuInfo info = (AdapterView.AdapterContextMenuInfo) item.getMenuInfo();
            activityArray.remove(info.position);
            arrayAdapter.notifyDataSetChanged();;
            Atmosphere.mountains[atmosphereSelected].storeHeroes(AtmosphereActivity.this, atmosphereSelected, activityArray);

        }
        return true;
    }
}
