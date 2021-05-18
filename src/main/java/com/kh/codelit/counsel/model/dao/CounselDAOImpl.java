package com.kh.codelit.counsel.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.codelit.counsel.model.vo.counsel;

@Repository
public abstract class CounselDAOImpl implements CounselDAO {

	@Autowired
	private SqlSessionTemplate session;

//	@Override
//	public List<counsel> counselList(Map<String, Object> param) {
//		int cPage = (int)param.get("cPage");
//		
//		int limit = (int)param.get("numPerPage");
//		int offset = (cPage - 1) * limit; // 1 -> 0, 2 -> 5, 3 -> 10....
//		RowBounds rowBounds = new RowBounds(offset, limit);
//		
//		return session.selectList("counsel.counselList", null, rowBounds);
//		
//	}
//
//
//	@Override
//	public int getListCount() {
//		return session.selectOne("counsel.getListCount");	
//	}
	

}
