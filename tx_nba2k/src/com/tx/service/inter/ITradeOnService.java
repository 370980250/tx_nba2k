package com.tx.service.inter;

import java.util.List;

import com.tx.pojo.TradeOn;

public interface ITradeOnService {
	public List<TradeOn> queryTradeOnListByGid(int gid);

	public int updateTradeOn(TradeOn tradeOn);

	public int addTradeOn(TradeOn tradeOn);

	public TradeOn queryTradeOn(TradeOn tradeOn);
}
