package com.tx.service;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.EncryptedDocumentException;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.tx.dao.GradeDao;
import com.tx.pojo.Grade;
import com.tx.pojo.Pick;
import com.tx.pojo.Player;
import com.tx.pojo.Team;
import com.tx.pojo.User;
import com.tx.service.inter.IGradeService;
import com.tx.service.inter.IPickService;
import com.tx.service.inter.IPlayerService;
import com.tx.service.inter.ITeamService;
import com.tx.util.IntegerUtil;
@Service
public class GradeService implements IGradeService {
	@Autowired
	ITeamService its;
	@Autowired
	IPlayerService ips;
	@Autowired
	IPickService ipicks;
	@Autowired
	Player player;
	@Autowired
	Team team;
	@Autowired
	Pick pick;
	@Autowired
	private GradeDao gd;
	@Override
	public List<Grade> queryGradeList() {
		return gd.queryGradeList();
	}
	@Override
	public Grade queryMaxGrade() {
		return gd.queryMaxGrade();
	}
	@Override
	public Grade queryGradeById(int id) {
		return gd.queryGradeById(id);
	}
	@Override
	public int addGrade(Grade grade) {
		// TODO Auto-generated method stub
		return gd.addGrade(grade);
	}
	@Transactional
	@Override
	public Map<String, Object> createLeague(User u,MultipartFile file, Grade grade) {
		Map<String,Object> json = new HashMap<String,Object>();
		InputStream is =null ;
		Workbook wb =null;
		json.put("meg", "只允许管理员创建");
		if(u!=null&&u.getPower().getId()==4){
			int flag = addGrade(grade);
			grade = queryMaxGrade();
			json.put("meg", "创建失败");
			if(flag>0){
				try {
					//表格转换输出流
					is = file.getInputStream();
					//得到excel
					wb = WorkbookFactory.create(is);
					//得到Sheet
					Sheet sheet = wb.getSheetAt(0);
					//将名单存入数据库
					for(Row row : sheet){
						if(row != sheet.getRow(0)){
							player.setCname(IntegerUtil.getString(row.getCell(0)));
							player.setEname(IntegerUtil.getString(row.getCell(1)));
							player.setPosition(IntegerUtil.getString(row.getCell(2)));
							player.setAbility(IntegerUtil.getInt(row.getCell(3)));
							player.setRound(IntegerUtil.getString(row.getCell(4)));
							player.setBadges(IntegerUtil.getInt(row.getCell(5)));
							player.setPrice(IntegerUtil.getInt(row.getCell(6)));
							player.setTname(IntegerUtil.getString(row.getCell(7)));
							player.setGrade(grade);
							ips.addPlayer(player);
						}
					}
					//创建选秀表
					pick.setGrade(grade);
					
					for(int i = 1;i<=30;i++){
						pick.setPick(i);
						pick.setState(1);
						ipicks.addPick(pick);
					}
					//创建队伍表
					ApplicationContext app = new ClassPathXmlApplicationContext("classpath:teamConfig.xml");
					List<Team> ts = (List<Team>) app.getBean("ts");
					for(Team t : ts){
						t.setGrade(grade);
						its.addTeam(t);
					}
					json.put("meg", "创建成功");
				} catch (IOException | EncryptedDocumentException | InvalidFormatException e) {
					e.printStackTrace();
				}finally{
					try {
						wb.close();
						is.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				
			}
		}
		
		return json;
	}
	@Override
	public int updateGrade(Grade grade) {
		// TODO Auto-generated method stub
		return gd.updateGrade(grade);
	}

}
