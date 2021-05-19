package com.kh.codelit.community.study.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.codelit.attachment.model.vo.Attachment;
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
	public List<StudyBoard> studyBoardList(Map<String, Object> param) {
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


	@Override
	public int updateCnt(int stdBrdNo) {
		return session.update("studyBoard.updateCnt",stdBrdNo);
	}

	@Override
	public Attachment selectOneAttach(int stdBrdNo) {
		return session.selectOne("studyBoard.selectOneAttach", stdBrdNo);
	}

	@Override
	public StudyBoard selectOneStudy(int stdBrdNo) {
		return session.selectOne("studyBoard.selectOneStudy",stdBrdNo);
	}


	@Override
	public int deleteAttach(int stdBrdNo) {
		return session.delete("studyBoard.deleteAttach", stdBrdNo);
	}


	@Override
	public int delete(int stdBrdNo) {
		return session.delete("studyBoard.delete",stdBrdNo);
	}


	@Override
	public int update(StudyBoard stdBrd) {
		return session.update("studyBoard.update", stdBrd);
	}

}
