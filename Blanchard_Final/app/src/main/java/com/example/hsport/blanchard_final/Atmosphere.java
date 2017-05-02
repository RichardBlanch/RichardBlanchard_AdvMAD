package com.example.hsport.blanchard_final;

import android.content.Context;
import android.content.SharedPreferences;
import android.util.Log;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * Created by gig_r on 5/2/17.
 */

public class Atmosphere {
    private String  doors;
    private ArrayList<String> activities = new ArrayList<>();

    //constructor
    private Atmosphere(String univ, ArrayList<String> runs){
        this.doors = univ;
        this.activities = new ArrayList<String>(runs);
    }
    //constructor
    public Atmosphere(String mountain_name){
        this.doors = mountain_name;
        this.activities = new ArrayList<String>();
    }

    public static final Atmosphere[] mountains = {
            new Atmosphere("Outside", new ArrayList<String>()),
            new Atmosphere("Inside", new ArrayList<String>()),
    };

    public void storeHeroes(Context context, int mountainID,List activities_to_save){
        SharedPreferences sharedPrefs = context.getSharedPreferences("Mountains", Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = sharedPrefs.edit();
        Set<String> set = new HashSet<String>();
        //add heroes to the set
        set.addAll(activities_to_save);
        editor.putStringSet(mountains[mountainID].getDoors(), set);
        editor.commit();
    }

    public void loadMountains(Context context, int mountainID){
        SharedPreferences sharedPrefs = context.getSharedPreferences("Mountains", Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = sharedPrefs.edit();
        Log.d("ID", "id is" + mountainID);
        Set<String> set = sharedPrefs.getStringSet(mountains[mountainID].doors, null);
        if (set != null){
            Atmosphere.mountains[mountainID].activities.addAll(set);
        }
        //Use Default
        else {
            switch (mountainID) {
                case 0:
                    Atmosphere.mountains[0].activities.addAll(Arrays.asList("Swimming", "Climbing", "Basketball"));
                    break;
                case 1:
                    Atmosphere.mountains[1].activities.addAll(Arrays.asList("Strength Training", "Treadmill", "Flag Football"));
                    break;
                default:
                    break;
            }
        }
    }


    public String getDoors(){
        return doors;
    }

    public ArrayList<String> getActivities(){
        return activities;
    }

    @Override
    public String toString() {
        return this.doors;
    }
}
