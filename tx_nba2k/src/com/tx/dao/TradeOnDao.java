package com.tx.dao;

import java.util.List;

import com.tx.pojo.TradeOn;

public interface TradeOnDao {
	public List<TradeOn> queryTradeOnListByGid(int gid);

	public int updateTradeOn(TradeOn tradeOn);

	public int addTradeOn(TradeOn tradeOn);

	public TradeOn queryTradeOn(TradeOn tradeOn);
}
