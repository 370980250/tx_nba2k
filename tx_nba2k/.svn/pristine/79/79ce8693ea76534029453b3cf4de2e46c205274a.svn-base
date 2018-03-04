package com.tx.service.inter;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.tx.pojo.Grade;
import com.tx.pojo.User;

public interface IGradeService {
	public List<Grade> queryGradeList();
	public Grade queryMaxGrade();
	public Grade queryGradeById(int id);
	public int addGrade(Grade grade);
	public Map<String,Object> createLeague(User u, MultipartFile file,Grade grade);
	public int updateGrade(Grade grade);
}
