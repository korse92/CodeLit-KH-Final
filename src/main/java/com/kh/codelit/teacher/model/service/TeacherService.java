package com.kh.codelit.teacher.model.service;

import java.util.Map;

import com.kh.codelit.teacher.model.vo.Teacher;

public interface TeacherService {

	int insertTeacherRequest(Teacher teacher);

	int insertTeacherRequest(Teacher teacher, Map<String, String> map);


}
