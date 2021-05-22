package com.kh.codelit.teacher.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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

	
}
