package com.tx.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.apache.tomcat.util.buf.UDecoder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import com.tx.dao.DraftDao;
import com.tx.pojo.Draft;
import com.tx.pojo.Grade;
import com.tx.pojo.Pick;
import com.tx.pojo.Power;
import com.tx.pojo.Team;
import com.tx.pojo.User;
import com.tx.service.inter.IDraftService;
import com.tx.service.inter.IPickService;
import com.tx.service.inter.IPowerService;
import com.tx.service.inter.ITeamService;
import com.tx.service.inter.IUserService;
@Service
public class DraftService implements IDraftService {
	@Autowired
	private IUserService ius;
	@Autowired
	private ITeamService its;
	@Autowired
	private IPickService ips;
	@Autowired
	private DraftDao dd;
	@Autowired
	private Draft draft;
	@Autowired
	private Grade grade;
	@Autowired
	private User manager;
	@Autowired    
	private Team team;
	@Autowired
	private Power power;
	@Override
	public List<Draft> queryDraftList(int gid) {
		return dd.queryDraftList(gid);
	}
	@Override
	public int addDraft(Draft draft){
		return dd.addDraft(draft);
		
	}
	@Override
	public Draft queryDraft(Draft draft){
		return dd.queryDraft(draft);
		
	}
	@Override
	public int updateDraft(Draft draft) {
		return dd.updateDraft(draft);
	}
	
	@Override
	public int queryDraftById(int id) {
		return dd.queryDraftById(id);
	}
	@Override
	public Map<String, Object> join(int gid,int yesDan, User u) {
		Map<String,Object> json = new HashMap<String, Object>();
		if(u!=null&&yesDan==1){
			draft.setU(u);
			grade.setId(gid);
			draft.setGrade(grade);
			Draft temp = queryDraft(draft);
			if(temp==null){
				draft.setJoinDate(new Date());
				draft.setState(0);
				int flag = addDraft(draft);
				if(flag>0){
					json.put("meg", true);
					return json;
				}
			}
		}
		json.put("meg", false);
		return json;
	}
	@Override
	public Map<String, Object> passJoin(int id,int gid, User u) {
		Map<String, Object> json = new HashMap<String, Object>();
		if(u.getPower().getId()>=3){
			draft.setAdmin(u);
			manager.setId(id);
			draft.setU(manager);
			draft.setState(1);
			draft.setPassDate(new Date());
			grade.setId(gid);
			draft.setGrade(grade);
			int flag = updateDraft(draft);
			if(flag>0){
				power.setId(2);
				manager.setPower(power);
				flag = ius.updateUser(manager);
				if(flag>0){
					json.put("meg",true);
					return json;
				}
			}
		}
		json.put("meg", false);
		return json;
	}
	@Override
	public Map<String, Object> drawInTonight(int gid,User u) {
		Map<String, Object> json = new HashMap<String, Object>();
		json.put("meg", "请先登录");
		if(u!=null){
			draft.setU(u);
			grade.setId(gid);
			draft.setGrade(grade);
			Draft draft1 = queryDraft(draft);
			json.put("meg", "请先报名");
			if(draft1!=null){
				json.put("meg", "你已经抽过签");
				if(draft1.getPickid()==0){
					json.put("meg","请等待审核");
					//state == 0 表示 未审核
					if(draft1.getState()==1){
						/*int flag = updateDraft(draft);
						if(flag>0){*/
							List<Pick> ps =  ips.queryPickList(gid);
							Random random = new Random();
							int arrInx = random.nextInt(ps.size()-1);
							Pick pick = ps.get(arrInx);
							pick.setState(0);
							pick.setGrade(grade);
							ips.updatePick(pick);
							draft1.setPickid(pick.getPick());
							System.out.println(team);
							team.setPickid(pick.getPick());
							team.setGrade(grade);
							Team team1 = its.queryTeam(team);
							if(team1!=null){
								draft1.setTeam(team1);
							}
							draft1.setDrawDate(new Date());
							updateDraft(draft1);
							if(draft1.getTeam()!=null){
								json.put("meg", "抽签成功,您获得了第"+pick.getPick()+"顺位"+draft.getTeam().getTcname()+"队");
							}else{
								json.put("meg", "抽签成功,您获得了第"+pick.getPick()+"顺位");
							}
						/*}*/
					}
				}
			}
		}
		return json;
	}
	/*
	 * 保存顺位和球队
	 */
	@Override
	public Map<String, Object> updateTeamAndPick(String[] tname, int[] pick,
			int gid) {
		Map<String,Object> json = new HashMap<String, Object>();
		grade.setId(gid); 
		System.out.println(team);
		team.setGrade(grade);
		if(tname.length == pick.length){
			//its.truncateTeam(gid);
			//先清空选秀的队伍信息
			truncateDraft(gid);
			//循环遍历
			for(int i = 0 ;i<tname.length;i++){
				//检查球队名字是否被设置，如果有名字就给对应的draft赋值
				if(tname[i]!=null&&!"".equals(tname[i])){
					team.setTcname(tname[i]);
					team.setPickid(pick[i]);
					its.updateTeam(team);
					team = its.queryTeam(team);
					List<Draft> ds = queryDraftList(gid);
					for(Draft d : ds){
						if(d.getPickid()!=0&&d.getPickid()==pick[i]){
							team.setTcname(tname[i]);
							team.setPickid(pick[i]);
							System.out.println(team.getPickid());
							System.out.println(team.getTcname());
							team = its.queryTeam(team);
							d.setTeam(team);
							updateDraft(d);
							d = queryDraft(d);
							if(d.getU()!=null&&d.getTeam()!=null){
								its.updateTeamUseridByTid(d);
							}
						}
					}
				}
			}
			
		}
		json.put("meg", "修改成功");
		return json;
	}
	@Override
	public int updateDraftById(Draft draft) {
		// TODO Auto-generated method stub
		return dd.updateDraftById(draft);
	}
	@Override
	public int truncateDraft(int gid) {
		// TODO Auto-generated method stub
		return dd.truncateDraft(gid);
	}
	
	
	
	
	
}
