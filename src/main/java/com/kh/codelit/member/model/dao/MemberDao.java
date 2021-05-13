package com.kh.codelit.member.model.dao;

import com.kh.codelit.member.model.vo.Member;

public interface MemberDao {

	Member selectOneMember(String id);

}
