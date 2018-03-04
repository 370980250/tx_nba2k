package com.tx.pojo;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Component;
@Component
//交易类
public class Trade {
	//交易id
	private int id;
	//交易时间
	private Date tradeDate;
	//交易届数
	private Grade grade;
	//提交人
	private User user;
	//交易队伍
	private List<Team> ts;
	//交易球员
	private List<Player> ps1;
	private List<Player> ps2;
	//交易价格
	private String tradePrice;
	//交易状态
	private int state;
	
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public String getTradePrice() {
		return tradePrice;
	}
	public void setTradePrice(String tradePrice) {
		this.tradePrice = tradePrice;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	
	public List<Team> getTs() {
		return ts;
	}
	public void setTs(List<Team> ts) {
		this.ts = ts;
	}
	public List<Player> getPs1() {
		return ps1;
	}
	public void setPs1(List<Player> ps1) {
		this.ps1 = ps1;
	}
	public List<Player> getPs2() {
		return ps2;
	}
	public void setPs2(List<Player> ps2) {
		this.ps2 = ps2;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Date getTradeDate() {
		return tradeDate;
	}
	public void setTradeDate(Date tradeDate) {
		this.tradeDate = tradeDate;
	}
	public Grade getGrade() {
		return grade;
	}
	public void setGrade(Grade grade) {
		this.grade = grade;
	}
	
}
