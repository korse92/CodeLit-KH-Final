package com.kh.codelit.community.study.model.service;

import com.kh.codelit.community.study.model.vo.Comment;
import com.kh.codelit.community.study.model.vo.StudyBoard;

public interface CommentService {

	int insertCmt(Comment cmt);

	Comment selectStdNo(int cmtNo);

	int delete(int cmtNo);

	int update(int stdCmtNo);


}
