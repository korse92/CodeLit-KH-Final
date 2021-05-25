package com.kh.codelit.websocket.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.codelit.websocket.model.vo.Messenger;

@Repository
public class MessengerDAOImpl implements MessengerDAO{

	@Autowired
	private SqlSessionTemplate session;

	@Override
	public int insertMsg(Messenger msg) {
		return session.insert("msg.insertMsg", msg);
	}

	@Override
	public int insertMsgCurrval(Messenger msg) {
		return session.insert("msg.insertMsgCurrval",msg);
	}

	@Override
	public List<Map<String, String>> selectAuth(String auth) {
		return session.selectList("msg.selectAuth", auth);
	}

	@Override
	public List<Messenger> alarmList(Map<String, Object> param) {
		int cPage = (int) param.get("cPage");
		int limit = (int) param.get("numPerPage");
		int offset = (cPage - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		String name = (String) param.get("name");
		
		return session.selectList("msg.alarmList",name,rowBounds);
	}

	@Override
	public int getListCount(String name) {
		return session.selectOne("msg.getListCount", name);
	}
	
}
