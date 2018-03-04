package com.tx.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tx.dao.PlayerDao;
import com.tx.pojo.Partion;
import com.tx.pojo.Player;
import com.tx.pojo.Team;
import com.tx.service.inter.IPlayerService;
@Service
public class PlayerService implements IPlayerService {
	@Autowired
	PlayerDao pd;
	@Override
	public int addPlayer(Player player) {
		// TODO Auto-generated method stub
		return pd.addPlayer(player);
	}
	@Override
	public List<Player> queryPlayerByGid(Partion partion) {
		// TODO Auto-generated method stub
		return pd.queryPlayerByGid(partion);
	}
	@Override
	public List<Player> queryPlayerByTeam(Team team) {
		// TODO Auto-generated method stub
		return pd.queryPlayerByTeam(team);
	}
	@Override
	public int getRowsCount(Partion partion) {
		// TODO Auto-generated method stub
		return pd.getRowsCount(partion);
	}
	@Override
	public List<Player> queryPlayerList(Partion partion) {
		// TODO Auto-generated method stub
		return pd.queryPlayerList(partion);
	}
	@Override
	public int updatePlayerToTeam(Player player) {
		// TODO Auto-generated method stub
		return pd.updatePlayerToTeam(player);
	}
	@Override
	public List<Player> queryPlayerByTradeId(int tid) {
		// TODO Auto-generated method stub
		return pd.queryPlayerByTradeId(tid);
	}

}
