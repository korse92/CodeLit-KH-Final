package com.kh.codelit.community.adminBoard.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.codelit.community.adminBoard.model.vo.Notice;

public interface AdminBoardDAO {

	int insertBoard(Notice notice);

	int getListCount();

	List<Notice> noticeList(Map<String, Object> param);

	Notice selectOneNotice(int noticeNo);

	int delete(int noticeNo);

	int update(Notice notice);

}
