package com.kh.codelit.counsel.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;





@Repository
public abstract class CounselDaoImpl implements CounselDao {

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
