package com.tx.action;

import java.util.List;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tx.pojo.Announcement;
import com.tx.pojo.User;
import com.tx.service.inter.IAnnouncementService;

@Controller
@RequestMapping("Anno")
public class AnnouncementAction {
	@Autowired
	private IAnnouncementService ias;
	
	@RequestMapping("/queryAnno.do")
	public @ResponseBody List<Announcement> queryAnnouncementList(){
		List<Announcement> as = ias.queryAnnouncementList();
		return as;
		
	}
	
	@RequestMapping("/addAnno.do")
	public @ResponseBody int addAnno(Announcement anno,HttpSession session){
		User u = (User) session.getAttribute("u");
		anno.setU(u);
		if(anno.getTitle()!=null&&!"".equals(anno.getTitle())&&anno.getContext()!=null&&!"".equals(anno.getContext())){
			return ias.addAnno(anno);			
		}
		return 0;
	}
	@RequestMapping("/updateAnno.do")
	public @ResponseBody int updateAnno(Announcement anno,HttpSession session){
		User u = (User)session.getAttribute("u");
		anno.setU(u);
		return ias.updateAnno(anno);
		
	}
	@RequestMapping("/deleteAnno.do")
	public @ResponseBody int deleteAnno(int id){
		
		return ias.deleteAnno(id);
		
	}
}
