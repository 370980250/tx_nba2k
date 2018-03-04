package com.tx.nba2kx.pojo;
/*
    届
 */
public class Grade {
    //id
    private int id;
    //名称
    private String gname;
    //抽签标题
    private String drawTitle;
    //抽签内容
    private String drawContext;
    //报名标题
    private String joinTitle;
    //报名内容
    private String joinContext;
    //联赛可报名状态
    private int state;
    //是否允许抽签
    private int allowDraw;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getGname() {
        return gname;
    }

    public void setGname(String gname) {
        this.gname = gname;
    }

    public String getDrawTitle() {
        return drawTitle;
    }

    public void setDrawTitle(String drawTitle) {
        this.drawTitle = drawTitle;
    }

    public String getDrawContext() {
        return drawContext;
    }

    public void setDrawContext(String drawContext) {
        this.drawContext = drawContext;
    }

    public String getJoinTitle() {
        return joinTitle;
    }

    public void setJoinTitle(String joinTitle) {
        this.joinTitle = joinTitle;
    }

    public String getJoinContext() {
        return joinContext;
    }

    public void setJoinContext(String joinContext) {
        this.joinContext = joinContext;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    public int getAllowDraw() {
        return allowDraw;
    }

    public void setAllowDraw(int allowDraw) {
        this.allowDraw = allowDraw;
    }
}
