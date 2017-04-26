package com.example.hsport.rich_blanchard_lab_8;

/**
 * Created by gig_r on 4/21/17.
 */
import android.content.Context;
import android.content.SharedPreferences;

import java.util.Arrays;
import java.util.ArrayList;
import java.util.HashSet;
import android.content.SharedPreferences;
import android.content.Context;
import android.util.Log;

import java.util.HashSet;
import java.util.Set;

public class Baseball {
    private String league;
    private ArrayList<String> teams = new ArrayList<>();

    private Baseball(String league, ArrayList<String> teams) {
        this.league = league;
        this.teams = teams;
    }

    ///(Arrays.asList("Baltimore Orioles", "Boston Red Sox", "Chicago White Sox", "Cleveland Indians", "Detroit Tigers", "Houston Astros"))
    //(Arrays.asList("Arizona Diamondbacks", "Atlanta Braves", "Chicago Cubs", "Cincinatti Reds", "Colorado Rockies", "Los Angeles Dodgers"))
    public static Baseball[] leagues = {
            new Baseball("American League", new ArrayList<String>()),
            new Baseball("National League", new ArrayList<String>())
    };


    public void loadTeams(Context context, int leagueID) {
        SharedPreferences sharedPreferences = context.getSharedPreferences("Teams", Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = sharedPreferences.edit();
        Set<String> set = sharedPreferences.getStringSet(leagues[leagueID].getLeague(),null);

        if (set.size() != 1 && set != null) {
            Log.e("size","size" + set.size());
            Log.e("set","set" + set);

            Baseball.leagues[leagueID].teams.addAll(set);
        }
        else {
            switch ((int) leagueID) {
                case 0:
                    Baseball.leagues[0].teams.addAll(Arrays.asList("Baltimore Orioles", "Boston Red Sox", "Chicago White Sox", "Cleveland Indians", "Detroit Tigers", "Houston Astros"));
                    break;
                case 1:
                    Baseball.leagues[1].teams.addAll(Arrays.asList("Arizona Diamondbacks", "Atlanta Braves", "Chicago Cubs", "Cincinatti Reds", "Colorado Rockies", "Los Angeles Dodgers"));
                    break;
                default:
                    break;
            }
        }

    }
    public void storeTeams(Context context, long leagueId) {
        SharedPreferences sharedPrefs = context.getSharedPreferences("Teams", Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = sharedPrefs.edit();
        Set<String> set = new HashSet<String>();

        set.addAll(leagues[(int)leagueId].getTeams());
        editor.putStringSet(leagues[(int)leagueId].getLeague(),set);
        editor.commit();
    }


    public String getLeague() {
        return this.league;
    }
    public ArrayList<String> getTeams() {
        return this.teams;
    }
    public String toString() {
        return this.league;
    }

}
