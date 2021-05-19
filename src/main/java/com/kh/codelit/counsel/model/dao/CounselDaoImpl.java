package com.kh.codelit.counsel.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.codelit.counsel.model.vo.Counsel;
@Repository
public class CounselDaoImpl implements CounselDao {
	@Autowired
	private SqlSessionTemplate session;

	@Override
	public int insertBoard(Counsel counsel) {
		
		return session.insert("counsel.insertBoard",counsel);
	}
}
