package com.tx.service.inter;

import java.util.List;
import java.util.Map;

import com.tx.pojo.Draft;
import com.tx.pojo.User;

public interface IDraftService {
	public List<Draft> queryDraftList(int gid);
	public Map<String,Object> join(int gid,int yesDan,User u);
	public int addDraft(Draft d);
	public int queryDraftById(int id);
	public Map<String, Object> passJoin(int id,int gid, User u);
	public int updateDraft(Draft draft);
	public Draft queryDraft(Draft draft);
	public Map<String, Object> drawInTonight(int gid,User u);
	public Map<String, Object> updateTeamAndPick(String[] tname, int[] pick,
			int gid);
	public int updateDraftById(Draft draft);
	public int truncateDraft(int gid);

}
