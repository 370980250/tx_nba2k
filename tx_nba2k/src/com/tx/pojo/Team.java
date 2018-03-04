package com.tx.pojo;

import java.util.Date;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
//队伍类
@Component
public class Team {
	//球队id
	private int id;
	//顺位
	private int pickid;
	//球队中文名
	private String tcname;
	//球队英文名
	private String tename;
	//队标
	private String pic;
	//届数
	private Grade grade;
	//胜场
	private int win;
	//负场
	private int lose;
	//更新日期
	private Date updateDate;
	//用户
	private User user;
	
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Date getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}
	public int getWin() {
		return win;
	}
	public void setWin(int win) {
		this.win = win;
	}
	public int getLose() {
		return lose;
	}
	public void setLose(int lose) {
		this.lose = lose;
	}
	public Grade getGrade() {
		return grade;
	}
	public void setGrade(Grade grade) {
		this.grade = grade;
	}
	public int getPickid() {
		return pickid;
	}
	public void setPickid(int pickid) {
		this.pickid = pickid;
	}
	public String getPic() {
		return pic;
	}
	public void setPic(String pic) {
		this.pic = pic;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTcname() {
		return tcname;
	}
	public void setTcname(String tcname) {
		this.tcname = tcname;
	}
	public String getTename() {
		return tename;
	}
	public void setTename(String tename) {
		this.tename = tename;
	}
	
}
