package com.kh.codelit.community.study.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.codelit.attachment.model.vo.Attachment;
import com.kh.codelit.community.notice.model.vo.Notice;
import com.kh.codelit.community.study.model.dao.StudyDAO;
import com.kh.codelit.community.study.model.vo.StudyBoard;

@Service
public class StudyServiceImpl implements StudyService {
	
	@Autowired
	private StudyDAO dao;


	@Override
	public int getListCount() {
		return dao.getListCount();
	}


	@Override
	public List<Notice> studyBoardList(Map<String, Object> param) {
		return dao.studyBoardList(param);
	}


	@Override
	public int insertAttachment(Attachment attach) {
		return dao.insertAttachment(attach);
	}


	@Override
	public int insertBoard(StudyBoard studyBoard) {
		return dao.insertBoard(studyBoard);
	}

	
	
}
