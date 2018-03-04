package com.tx.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tx.dao.PowerDao;
import com.tx.pojo.Power;
import com.tx.service.inter.IPowerService;
@Service
public class PowerService implements IPowerService {
	@Autowired
	private PowerDao pd;
	@Override
	public List<Power> queryPowerList() {
		// TODO Auto-generated method stub
		return pd.queryPowerList();
	}
	
}
