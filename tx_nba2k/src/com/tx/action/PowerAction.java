package com.tx.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tx.pojo.Partion;
import com.tx.pojo.Power;
import com.tx.pojo.User;
import com.tx.service.inter.IPowerService;
import com.tx.service.inter.IUserService;

@Controller
@RequestMapping("Power")
public class PowerAction {
	@Autowired
	private IUserService ius;
	@Autowired
	private IPowerService ips;
	@Autowired
	private User user;
	@Autowired
	private Power power ;
	@Autowired
	private Partion partion;
	@RequestMapping("/updatePower.do")
	public @ResponseBody Map<String, Object> alertPower(int uid , int pid){
		Map<String,Object> json = new HashMap<String, Object>();
		json.put("meg", false);
		if(pid<=4){
			user.setId(uid);
			power.setId(pid);
			user.setPower(power);
			int flag = ius.updateUser(user);
			if(flag>0){
				json.put("meg", true);
			}
		}
		return json;
	}
	
	/*
	 * 查询用户和权限集合
	 * 
	 */
	@RequestMapping("/queryList.do")
	public @ResponseBody Map<String,Object> queryList(int cpage){
		Map<String,Object> json = new HashMap<String, Object>();
		List<Power> ps = ips.queryPowerList();
		partion.setPageSize(15);
		partion.setCpage(cpage);
		partion.setAcount(ius.getRowsCount());
		List<User> us= ius.queryUserList(partion);
		json.put("us", us);
		json.put("ps", ps);
		json.put("partion", partion);
		return json;
	}
}
