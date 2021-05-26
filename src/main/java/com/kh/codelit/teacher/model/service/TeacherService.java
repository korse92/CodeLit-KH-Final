package com.kh.codelit.teacher.model.service;

import java.util.List;
import java.util.Map;

import com.kh.codelit.attachment.model.vo.Attachment;
import com.kh.codelit.member.model.vo.Member;
import com.kh.codelit.teacher.model.vo.Teacher;

public interface TeacherService {

	int insertTeacherRequest(Teacher teacher);

	int insertTeacherRequest(Teacher teacher, Map<String, String> map);

	int insertAttachment(Attachment attach);

	int updateModify(Teacher teacher);
	
	int selectUpdate(Teacher teacher, Map<String, String> map);

	Teacher selectOne(String refMemberId);

	








 





	






}
