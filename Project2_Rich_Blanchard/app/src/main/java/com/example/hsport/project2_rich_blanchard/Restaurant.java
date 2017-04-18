package com.example.hsport.project2_rich_blanchard;

/**
 * Created by gig_r on 4/17/17.
 */

public class Restaurant {
    private String name;
    private String hours;
    private String address;
    private String url;
    private String phone_number;

    //initializer
    private Restaurant(String name, String hours, String address, String url, String phone_number){
        this.name = name;
        this.address = address;
        this.hours = hours;
        this.url = url;
        this.phone_number = phone_number;
    }

    public static final Restaurant[] boulder_restauraunts = {
            new Restaurant("Oak at 14th", "Dummy-Address", "MON-SAT 11:30am-2:30pm", "http://oakatfourteenth.com", "(303) 444-3622")
    };

   // public String getName(){
       // return name;
   // }
   // public String toString(){
     //   return this.name;
    //}


}
