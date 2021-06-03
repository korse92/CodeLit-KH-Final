package com.kh.codelit.community.study.model.dao;

import com.kh.codelit.community.study.model.vo.Comment;
import com.kh.codelit.community.study.model.vo.StudyBoard;

public interface CommentDAO {

	int insertCmt(Comment cmt);

	Comment selectStdNo(int cmtNo);

	int delete(int cmtNo);

	int update(Comment cmt);

}
