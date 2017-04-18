package com.example.hsport.richardblanchard_project2;
import java.util.Arrays;
import java.util.Date;

/**
 * Created by gig_r on 4/17/17.
 */
import java.io.Serializable;
@SuppressWarnings("serial")
public class Restauraunt implements Serializable {
    private String name;
    private String hours;
    private String address;
    private String url;
    private String phone_number;
    private int imageResourceID;
    private Double lat;
    private Double lng;

    //initializer
    private Restauraunt(String name, String hours, String address, String url, String phone_number,int imageResourceID, Double lat, Double lng){
        this.name = name;
        this.address = address;
        this.hours = hours;
        this.url = url;
        this.phone_number = phone_number;
        this.imageResourceID = imageResourceID;
        this.lat = lat;
        this.lng = lng;
    }

    public static final Restauraunt[] boulder_restauraunts = {
            new Restauraunt("Oak at 14th", "1400 Pearl St. Boulder, CO 80302", "MON-SAT 11:30am-2:30pm", "http://oakatfourteenth.com", "(303) 444-3622",R.drawable.oak_14th,40.018153,-105.277073),
            new Restauraunt("Mountain Sun Pub & Brewery", "1535 Pearl St, Boulder, CO 80302", "11 AM - 1 AM", "http://mountainsunpub.com", "(303) 546-0886",R.drawable.mountain_sun,40.019151,-105.275291),
            new Restauraunt("Snooze an A.M. Eatery", "1617 Pearl St, Boulder, CO 80302", "7 AM - 3 AM", "http://snoozeeatery.com", "(303) 225-7344",R.drawable.snooze,40.019358,-105.274261),
            new Restauraunt("Avery Brewing Company", "4910 Nautilus Ct N, Boulder, CO 80301", "3 PM - 11 PM", "http://averybrewing.com", "(303) 440-4324",R.drawable.avery,40.062531,-105.204787),
            new Restauraunt("Walnut Brewery", "1123 Walnut St, Boulder, CO 80302", "11AM–10:30PM", "http://walnutbrewery.com", "(303) 447-1345",R.drawable.walnut,40.062531,-105.204787)
    };
    public static String[] rest_details(Restauraunt rest) {
        String[] rest_details = {"Name: " + rest.name,"Hours: " + rest.address,"Address: " + rest.hours,"Website: " + rest.url,"Contact At: " +rest.phone_number};
        return rest_details;
    };

     public String getName(){
     return name;
     }
     public String toString(){
       return this.name;
    }

    public int getImageResourceID() {
        return this.imageResourceID;
    }
    public String getURL() {
        return this.url;
    }
    public Double getLat() {
        return this.lat;
    }
    public Double getLng() {
        return this.lng;
    }



}
