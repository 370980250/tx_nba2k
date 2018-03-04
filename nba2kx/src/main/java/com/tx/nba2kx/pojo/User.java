package com.tx.nba2kx.pojo;

import org.springframework.stereotype.Component;
/*
用户
 */
@Component
public class User {
    private int id;//用户id
    private String uname;//用户名
    private String pwd;//密码
    private String pname;//昵称
    private Power power;//权限
    private String msalt;//盐值
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

    public String getMsalt() {
        return msalt;
    }

    public void setMsalt(String msalt) {
        this.msalt = msalt;
    }
}
