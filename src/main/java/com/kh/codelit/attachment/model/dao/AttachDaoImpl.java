package com.kh.codelit.attachment.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.codelit.attachment.model.vo.Attachment;

@Repository
public class AttachDaoImpl implements AttachDao {
	
	@Autowired
	private SqlSessionTemplate session;

	@Override
	public int insertAttachment(Attachment attach) {
		return session.insert("attachment.insertAttachment", attach);
	}

}
