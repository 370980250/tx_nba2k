package com.tx.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tx.pojo.Grade;
import com.tx.pojo.Team;
import com.tx.service.inter.ITeamService;

@Controller
@RequestMapping("Rank")
public class RankAction {
	@Autowired
	private ITeamService its ;
	@Autowired
	private Team team;
	@Autowired
	private Grade grade;
	
	@RequestMapping("/queryRank.do")
	public @ResponseBody Map<String,Object> rankInit(int gid){
		List<Team> ts = its.queryTeamRankByGid(gid);
		List<Team> pts = its.queryTeamPlayoffRankByGid(gid);
		Map<String,Object> json = new HashMap<String, Object>();
		json.put("ts", ts);
		json.put("pts", pts);
		return json;
	}
	
	@RequestMapping("/saveWin.do")
	public @ResponseBody Map<String,Object> saveWin(int[] wins,String[] tcnames,int gid){
		Map<String,Object> json = new HashMap<String, Object>();
		team.setLose(0);
		grade.setId(gid);
		team.setGrade(grade);
		for(int i=0;i<wins.length;i++){
			if(wins[i]!=0){
				team.setWin(wins[i]);
				team.setUpdateDate(new Date());
				team.setTcname(tcnames[i]);
				int flag = its.updateTeam(team);
			}
		}
		return json;
	}
	
	@RequestMapping("/saveLose.do")
	public @ResponseBody Map<String,Object> saveLose(int[] loses,String[] tcnames,int gid){
		Map<String,Object> json = new HashMap<String, Object>();
		team.setWin(0);
		grade.setId(gid);
		team.setGrade(grade);
		for(int i=0;i<loses.length;i++){
			if(loses[i]!=0){
				team.setUpdateDate(new Date());
				team.setLose(loses[i]);
				team.setTcname(tcnames[i]);
				int flag = its.updateTeam(team);
			}
		}
		return json;
	}
}
