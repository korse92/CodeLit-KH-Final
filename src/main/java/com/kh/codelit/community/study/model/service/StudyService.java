package com.kh.codelit.community.study.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.kh.codelit.attachment.model.vo.Attachment;
import com.kh.codelit.community.study.model.vo.Comment;
import com.kh.codelit.community.study.model.vo.StudyBoard;
import com.kh.codelit.lecture.model.vo.Lecture;

public interface StudyService {


	int getListCount();

	List<Map<String, Object>> studyBoardList(Map<String, Object> param);

	int insertAttachment(Attachment attach);

	int insertBoard(StudyBoard studyBoard);

	int updateCnt(int stdBrdNo);

	Attachment selectOneAttach(int stdBrdNo);

	StudyBoard selectOneStudy(int stdBrdNo);

	int deleteAttach(int stdBrdNo);

	int delete(int stdBrdNo);

	int update(StudyBoard stdBrd);

	List<Lecture> selectLec();

	List<Comment> selectCmt(int stdBrdNo);

	Lecture selectOneLec(int lecNo);

	int deleteStdCmt(int stdBrdNo);


}
