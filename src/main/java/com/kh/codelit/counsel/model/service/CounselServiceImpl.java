package com.kh.codelit.counsel.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.codelit.counsel.model.dao.CounselDao;
import com.kh.codelit.counsel.model.vo.Counsel;


@Service
public class CounselServiceImpl implements CounselService{
		
	@Autowired
	private CounselDao dao;

	@Override
	public int insertCounsel(Counsel counsel) {
	
		return dao.insertCounsel(counsel);
	}
}
