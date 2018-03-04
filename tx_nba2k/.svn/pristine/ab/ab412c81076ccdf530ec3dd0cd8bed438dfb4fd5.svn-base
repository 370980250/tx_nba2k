package com.tx.pojo;

import org.springframework.stereotype.Component;

@Component
public class Partion {
	//当前页第一条记录
	private int start;
	//当前页最后一条记录
	private int end;
	//当前页
	private int cpage;
	//总页数
	private int apage;
	//总记录数
	private int acount;
	//每页显示多少条记录
	private int pageSize;
	private Grade grade;
	
	private Query query;
	
	public Grade getGrade() {
		return grade;
	}
	public void setGrade(Grade grade) {
		this.grade = grade;
	}
	public void setApage(int apage) {
		this.apage = apage;
	}
	public Query getQuery() {
		return query;
	}
	public void setQuery(Query query) {
		this.query = query;
	}
	public int getStart() {
		start = (getCpage()-1)*getPageSize()+1;
		return start;
	}
	public void setStart(int start) {
		this.start = start;
	}
	public int getEnd() {
		end = getCpage()*getPageSize();
		return end;
	}
	public void setEnd(int end) {
		this.end = end;
	}
	public int getCpage() {
		return cpage;
	}
	public void setCpage(int cpage) {
		this.cpage = cpage;
	}
	public int getApage() {
		if(getAcount()%getPageSize()==0){
			return getAcount()/getPageSize();
		}else{		
			return getAcount()/getPageSize()+1;
		}
	}
	public void setapage(int apage) {
		this.apage = apage;
	}
	public int getAcount() {
		return acount;
	}
	public void setAcount(int acount) {
		this.acount = acount;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	
}
