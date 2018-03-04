package com.tx.service;

import java.io.InputStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tx.dao.UserDao;
import com.tx.pojo.Partion;
import com.tx.pojo.Temp;
import com.tx.pojo.User;
import com.tx.service.inter.IUserService;

@Service
public class UserService  implements IUserService{
	@Autowired
	private UserDao ud;
	@Override
	//登录验证
	public User queryUser(User u){
		return ud.queryUser(u);	
	}
	@Override
	public User queryUserByPname(String pname) {
		// TODO Auto-generated method stub
		return ud.queryUserByPname(pname);
	}
	@Override
	public Integer addTempUser() {
		Map<String,Integer> param = new HashMap<String, Integer>();
		param.put("tempId", null);
		ud.addTempUser(param);
		return param.get("tempId");
	}
	@Override
	public Integer queryTempId() {
		return ud.queryTempId();
	}
	@Override
	public User queryUserByUname(String uname) {
		// TODO Auto-generated method stub
		return ud.queryUserByUname(uname);
	}
	@Override
	public User addUser(User user) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("pname", user.getPname());
		map.put("uname", user.getUname());
		map.put("pwd", user.getPwd());
		map.put("pid", user.getPower().getId());
		map.put("user",null);
		ud.addUser(map);
		System.out.println(map.get("user"));
		List<User> list = (List<User>) map.get("user");
		System.out.println("list:"+list.size());
		for(Object obj : list){
			User u = (User)obj;
			System.out.println(u);
			return u;
		}
		return null;
	}
	@Override
	public int updateUser(User user) {
		// TODO Auto-generated method stub
		return ud.updateUser(user);
	}
	@Override
	public List<User> queryUserList(Partion partion) {
		// TODO Auto-generated method stub
		return ud.queryUserList(partion);
	}
	@Override
	public int getRowsCount() {
		// TODO Auto-generated method stub
		return ud.getRowsCount();
	}
}
