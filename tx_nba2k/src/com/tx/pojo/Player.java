package com.tx.pojo;

import org.springframework.stereotype.Component;

//球员类
@Component
public class Player {
	//球员id
	private int id;
	//英文名
	private String ename;
	//中文名
	private String cname;
	//原队伍名
	private String tname;
	//位置
	private String position;
	//能力值
	private int ability;
	//轮数
	private String round;
	//价格
	private int price;
	//徽章
	private int badges;
	//届数
	private Grade grade;
	//球队
	private Team team;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getEname() {
		return ename;
	}
	public void setEname(String ename) {
		this.ename = ename;
	}
	public String getCname() {
		return cname;
	}
	public void setCname(String cname) {
		this.cname = cname;
	}
	public String getTname() {
		return tname;
	}
	public void setTname(String tname) {
		this.tname = tname;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public int getAbility() {
		return ability;
	}
	public void setAbility(int ability) {
		this.ability = ability;
	}
	public String getRound() {
		return round;
	}
	public void setRound(String round) {
		this.round = round;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getBadges() {
		return badges;
	}
	public void setBadges(int badges) {
		this.badges = badges;
	}
	public Grade getGrade() {
		return grade;
	}
	public void setGrade(Grade grade) {
		this.grade = grade;
	}
	public Team getTeam() {
		return team;
	}
	public void setTeam(Team team) {
		this.team = team;
	}
	
	
}
