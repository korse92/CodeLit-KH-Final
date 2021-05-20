package com.kh.codelit.counsel.model.dao;

import java.util.List;

import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
		int catNo = (int)param.get("catNo");
		
		int limit = (int)param.get("numPerPage");
		int offset = (cPage - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("counsel.selectCounselList",catNo,rowBounds);
	}

	@Override
	public int getTotalContents(Integer catNo) {
		
		return session.selectOne("counsel.getTotalContents", catNo);
	}
	


}
