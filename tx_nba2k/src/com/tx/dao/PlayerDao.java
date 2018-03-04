package com.tx.dao;

import java.util.List;

import com.tx.pojo.Partion;
import com.tx.pojo.Player;
import com.tx.pojo.Team;

public interface PlayerDao {
	public int addPlayer(Player player);

	public List<Player> queryPlayerByGid(Partion partion);
	
	public List<Player> queryPlayerList(Partion partion);
	
	public List<Player> queryPlayerByTeam(Team team);

	public int getRowsCount(Partion partion);

	public int updatePlayerToTeam(Player player);
	
	public List<Player> queryPlayerByTradeId(int tid);
}
