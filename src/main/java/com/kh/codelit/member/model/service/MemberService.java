package com.kh.codelit.member.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.security.core.userdetails.UserDetailsService;

import com.kh.codelit.lecture.model.vo.Lecture;
import com.kh.codelit.member.model.vo.Member;

public interface MemberService extends UserDetailsService{
	
	//public static final 
	String ROLE_USER = "USER";
	String ROLE_ADMIN = "ADMIN";
	String ROLE_TEACHER = "TEACHER";

	int insertMember(Member member);

	Member selectOneMember(String refMemberId);

	Member loginByGoogle(Member member);

	int insertMemberByGoogle(Member member);

	Member selectDetail(String memberId);

	int updateMember(Member member);

	int deleteMember(String memberId);

	List<Map<String, String>> selectLectureList(Map<String, Object> param);

	int getTotalContents(String memberId);

	List<Lecture> getLectureList(String memberId);

}
