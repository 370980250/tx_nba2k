package com.tx.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tx.dao.TeamDao;
import com.tx.pojo.Draft;
import com.tx.pojo.Team;
import com.tx.pojo.Trade;
import com.tx.pojo.TradeOn;
import com.tx.service.inter.ITeamService;
@Service
public class TeamService implements ITeamService {
	@Autowired
	private TeamDao td;
	@Override
	public Team queryTeam(Team team) {
		// TODO Auto-generated method stub
		return td.queryTeam(team);
	}
	@Override
	public int addTeam(Team team) {
		// TODO Auto-generated method stub
		return td.addTeam(team);
	}
	@Override
	public List<Team> queryTeamListByPick(int gid) {
		// TODO Auto-generated method stub
		return td.queryTeamListByPick(gid);
	}
	@Override
	public int updateTeam(Team team) {
		// TODO Auto-generated method stub
		return td.updateTeam(team);
	}
	@Override
	public int truncateTeam(int gid) {
		// TODO Auto-generated method stub
		return td.truncateTeam(gid);
	}
	@Override
	public List<Team> queryTeamByGid(int gid) {
		// TODO Auto-generated method stub
		return td.queryTeamByGid(gid);
	}
	@Override
	public List<Team> queryTeamByTradeId(Trade trade) {
		// TODO Auto-generated method stub
		return td.queryTeamByTradeId(trade);
	}
	@Override
	public List<Team> queryTeamRankByGid(int gid) {
		// TODO Auto-generated method stub
		return td.queryTeamRankByGid(gid);
	}
	@Override
	public List<Team> queryTeamPlayoffRankByGid(int gid) {
		// TODO Auto-generated method stub
		return td.queryTeamPlayoffRankByGid(gid);
	}
	@Override
	public Team queryTeamByUser(TradeOn tradeOn) {
		// TODO Auto-generated method stub
		return td.queryTeamByUser(tradeOn);
	}
	@Override
	public int updateTeamUseridByTid(Draft draft) {
		// TODO Auto-generated method stub
		return td.updateTeamUseridByTid(draft);
	}

}
