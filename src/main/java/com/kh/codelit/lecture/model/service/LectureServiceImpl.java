package com.kh.codelit.lecture.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.codelit.lecture.model.dao.LectureDao;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class LectureServiceImpl implements LectureService {
	
	@Autowired
	private LectureDao lectureDao;
	
	private static List<Map<String, Object>> categoryListInstance;//싱글톤 객체로 처리

	@Override
	public List<Map<String, Object>> selectCategoryListInstance() {
		if(categoryListInstance == null) {
			categoryListInstance = lectureDao.selectCategoryList();
			log.debug("인스턴스 생성");
		}
		
		return categoryListInstance;
	}

}
