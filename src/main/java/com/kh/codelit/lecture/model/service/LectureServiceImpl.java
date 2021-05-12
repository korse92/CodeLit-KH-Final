package com.kh.codelit.lecture.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.codelit.lecture.model.dao.LectureDao;

import lombok.extern.slf4j.Slf4j;



@Service
@Slf4j
public class LectureServiceImpl implements LectureService {
	
	@Autowired
	private LectureDao lectureDao;

	@Override
	public List<Map<String, Object>> selectCategoryList() {
		
		return lectureDao.selectCategoryList();
	}

	
}
