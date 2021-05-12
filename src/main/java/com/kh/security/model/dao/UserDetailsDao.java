package com.kh.security.model.dao;

import com.kh.codelit.member.model.vo.Member;

public interface UserDetailsDao {

	Member selectOneMember(String id);

}
