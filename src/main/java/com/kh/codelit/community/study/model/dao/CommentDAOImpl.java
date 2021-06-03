package com.kh.codelit.community.study.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.codelit.community.study.model.vo.Comment;
import com.kh.codelit.community.study.model.vo.StudyBoard;

@Repository
public class CommentDAOImpl implements CommentDAO {
	
	@Autowired
	private SqlSessionTemplate session;
		
	@Override
	public int insertCmt(Comment cmt) {
		return session.insert("cmt.insertCmt",cmt);
	}

	@Override
	public Comment selectStdNo(int cmtNo) {
		return session.selectOne("cmt.selectStdNo", cmtNo);
	}

	@Override
	public int delete(int cmtNo) {
		return session.delete("cmt.delete", cmtNo);
	}

	@Override
	public int update(Comment cmt) {
		return session.update("cmt.update", cmt);
	}

}
