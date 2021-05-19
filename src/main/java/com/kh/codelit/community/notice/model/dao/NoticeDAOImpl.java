package com.kh.codelit.community.notice.model.dao;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.codelit.attachment.model.vo.Attachment;
import com.kh.codelit.community.notice.model.vo.Notice;

import lombok.extern.slf4j.Slf4j;

@Repository
public class NoticeDAOImpl implements NoticeDAO {

	@Autowired
	private SqlSessionTemplate session;


	@Override
	public int insertBoard(Notice notice) {
		return session.insert("notice.insertBoard", notice);
	}


	@Override
	public int getListCount() {
		return session.selectOne("notice.getListCount");	
	}

	@Override
	public List<Notice> noticeList(Map<String, Object> param) {
		int cPage = (int)param.get("cPage");
		
		int limit = (int)param.get("numPerPage");
		int offset = (cPage - 1) * limit; // 1 -> 0, 2 -> 5, 3 -> 10....
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return session.selectList("notice.noticeList", null, rowBounds);
	}


	@Override
	public Notice selectOneNotice(int noticeNo) {
		return session.selectOne("notice.selectOneNotice", noticeNo);
	}


	@Override
	public int delete(int noticeNo) {
		return session.delete("notice.delete", noticeNo);
	}


	@Override
	public int update(Notice notice) {
		return session.update("notice.update", notice);
	}


	@Override
	public int updateCnt(int noticeNo) {
		return session.update("notice.updateCnt", noticeNo);
	}


	@Override
	public int insertAttachment(Attachment attach) {
		return session.insert("attachment.insertAttachment", attach);
	}


	@Override
	public Attachment selectAttachment(int noticeNo) {
		return session.selectOne("notice.selectAttachment", noticeNo);
	}


	@Override
	public int deleteAttach(int noticeNo) {
		return session.delete("notice.deleteAttach", noticeNo);
	}

}
