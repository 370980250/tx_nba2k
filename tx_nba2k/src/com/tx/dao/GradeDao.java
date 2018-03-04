package com.tx.dao;

import java.util.List;
import java.util.Map;

import com.tx.pojo.Grade;

public interface GradeDao {
	public Grade queryMaxGrade();
	public List<Grade> queryGradeList();
	public Grade queryGradeById(int id);
	public int addGrade(Grade grade);
	public int updateGrade(Grade grade);
	
}
