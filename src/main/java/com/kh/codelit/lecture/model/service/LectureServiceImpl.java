package com.kh.codelit.lecture.model.service;

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
	
	@Override
	public List<Map<String, Object>> selectCategoryListInstance() {
		if(categoryListInstance == null || categoryListInstance.isEmpty()) {
			categoryListInstance = lectureDao.selectCategoryList();
			log.debug("categoryListInstance 생성 = {}", categoryListInstance);
		}
		
		return categoryListInstance;
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
}
