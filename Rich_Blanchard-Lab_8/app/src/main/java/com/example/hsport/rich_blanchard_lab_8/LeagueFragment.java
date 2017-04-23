package com.example.hsport.rich_blanchard_lab_8;


import android.content.Context;
import android.os.Bundle;
import android.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.content.Context;
import android.widget.AdapterView;


/**
 * A simple {@link Fragment} subclass.
 */
public class LeagueFragment extends Fragment implements AdapterView.OnItemClickListener {
    private ListenerForLeagueSelected listener;

    @Override
    public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
        if (listener != null) {
            listener.itemClicked(id);
        }
    }

    public LeagueFragment() {
        // Required empty public constructor
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_league, container, false);
    }

    @Override
    public void onStart() {
        super.onStart();
        View view = getView();
        if (view != null) {
            ListView leagueListView = (ListView) view.findViewById(R.id.listView);
            ArrayAdapter<Baseball> listAdapter = new ArrayAdapter<Baseball>(getActivity(),
                    android.R.layout.simple_list_item_1, Baseball.leagues);
            leagueListView.setAdapter(listAdapter);
            leagueListView.setOnItemClickListener(this);
        }
    }
    interface ListenerForLeagueSelected{
        void itemClicked(long id);
    }

    @Override
    public void onAttach(Context context) {
        super.onAttach(context);
        listener = (ListenerForLeagueSelected) context;
    }
}
