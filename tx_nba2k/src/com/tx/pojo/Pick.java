package com.tx.pojo;

import org.springframework.stereotype.Component;

@Component
public class Pick {
	//id
	private int id;
	//顺位
	private int pick;
	//0表示已经被选 1表示还未被选
	private int state;
	private Grade grade;
	
	public Grade getGrade() {
		return grade;
	}
	public void setGrade(Grade grade) {
		this.grade = grade;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getPick() {
		return pick;
	}
	public void setPick(int pick) {
		this.pick = pick;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	
}
