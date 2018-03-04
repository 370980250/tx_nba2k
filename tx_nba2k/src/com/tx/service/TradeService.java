package com.tx.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tx.dao.TradeDao;
import com.tx.pojo.Grade;
import com.tx.pojo.Player;
import com.tx.pojo.Team;
import com.tx.pojo.Trade;
import com.tx.service.inter.IPlayerService;
import com.tx.service.inter.ITradeService;
@Service
public class TradeService implements ITradeService {
	@Autowired
	private TradeDao td;
	@Autowired
	private Trade trade;
	@Autowired
	private Grade grade;
	@Autowired
	private IPlayerService ips;
	@Override
	public List<Trade> queryTradeList(int gid) {
		// TODO Auto-generated method stub
		return td.queryTradeList(gid);
	}
	@Override
	public Map<String, Object> publishTrade(int gid,int[] ps1, int[] ps2, int t1,
			int t2, int price1, int price2) {
			Map<String,Object> json= new HashMap<String, Object>();
			for(int i :ps1){
				System.out.println("num:"+i);
				
			}
			System.out.println("ps1"+ps1.length);
			System.out.println("ps2"+ps2.length);
			json.put("meg", "交易球员数量必须一致");
			if(ps1.length==ps2.length){
				if(ps1.length==1){
					json.put("meg", "一换一交易差价不能大于50");
					if(Math.abs(price1-price2)<=50){ 
						trade.setState(0);
						grade.setId(gid);
						trade.setGrade(grade);
						String tradePrice = price1+"-"+price2;
						trade.setTradePrice(tradePrice);
						trade.setTradeDate(new Date());
						int flag = addTrade(trade);
						if(flag>0){
							trade = queryTradeByMaxId();
							int tid[] = {t1,t2};
							for(int t : tid){
								int[] ids = {t,trade.getId()};
								addTradeAndTeam(ids);
							}
							for(int p:ps1){
								int[] ids ={p,trade.getId()};
								flag =addTradeAndPlayer(ids);
							}
							for(int p:ps2){
								int[] ids ={p,trade.getId()};
								flag =addTradeAndPlayer(ids);
							}
							json.put("meg", "交易成功，等待审核");
			 			}
					}
				}
				if(ps1.length>1){
					json.put("meg","多换多交易差价不得大于100");
					if(Math.abs(price1-price2)<=100){
						trade.setState(0);
						grade.setId(gid);
						trade.setGrade(grade);
						String tradePrice = price1+"-"+price2;
						trade.setTradePrice(tradePrice);
						trade.setTradeDate(new Date());
						int flag = addTrade(trade);
						if(flag>0){
							trade = queryTradeByMaxId();
							int tid[] = {t1,t2};
							for(int t : tid){
								int[] ids = {t,trade.getId()};
								addTradeAndTeam(ids);
							}
							for(int p:ps1){
								int[] ids ={p,trade.getId()};
								flag =addTradeAndPlayer(ids);
							}
							for(int p:ps2){
								int[] ids ={p,trade.getId()};
								flag =addTradeAndPlayer(ids);
							}
							json.put("meg", "交易成功，等待审核");
			 			}
					}
				}
			}
		
		return json;
	}
	private int addTradeAndPlayer(int[] ids) {
		// TODO Auto-generated method stub
		return td.addTradeAndPlayer(ids);
	}
	private int addTradeAndTeam(int[] ids) {
		// TODO Auto-generated method stub
		return td.addTradeAndTeam(ids);
	}
	@Override
	public int addTrade(Trade trade) {
		// TODO Auto-generated method stub
		return td.addTrade(trade);
	}
	@Override
	public Trade queryTradeByMaxId() {
		// TODO Auto-generated method stub
		return td.queryTradeByMaxId();
	}
	@Override
	public Trade updateTradeByTid(Trade t) {
		Map<String,Object> param = new HashMap<String, Object>();
		param.put("id", t.getId());
		param.put("state", t.getState());
		param.put("v_trade", null);
		param.put("v_team", null);
		param.put("player1", null);
		param.put("player2", null);
		td.updateTradeByTid(param);
		List<Trade> tradeList =  (List<Trade>) param.get("v_trade");
		List<Player> ps1 = (List<Player>) param.get("player1");
		List<Player> ps2 = (List<Player>) param.get("player2");
		List<Team> ts = (List<Team>) param.get("v_team");
		t = tradeList.get(0);
		t.setPs1(ps1);
		t.setPs2(ps2);
		t.setTs(ts);
		return t;
	}

}
