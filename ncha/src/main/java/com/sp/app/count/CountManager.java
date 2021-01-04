package com.sp.app.count;

import java.util.Calendar;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

@WebListener
public class CountManager implements HttpSessionListener{
	private static int currentCount;
	private static long toDayCount, yesterDayCount, totalCount;
	
	public CountManager() {
		TimerTask task=new TimerTask() {
			@Override
			public void run() {
				yesterDayCount=toDayCount;
				toDayCount=0;
			}
		};
		
		Timer timer =new Timer();
		Calendar cal=Calendar.getInstance();
		cal.add(Calendar.DATE, 1);
		
		cal.set(Calendar.HOUR, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);
		
		
		timer.schedule(task, cal.getTime(), 1000*60*60*24);
	}
	
	public static void init(long toDay, long yesterDay, long total) {
		toDayCount=toDay;
		yesterDayCount=yesterDay;
		totalCount=total;
	}
	public static int getCurrentCount() {
		return currentCount;
	}
	public static long getTodayCount() {
		return toDayCount;
	}
	public static long getYesterDayCount() {
		return yesterDayCount;
	}
	public static long getTotalCount() {
		return totalCount;
	}

	@Override
	public void sessionCreated(HttpSessionEvent se) {
		synchronized (se) {
			currentCount++;
			toDayCount++;
			totalCount++;
		}
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent se) {
		
		synchronized (se) {
			currentCount--;
			if(currentCount<0) {
				currentCount=0;
			}
		}
	}

}
