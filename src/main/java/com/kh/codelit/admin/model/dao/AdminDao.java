package com.kh.codelit.admin.model.dao;

import java.util.List;

import com.kh.codelit.member.model.vo.Member;
import com.kh.codelit.teacher.model.vo.Teacher;

import java.util.Map;

public interface AdminDao {


	List<Member> selectMemberList();

	int deleteMember(String memberId);

	List<Teacher> selectTeacherList();

	List<Map<String, Object>> selectAllBySearching(String searchByAdmin);

	List<Map<String, Object>> applyTeacherList();

	int approveTeacher(String id);

	List<Map<String, Object>> applyLectureList();

	int approveLecture(String id);

	int deleteTeacher(String id);

	int deleteLecture(String id);

	List<Map<String, Object>> selectAllLecture(Map<String, Object> param);

	int getTotalContents();


	

}
