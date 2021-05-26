package com.kh.codelit.teacher.model.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.codelit.attachment.model.vo.Attachment;
import com.kh.codelit.member.model.vo.Member;
import com.kh.codelit.teacher.model.vo.Teacher;

import lombok.extern.slf4j.Slf4j;



@Repository
@Slf4j
public class TeacherDaoImpl implements TeacherDao {

	@Autowired
	private SqlSessionTemplate session;

	@Override
	public int insertTeacherRequest(Teacher teacher) {
		
		return session.insert("teacher.insertTeacherRequest", teacher);
	}

	@Override
	public Teacher selectOne(String refMemberId) {
	
		return session.selectOne("teacher.selectOne",refMemberId);
	}



	@Override
	public int insertAttachment(Attachment attach) {
		// TODO Auto-generated method stub
		return session.insert("teacher.insertAttachment",attach);
	}

	@Override
	public int selectUpdate(Teacher teacher) {
	
		return session.update("teacher.selectUpdate", teacher);
	}









	





	

	

	
	
}
