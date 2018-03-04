package com.tx.action;

import java.util.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tx.pojo.Grade;
import com.tx.pojo.Player;
import com.tx.pojo.Team;
import com.tx.pojo.Trade;
import com.tx.pojo.TradeOn;
import com.tx.pojo.User;
import com.tx.service.inter.IPlayerService;
import com.tx.service.inter.ITeamService;
import com.tx.service.inter.ITradeOnService;
import com.tx.service.inter.ITradeService;

@Controller
@RequestMapping("Trade")
public class TradeAction {
	@Autowired
	private ITradeService its;
	@Autowired
	private ITeamService iteam;
	@Autowired
	private IPlayerService ips;
	@Autowired
	private ITradeOnService itos;
	@Autowired
	private Trade trade;
	@Autowired
	private TradeOn tradeOn;
	@Autowired
	private Grade grade;
	@Autowired
	private Player player;
	@Autowired
	private Team team;
	@RequestMapping("/queryTradeList.do")
	@ResponseBody
	public Map<String,Object> queryTradeList(int gid,HttpSession sess){
		Map<String,Object> json = new HashMap<String, Object>();
		User user = (User)sess.getAttribute("u");
		tradeOn.setUser(user);
		if(user!=null){
			grade.setId(gid);
			System.out.println(user.getId()+"-"+grade.getId());
			tradeOn.setGrade(grade);
			Team myteam = iteam.queryTeamByUser(tradeOn);
			List<Player> myps = ips.queryPlayerByTeam(myteam); 
			json.put("myteam", myteam);
		/*	System.out.println(myteam.getId()+"-"+myteam.getGrade().getId());*/
			System.out.println(myps);
			json.put("myps", myps);
		}
		List<Trade> ts = its.queryTradeList(gid);
		List<TradeOn> tos = itos.queryTradeOnListByGid(gid);
		if(ts!=null){
			for(Trade trade:ts){
				List<Team> tss= iteam.queryTeamByTradeId(trade);
				trade.setTs(tss);
				List<Player> ps = ips.queryPlayerByTradeId(trade.getId());
				List<Player> ps1 = new ArrayList<Player>();
				List<Player> ps2 = new ArrayList<Player>();
				for(Player p : ps){
					if(p.getTeam().getId()==tss.get(0).getId()){
						ps1.add(p);
					}
					if(p.getTeam().getId()==tss.get(1).getId()){
						ps2.add(p);
					}
				}
				trade.setPs1(ps1);
				trade.setPs2(ps2);
			}
		}
		List<Team> teams = iteam.queryTeamByGid(gid);
		json.put("ts", ts);
		json.put("teams", teams);
		json.put("tos", tos);
		return json;
	}
	@RequestMapping("/publishTrade.do")
	public @ResponseBody Map<String,Object> publishTrade(int gid,int[] ps1,int[] ps2,int t1,int t2,int price1,int price2){
		Map<String,Object> json = its.publishTrade(gid,ps1,ps2,t1, t2, price1, price2);
		return json;
	}
	@RequestMapping("/passTrade.do")
	public @ResponseBody Map<String,Object> passTrade(int tid){
		Map<String,Object> json = new HashMap<String, Object>();
		trade.setId(tid);
		trade.setState(1);
		trade = its.updateTradeByTid(trade);
		List<Team>  ts = trade.getTs();
		List<Player> ps1 = trade.getPs1();
		for(Player p : ps1){
			p.setTeam(ts.get(1));
			ips.updatePlayerToTeam(p);
		}
		List<Player> ps2 = trade.getPs2();
		for(Player p : ps2){
			p.setTeam(ts.get(0));
			ips.updatePlayerToTeam(p);
		}
		json.put("meg", "交易失败");
		if(trade!=null){
			json.put("meg", "交易完成");
		}
		return json;
		
	}
	@RequestMapping("/rejectTrade.do")
	public @ResponseBody Map<String,Object> rejectTrade(int tid){
		Map<String,Object> json =new HashMap<String, Object>();
		trade.setState(2);
		trade.setId(tid);
		trade = its.updateTradeByTid(trade);
		json.put("meg", "无法拒绝");
		if(trade!=null){
			json.put("meg", "交易已驳回");
		}
		return json;
	}
	
	@RequestMapping("/TradeOnPlayer.do")
	public @ResponseBody Map<String,Object> TradeOnPlayer(int gid,int tid,int pid,String tradeContext,HttpSession sess){
		Map<String,Object> json =new HashMap<String, Object>();
		User user = (User) sess.getAttribute("u");
		if(user!=null){
			tradeOn.setUser(user);
			player.setId(pid);
			tradeOn.setPlayer(player);
			grade.setId(gid);
			tradeOn.setGrade(grade);
			team.setId(tid);
			tradeOn.setTeam(team);
			tradeOn.setTradeContext(tradeContext);
			tradeOn.setTradeOnDate(new Date());
			TradeOn to = itos.queryTradeOn(tradeOn);
			if(to==null){
				int flag = itos.addTradeOn(tradeOn);
				json.put("meg", true);
			}else{
				json.put("meg", false);
			}
		}
		return json;
		
	}
}
