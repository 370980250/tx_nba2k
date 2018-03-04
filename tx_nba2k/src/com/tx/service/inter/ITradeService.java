package com.tx.service.inter;

import java.util.List;
import java.util.Map;

import com.tx.pojo.Trade;

public interface ITradeService {
	public List<Trade> queryTradeList(int gid);

	public Map<String, Object> publishTrade(int gid,int[] ps1, int[] ps2, int t1,
			int t2, int price1, int price2);
	
	public int addTrade(Trade trade);
	
	public Trade queryTradeByMaxId();

	public Trade updateTradeByTid(Trade trade);
}
