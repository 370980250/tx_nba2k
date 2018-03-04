package com.tx.util;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

public class JedisUtil {
	private JedisPool jp = null;
	private JedisPoolConfig jpc = null;
	private static JedisUtil ju = new JedisUtil();
	private JedisUtil(){
		//创建连接池对象
		jpc = new JedisPoolConfig();
		//最大空闲连接
		jpc.setMaxIdle(50);
		//最大连接
		jpc.setMaxTotal(300);
		//最大等待毫秒数
		jpc.setMaxWaitMillis(10000);
		//保证连接可用
		jpc.setTestOnBorrow(true);
		String url = GetIPUtil.getIP();
		jp = new JedisPool(jpc,url,6379);
		
	}
	
	public static JedisUtil init(){
		return ju;
	}
	
	public Jedis getConn(){
		return jp.getResource();
	}
}
