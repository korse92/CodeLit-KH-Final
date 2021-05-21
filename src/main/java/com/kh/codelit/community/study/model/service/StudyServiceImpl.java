package com.kh.codelit.community.study.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.codelit.attachment.model.vo.Attachment;
import com.kh.codelit.community.study.model.dao.StudyDAO;
import com.kh.codelit.community.study.model.vo.Comment;
import com.kh.codelit.community.study.model.vo.StudyBoard;
import com.kh.codelit.lecture.model.vo.Lecture;

@Service
public class StudyServiceImpl implements StudyService {
	
	@Autowired
	private StudyDAO dao;


	@Override
	public int getListCount() {
		return dao.getListCount();
	}


	@Override
	public List<Map<String, Object>> studyBoardList(Map<String, Object> param) {
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


	@Override
	public int updateCnt(int stdBrdNo) {
		return dao.updateCnt(stdBrdNo);
	}


	@Override
	public Attachment selectOneAttach(int stdBrdNo) {
		return dao.selectOneAttach(stdBrdNo);
	}


	@Override
	public StudyBoard selectOneStudy(int stdBrdNo) {
		return dao.selectOneStudy(stdBrdNo);
	}


	@Override
	public int deleteAttach(int stdBrdNo) {
		return dao.deleteAttach(stdBrdNo);
	}


	@Override
	public int delete(int stdBrdNo) {
		return dao.delete(stdBrdNo);
	}


	@Override
	public int update(StudyBoard stdBrd) {
		return dao.update(stdBrd);
	}


	@Override
	public List<Lecture> selectLec() {
		return dao.selectLec();
	}


	@Override
	public Lecture selectOneLec(int lecNo) {
		return dao.selectOneLec(lecNo);
	}


	@Override
	public List<Comment> selectCmt(int stdBrdNo) {
		return dao.selectCmt(stdBrdNo);
	}


}
