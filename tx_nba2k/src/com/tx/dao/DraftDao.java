package com.tx.dao;

import java.util.List;

import com.tx.pojo.Draft;

public interface DraftDao {
	public List<Draft> queryDraftList(int gid);

	public int addDraft(Draft draft);

	public Draft queryDraft(Draft draft);
	
	public int queryDraftById(int id);

	public int updateDraft(Draft draft);
	
	public int updateDraftById(Draft draft);
	
	public int truncateDraft(int gid);
}
