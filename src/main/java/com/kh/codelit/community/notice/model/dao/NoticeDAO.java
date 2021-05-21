package com.kh.codelit.community.notice.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.codelit.attachment.model.vo.Attachment;
import com.kh.codelit.community.notice.model.vo.Notice;
import com.kh.codelit.lecture.model.vo.Lecture;

public interface NoticeDAO {

	int insertBoard(Notice notice);

	int getListCount();

	List<Notice> noticeList(Map<String, Object> param);

	Notice selectOneNotice(int noticeNo);

	int delete(int noticeNo);

	int update(Notice notice);

	int updateCnt(int noticeNo);

	int insertAttachment(Attachment attach);

	Attachment selectAttachment(int noticeNo);

	int deleteAttach(int noticeNo);

	int updateAttach(Attachment attach);

	List<Lecture> selectLec();


}
