package com.tx.nba2kx.pojo;

import java.util.Date;

public class Team {
    //球队id
    private int id;
    //顺位
    private int pickid;
    //球队中文名
    private String cname;
    //球队英文名
    private String ename;
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
    //逻辑删除
    private int isdel;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getPickid() {
        return pickid;
    }

    public void setPickid(int pickid) {
        this.pickid = pickid;
    }

    public String getCname() {
        return cname;
    }

    public void setCname(String cname) {
        this.cname = cname;
    }

    public String getEname() {
        return ename;
    }

    public void setEname(String ename) {
        this.ename = ename;
    }

    public String getPic() {
        return pic;
    }

    public void setPic(String pic) {
        this.pic = pic;
    }

    public Grade getGrade() {
        return grade;
    }

    public void setGrade(Grade grade) {
        this.grade = grade;
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

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public int getIsdel() {
        return isdel;
    }

    public void setIsdel(int isdel) {
        this.isdel = isdel;
    }
}
