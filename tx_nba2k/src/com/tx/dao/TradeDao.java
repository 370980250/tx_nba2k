package com.tx.dao;

import java.util.List;
import java.util.Map;

import com.tx.pojo.Trade;

public interface TradeDao {
	public List<Trade> queryTradeList(int gid);

	public Trade queryTradeByMaxId();

	public int addTrade(Trade trade);

	public int addTradeAndTeam(int[] ids);

	public int addTradeAndPlayer(int[] ids);

	public void updateTradeByTid(Map<String,Object> param);

}
