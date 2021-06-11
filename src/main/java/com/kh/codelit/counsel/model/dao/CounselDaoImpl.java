package com.kh.codelit.counsel.model.dao;

import java.util.List;

import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.codelit.attachment.model.vo.Attachment;
import com.kh.codelit.counsel.model.vo.Counsel;


import lombok.extern.slf4j.Slf4j;




@Slf4j
@Repository
public class CounselDaoImpl implements CounselDao {
	
	@Autowired
	private SqlSessionTemplate session;

	@Override
	public int insertCounsel(Counsel counsel) {
		
		return session.insert("counsel.insertCounsel",counsel);
	}

	@Override
	public List<Counsel> selectCounselList(Map<String, Object> param) {

		int cPage = (int)param.get("cPage");
		String memberId = (String)param.get("memberId");

		int limit = (int)param.get("numPerPage");
		int offset = (cPage - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);

		return session.selectList("counsel.selectCounselList", memberId, rowBounds);
	}

	@Override
	public int getTotalContents(String memberId) {
		
		log.debug("counsel getTotalContents memberId = {}", memberId);
		return session.selectOne("counsel.getTotalContents", memberId);

	}

	@Override
	public Counsel selectOneCounsel(int counselNo) {

		return session.selectOne("counsel.selectOneCounsel", counselNo);
	}

	@Override
	public int selectAnswerBool(int counselNo) {

		return session.selectOne("counsel.selectAnswerBool", counselNo);

	}

	@Override
	public List<Counsel> selectCounselListAdmin(Map<String, Object> param) {

		int cPage = (int)param.get("cPage");
		int limit = (int)param.get("numPerPage");
		int offset = (cPage - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return session.selectList("counsel.selectCounselListAdmin", null, rowBounds);
	}

	@Override
	public int insertCounselAnswer(Counsel counsel) {

		log.debug("insertCounselAnswer = {}", "도착");
		return session.insert("counsel.insertCounselAnswer", counsel);
	}
	

}
