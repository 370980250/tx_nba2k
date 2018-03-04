package com.tx.nba2kx.pojo;

import java.util.Date;

public class Draft {
    //选秀id
    private int id;
    //选秀顺位
    private int pickid;
    //用户
    private User user;
    //队伍
    private Team team;
    //届
    private Grade grade;
    //选秀标题
    private String draftTitle;
    //选秀内容
    private String draftContext;
    //报名日期
    private Date joinDate;
    //通过日期
    private Date passDate;
    //状态
    private int state;
    //提交人
    private User admin;
    //抽签时间
    private Date drawDate;
    //删除
    private int isdel;

    public int getIsdel() {
        return isdel;
    }

    public void setIsdel(int isdel) {
        this.isdel = isdel;
    }

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

    public Grade getGrade() {
        return grade;
    }

    public void setGrade(Grade grade) {
        this.grade = grade;
    }

    public String getDraftTitle() {
        return draftTitle;
    }

    public void setDraftTitle(String draftTitle) {
        this.draftTitle = draftTitle;
    }

    public String getDraftContext() {
        return draftContext;
    }

    public void setDraftContext(String draftContext) {
        this.draftContext = draftContext;
    }

    public Date getJoinDate() {
        return joinDate;
    }

    public void setJoinDate(Date joinDate) {
        this.joinDate = joinDate;
    }

    public Date getPassDate() {
        return passDate;
    }

    public void setPassDate(Date passDate) {
        this.passDate = passDate;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    public User getAdmin() {
        return admin;
    }

    public void setAdmin(User admin) {
        this.admin = admin;
    }

    public Date getDrawDate() {
        return drawDate;
    }

    public void setDrawDate(Date drawDate) {
        this.drawDate = drawDate;
    }
}
