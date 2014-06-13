package com.streetguard.mobile.android;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.Dialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.provider.Settings;
import android.support.v4.app.DialogFragment;
import android.support.v4.app.Fragment;
import android.text.method.ScrollingMovementMethod;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;

import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.GooglePlayServicesUtil;
import com.streetguard.mobile.android.tasks.GUIHandlerListener;
import com.streetguard.mobile.android.tasks.SystemRequestTask;
import com.streetguard.mobile.android.tasks.Tasks;
import com.streetguard.mobile.android.tasks.Util;

public class SystemCheckFragment extends Fragment
{
	private final static int					CONNECTION_FAILURE_RESOLUTION_REQUEST	= 9000;

	private final static String					STATUS_WINDOW_KEY						= "status_window_content";
	private final static String					TASK_PENDING_KEY						= "task_pending_key";

	private final static String					GOOGLE_SERVICES_TESTED_KEY				= "google_services_tested_key";
	private final static String					LOCATION_TESTED_KEY						= "location_tested_key";
	private final static String					NETWORK_TESTED_KEY						= "network_tested_key";
	private final static String SYSTEM_TESTED_KEY = "system_tested_key";

	private final static String					GOOGLE_SERVICES_ON_KEY					= "google_services_on_key";
	private final static String					LOCATION_ON_KEY							= "location_on_key";
	private final static String					NETWORK_ON_KEY							= "network_on_key";
	private final static String SYSTEM_ON_KEY = "system_on_key";

	private TextView							status_window;

	private Button								system_test_button;

	private SystemRequestTask<Void, Integer>	polling_task;

	private boolean								task_pending;

	private boolean								google_services_tested;
	private boolean								location_tested;
	private boolean								network_tested;
	private boolean system_tested;

	private boolean								google_services_on;
	private boolean								location_on;
	private boolean								network_on;
	private boolean system_on;

	private SystemTestListener					sys_listener;

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState)
	{
		// Inflate the layout for this fragment
		View v = inflater.inflate(R.layout.system_check_fragment, container, false);

		status_window = (TextView)v.findViewById(R.id.status_window);
		system_test_button = (Button)v.findViewById(R.id.system_test_button);

		status_window.setMovementMethod(new ScrollingMovementMethod());

		system_test_button.setOnClickListener(new View.OnClickListener()
		{
			@Override
			public void onClick(View v)
			{
				if(!google_services_tested)
					testGoogleServices();

				testSystemCommunication();
			}
		});

		if(savedInstanceState != null)
		{
			status_window.setText(savedInstanceState.getString(STATUS_WINDOW_KEY));
			task_pending = savedInstanceState.getBoolean(TASK_PENDING_KEY);

			google_services_tested = savedInstanceState.getBoolean(GOOGLE_SERVICES_TESTED_KEY);
			location_tested = savedInstanceState.getBoolean(LOCATION_TESTED_KEY);
			network_tested = savedInstanceState.getBoolean(NETWORK_TESTED_KEY);
			system_tested = savedInstanceState.getBoolean(SYSTEM_TESTED_KEY);

			google_services_on = savedInstanceState.getBoolean(GOOGLE_SERVICES_ON_KEY);
			location_on = savedInstanceState.getBoolean(LOCATION_ON_KEY);
			network_on = savedInstanceState.getBoolean(NETWORK_ON_KEY);
			system_on = savedInstanceState.getBoolean(SYSTEM_ON_KEY);

			status_window.scrollBy(0, status_window.getLineCount());
		}

		return v;
	}

	@Override
	public void onResume()
	{
		super.onResume();

		if(!google_services_on)
			testGoogleServices();

		if(!google_services_on)
			return;

		testNetworkConnectivity();

		if(!network_on)
			return;

		testLocationSources();

		if(!location_on)
			return;

		if(!system_on)
			if(!system_tested || task_pending && polling_task == null)
				testSystemCommunication();
	}

	@Override
	public void onSaveInstanceState(Bundle savedInstanceState)
	{
		savedInstanceState.putString(STATUS_WINDOW_KEY, status_window.getText().toString());
		savedInstanceState.putBoolean(TASK_PENDING_KEY, task_pending);

		savedInstanceState.putBoolean(GOOGLE_SERVICES_TESTED_KEY, google_services_tested);
		savedInstanceState.putBoolean(LOCATION_TESTED_KEY, location_tested);
		savedInstanceState.putBoolean(NETWORK_TESTED_KEY, network_tested);
		savedInstanceState.putBoolean(SYSTEM_TESTED_KEY, system_tested);

		savedInstanceState.putBoolean(GOOGLE_SERVICES_ON_KEY, google_services_on);
		savedInstanceState.putBoolean(LOCATION_ON_KEY, location_on);
		savedInstanceState.putBoolean(NETWORK_ON_KEY, network_on);
		savedInstanceState.putBoolean(SYSTEM_ON_KEY, system_on);

		super.onSaveInstanceState(savedInstanceState);
	}

	@Override
	public void onPause()
	{
		if(polling_task != null)
			polling_task.cancel(true);

		super.onPause();
	}

	@Override
	public void onAttach(Activity a)
	{
		super.onAttach(a);

		sys_listener = (SystemTestListener)a;
	}

	protected void testNetworkConnectivity()
	{
		if(!Util.testConnection(getActivity()))
		{
			if(!network_tested)
				addMessage("[-] Połączenie internetowe");

			AlertDialog dialog = createSystemConfigDialog("Brak połączenia",
						"Do poprawnego działania aplikacji \nwymagane jest połączenie internetowe",
						new DialogInterface.OnClickListener()
						{

							@Override
							public void onClick(DialogInterface dialog, int which)
							{
								Intent i = new Intent(Settings.ACTION_WIRELESS_SETTINGS);
								startActivity(i);
							}
						}, new DialogInterface.OnClickListener()
						{

							@Override
							public void onClick(DialogInterface dialog, int which)
							{
								getActivity().finish();
							}
						});

			dialog.show();

			network_on = false;
		}
		else
		{
			if(!network_on)
				addMessage("[+] Połączenie internetowe");

			network_on = true;
		}

		network_tested = true;
	}

	private void testLocationSources()
	{
		String provider = Settings.Secure.getString(getActivity().getContentResolver(),
					Settings.Secure.LOCATION_PROVIDERS_ALLOWED);

		if(provider.equals(""))
		{
			if(!location_tested)
				addMessage("[-] Usługa lokalizacji");

			AlertDialog dialog = createSystemConfigDialog("Brak lokalizacji",
						"Do poprawnego działania aplikacji \nwymagane jest pozwolenie lokalizacji",
						new DialogInterface.OnClickListener()
						{

							@Override
							public void onClick(DialogInterface dialog, int which)
							{
								Intent i = new Intent(Settings.ACTION_LOCATION_SOURCE_SETTINGS);
								startActivity(i);
							}
						}, new DialogInterface.OnClickListener()
						{

							@Override
							public void onClick(DialogInterface dialog, int which)
							{
								getActivity().finish();
							}
						});

			dialog.show();

		}
		else
		{
			if(!location_on)
				addMessage("[+] Usługa lokalizacji");

			if(!provider.contains("gps") && !location_tested)
			{
				AlertDialog dialog = createSystemConfigDialog("Źródło lokalizacji",
							"Odbiornik GPS zapewnia dokładniejsze \nokreślenie lokalizacji",
							new DialogInterface.OnClickListener()
							{

								@Override
								public void onClick(DialogInterface dialog, int which)
								{
									Intent i = new Intent(Settings.ACTION_LOCATION_SOURCE_SETTINGS);
									startActivity(i);
								}
							}, new DialogInterface.OnClickListener()
							{

								@Override
								public void onClick(DialogInterface dialog, int which)
								{}
							});

				dialog.show();
			}

			location_on = true;
		}

		location_tested = true;
	}

	private AlertDialog createSystemConfigDialog(String title, String message,
				DialogInterface.OnClickListener positive, DialogInterface.OnClickListener negative)
	{
		AlertDialog.Builder builder = new AlertDialog.Builder(getActivity());
		builder.setTitle(title).setCancelable(false).setPositiveButton("Ustawienia", positive)
					.setNegativeButton("Anuluj", negative);

		TextView myMsg = new TextView(getActivity());
		myMsg.setMaxLines(10);
		myMsg.setText(message);
		myMsg.setGravity(Gravity.CENTER_HORIZONTAL);
		builder.setView(myMsg);

		return builder.create();
	}

	private void testSystemCommunication()
	{
		polling_task = Tasks.createLookupTask(getActivity(), new GUIHandlerListener<Integer>()
		{
			@Override
			public void taskStart()
			{
				system_tested = true;
				system_test_button.setEnabled(false);

				if(!task_pending)
					addMessage("Test łączności systemu...");

				task_pending = true;
			}

			@Override
			public void taskStop(boolean cancel, boolean fail, Integer res)
			{
				if(!cancel)
				{
					task_pending = false;

					//sys_listener.onSystemTestSucceeded(0);// res);
					if(!fail)
					{
						if(res != null)
						{
							addMessage("System dostępny");
							sys_listener.onSystemTestSucceeded(res);
						}
					}
				}

				polling_task = null;
				system_test_button.setEnabled(true);
			}

			@Override
			public void error(String s)
			{
				addMessage(s);
			}

		});

		polling_task.execute();
	}

	private void testGoogleServices()
	{
		int resultCode = GooglePlayServicesUtil.isGooglePlayServicesAvailable(getActivity());

		if(ConnectionResult.SUCCESS == resultCode)
		{
			if(!google_services_on)
				addMessage("[+] Google Services");

			google_services_on = true;
		}
		else
		{
			if(!google_services_tested)
				addMessage("[-] Google Services");

			Dialog errorDialog = GooglePlayServicesUtil.getErrorDialog(resultCode, getActivity(),
						CONNECTION_FAILURE_RESOLUTION_REQUEST);

			if(errorDialog != null)
			{
				ErrorDialogFragment errorFragment = new ErrorDialogFragment();

				errorFragment.setDialog(errorDialog);

				errorFragment.show(getActivity().getSupportFragmentManager(), "Google Services");
			}
		}

		google_services_tested = true;
	}

	public void addMessage(String msg)
	{
		status_window.append(msg + "\n");

		// status_window.scrollBy(0, status_window.getLineCount());
	}

	public static class ErrorDialogFragment extends DialogFragment
	{
		// Global field to contain the error dialog
		private Dialog	mDialog;

		// Default constructor. Sets the dialog field to null
		public ErrorDialogFragment()
		{
			super();
			mDialog = null;
		}

		// Set the dialog to display
		public void setDialog(Dialog dialog)
		{
			mDialog = dialog;
		}

		// Return a Dialog to the DialogFragment.
		@Override
		public Dialog onCreateDialog(Bundle savedInstanceState)
		{
			return mDialog;
		}
	}

	interface SystemTestListener
	{
		void onSystemTestSucceeded(long id);
	}
}
