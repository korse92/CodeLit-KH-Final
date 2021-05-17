package com.kh.codelit.community.notice.model.service;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.codelit.community.notice.model.dao.NoticeDAO;
import com.kh.codelit.community.notice.model.vo.Notice;


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


}
