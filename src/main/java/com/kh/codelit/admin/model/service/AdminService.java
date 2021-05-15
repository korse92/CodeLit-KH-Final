package com.kh.codelit.admin.model.service;

import java.util.List;

import com.kh.codelit.member.model.vo.Member;
import com.kh.codelit.teacher.model.vo.Teacher;

public interface AdminService {

	List<Member> selectMemberList();

	int deleteMember(String memberId);

	List<Teacher> selectTeacherList();

}
