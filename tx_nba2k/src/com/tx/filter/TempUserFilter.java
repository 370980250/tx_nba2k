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
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import com.tx.service.UserService;
import com.tx.service.inter.IUserService;
public class TempUserFilter implements Filter{
	private IUserService ius;
	
	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void doFilter(ServletRequest arg0, ServletResponse arg1,
			FilterChain arg2) throws IOException, ServletException {
		HttpServletRequest req= (HttpServletRequest) arg0;
		HttpServletResponse resp = (HttpServletResponse) arg1;
		HttpSession sess = req.getSession();
		Integer tempId = (Integer) sess.getAttribute("tempId");
		if(tempId!=null){
			arg2.doFilter(req, resp);
		}else{
			tempId = ius.addTempUser();
			if(tempId!=null){
				sess.setAttribute("tempId", tempId);
				//动态的拼一个绝对路径
				String basePath = req.getScheme()+"://"+req.getServerName()+":"+req.getServerPort()+req.getContextPath()+"/";
				resp.sendRedirect(basePath+"2k/main.jsp");
			}
		}
	}

	@Override
	public void init(FilterConfig fConfig) throws ServletException {
	        ApplicationContext cxt = new ClassPathXmlApplicationContext("classpath:springMVC.xml");
	        if(cxt != null && cxt.getBean("userService") != null && ius == null){
	        	ius = (UserService) cxt.getBean("userService");        
	        }
	}
}
	

