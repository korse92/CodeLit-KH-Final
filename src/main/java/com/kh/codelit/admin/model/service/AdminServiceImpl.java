package com.kh.codelit.admin.model.service;

import java.util.List;

import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.codelit.admin.model.dao.AdminDao;
import com.kh.codelit.member.model.vo.Member;
import com.kh.codelit.teacher.model.vo.Teacher;

@Service
public class AdminServiceImpl implements AdminService {

	
	@Autowired
	private AdminDao adminDao;

	@Override

	public List<Member> selectMemberList() {
		
		return adminDao.selectMemberList();
	}

	@Override
	public int deleteMember(String memberId) {

		return adminDao.deleteMember(memberId);
	}

	@Override
	public List<Teacher> selectTeacherList() {
		
		return adminDao.selectTeacherList();
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
	public int approveLecture(String id) {
		return adminDao.approveLecture(id);
	}

	@Override
	public int deleteTeacher(String id) {
		return adminDao.deleteTeacher(id);
	}

	@Override
	public int deleteLecture(String id) {
		return adminDao.deleteLecture(id);
	}

	@Override
	public List<Map<String, Object>> selectAllLecture(Map<String, Object> param) {
		return adminDao.selectAllLecture(param);
	}

	@Override
	public int getTotalContents() {
		return adminDao.getTotalContents();
	}

}
