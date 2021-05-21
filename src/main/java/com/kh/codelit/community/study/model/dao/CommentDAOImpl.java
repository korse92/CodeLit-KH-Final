package com.kh.codelit.community.study.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.codelit.community.study.model.vo.Comment;

@Repository
public class CommentDAOImpl implements CommentDAO {
	
	@Autowired
	private SqlSessionTemplate session;
		
	@Override
	public int insertCmt(Comment cmt) {
		return session.insert("cmt.insertCmt",cmt);
	}

}
