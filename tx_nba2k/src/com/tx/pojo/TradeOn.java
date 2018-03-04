package com.tx.pojo;

import java.util.Date;

import org.springframework.stereotype.Component;
@Component
public class TradeOn {
	private int id;
	private User user;
	private Team team;
	private Player player;
	private Grade grade;
	private String tradeContext;
	private Date tradeOnDate;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Team getTeam() {
		return team;
	}
	public void setTeam(Team team) {
		this.team = team;
	}
	public Player getPlayer() {
		return player;
	}
	public void setPlayer(Player player) {
		this.player = player;
	}
	public Grade getGrade() {
		return grade;
	}
	public void setGrade(Grade grade) {
		this.grade = grade;
	}
	public String getTradeContext() {
		return tradeContext;
	}
	public void setTradeContext(String tradeContext) {
		this.tradeContext = tradeContext;
	}
	public Date getTradeOnDate() {
		return tradeOnDate;
	}
	public void setTradeOnDate(Date tradeOnDate) {
		this.tradeOnDate = tradeOnDate;
	}
	
}
