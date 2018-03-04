package com.tx.util;

import java.net.InetAddress;
import java.net.UnknownHostException;

public class GetIPUtil {
	public static String getIP(){
		String url = null;
		try {
			InetAddress address = InetAddress.getLocalHost();
			url = address.getHostAddress();
		} catch (UnknownHostException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return url;
	}
}
