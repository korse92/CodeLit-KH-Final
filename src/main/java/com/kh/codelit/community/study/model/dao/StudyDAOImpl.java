package com.kh.codelit.community.study.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.codelit.attachment.model.vo.Attachment;
import com.kh.codelit.community.notice.model.vo.Notice;
import com.kh.codelit.community.study.model.vo.StudyBoard;

@Repository
public class StudyDAOImpl implements StudyDAO {

	@Autowired
	private SqlSessionTemplate session;
	

	@Override
	public int getListCount() {
		return session.selectOne("studyBoard.getListCount");
	}


	@Override
	public List<Notice> studyBoardList(Map<String, Object> param) {
		return session.selectList("studyBoard.studyBoardList", param);
	}


	@Override
	public int insertAttachment(Attachment attach) {
		return session.insert("attachment.insertAttachment", attach);
	}


	@Override
	public int insertBoard(StudyBoard studyBoard) {
		return session.insert("studyBoard.insertBoard", studyBoard);
	}

}
