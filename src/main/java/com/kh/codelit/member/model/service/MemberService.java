package com.kh.codelit.member.model.service;

import com.kh.codelit.member.model.vo.Member;

public interface MemberService {

	int insertMember(Member member);

	Member selectOneMember(String id);

}
