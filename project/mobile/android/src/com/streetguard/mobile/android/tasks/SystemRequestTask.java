package com.streetguard.mobile.android.tasks;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.SocketTimeoutException;
import java.net.UnknownHostException;

import org.json.JSONException;

import android.app.Activity;
import android.os.AsyncTask;

import com.streetguard.mobile.android.R;

interface RequestTask<Param, Res>
{
	public Res execute(Param... p) throws MalformedURLException, JSONException, UnknownHostException, SocketTimeoutException, IOException;
}

public class SystemRequestTask<Param, Res> extends AsyncTask<Param, Void, Res>
{
	private RequestTask<Param, Res>	req_task;
	private Activity a;
	private GUIHandlerListener<Res>	gui;
	
	private boolean						fail;

	SystemRequestTask(Activity ac,GUIHandlerListener<Res> g)
	{
		gui = g;
		a = ac;
	}
	
	public SystemRequestTask<Param, Res> setRequestTask(RequestTask<Param, Res> req)
	{
		req_task = req;
		return this;
	}
	
	public void GUIThreadError(final String content)
	{
		a.runOnUiThread(new Runnable()
		{
			@Override
			public void run()
			{
				// Util.printToast(content, a);
				gui.error(content);
			}
		});
	}

	@Override
	protected void onPreExecute()
	{
		gui.taskStart();
		
		if(!Util.testConnection(a))
		{
			GUIThreadError(a.getString(R.string.error_no_connection));
			this.cancel(true);
			return;
		}
	}

	@Override
	protected Res doInBackground(Param... pa)
	{
		Res ret = null;

		fail = true;

		try
		{
			ret = req_task.execute(pa);
			fail = false;
		}
		catch(NumberFormatException e)
		{
			GUIThreadError(a.getString(R.string.error_string_to_number_conversion));
		}
		catch(MalformedURLException e)
		{
			GUIThreadError(a.getString(R.string.error_malformed_url));
		}
		catch(UnsupportedEncodingException e)
		{
			GUIThreadError(a.getString(R.string.encoding_not_supported));
		}
		catch(UnknownHostException e)
		{
			GUIThreadError(a.getString(R.string.error_unknown_host));
		}
		catch(SocketTimeoutException s)
		{
			GUIThreadError(a.getString(R.string.error_timeout));
		}
		catch(IOException e)
		{
			String msg = e.getMessage();
			Throwable cause = e.getCause();
			
			if(msg != null && cause == null)
				GUIThreadError(msg);
			else
				GUIThreadError(a.getString(R.string.error_io));
		}
		catch(JSONException e)
		{
			GUIThreadError(a.getString(R.string.error_json));
		}

		return ret;
	}

	@Override
	protected void onPostExecute(final Res res)
	{
		gui.taskStop(false, fail, res);
	}

	@Override
	public void onCancelled()
	{
		gui.taskStop(true, fail, null);
	}
}
