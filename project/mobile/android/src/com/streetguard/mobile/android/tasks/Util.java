package com.streetguard.mobile.android.tasks;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Formatter;

import android.app.Activity;
import android.content.Context;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.util.Log;
import android.widget.Toast;

public class Util
{
	private final static String tag = "[streetGuard - android]";
	
	public static void printToast(String s, Activity a)
	{
		Toast.makeText(a, s, Toast.LENGTH_SHORT).show();
	}
	
	public static boolean testConnection(Activity a)
	{
		ConnectivityManager connMgr = (ConnectivityManager)a.getSystemService(Context.CONNECTIVITY_SERVICE);
		NetworkInfo networkInfo = connMgr.getActiveNetworkInfo();

		return (networkInfo != null && networkInfo.isConnected());
	}
	
	public static void Log(String content)
	{
		Log.d(tag, content);
	}
	
	public static String SHA1(String password)
	{
		String sha1 = "";
		try
		{
			MessageDigest crypt = MessageDigest.getInstance("SHA-1");
			crypt.reset();
			crypt.update(password.getBytes("UTF-8"));
			sha1 = byteToHex(crypt.digest());
		}
		catch(NoSuchAlgorithmException e)
		{
			e.printStackTrace();
		}
		catch(UnsupportedEncodingException e)
		{
			e.printStackTrace();
		}
		return sha1;
	}

	static String byteToHex(final byte[] hash)
	{
		Formatter formatter = new Formatter();
		for(byte b : hash)
		{
			formatter.format("%02x", b);
		}
		String result = formatter.toString();
		formatter.close();
		return result;
	}
}
