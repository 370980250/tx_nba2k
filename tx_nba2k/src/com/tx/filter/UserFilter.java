package com.tx.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.tx.pojo.User;


public class UserFilter implements Filter{

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doFilter(ServletRequest arg0, ServletResponse arg1,
			FilterChain arg2) throws IOException, ServletException {
		// TODO Auto-generated method stub
		HttpServletRequest req = (HttpServletRequest) arg0;
		HttpServletResponse resp = (HttpServletResponse) arg1;
		HttpSession sess = req.getSession();
		String sPath = req.getServletPath();
		String basePath = req.getScheme()+"://"+req.getServerName()+":"+req.getServerPort()+req.getContextPath()+"/";
		User u  = (User) sess.getAttribute("u");
		if(sPath.equals("/2k/user.jsp")||sPath.equals("/2k/power.jsp")){
			if((u!=null&&sPath.equals("/2k/user.jsp"))||(u!=null&&u.getPower().getId()==4&&sPath.equals("/2k/power.jsp"))){
				arg2.doFilter(req, resp);
			}else{
				resp.sendRedirect(basePath+"2k/main.jsp");
			}
		}else{
			arg2.doFilter(req, resp);
		}
		
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		
	}

}
