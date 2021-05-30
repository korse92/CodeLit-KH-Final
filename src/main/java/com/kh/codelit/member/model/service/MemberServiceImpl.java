package com.kh.codelit.member.model.service;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.kh.codelit.lecture.model.vo.Lecture;
import com.kh.codelit.member.model.dao.MemberDao;
import com.kh.codelit.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;



@Slf4j
@Service
public class MemberServiceImpl implements MemberService {

	
	@Autowired
	private MemberDao memberDao;
	
	
	@Override
	public UserDetails loadUserByUsername(String id) throws UsernameNotFoundException {
		Member member = memberDao.selectOneMember(id);
		log.debug("member = {}", member);
		if(member == null)
			throw new UsernameNotFoundException(id);
		return member;
	}



	@Override
	public int insertMember(Member member) {
		return memberDao.insertMember(member);
	}

	// 아이디를 통해 멤버 테이블 한 줄 가져오는 메소드
	@Override
	public Member selectOneMember(String id) {
		
		return memberDao.selectOneMember(id);

	}



	/* 구글 로그인 */
	@Override
	public Member loginByGoogle(Member member) {
		return memberDao.loginByGoogle(member.getMemberId(), member.getMemberPw());
	}


	/* 구글 회원가입 */
	@Override
	public int insertMemberByGoogle(Member member) {
		log.debug("insertMemberByGoogleService = {}", member);
		return memberDao.insertMemberByGoogle(member);
	}



	@Override
	public Member selectDetail(String memberId) {
		
		return memberDao.selectDetail(memberId);
	}



	@Override
	public int updateMember(Member member) {	
		return memberDao.updateMember(member);
	}



	@Override
	public int deleteMember(String memberId) {

		return memberDao.deleteMember(memberId);
	}


	@Override
	public List<Map<String, String>> selectLectureList(Map<String, Object> param) {
		return memberDao.selectLectureList(param);
	}


	@Override
	public int getTotalContents(String memberId) {
		return memberDao.getTotalContents(memberId);
	}


	@Override
	public List<Lecture> getLectureList(String memberId) {
		return memberDao.getLectureList(memberId);
	}


}
