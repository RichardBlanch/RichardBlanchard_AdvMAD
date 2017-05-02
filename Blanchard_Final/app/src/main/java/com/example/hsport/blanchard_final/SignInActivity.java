package com.example.hsport.blanchard_final;

import android.app.Activity;
import android.os.Bundle;
import android.view.MenuItem;
import android.app.ActionBar;

public class SignInActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_sign_in);
        ActionBar actionBar = getActionBar();
        actionBar.setDisplayHomeAsUpEnabled(true);
    }
}
