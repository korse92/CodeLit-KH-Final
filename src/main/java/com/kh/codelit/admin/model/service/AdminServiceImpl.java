package com.kh.codelit.admin.model.service;

import java.util.List;

import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.codelit.admin.model.dao.AdminDao;
import com.kh.codelit.member.model.vo.Member;
import com.kh.codelit.order.model.vo.Payment;
import com.kh.codelit.teacher.model.vo.Teacher;

@Service
public class AdminServiceImpl implements AdminService {

	
	@Autowired
	private AdminDao adminDao;

	@Override

	public List<Member> selectMemberList(Map<String, Object> param) {
		
		return adminDao.selectMemberList(param);
	}

	@Override
	public int deleteMember(String memberId) {

		return adminDao.deleteMember(memberId);
	}

	@Override
	public List<Teacher> selectTeacherList(Map<String, Object> param) {
		
		return adminDao.selectTeacherList(param);
	}

	public List<Map<String, Object>> selectAllBySearching(String searchByAdmin) {
		return adminDao.selectAllBySearching(searchByAdmin);
	}

	@Override
	public List<Map<String, Object>> applyTeacherList() {
		return adminDao.applyTeacherList();
	}

	@Override
	public int approveTeacher(String id) {
		return adminDao.approveTeacher(id);
	}

	@Override
	public List<Map<String, Object>> applyLectureList() {
		return adminDao.applyLectureList();
	}

	@Override
	public int approveLecture(int no) {
		return adminDao.approveLecture(no);
	}

	@Override
	public int deleteTeacher(String id) {
		return adminDao.deleteTeacher(id);
	}

	@Override
	public int deleteLecture(int no) {
		return adminDao.deleteLecture(no);
	}

	@Override
	public List<Map<String, Object>> selectAllLecture(Map<String, Object> param) {
		return adminDao.selectAllLecture(param);
	}

	@Override
	public int getTotalContents(Map<String, Object> param) {
		return adminDao.getTotalContents(param);
	}

	@Override
	public List<Map<String, Object>> searchCategory(int type) {
		return adminDao.searchCategory(type);
	}

	@Override
	public int rejectPlayingLecture(int no) {
		return adminDao.rejectPlayingLecture(no);
	}
	
	@Override
	public int selecMemberCount(Map<String, Object> param) {
		
		return adminDao.selectMemberCount(param);
	}

	@Override
	public int selectTeacherCount(Map<String, Object> param) {

		return adminDao.selectTeacherCount(param);
	}

	@Override
	public int selectMemberOrderCount(Map<String, Object> param) {
		
		return adminDao.selectMemberOrderCount(param);
	}

	@Override
	public List<Payment> selectMemberOrderList(Map<String, Object> param) {
		
		return adminDao.selectMemberOrderList(param);
	}


	


	


}
