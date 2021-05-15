package com.kh.codelit.admin.model.service;

import java.util.List;

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
}
