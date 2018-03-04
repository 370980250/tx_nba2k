package com.tx.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tx.dao.AnnouncementDao;
import com.tx.pojo.Announcement;
import com.tx.service.inter.IAnnouncementService;
@Service
public class AnnouncementService implements IAnnouncementService {
	@Autowired
	private AnnouncementDao ad;
	@Override
	public List<Announcement> queryAnnouncementList() {
		// TODO Auto-generated method stub
		return ad.queryAnnouncementList();
	}

	@Override
	public Announcement queryAnnouncementById(int id) {
		// TODO Auto-generated method stub
		return ad.queryAnnouncementById(id);
	}

	@Override
	public int addAnno(Announcement anno) {
		anno.setReleaseDate(new Date());
		return ad.addAnno(anno);
	}

	@Override
	public int updateAnno(Announcement anno) {
		anno.setReleaseDate(new Date());
		return ad.updateAnno(anno);
	}

	@Override
	public int deleteAnno(int id) {
		// TODO Auto-generated method stub
		return ad.deleteAnno(id);
	}

}
