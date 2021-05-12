package com.kh.codelit.teacher.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.codelit.teacher.model.dao.TeacherDao;

import lombok.extern.slf4j.Slf4j;



@Service
@Slf4j
public class TeacherServiceImpl implements TeacherService {

	@Autowired
	private TeacherDao teacherDao;
}
