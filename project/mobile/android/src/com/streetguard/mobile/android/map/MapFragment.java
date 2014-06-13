package com.streetguard.mobile.android.map;

import java.io.IOException;
import java.util.AbstractMap.SimpleEntry;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.concurrent.Callable;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import javax.xml.parsers.ParserConfigurationException;

import org.apache.http.client.ClientProtocolException;
import org.w3c.dom.Document;
import org.xml.sax.SAXException;

import android.location.Location;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.ImageButton;
import android.widget.Toast;

import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.GooglePlayServicesClient.ConnectionCallbacks;
import com.google.android.gms.common.GooglePlayServicesClient.OnConnectionFailedListener;
import com.google.android.gms.common.GooglePlayServicesNotAvailableException;
import com.google.android.gms.location.LocationClient;
import com.google.android.gms.location.LocationListener;
import com.google.android.gms.location.LocationRequest;
import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.GoogleMap.OnCameraChangeListener;
import com.google.android.gms.maps.GoogleMap.OnMapClickListener;
import com.google.android.gms.maps.GoogleMap.OnMapLongClickListener;
import com.google.android.gms.maps.GoogleMap.OnMarkerClickListener;
import com.google.android.gms.maps.GoogleMap.OnMyLocationButtonClickListener;
import com.google.android.gms.maps.MapView;
import com.google.android.gms.maps.MapsInitializer;
import com.google.android.gms.maps.model.BitmapDescriptorFactory;
import com.google.android.gms.maps.model.CameraPosition;
import com.google.android.gms.maps.model.Circle;
import com.google.android.gms.maps.model.CircleOptions;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.Marker;
import com.google.android.gms.maps.model.MarkerOptions;
import com.google.android.gms.maps.model.Polyline;
import com.google.android.gms.maps.model.PolylineOptions;
import com.streetguard.mobile.android.R;
import com.streetguard.mobile.android.tasks.GUIHandlerListener;
import com.streetguard.mobile.android.tasks.SystemRequestTask;
import com.streetguard.mobile.android.tasks.Tasks;
import com.streetguard.mobile.android.tasks.Util;

public class MapFragment extends Fragment

{
	// bundle keys

	static final private String											ROUTE_TASK_PENDING_KEY	= "route_task_pending_key";
	static final private String											EVENT_TASK_PENDING_KEY	= "event_task_pending_key";
	static final private String											EVENT_TASK_TYPE_KEY		= "event_task_type_key";
	static final private String											LOCATION_POINT_KEY		= "location_point_key";
	static final private String											ROUTE_TARGET_KEY		= "route_target_key";
	static final private String EVENTS_ON_ROUTE_KEY = "events_on_route_key";
	static final private String MARKER_OPTIONS_KEY = "marker_options_key";
	static final private String MY_EVENTS_KEY = "my_events_key";
	static final private String ROUTE_POINTS_KEY = "route_points_key";
	static final private String USER_ID_KEY = "user_id_key";
	static final private String FIRST_ROUTE_KEY = "first_route_key";
	static final private String ACCURACY_KEY = "accuracy_key";
	static final private String MARKER_BACKGROUND_KEY = "marker_background_key";
	
	static final private String CHECKING_ROUTE_KEY = "checking_route_key";
	static final private String LOCALIZE_KEY = "localize_key";

	// route
	private Polyline												route_path;
	private Circle													current_point, target_point;
	private ArrayList<LatLng>										route_points;
	private boolean													route_task_pending;
	private SystemRequestTask<LatLng, ArrayList<LatLng>>	route_task;
	private LatLng													target;

	private HashMap<LatLng, SimpleEntry<Integer, Double>> events_on_route;
	
	ScheduledExecutorService poll_schedule_executor ;
	SystemRequestTask<Void, HashMap<LatLng, SimpleEntry<Integer, Double>>> check_task;
private boolean checking;
	
	// events
	private boolean													event_task_pending;
	private short													event_task_type;									// 0
																														// -
																														// radar,
																														// 1
																														// -
																														// crash
	private LatLng													event_point;
	private SystemRequestTask<LatLng, Void>							event_task;
	private HashMap<LatLng, SimpleEntry<Integer, Double>> my_events;
	
	private ArrayList<MarkerOptions> marker_options;
	private ArrayList<CircleOptions> marker_background_options;
	
	private final static short RADAR_EVENT_MARKER = 0;
	private final static short CRASH_EVENT_MARKER = 1;
	private final static short MY_EVENT_MARKER = 2;

	
	private float													speed;

	// map
	private boolean													localize, updated_cam;
	
	private double accuracy;
	private double curr_accuracy;

	private LocationClientCallbacks									location_callbacks;
	private MapEventsCallbacks										map_callbacks;

	private LocationClient											loc;
	private MapView													map_view;
	private GoogleMap												map;

	private LatLng													current_pos, view_pos;

	private long													user_id;
	
	private boolean first_route;

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState)
	{
		View v = inflater.inflate(R.layout.map_fragment, container, false);

		((ImageButton)v.findViewById(R.id.x_button)).setOnClickListener(new OnClickListener()
		{
			@Override
			public void onClick(View v)
			{
				cancelRoute();
			}
		});

		((ImageButton)v.findViewById(R.id.crash_button)).setOnClickListener(new OnClickListener()
		{

			@Override
			public void onClick(View v)
			{
				if(current_pos == null)
					return;
				
				event_point = current_pos;
				addEvent((short)1);
			}

		});

		((ImageButton)v.findViewById(R.id.radar_button)).setOnClickListener(new OnClickListener()
		{

			@Override
			public void onClick(View v)
			{
				if(current_pos == null)
					return;
				
				event_point = current_pos;
				addEvent((short)0);
			}

		});
		
		

		map_view = (MapView)v.findViewById(R.id.map);
		map_view.onCreate(savedInstanceState);

		map_callbacks = new MapEventsCallbacks();
		location_callbacks = new LocationClientCallbacks();

		loc = new LocationClient(getActivity(), location_callbacks, location_callbacks);

		first_route = true;
		if(savedInstanceState != null)
		{
			event_task_pending = savedInstanceState.getBoolean(EVENT_TASK_PENDING_KEY);
			event_task_type = savedInstanceState.getShort(EVENT_TASK_TYPE_KEY);

			route_task_pending = savedInstanceState.getBoolean(ROUTE_TASK_PENDING_KEY);
			current_pos = (LatLng)savedInstanceState.getParcelable(LOCATION_POINT_KEY);

			target = (LatLng)savedInstanceState.getParcelable(ROUTE_TARGET_KEY);
			
			marker_options = savedInstanceState.getParcelableArrayList(MARKER_OPTIONS_KEY);
			events_on_route = (HashMap<LatLng, SimpleEntry<Integer, Double>>)savedInstanceState.getSerializable(EVENTS_ON_ROUTE_KEY);
			my_events = (HashMap<LatLng, SimpleEntry<Integer, Double>>)savedInstanceState.getSerializable(MY_EVENTS_KEY);
			
			route_points = savedInstanceState.getParcelableArrayList(ROUTE_POINTS_KEY);
			
			user_id = savedInstanceState.getLong(USER_ID_KEY);
			
			first_route = savedInstanceState.getBoolean(FIRST_ROUTE_KEY);
			
			accuracy = savedInstanceState.getDouble(ACCURACY_KEY);
			
			marker_background_options = savedInstanceState.getParcelableArrayList(MARKER_BACKGROUND_KEY);
			checking = savedInstanceState.getBoolean(CHECKING_ROUTE_KEY);
			
			localize = savedInstanceState.getBoolean(LOCALIZE_KEY);
		}
		else
		{
			try
			{
				MapsInitializer.initialize(getActivity());
			}
			catch(GooglePlayServicesNotAvailableException e)
			{
				e.printStackTrace();
			}
			
			marker_options = new ArrayList<MarkerOptions>();
			
			marker_options.add(RADAR_EVENT_MARKER, new MarkerOptions().title("Radar").icon(BitmapDescriptorFactory.defaultMarker(BitmapDescriptorFactory.HUE_YELLOW)));
			marker_options.add(CRASH_EVENT_MARKER, new MarkerOptions().title("Wypadek").icon(BitmapDescriptorFactory.defaultMarker(BitmapDescriptorFactory.HUE_RED)));
			marker_options.add(MY_EVENT_MARKER, new MarkerOptions());
			
			marker_background_options = new ArrayList<CircleOptions>();
			
			marker_background_options.add(new CircleOptions().fillColor(0x22ffff00).strokeWidth(0));
			marker_background_options.add(new CircleOptions().fillColor(0x22ff0000).strokeWidth(0));
			
			localize = true;
		}

		return v;
	}
	
	public void setId(long id_)
	{
		user_id = id_;
	}

	@Override
	public void onStart()
	{
		super.onStart();

		loc.connect();
	}

	@Override
	public void onResume()
	{
		super.onResume();

		map_view.onResume();

		initializeMap();

		if(current_pos != null)
			map.animateCamera(CameraUpdateFactory.newLatLng(current_pos));

		if(route_task_pending)
		{
			if(route_task == null)
				addRoute(target);
		}
		else if(event_task_pending)
		{
			if(event_task == null)
				addEvent(event_task_type);
		}
		
		if(checking)
			addCheckTask();

		if(events_on_route != null)
			drawEvents(events_on_route);
		
		if(my_events != null)
			drawEvents(my_events);
		
		if(route_points != null)
			drawPath(route_points);
	}

	@Override
	public void onPause()
	{
		if(loc.isConnected())
			loc.removeLocationUpdates(map_callbacks);

		map_view.onPause();
		
		if(route_task != null)
			route_task.cancel(true);
		else if(event_task != null)
			event_task.cancel(true);
		
		if(poll_schedule_executor != null)
			poll_schedule_executor.shutdown();

		super.onPause();
	}

	@Override
	public void onStop()
	{
		loc.disconnect();

		super.onStop();
	}

	@Override
	public void onDestroy()
	{
		map_view.onDestroy();
		super.onDestroy();
	}

	@Override
	public void onSaveInstanceState(Bundle savedInstanceState)
	{
		super.onSaveInstanceState(savedInstanceState);

		map_view.onSaveInstanceState(savedInstanceState);

		savedInstanceState.putBoolean(EVENT_TASK_PENDING_KEY, event_task_pending);
		savedInstanceState.putShort(EVENT_TASK_TYPE_KEY, event_task_type);

		savedInstanceState.putBoolean(ROUTE_TASK_PENDING_KEY, route_task_pending);
		savedInstanceState.putParcelable(LOCATION_POINT_KEY, current_pos);
		savedInstanceState.putParcelable(ROUTE_TARGET_KEY, target);
		
		savedInstanceState.putSerializable(EVENTS_ON_ROUTE_KEY, events_on_route);
		savedInstanceState.putSerializable(MY_EVENTS_KEY, my_events);
		
		savedInstanceState.putParcelableArrayList(MARKER_OPTIONS_KEY, marker_options);
		savedInstanceState.putParcelableArrayList(ROUTE_POINTS_KEY, route_points);
		
		savedInstanceState.putLong(USER_ID_KEY, user_id);
		
		savedInstanceState.putBoolean(FIRST_ROUTE_KEY, first_route);
		savedInstanceState.putDouble(ACCURACY_KEY, accuracy);
		savedInstanceState.putBoolean(CHECKING_ROUTE_KEY, checking);
		savedInstanceState.putBoolean(LOCALIZE_KEY, localize);
		
		savedInstanceState.putParcelableArrayList(MARKER_BACKGROUND_KEY, marker_background_options);
	}

	@Override
	public void onLowMemory()
	{
		super.onLowMemory();

		map_view.onLowMemory();
	}
	
	private void addRouteEvents(HashMap<LatLng, SimpleEntry<Integer, Double>> events)
	{		
		if(events_on_route == null)
			events_on_route = new HashMap<LatLng, SimpleEntry<Integer, Double>>();
		
		events_on_route.putAll(events);
		
		drawEvents(events);
	}
	
	private void drawEvents(HashMap<LatLng, SimpleEntry<Integer, Double>> events)
	{
		for(LatLng p : events.keySet())
		{
			SimpleEntry<Integer, Double> en = events.get(p);

			map.addMarker(marker_options.get(en.getKey()).position(p));
			map.addCircle(marker_background_options.get(en.getKey()).center(p).radius(en.getValue()));
		}
	}

	private void drawPath(ArrayList<LatLng> rp)
	{
		PolylineOptions rectLine = new PolylineOptions().width(5).color(0x880000ff);
		CircleOptions circleOptions = new CircleOptions().center(route_points.get(0)).radius(10).zIndex((float)0.1)
					.strokeWidth(0).fillColor(0x8800ff00);

		
			rectLine.addAll(rp);

		route_path = map.addPolyline(rectLine);
		current_point = map.addCircle(circleOptions);

		circleOptions.fillColor(0x88ffff00);
		circleOptions.center(rp.get(route_points.size() - 1));

		target_point = map.addCircle(circleOptions);
		
/*		for(LatLng p : rp)
		{
			circleOptions.center(p).radius(1);
			map.addCircle(circleOptions);
		}*/
	}

	private void initializeMap()
	{
		map = map_view.getMap();

		if(map == null)
			return;
						
		map.setMyLocationEnabled(true);

		map.setOnMapLongClickListener(map_callbacks);
		map.setOnCameraChangeListener(map_callbacks);
		map.setOnMyLocationButtonClickListener(map_callbacks);
		map.setOnMarkerClickListener(new OnMarkerClickListener()
		{

			@Override
			public boolean onMarkerClick(Marker marker)
			{
				// TODO Auto-generated method stub
				
				return false;
			}
			
		});
		map.setOnMapClickListener(new OnMapClickListener()
		{

			@Override
			public void onMapClick(LatLng point)
			{
				event_point = point;
				
				addEvent((short)1);
			}
			
		});

		updated_cam = true;
	}

	private void addRoute(final LatLng point)
	{
		
		
		(route_task = Tasks.createRouteTask(getActivity(), new GUIHandlerListener<ArrayList<LatLng>>()
		{

			@Override
			public void taskStart()
			{
				route_task_pending = true;
			}

			@Override
			public void taskStop(boolean cancel, boolean fail, ArrayList<LatLng> res)
			{
				if(!cancel && !fail)
				{
					first_route = false;
					if(route_points == null)
						route_points = new ArrayList<LatLng>();
					route_points.addAll(res);
					drawPath(route_points);
					
					addCheckTask();
					
					checking = true;
				}
				else
				{
					if(route_points != null)
						route_points.clear();
						
						route_points = null;
				}
				
				if(!cancel)
					route_task_pending = false;
				
				route_task = null;
			}

			@Override
			public void error(String s)
			{
				Toast.makeText(getActivity(), s, Toast.LENGTH_SHORT).show();
			}

		}, user_id, first_route)).execute(current_pos, point);
	}
	
	private void addCheckTask()
	{
		poll_schedule_executor = Executors.newSingleThreadScheduledExecutor();
		poll_schedule_executor.scheduleWithFixedDelay(new Runnable() {
	        public void run(){
	    		getActivity().runOnUiThread(new Runnable()
	    		{
	    			@Override
	    			public void run()
	    			{
			            (check_task = Tasks.createCheckTask(getActivity(), new GUIHandlerListener<HashMap<LatLng, SimpleEntry<Integer, Double>>>()
			            {

							@Override
							public void taskStart()
							{
								//Util.printToast(String.valueOf(user_id), getActivity());
							}

							@Override
							public void taskStop(boolean cancel, boolean fail,
										HashMap<LatLng, SimpleEntry<Integer, Double>> res)
							{
								if(!cancel && !fail)	
								{
									map.clear();
									if(events_on_route != null)
									events_on_route.clear();
									
									if(my_events != null)
										drawEvents(my_events);
									
									drawPath(route_points);
									
									if(res != null)		
										addRouteEvents(res);
								}
							}

							@Override
							public void error(String s)
							{
								Toast.makeText(getActivity(), s, Toast.LENGTH_SHORT).show();
								
							}

			            	
			            }, user_id)).execute();
	    			}
	    		});
	    		
	        }
	    },1,
	    5,
	    TimeUnit.SECONDS);
	}

	private void addEvent(final short event_type)
	{
		if((curr_accuracy = accuracy) > 500)
		{
			Util.printToast("Zbyt mała dokładność pozycji aby wysłac zdarzenie", getActivity());
			return;
		}
		
		(event_task = Tasks.createEventTask(getActivity(), new GUIHandlerListener<Void>()
		{
			@Override
			public void taskStart()
			{
				event_task_pending = true;
			}

			@Override
			public void taskStop(boolean cancel, boolean fail, Void res)
			{
				if(!cancel && !fail)
				{
					MarkerOptions opts = new MarkerOptions();
					opts.position(event_point).title("Event");

					if(my_events == null)
						my_events = new HashMap<LatLng, SimpleEntry<Integer, Double>>();
					
					my_events.put(event_point, new SimpleEntry<Integer, Double>((int)event_type, curr_accuracy));
					
					marker_options.get(event_type).position(event_point);
					map.addMarker(marker_options.get(event_type));
					
					map.addCircle(marker_background_options.get(event_type).center(event_point).radius(curr_accuracy));
				}
				
				if(!cancel)
					event_task_pending = false;
				
				event_task = null;
			}

			@Override
			public void error(String s)
			{
				Toast.makeText(getActivity(), s, Toast.LENGTH_SHORT).show();
			}

		}, user_id, event_type, accuracy)).execute(event_point);
	}

	private void cancelRoute()
	{
		if(route_task != null)
			route_task.cancel(true);
		
		if(route_path == null)
			return;
		
		if(poll_schedule_executor != null)
			poll_schedule_executor.shutdown();

		route_path.remove();
		current_point.remove();
		target_point.remove();
		
		if(route_points != null)
		route_points.clear();
		
		route_points = null;
		route_path = null;
		
		map.clear();
		if(events_on_route != null)
		events_on_route.clear();
		
		if(my_events != null)
			drawEvents(my_events);
		
		checking = false;
	}

	class LocationClientCallbacks implements ConnectionCallbacks, OnConnectionFailedListener
	{
		@Override
		public void onConnectionFailed(ConnectionResult arg0)
		{
			// Util.printToast("conn failed", getActivity());

		}

		@Override
		public void onConnected(Bundle connectionHint)
		{
			Location last_loc = loc.getLastLocation();

			if(last_loc != null)
				map.animateCamera(CameraUpdateFactory.newLatLng(new LatLng(last_loc.getLatitude(), last_loc.getLongitude())));

			LocationRequest req = LocationRequest.create();

			req.setPriority(LocationRequest.PRIORITY_HIGH_ACCURACY);
			req.setInterval(500);
			req.setFastestInterval(500);

			loc.requestLocationUpdates(req, map_callbacks);
		}

		@Override
		public void onDisconnected()
		{
			// Util.printToast("disconnected", getActivity());
		}
	}

	class MapEventsCallbacks implements LocationListener, OnMapLongClickListener, OnCameraChangeListener,
				OnMyLocationButtonClickListener
	{

		@Override
		public void onLocationChanged(Location arg0)
		{
			updated_cam = true;
			accuracy = arg0.getAccuracy();
			current_pos = new LatLng(arg0.getLatitude(), arg0.getLongitude());

			if(map != null && localize)
			{
				map.moveCamera(CameraUpdateFactory.newLatLng(current_pos));
				map.animateCamera(CameraUpdateFactory.zoomTo(15));
			}
			
			if(arg0.getSpeed() != speed)
			{
				speed = arg0.getSpeed();

				// Util.printToast("Speed: " + String.valueOf(speed),
				// getActivity());
			}

		}

		@Override
		public void onMapLongClick(LatLng point)
		{
			if(current_pos == null || route_task != null)
				return;	

			cancelRoute();
			
			addRoute(target = point);
		}

		@Override
		public void onCameraChange(CameraPosition position)
		{
			if(!updated_cam)
				localize = false;
			else
				updated_cam = false;
		}

		@Override
		public boolean onMyLocationButtonClick()
		{
			return !(localize = true);
		}
	}
}
