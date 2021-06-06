package com.kh.codelit.admin.model.service;

import java.util.List;


import com.kh.codelit.member.model.vo.Member;
import com.kh.codelit.order.model.vo.Payment;
import com.kh.codelit.teacher.model.vo.Teacher;

import java.util.Map;


public interface AdminService {

	List<Member> selectMemberList(Map<String, Object> param);

	int deleteMember(String memberId);

	List<Teacher> selectTeacherList(Map<String, Object> param);

	List<Map<String, Object>> selectAllBySearching(String searchByAdmin);

	List<Map<String, Object>> applyTeacherList();

	int approveTeacher(String id);

	List<Map<String, Object>> applyLectureList();

	int approveLecture(int no);

	int deleteTeacher(String id);

	int deleteLecture(int no);

	List<Map<String, Object>> selectAllLecture(Map<String, Object> param);

	int getTotalContents(Map<String, Object> param);

	List<Map<String, Object>> searchCategory(int type);

	int rejectPlayingLecture(int no);

	int selecMemberCount(Map<String, Object> param);

	int selectTeacherCount(Map<String, Object> param);

	int selectMemberOrderCount(Map<String, Object> param);

	List<Payment> selectMemberOrderList(Map<String, Object> param);

	int deleteTeacherAndAuth(String refMemberId);

	List<Map<String, Object>> selectClickRank();

	List<Map<String, Object>> selectCategorySales();

	List<Map<String, Object>> selectUserClick(String userName);

	List<Map<String, Object>> selectCategorySalesSummary();




}
