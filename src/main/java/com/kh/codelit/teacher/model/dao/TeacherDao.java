package com.kh.codelit.teacher.model.dao;

import com.kh.codelit.attachment.model.vo.Attachment;
import com.kh.codelit.member.model.vo.Member;
import com.kh.codelit.teacher.model.vo.Teacher;

public interface TeacherDao {

	int insertTeacherRequest(Teacher teacher);

	Teacher selectOne(String refMemberId);

	int insertAttachment(Attachment attach);

	int selectUpdate(Teacher teacher);










	

}
