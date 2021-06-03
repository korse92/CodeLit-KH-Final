package com.kh.codelit.member.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.codelit.lecture.model.vo.Lecture;
import com.kh.codelit.lecture.model.vo.StreamingDate;
import com.kh.codelit.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;



@Slf4j
@Repository
public class MemberDaoImpl implements MemberDao {

	@Autowired
	private SqlSessionTemplate session;

	@Override
	public Member selectOneMember(String id) {
		// TODO Auto-generated method stub
		log.debug("memberDao id={}", id);
		return session.selectOne("member.selectOneMember", id);
	}

	@Override
	public int insertMember(Member member) {
		log.debug("insertmemberDao = {}", member);
		return session.insert("member.insertMember", member);
	}

	@Override
	public int updateMemberProfile(Map<String, String> map) {
		return session.update("member.updateMemberProfile", map);
	}

	@Override
	public Member loginByGoogle(String memberId, String memberPw) {
		Map<String, String> param = new HashMap<String, String>();
		param.put("memberId", memberId);
		param.put("memberPw", memberPw);
		return session.selectOne("member.loginByGoogle", param);
	}

	@Override
	public int insertMemberByGoogle(Member member) {
		log.debug("insertMemberByGoogleDao = {}", member);
		return session.insert("member.insertMemberByGoogle", member);
	}

	@Override
	public Member selectDetail(String memberId) {

		return session.selectOne("member.selectDetail",memberId);
	}

	@Override
	public int updateMember(Member member) {

		return session.update("member.updateMember", member);
	}



	@Override
	public int deleteMember(String memberId) {

		return session.delete("member.deleteMember",memberId);
	}

	@Override
	public List<Map<String, String>> selectLectureList(Map<String, Object> param) {
		int cPage = (int)param.get("cPage");

		int limit = (int)param.get("numPerPage");
		int offset = (cPage - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);

		return session.selectList("member.selectLectureList", param, rowBounds);
	}

	@Override
	public int getTotalContents(String memberId) {
		return session.selectOne("member.getTotalContents", memberId);
	}

	@Override
	public List<Lecture> getLectureList(String memberId) {
		return session.selectList("member.getLectureList", memberId);
	}

	@Override
	public List<StreamingDate> selectStreamingDateList(String refMemberId) {
		return session.selectList("member.selectStreamingDateList", refMemberId);
	}

}
