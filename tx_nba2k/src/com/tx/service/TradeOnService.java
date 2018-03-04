package com.tx.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tx.dao.TradeOnDao;
import com.tx.pojo.TradeOn;
import com.tx.service.inter.ITradeOnService;
@Service
public class TradeOnService implements ITradeOnService {
	@Autowired
	private TradeOnDao tod;
	@Override
	public List<TradeOn> queryTradeOnListByGid(int gid) {
		// TODO Auto-generated method stub
		return tod.queryTradeOnListByGid(gid);
	}
	@Override
	public int updateTradeOn(TradeOn tradeOn) {
		// TODO Auto-generated method stub
		return tod.updateTradeOn(tradeOn);
	}
	@Override
	public int addTradeOn(TradeOn tradeOn) {
		// TODO Auto-generated method stub
		return tod.addTradeOn(tradeOn);
	}
	@Override
	public TradeOn queryTradeOn(TradeOn tradeOn) {
		// TODO Auto-generated method stub
		return tod.queryTradeOn(tradeOn);
	}

}
