package com.kh.codelit.lecture.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.codelit.attachment.model.dao.AttachDao;
import com.kh.codelit.attachment.model.vo.Attachment;
import com.kh.codelit.lecture.model.dao.LectureDao;
import com.kh.codelit.lecture.model.vo.Lecture;

import lombok.extern.slf4j.Slf4j;



@Service
@Slf4j
public class LectureServiceImpl implements LectureService {
	
	@Autowired
	private LectureDao lectureDao;
	
	@Autowired
	private AttachDao attachDao;

	private static List<Map<String, Object>> categoryListInstance; //싱글톤 객체로 처리
	private static Map<Integer, Object> categoryMapInstance;
	
	@Override
	public List<Map<String, Object>> selectCategoryListInstance() {
		if(categoryListInstance == null || categoryListInstance.isEmpty()) {
			categoryListInstance = lectureDao.selectCategoryList();
			log.debug("categoryListInstance 생성 = {}", categoryListInstance);
		}
		
		return categoryListInstance;
	}

	
	@Override
	public Map<Integer, Object> getCategoryMapInstance() {
		if(categoryListInstance == null || categoryListInstance.isEmpty())
			categoryListInstance = selectCategoryListInstance();
		
		if(categoryMapInstance == null || categoryMapInstance.isEmpty()) {
			categoryMapInstance = new HashMap<>();
			for(Map<String, Object> category : categoryListInstance) {
				Integer no = (Integer)category.get("no");
				String name = (String)category.get("name");
				categoryMapInstance.put(no, name);
			}
			log.debug("categoryMapInstance 생성 = {}", categoryMapInstance);
		}		
		
		return categoryMapInstance;
	}



	@Override
	public int insertLecture(Lecture lecture) {		
		int result = 0;
		
		//1. lecture객체 등록
		result = lectureDao.insertLecture(lecture);
		log.debug("lecture.no = {}", lecture.getLectureNo());//insert한 lecture 번호 확인
		
		if(!lecture.getAttachList().isEmpty()) {
			for(Attachment attach : lecture.getAttachList()) {
				attach.setRefContentsNo(lecture.getLectureNo());
				result = attachDao.insertAttachment(attach);
			}
		}
		
		return result;
	}

	@Override
	public List<Lecture> selectLectureList(Map<String, Object> param) {
		return lectureDao.selectLectureList(param);
	}

	@Override
	public int getTotalContents(Integer catNo) {
		return lectureDao.getTotalContents(catNo);
	}

	@Override
	public List<Lecture> selectMyLecture(String id) {
		return lectureDao.selectMyLecture(id);
	}
	
	
}
