package com.kh.codelit.community.study.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.codelit.attachment.model.vo.Attachment;
import com.kh.codelit.community.notice.model.vo.Notice;
import com.kh.codelit.community.study.model.vo.StudyBoard;

public interface StudyDAO {

	int getListCount();

	List<Notice> studyBoardList(Map<String, Object> param);

	int insertAttachment(Attachment attach);

	int insertBoard(StudyBoard studyBoard);

}
