package com.tx.nba2kx.pojo;

import org.springframework.stereotype.Component;
/*
*权限类
*/
@Component
public class Power {
    private int id;//权限id
    private String pname;//权限名

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPname() {
        return pname;
    }

    public void setPname(String pname) {
        this.pname = pname;
    }
}
