package com.tx.dao;

import java.util.List;

import com.tx.pojo.Draft;
import com.tx.pojo.Team;
import com.tx.pojo.Trade;
import com.tx.pojo.TradeOn;

public interface TeamDao {
	public Team queryTeam(Team team);

	public int addTeam(Team team);
	
	public List<Team> queryTeamListByPick(int gid);

	public int updateTeam(Team team);
	
	public int truncateTeam(int gid);
	
	public List<Team> queryTeamByGid(int gid);
	
	public List<Team> queryTeamByTradeId(Trade trade);
	
	public List<Team> queryTeamRankByGid(int gid);
	
	public List<Team> queryTeamPlayoffRankByGid(int gid);
	
	public Team queryTeamByUser(TradeOn tradeOn);
	
	public int updateTeamUseridByTid(Draft draft);
}
