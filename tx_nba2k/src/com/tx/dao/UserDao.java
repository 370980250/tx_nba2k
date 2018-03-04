package com.tx.dao;

import java.util.List;
import java.util.Map;

import com.tx.pojo.Partion;
import com.tx.pojo.Temp;
import com.tx.pojo.User;

public interface UserDao {
	//登录验证
	public User queryUser(User u);
	//注册
	public int regUser(User u);
	//验证用户名是否存在
	public User queryUserByUname(String uname);
	//根据pname查用户
	public User queryUserByPname(String pname);
	//创建临时用户
	public void addTempUser(Map<String,Integer> param);
	//查询临时用户
	public Integer queryTempId();
	//注册用户
	public int addUser(Map<String,Object> map);
	//修改用户
	public int updateUser(User user);
	//查询用户集合
	public List<User> queryUserList(Partion partion);
	//查询用户总数
	public int getRowsCount();

	
}
