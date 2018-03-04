package com.tx.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tx.pojo.Power;
import com.tx.pojo.User;
import com.tx.service.inter.IPowerService;
import com.tx.service.inter.IUserService;

@Controller
@RequestMapping("User")
public class UserAction {
	@Autowired
	private IUserService ius;
	@Autowired
	private IPowerService ips;
	@Autowired
	private Power power;
	/*
	 * 登录
	 */
	@RequestMapping("/login.do")
	public @ResponseBody User login(User u,HttpSession session){
		u = ius.queryUser(u);
		if(u!=null){
			session.setAttribute("u", u);
		}
		return u;
	}
	/*
	 * 注销
	 */
	@RequestMapping("/exit.do")
	public @ResponseBody boolean exit(HttpSession session){
		session.removeAttribute("u");		
		return true;
	}
	/*
	 * 注册
	 */
	@RequestMapping(value="/reg.do",method=RequestMethod.POST)
	public @ResponseBody Map<String,Object> reg(User user,HttpSession sess){
		Map<String,Object> json = new HashMap<String, Object>();
		User u  = ius.queryUserByUname(user.getUname());
		json.put("meg", false);
		if(u==null){
			power.setId(1);
			user.setPower(power);
			user = ius.addUser(user);
			if(user!= null){
				sess.setAttribute("u", user);
				json.put("meg", true);
			}
		}
		return json;
	}
	/*
	 * 验证用户名
	 */
	@RequestMapping("/RegUser.do")
	public @ResponseBody Map<String,Object> regUser(String uname){
		Map<String,Object> json = new HashMap<String, Object>();
		User u  =  ius.queryUserByUname(uname);
		if(u==null){
			json.put("meg", true);
		}else{
			json.put("meg", false);
		}
		return json;
	}
	/*
	 * 验证昵称
	 */
	@RequestMapping("/RegPname.do")
	public @ResponseBody Map<String,Object> regPname(String pname){
		Map<String,Object> json = new HashMap<String, Object>();
		User u  =  ius.queryUserByPname(pname);
		if(u==null){
			json.put("meg", true);
		}else{
			json.put("meg", false);
		}
		return json;
	}
	/*
	 * 修改密码
	 */
	@RequestMapping("/alterUser.do")
	public @ResponseBody Map<String,Object> alterUser(User user,HttpSession sess){
		Map<String,Object> json = new HashMap<String, Object>();
		User u  = (User) sess.getAttribute("u");
		json.put("meg", false);
		if(ius.queryUserByPname(user.getPname())==null){
			u.setPname(user.getPname());
			u.setPwd(user.getPwd());
			int flag = ius.updateUser(u);
			if(flag>0){
				json.put("meg", true);
			}
		}
		return json;
	}
	
	
}

