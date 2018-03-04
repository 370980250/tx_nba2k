package com.tx.service.inter;

import java.util.List;

import com.tx.pojo.Partion;
import com.tx.pojo.Temp;
import com.tx.pojo.User;

public interface IUserService {
	public User queryUser(User u);
	
	public User queryUserByPname(String pname);
	
	public Integer addTempUser();

	public Integer queryTempId();

	public User queryUserByUname(String uname);

	public User addUser(User user);

	public int updateUser(User user);

	public List<User> queryUserList(Partion partion);

	public int getRowsCount();

}
