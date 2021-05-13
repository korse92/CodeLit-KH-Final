package com.kh.codelit.member.model.dao;

import java.util.Map;

import com.kh.codelit.member.model.vo.Member;

public interface MemberDao {

	Member selectOneMember(String id);

	int updateMemberProfile(Map<String, String> map);

}
