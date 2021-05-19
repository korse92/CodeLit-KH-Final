package com.kh.codelit.community.study.model.service;

import java.util.List;
import java.util.Map;

import com.kh.codelit.attachment.model.vo.Attachment;
import com.kh.codelit.community.study.model.vo.StudyBoard;

public interface StudyService {


	int getListCount();

	List<StudyBoard> studyBoardList(Map<String, Object> param);

	int insertAttachment(Attachment attach);

	int insertBoard(StudyBoard studyBoard);

	int updateCnt(int stdBrdNo);

	Attachment selectOneAttach(int stdBrdNo);

	StudyBoard selectOneStudy(int stdBrdNo);

	int deleteAttach(int stdBrdNo);

	int delete(int stdBrdNo);

	int update(StudyBoard stdBrd);


}
