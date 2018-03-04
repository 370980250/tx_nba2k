package com.tx.nba2kx.controller;

import com.tx.nba2kx.pojo.User;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.Map;

@RestController
public class IndexAction {
   /* @RequestMapping(value = "login")
    public boolean login(User user, HttpSession session){
        boolean isLogin =  false;
        return isLogin;
    }

    @RequestMapping(value = "register")
    public boolean register(User user,HttpSession session){
        boolean isRegister = false;

        return isRegister;
    }*/

    /*@RequestMapping("test")
    public String hello(HttpSession model){
        model.setAttribute("name","beal");
        return "index";
    }*/
}
