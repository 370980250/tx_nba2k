package com.tx.action;

import java.io.IOException;
import java.net.InetAddress;
import java.net.Socket;
import java.net.UnknownHostException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.socket.TextMessage;

import com.tx.pojo.Grade;
import com.tx.pojo.Partion;
import com.tx.pojo.Player;
import com.tx.pojo.Query;
import com.tx.pojo.Team;
import com.tx.service.inter.IPlayerService;
import com.tx.service.inter.ITeamService;

@Controller
@RequestMapping("Player")
public class PlayerAction{
	@Autowired
	private ITeamService its;
	@Autowired
	private IPlayerService ips;
	@Autowired
	private Grade grade;
	@Autowired
	private Team team;
	@Autowired
	private Partion partion;
	
	boolean flag = true;
	
	@RequestMapping("/queryPlayerList.do")
	public @ResponseBody Map<String,Object> queryList(int gid,Query query,int cpage,HttpServletRequest req) throws UnknownHostException{
		Map<String,Object> json = new HashMap<String, Object>();
		grade.setId(gid);
		partion.setGrade(grade);
		partion.setPageSize(30);
		partion.setCpage(cpage);
		partion.setAcount(ips.getRowsCount(partion));
		if(query!=null){
			partion.setQuery(query);
		}
		List<Team> ts = its.queryTeamByGid(gid);
		List<Player> ps = ips.queryPlayerList(partion);
		InetAddress address = InetAddress.getLocalHost();
		String url = address.toString().substring(address.toString().indexOf("/"));
		json.put("ts", ts);
		json.put("partion", partion);
		json.put("ps", ps);
		json.put("url", url);
		return json;
	}
	@RequestMapping("/updatePlayerToTeam.do")
	public @ResponseBody Map<String,Object> updatePlayer(Player player,int tid) throws UnknownHostException, IOException{
		Map<String,Object> json = new HashMap<String, Object>();
		team.setId(tid);
		player.setTeam(team);
		json.put("meg", false);
		int flag = ips.updatePlayerToTeam(player);
		if(flag>0){
			json.put("meg", true);
		}
		return json;
	}

}
