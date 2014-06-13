package com.streetguard.mobile.android;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.net.ConnectivityManager;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentActivity;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentTransaction;
import android.view.Menu;
import android.view.MenuItem;
import android.view.Window;
import android.view.WindowManager;

import com.google.android.gms.common.GooglePlayServicesNotAvailableException;
import com.google.android.gms.maps.MapsInitializer;
import com.streetguard.mobile.android.SystemCheckFragment.SystemTestListener;
import com.streetguard.mobile.android.map.MapFragment;
import com.streetguard.mobile.android.tasks.Util;

public class MainActivity extends FragmentActivity implements SystemTestListener
{
	private NetworkReceiver	receiver;

	private final short		SYSTEM_CHECK_FRAGMENT	= 0;
	private final short		MAIN_FRAGMENT			= 1;
	private final short		FRAGMENTS_COUNT			= 2;
	
	private final String ACTIVE_FRAGMENT_KEY = "active_fragment_key";
	
	private short active_fragment;

	private Fragment[]		fragments_table;

	private boolean			connected;

	@Override
	protected void onCreate(Bundle savedInstanceState)
	{
		super.onCreate(savedInstanceState);
		try {
	        MapsInitializer.initialize(getApplicationContext());
	    } catch (GooglePlayServicesNotAvailableException e) {
	        // TODO Auto-generated catch block
	        e.printStackTrace();
	    }
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN);

		setContentView(R.layout.activity_main);

		connected = Util.testConnection(this);

		receiver = new NetworkReceiver();
		registerReceiver(receiver, new IntentFilter(ConnectivityManager.CONNECTIVITY_ACTION));

		fragments_table = new Fragment[FRAGMENTS_COUNT];
		
		if(savedInstanceState != null)
		{
			fragments_table[MAIN_FRAGMENT] = getSupportFragmentManager().findFragmentByTag("MAIN_FRAGMENT_TAG");
			fragments_table[SYSTEM_CHECK_FRAGMENT] = new SystemCheckFragment();//fm.findFragmentById(R.id.system_check_fragment);
			
			active_fragment = savedInstanceState.getShort(ACTIVE_FRAGMENT_KEY);
		}
		else
		{
			fragments_table[MAIN_FRAGMENT] = new MapFragment();//(MapFragment)fm.findFragmentById(R.id.map_fragment_id);
			fragments_table[SYSTEM_CHECK_FRAGMENT] = new SystemCheckFragment();//fm.findFragmentById(R.id.system_check_fragment);
		}
	}
	
	@Override
	public void onResumeFragments()
	{
		super.onResumeFragments();
		
		FragmentTransaction ftr = getSupportFragmentManager().beginTransaction();
		
		ftr.replace(R.id.fragments_container, fragments_table[active_fragment]);

		ftr.commit();
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu)
	{
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.main, menu);
		return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item)
	{
		if(item.getItemId() == R.id.debug_box_id)
		{
			FragmentTransaction ftr = getSupportFragmentManager().beginTransaction();

			if(fragments_table[SYSTEM_CHECK_FRAGMENT].isVisible())
				ftr.hide(fragments_table[SYSTEM_CHECK_FRAGMENT]);
			else
				ftr.show(fragments_table[SYSTEM_CHECK_FRAGMENT]);

			ftr.commit();
		}

		return true;
	}

	@Override
	public void onDestroy()
	{
		super.onDestroy();

		if(receiver != null)
			unregisterReceiver(receiver);
	}

	@Override
	public void onSaveInstanceState(Bundle savedInstanceState)
	{
		super.onSaveInstanceState(savedInstanceState);

		savedInstanceState.putShort(ACTIVE_FRAGMENT_KEY, active_fragment);
	}

	public void onSystemTestSucceeded(long uid)
	{

		displayFragment(active_fragment = MAIN_FRAGMENT, false);

		((MapFragment)fragments_table[MAIN_FRAGMENT]).setId(uid);
	}

	private void displayFragment(short id, boolean stack)
	{
		FragmentTransaction tr = getSupportFragmentManager().beginTransaction();

		tr.replace(R.id.fragments_container, fragments_table[MAIN_FRAGMENT], "MAIN_FRAGMENT_TAG");

		if(stack)
			tr.addToBackStack(null);

		tr.commit();
	}

	private class NetworkReceiver extends BroadcastReceiver
	{
		@Override
		public void onReceive(Context context, Intent intent)
		{
			if(Util.testConnection(MainActivity.this))
			{
				if(!connected)
				{
					Util.printToast(getString(R.string.connection_established), MainActivity.this);

					connected = true;
				}
			}
			else
			{
				Util.printToast(getString(R.string.error_no_connection), MainActivity.this);

				connected = false;
			}
		}
	}
}