package com.example.hsport.lab_7_rich_blanchard;

/**
 * Created by gig_r on 4/10/17.
 */

public class TypeOfFoodOrDrinks {
    private String name;

    //constructor
    private TypeOfFoodOrDrinks(String newname){
        this.name = newname;
    }



    //food
    public static final TypeOfFoodOrDrinks[] foods = {
            new TypeOfFoodOrDrinks("Breakfast"),
            new TypeOfFoodOrDrinks("Lunch"),
            new TypeOfFoodOrDrinks("Dinner")
    };

    public static final TypeOfFoodOrDrinks[] drinks = {
            new TypeOfFoodOrDrinks("Water"),
            new TypeOfFoodOrDrinks("Soda"),
            new TypeOfFoodOrDrinks("Alcoholic")
    };

    public static final TypeOfFoodOrDrinks[] breakfast = {
            new TypeOfFoodOrDrinks("Pancakes"),
            new TypeOfFoodOrDrinks("Waffles"),
            new TypeOfFoodOrDrinks("Steak and Eggs")
    };

    public static final TypeOfFoodOrDrinks[] lunch = {
            new TypeOfFoodOrDrinks("Reuben Sandwich"),
            new TypeOfFoodOrDrinks("Bacon BBQ Burger"),
            new TypeOfFoodOrDrinks("Caesar Salad")
    };

    public static final TypeOfFoodOrDrinks[] dinner = {
            new TypeOfFoodOrDrinks("Spaghetti and Meatballs"),
            new TypeOfFoodOrDrinks("Pepperoni Pizza"),
            new TypeOfFoodOrDrinks("Steak and Lobster")
    };

    public static final TypeOfFoodOrDrinks[] water = {
            new TypeOfFoodOrDrinks("Dasani"),
            new TypeOfFoodOrDrinks("Aquafina"),
            new TypeOfFoodOrDrinks("Smart Water")
    };

    public static final TypeOfFoodOrDrinks[] soda = {
            new TypeOfFoodOrDrinks("Coca-Cola"),
            new TypeOfFoodOrDrinks("Dr. Pepper"),
            new TypeOfFoodOrDrinks("Sprite")
    };

    public static final TypeOfFoodOrDrinks[] alcoholic = {
            new TypeOfFoodOrDrinks("Coors Light"),
            new TypeOfFoodOrDrinks("Moscow Mule"),
            new TypeOfFoodOrDrinks("Vodka")
    };

    public static int getDefaultIntegerValue(String food_or_drink_type) {
        switch(food_or_drink_type) {
            case "Breakfast":
                return 0;
            case "Lunch":
                return 0;
            case "Dinner":
                return 0;
            default: return 1;
        }
    }


    public String getName(){
        return name;
    }


    public String toString(){
        return this.name;
    }
}
