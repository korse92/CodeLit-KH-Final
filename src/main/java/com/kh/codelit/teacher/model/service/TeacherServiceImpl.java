package com.kh.codelit.teacher.model.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.codelit.member.model.dao.MemberDao;
import com.kh.codelit.teacher.model.dao.TeacherDao;
import com.kh.codelit.teacher.model.vo.Teacher;

import lombok.extern.slf4j.Slf4j;



@Service
@Slf4j
public class TeacherServiceImpl implements TeacherService {

	@Autowired
	private TeacherDao teacherDao;
	
	@Autowired
	private MemberDao memberDao;
	
	
	
	@Override
	public int insertTeacherRequest(Teacher teacher) {
		// TODO Auto-generated method stub
		
		return teacherDao.insertTeacherRequest(teacher);
	}

	
	
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertTeacherRequest(Teacher teacher, Map<String, String> map) {

		log.debug("강사신청 서비스 = {}", "첨부파일 있는 버전");

		int result = 0;
		
		// 1. 강사 신청
		result = teacherDao.insertTeacherRequest(teacher);
		
		//2. 첨부파일 등록
		result = memberDao.updateMemberProfile(map);
		
		return result;
	}
	
	
}
