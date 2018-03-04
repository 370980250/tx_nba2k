package com.tx.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tx.dao.PickDao;
import com.tx.pojo.Grade;
import com.tx.pojo.Pick;
import com.tx.service.inter.IPickService;
@Service
public class PickService implements IPickService {
	@Autowired
	private PickDao pd;
	@Override
	public List<Pick> queryPickList(int gid) {
		return pd.queryPickList(gid);
	}

	@Override
	public int updatePick(Pick pick) {
		return pd.updatePick(pick);
	}

	@Override
	public int addPick(Pick pick) {
		return pd.addPick(pick);
	}

	
}
