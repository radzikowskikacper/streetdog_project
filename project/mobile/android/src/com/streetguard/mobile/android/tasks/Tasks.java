package com.streetguard.mobile.android.tasks;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.SocketTimeoutException;
import java.net.URL;
import java.net.UnknownHostException;
import java.util.AbstractMap.SimpleEntry;
import java.util.ArrayList;
import java.util.HashMap;

import javax.xml.parsers.ParserConfigurationException;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.w3c.dom.Document;
import org.xml.sax.SAXException;

import android.app.Activity;

import com.google.android.gms.maps.model.LatLng;
import com.streetguard.mobile.android.R;
import com.streetguard.mobile.android.map.GMapV2Direction;

public class Tasks
{
	public static SystemRequestTask<Void, Integer> createLookupTask(final Activity a,
				final GUIHandlerListener<Integer> gui)
	{
		final SystemRequestTask<Void, Integer> task = new SystemRequestTask<Void, Integer>(a, gui);

		task.setRequestTask(new RequestTask<Void, Integer>()
		{

			@Override
			public Integer execute(Void... p) throws NumberFormatException, MalformedURLException, JSONException,
						UnknownHostException, SocketTimeoutException, IOException
			{		
				HttpURLConnection urlconn = (HttpURLConnection)(new URL(a.getString(R.string.base_server_url) // malformed
							+ a.getString(R.string.users_server_url))).openConnection(); // io

				int timeout = a.getResources().getInteger(R.integer.connect_timeout);
				
				urlconn.setConnectTimeout(timeout);
				urlconn.setReadTimeout(timeout);

				urlconn.setRequestMethod("POST");
				urlconn.setRequestProperty("Connection", "close");
				urlconn.setRequestProperty("Accept", "application/json");

				urlconn.connect(); // io
				
				try
				{					
					if(urlconn.getResponseCode() == HttpURLConnection.HTTP_OK) // io
					{
						BufferedReader r = new BufferedReader(new InputStreamReader(urlconn.getInputStream()), 8192);
						JSONObject o = new JSONObject(r.readLine());

						return o.getInt("id");
					}
					else
					{
						//task.GUIThreadError("err1");
						InputStream es = urlconn.getErrorStream();

						//task.GUIThreadError("err2");
						if(es != null)
						{	
						//	task.GUIThreadError("erro");
							String cause = new BufferedReader(new InputStreamReader(es)).readLine();
							throw new IOException(cause);
						}
						else
							throw new IOException();
					}
				}
				finally
				{
					if(urlconn != null)
						urlconn.disconnect();
				}
			}

		});

		return task;
	}

	public static SystemRequestTask<LatLng, ArrayList<LatLng>> createRouteTask(final Activity a,
				final GUIHandlerListener<ArrayList<LatLng>> gui, final long user_id, final boolean first)
	{
		final SystemRequestTask<LatLng, ArrayList<LatLng>> task = new SystemRequestTask<LatLng, ArrayList<LatLng>>(
					a, gui);
			
		task.setRequestTask(new RequestTask<LatLng, ArrayList<LatLng>>()
		{
			@Override
			public ArrayList<LatLng> execute(LatLng... pa) throws NumberFormatException,
						MalformedURLException, UnsupportedEncodingException, UnknownHostException, IOException,
						JSONException
			{
				GMapV2Direction dir = new GMapV2Direction();

				Document doc = null;
				try
				{
					doc = dir.getDocument(pa[0], pa[1], GMapV2Direction.MODE_DRIVING);
				}
				catch(ParserConfigurationException e)
				{
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				catch(SAXException e)
				{
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				ArrayList<LatLng> res = dir.getDirection(doc);

				JSONObject obj = new JSONObject();

				if(first)
					obj.put("uid", user_id);

				JSONArray param = new JSONArray();
			
				for(LatLng i : res)
				{
					JSONObject point_obj = new JSONObject();

					point_obj.put("la", i.latitude);
					point_obj.put("lo", i.longitude);

					param.put(point_obj);
				}

				obj.put("track", param);
				
				HttpURLConnection urlconn;

				if(first)
					 urlconn = (HttpURLConnection)(new URL(a.getString(R.string.base_server_url)
							+ a.getString(R.string.tracks_server_url))).openConnection();
				else
					urlconn = (HttpURLConnection)(new URL(a.getString(R.string.base_server_url)
								+ a.getString(R.string.track_server_url) + user_id)).openConnection();
					

				urlconn.setConnectTimeout(a.getResources().getInteger(R.integer.connect_timeout));

				
				urlconn.setDoOutput(true);
				if(!first)
					urlconn.setRequestMethod("PUT");


				urlconn.setRequestProperty("Connection", "close");
				urlconn.setRequestProperty("Accept", "application/json");

				urlconn.setFixedLengthStreamingMode(obj.toString().length());
				urlconn.getOutputStream().write(obj.toString().getBytes(a.getString(R.string.charset)));

				try
				{
					int resp = urlconn.getResponseCode();

					if(resp != HttpURLConnection.HTTP_CREATED && resp != HttpURLConnection.HTTP_NO_CONTENT)
					{
						InputStream es = urlconn.getErrorStream();

						if(es != null)
						{	
							String cause = new BufferedReader(new InputStreamReader(es)).readLine();
							throw new IOException(cause);
						}
						else
							throw new IOException();
					}
				}
				finally
				{
					if(urlconn != null)
						urlconn.disconnect();
				}
				
				return res;
			}
		});

		return task;
	}

	public static SystemRequestTask<LatLng, Void> createEventTask(final Activity a, final GUIHandlerListener<Void> gui,
				final long user_id, final short type, final double accuracy)
	{
		final SystemRequestTask<LatLng, Void> task = new SystemRequestTask<LatLng, Void>(a, gui);
		
		task.setRequestTask(new RequestTask<LatLng, Void>()
		{
			@Override
			public Void execute(LatLng... pa) throws NumberFormatException, MalformedURLException,
						UnsupportedEncodingException, UnknownHostException, IOException, JSONException
			{
				LatLng pos = pa[0];

				JSONObject obj = new JSONObject();
				obj.put("type", type);
				obj.put("la", pos.latitude);
				obj.put("lo", pos.longitude);
				obj.put("acc", accuracy);
				obj.put("uid", user_id);

				HttpURLConnection urlconn = (HttpURLConnection)(new URL(a.getString(R.string.base_server_url)
							+ a.getString(R.string.events_server_url))).openConnection();

				int timeout = a.getResources().getInteger(R.integer.connect_timeout);
				
				urlconn.setConnectTimeout(timeout);
				urlconn.setReadTimeout(timeout);
				
				urlconn.setRequestProperty("Content-Type", "application/json");
				urlconn.setDoOutput(true);
				urlconn.setRequestProperty("Connection", "close");

				urlconn.setFixedLengthStreamingMode(obj.toString().length());
				urlconn.getOutputStream().write(obj.toString().getBytes(a.getString(R.string.charset)));

				try
				{
					
					if(urlconn.getResponseCode() != HttpURLConnection.HTTP_CREATED)
					{
						InputStream es = urlconn.getErrorStream();

						if(es != null)
						{	
							String cause = new BufferedReader(new InputStreamReader(es)).readLine();
							throw new IOException(cause);
						}
						else
							throw new IOException();
					}
				}
				finally
				{
					if(urlconn != null)
						urlconn.disconnect();
				}

				return null;
			}
		});
		
		return task;
	}

	public static SystemRequestTask<Void, HashMap<LatLng, SimpleEntry<Integer, Double>>> createCheckTask(final Activity a,
				final GUIHandlerListener<HashMap<LatLng, SimpleEntry<Integer, Double>>> gui, final long user_id)
	{
		final SystemRequestTask<Void, HashMap<LatLng, SimpleEntry<Integer, Double>>> task = new SystemRequestTask<Void, HashMap<LatLng, SimpleEntry<Integer, Double>>>(a, gui);
		
		task.setRequestTask(new RequestTask<Void, HashMap<LatLng, SimpleEntry<Integer, Double>>>()
		{
			@Override
			public HashMap<LatLng, SimpleEntry<Integer, Double>> execute(Void... pa) throws NumberFormatException, MalformedURLException,
						UnsupportedEncodingException, UnknownHostException, IOException, JSONException
			{
				HttpURLConnection urlconn = (HttpURLConnection)(new URL(a.getString(R.string.base_server_url)
							+ a.getString(R.string.poller_server_url) + user_id)).openConnection();

				urlconn.setConnectTimeout(a.getResources().getInteger(R.integer.connect_timeout));

				urlconn.setRequestProperty("Accept", "application/json");
				urlconn.setRequestProperty("Connection", "close");

				urlconn.connect();

				try
				{
					if(urlconn.getResponseCode() == HttpURLConnection.HTTP_OK)
					{
						BufferedReader r = new BufferedReader(new InputStreamReader(urlconn.getInputStream()), 8192);
						JSONArray input = new JSONArray(r.readLine());

						HashMap<LatLng, SimpleEntry<Integer, Double>> ret = new HashMap<LatLng, SimpleEntry<Integer, Double>>();

						for(int i = 0; i < input.length(); ++i)
						{
							JSONObject objret = input.getJSONObject(i);
							
							ret.put(new LatLng(objret.getDouble("y"), objret.getDouble("x")), new SimpleEntry<Integer, Double>(objret.getInt("type"), objret.getDouble("acc")));
						}

						return ret;
					}
					else
					{
						InputStream es = urlconn.getErrorStream();

						if(es != null)
						{	
							String cause = new BufferedReader(new InputStreamReader(es)).readLine();
							throw new IOException(cause);
						}
						else
							throw new IOException();
					}
				}
				finally
				{
					urlconn.disconnect();
				}
			}
		});
		
		return task;
	}
}