package com.kh.codelit.websocket.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.codelit.websocket.model.dao.MessengerDAO;
import com.kh.codelit.websocket.model.dao.MessengerDAOImpl;
import com.kh.codelit.websocket.model.vo.Messenger;

@Service
public class MessengerServiceImpl implements MessengerService {
	
	@Autowired
	private MessengerDAO dao;


	@Override
	public int insertMsg(Messenger msg) {
		return dao.insertMsg(msg);
	}

	@Override
	public int insertMsgCurrval(Messenger msg) {
		return dao.insertMsgCurrval(msg);
	}


	@Override
	public List<Map<String, String>> selectAuth(String auth) {
		return dao.selectAuth(auth);
	}


	@Override
	public List<Messenger> arlarmList(String name) {
		return dao.alarmList(name);
	}

}	
