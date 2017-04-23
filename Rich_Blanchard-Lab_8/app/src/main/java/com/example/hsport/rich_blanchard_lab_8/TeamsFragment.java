package com.example.hsport.rich_blanchard_lab_8;


import android.app.Dialog;
import android.content.Context;
import android.os.Bundle;
import android.app.Fragment;
import android.view.LayoutInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.EditText;
import android.widget.ListView;

import java.util.ArrayList;
import android.widget.Button;
import android.view.ContextMenu;
import android.widget.AdapterView;


/**
 * A simple {@link Fragment} subclass.
 */
public class TeamsFragment extends Fragment implements View.OnClickListener {
    private ArrayAdapter<String> adapter;
    private long leagueIDSelected;
    private ButtonClickListener listener;


    public void setLeague(long id){
        this.leagueIDSelected = id;
    }


    public TeamsFragment() {
        // Required empty public constructor
    }
    interface ButtonClickListener {
        void addHeroClicked(View view);
    }

    @Override
    public void onClick(View v) {
        if (listener != null) {
            listener.addHeroClicked(v);
        }
    }

    @Override
    public void onAttach(Context context) {
        super.onAttach(context);
        listener = (ButtonClickListener)context;
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        if (savedInstanceState !=null){
            leagueIDSelected = savedInstanceState.getLong("leagueIDSelected");
        }

        if (Baseball.leagues[0].getTeams().size() == 0) {
            Baseball.leagues[0].loadTeams(getActivity(),0);
        } if (Baseball.leagues[1].getTeams().size() == 0) {
            Baseball.leagues[1].loadTeams(getActivity(),1);
        }
        return inflater.inflate(R.layout.fragment_teams, container, false);
    }
    @Override
    public void onStart() {
        super.onStart();
        View view = getView();
        ListView teamsListView = (ListView) view.findViewById(R.id.teamListView);
        ArrayList<String> teams = new ArrayList<String>();
        teams = Baseball.leagues[(int) leagueIDSelected].getTeams();

        adapter = new ArrayAdapter<String>(getActivity(), android.R.layout.simple_list_item_1, teams);
        teamsListView.setAdapter(adapter);

        Button addButton = (Button) view.findViewById(R.id.addButton);
        addButton.setOnClickListener(this);

        registerForContextMenu(teamsListView);

    }
    public void addHero() {
        final Dialog dialog = new Dialog(getActivity());
        dialog.setContentView(R.layout.dialog);
        dialog.setTitle("Add A new team.");
        dialog.setCancelable(true);
        final EditText editText = (EditText) dialog.findViewById(R.id.editTextHero);
        Button button = (Button) dialog.findViewById(R.id.addButton);
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String teamName = editText.getText().toString();
                Baseball.leagues[(int)leagueIDSelected].getTeams().add(teamName);
                TeamsFragment.this.adapter.notifyDataSetChanged();
                Baseball.leagues[(int)leagueIDSelected].storeTeams(getActivity(), leagueIDSelected);
                dialog.dismiss();
            }
        });
        dialog.show();
    }
    @Override
    public void onSaveInstanceState(Bundle outState) {
        outState.putLong("leagueIDSelected", leagueIDSelected);
    }
    @Override public void onCreateContextMenu(ContextMenu menu, View view,
                                              ContextMenu.ContextMenuInfo menuInfo){
        super.onCreateContextMenu(menu, view, menuInfo);
        AdapterView.AdapterContextMenuInfo adapterContextMenuInfo =
                (AdapterView.AdapterContextMenuInfo) menuInfo;
        String heroname = adapter.getItem(adapterContextMenuInfo.position);
        menu.setHeaderTitle("Delete " + heroname);
        menu.add(1, 1, 1, "Yes");
        menu.add(2, 2, 2, "No");
    }

    @Override
    public boolean onContextItemSelected(MenuItem item) {
        int itemID = item.getItemId();
        if (itemID == 1) {
            AdapterView.AdapterContextMenuInfo info = (AdapterView.AdapterContextMenuInfo)
                    item.getMenuInfo();
            Baseball.leagues[(int) leagueIDSelected].getTeams().remove(info.position);
            Baseball.leagues[(int)leagueIDSelected].storeTeams(getActivity(), leagueIDSelected);
            TeamsFragment.this.adapter.notifyDataSetChanged();;
        }
        return true;
    }
}
