package com.tx.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tx.pojo.Draft;
import com.tx.pojo.Grade;
import com.tx.pojo.Partion;
import com.tx.pojo.Player;
import com.tx.pojo.Team;
import com.tx.pojo.User;
import com.tx.service.inter.IDraftService;
import com.tx.service.inter.IPlayerService;
import com.tx.service.inter.ITeamService;
import com.tx.service.inter.IUserService;

@Controller
@RequestMapping("Team")
public class TeamAction {
	@Autowired
	private ITeamService its;
	@Autowired
	private IPlayerService ips;
	@Autowired
	private IUserService ius;
	@Autowired
	private IDraftService ids;
	@Autowired
	private Grade grade;
	@Autowired
	private Partion partion;
	@RequestMapping("/queryList.do")
	public @ResponseBody Map<String,Object> queryList(int gid){
		List<Team> ts = its.queryTeamByGid(gid);
		grade.setId(gid);
		partion.setGrade(grade);
		List<Player> ps = ips.queryPlayerByGid(partion);
		Map<String,Object> json = new HashMap<String, Object>();
		json.put("ts", ts);
		json.put("ps", ps);
		return json;
	}
	@RequestMapping("/queryManager.do")
	public @ResponseBody List<Draft> queryManager(int gid){
		List<Draft> ds = ids.queryDraftList(gid);
		return ds;
	}
	
	@RequestMapping("/queryPlayer.do")
	public @ResponseBody List<Player> queryPlayer(Team team,int gid){
		grade.setId(gid);
		team.setGrade(grade);
		List<Player> ps=  ips.queryPlayerByTeam(team);
		return ps;
	}
}
