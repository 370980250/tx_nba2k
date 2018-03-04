package com.tx.nba2kx.pojo;

import java.util.Date;
import java.util.List;

public class Trade {
    //交易id
    private int id;
    //交易编号
    private int tradeNo;
    //交易时间
    private Date tradeDate;
    //交易届数
    private Grade grade;
    //管理员
    private User user;
    //交易队伍
    private Team home;
    private Team away;
    //交易球员
    private List<Player> homePlayers;
    private List<Player> awayPlayers;
    //交易价格
    private String tradePrice;
    //交易状态
    private int state;
    //逻辑删除
    private int isdel;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getTradeNo() {
        return tradeNo;
    }

    public void setTradeNo(int tradeNo) {
        this.tradeNo = tradeNo;
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

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Team getHome() {
        return home;
    }

    public void setHome(Team home) {
        this.home = home;
    }

    public Team getAway() {
        return away;
    }

    public void setAway(Team away) {
        this.away = away;
    }

    public List<Player> getHomePlayers() {
        return homePlayers;
    }

    public void setHomePlayers(List<Player> homePlayers) {
        this.homePlayers = homePlayers;
    }

    public List<Player> getAwayPlayers() {
        return awayPlayers;
    }

    public void setAwayPlayers(List<Player> awayPlayers) {
        this.awayPlayers = awayPlayers;
    }

    public String getTradePrice() {
        int homePrice = 0;
        int awayPrice = 0;
        if(awayPlayers.size()==homePlayers.size()){
            for(int i = 0 ;i<awayPlayers.size();i++){
                awayPrice += awayPlayers.get(i).getPrice();
                homePrice += homePlayers.get(i).getPrice();
            }
            return homePrice + "-" + awayPrice;
        }else{
            return tradePrice;
        }
    }

    public void setTradePrice(String tradePrice) {
        this.tradePrice = tradePrice;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    public int getIsdel() {
        return isdel;
    }

    public void setIsdel(int isdel) {
        this.isdel = isdel;
    }
}
