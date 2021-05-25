package com.kh.codelit.websocket.model.dao;

import java.util.List;
import java.util.Map;

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
	public List<Map<String, String>> selectMember() {
		return  session.selectList("msg.selectMember");
	}

	@Override
	public int insertMsgCurrval(Messenger msg) {
		return session.insert("msg.insertMsgCurrval",msg);
	}

	@Override
	public List<Map<String, String>> selectAuth(String auth) {
		return session.selectList("msg.selectAuth", auth);
	}
	
}
