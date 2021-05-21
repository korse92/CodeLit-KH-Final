package com.kh.codelit.community.notice.model.service;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.codelit.attachment.model.vo.Attachment;
import com.kh.codelit.community.notice.model.dao.NoticeDAO;
import com.kh.codelit.community.notice.model.vo.Notice;
import com.kh.codelit.lecture.model.vo.Lecture;


@Service
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	private NoticeDAO dao;
	

	@Override
	public int insertBoard(Notice notice) {
		return dao.insertBoard(notice);
	}


	@Override
	public int getListCount() {
		return dao.getListCount();
	}

	@Override
	public List<Notice> noticeList(Map<String, Object> param) {
		return dao.noticeList(param);
	}


	@Override
	public Notice selectOneNotice(int noticeNo) {
		return dao.selectOneNotice(noticeNo);
	}


	@Override
	public int delete(int noticeNo) {
		return dao.delete(noticeNo);
	}


	@Override
	public int update(Notice notice) {
		return dao.update(notice);
	}


	@Override
	public int updateCnt(int noticeNo) {
		return dao.updateCnt(noticeNo);
	}


	@Override
	public int insertAttachment(Attachment attach) {
		return dao.insertAttachment(attach);
	}


	@Override
	public Attachment selectOneAttach(int noticeNo) {
		return dao.selectAttachment(noticeNo);
	}


	@Override
	public int deleteAttach(int noticeNo) {
		return dao.deleteAttach(noticeNo);
	}


	@Override
	public int updateAttach(Attachment attach) {
		return dao.updateAttach(attach);
	}


	@Override
	public List<Lecture> selectLec() {
		return dao.selectLec();
	}




}
