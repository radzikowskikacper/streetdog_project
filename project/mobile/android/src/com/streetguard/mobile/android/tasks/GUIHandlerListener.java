package com.streetguard.mobile.android.tasks;

public interface GUIHandlerListener<Result>
{
	public void taskStart();

	public void taskStop(boolean cancel, boolean fail, Result res);

	public void error(String s);
}
