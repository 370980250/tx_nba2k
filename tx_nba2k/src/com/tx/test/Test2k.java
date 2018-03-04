package com.tx.test;

import java.io.Reader;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.apache.tomcat.util.buf.UDecoder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.tx.dao.UserDao;
import com.tx.pojo.Grade;
import com.tx.pojo.Team;
import com.tx.service.GradeService;
import com.tx.service.TeamService;
import com.tx.service.inter.IGradeService;
import com.tx.service.inter.ITeamService;
import com.tx.util.GetIPUtil;
public class Test2k {

	
	public static void test(){
		
	}
	
	public static void main(String[] args) {
		test();
	}
}
