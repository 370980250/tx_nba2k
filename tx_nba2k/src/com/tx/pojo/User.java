package com.tx.pojo;

import org.springframework.stereotype.Component;
//用户类
@Component
public class User {
	//用户id
	private int id;
	//用户名
	private String uname;
	//用户密码
	private String pwd;
	//用户昵称
	private String pname;
	//用户权限
	private Power power;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public Power getPower() {
		return power;
	}
	public void setPower(Power power) {
		this.power = power;
	}
	
}
