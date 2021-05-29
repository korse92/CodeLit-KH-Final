package com.kh.codelit.member.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.codelit.member.model.vo.Member;

public interface MemberDao {

	Member selectOneMember(String id);


	int insertMember(Member member);

	int updateMemberProfile(Map<String, String> map);


	Member loginByGoogle(String memberId, String memberPw);


	int insertMemberByGoogle(Member member);


	Member selectDetail(String memberId);


	int updateMember(Member member);


	int deleteMember(String memberId);


	List<Map<String, String>> selectLectureList(Map<String, Object> param);


	int getTotalContents(String memberId);







}
