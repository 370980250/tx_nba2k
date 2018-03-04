package com.tx.action;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.tx.pojo.Draft;
import com.tx.pojo.Grade;
import com.tx.pojo.Pick;
import com.tx.pojo.Team;
import com.tx.pojo.User;
import com.tx.service.inter.IDraftService;
import com.tx.service.inter.IGradeService;
import com.tx.service.inter.IPickService;
import com.tx.service.inter.ITeamService;
import com.tx.service.inter.IUserService;
@Controller
@RequestMapping("Draft")
public class DraftAction {
	@Autowired
	private IPickService ips;	
	@Autowired
	private IDraftService ids;
	@Autowired
	private IGradeService igs;
	@Autowired
	private ITeamService its;
	@Autowired
	private IUserService ius;
	/*查询届集合*/
	@RequestMapping("/queryGradeList.do")
	public @ResponseBody List<Grade> queryGradeList(){
		List<Grade> gs = igs.queryGradeList();
		return gs;
	}
	/*
	 * 查询选秀集合
	 */
	@RequestMapping("/queryDraftList.do")
	public @ResponseBody Map<String,Object> queryDraftList(Integer gid){
		List<Draft> ds = ids.queryDraftList(gid);
		List<Pick> ps = ips.queryPickList(gid);
		List<Team> ts = its.queryTeamListByPick(gid);
		Map<String,Object> json = new HashMap<String, Object>();
		json.put("ds", ds);
		json.put("ps", ps);
		json.put("ts", ts);
		return json;
	}
	/*
	 * 查询最后创建的联赛
	 */
	@RequestMapping("/queryMaxGrade.do")
	public @ResponseBody Grade queryMaxGrade(){
		Grade grade = igs.queryMaxGrade();
		return grade;
	}
	/*
	 * 查询届
	 */
	@RequestMapping("/queryGradeById.do")
	public @ResponseBody Grade queryGradeById(int id){
		return igs.queryGradeById(id);
	}
	/*
	 * 报名
	 */
	@RequestMapping("/join.do")
	public @ResponseBody Map<String,Object> addDraft(int gid,int yesDan,HttpSession sess){
		User u = (User) sess.getAttribute("u");
		Map<String,Object> json = ids.join(gid,yesDan, u);
		return json;
	}
	/*
	 * 报名通过
	 */
	@RequestMapping("/passJoin.do")
	public @ResponseBody Map<String,Object> updateDraft(int id,int gid,HttpSession sess){
		User u = (User) sess.getAttribute("u");
		Map<String, Object> json = ids.passJoin(id,gid,u);
		return json;
	}
	/*
	 * 选秀
	 */
	@RequestMapping("/drawInTonight.do")
	public @ResponseBody Map<String,Object> updateDraftDraw(int gid,HttpSession sess){
		User u =(User) sess.getAttribute("u");
		Map<String,Object> json = ids.drawInTonight(gid,u);
		return json;
	}
	/*
	 * 创建联赛
	 */
	@RequestMapping("/createLeague.do")
	public @ResponseBody Map<String,Object> createLeague(Grade grade,@RequestParam(value = "PlayerFileUp") MultipartFile file ,HttpSession sess) throws IllegalStateException, IOException, ServletException{
		User u =(User) sess.getAttribute("u");
		Map<String,Object> json = igs.createLeague(u,file,grade);
		return json;
	}
	/*
	 * 修改联赛
	 */
	@RequestMapping("/updateGrade.do")
	public @ResponseBody Map<String,Object> updateLeague(Grade grade){
		int flag = igs.updateGrade(grade);
		Map<String,Object> json = new HashMap<String, Object>();
		json.put("meg", "修改失败");
		if(flag>0){
			json.put("meg", "修改成功");
		}
		return json;
	}
	
	/*
	 * 保存队伍与顺位的设置
	 */
	@RequestMapping("/updateTeamAndPick.do")
	public @ResponseBody Map<String,Object> updateTeamAndPick(String[] tname,int[] pick,int gid){
		Map<String,Object> json = ids.updateTeamAndPick(tname,pick,gid);
		return json;
	}
	
	/*
	 * 修改球队归属及公告
	 */
	@RequestMapping("/updateDraft.do")
	public  @ResponseBody Map<String,Object> updateDraft(Draft draft,String pname){
		Map<String,Object> json = new HashMap<String, Object>();
		User u =  ius.queryUserByPname(pname);
		System.out.println(draft.getId());
		json.put("meg", false);
		if(u!=null){
			draft.setU(u);
			int flag = ids.updateDraftById(draft);
			System.out.println(flag);
			if(flag>0){
				json.put("meg", true);
			}
		}
		
		return json;
	}
}
