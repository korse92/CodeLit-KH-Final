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
	public List<Messenger> arlarmList(Map<String, Object> param) {
		return dao.alarmList(param);
	}

	@Override
	public int getListCount(String name) {
		return dao.getListCount(name);

	}

	@Override
	public int getReadVal(String name) {
		return dao.getReadVal(name);
	}

	@Override
	public int updateReadVal(int msgNo) {
		return dao.updateReadVal(msgNo);
	}

	@Override
	public Messenger selectOneMsg(int msgNo) {
		return dao.selectOneMsg(msgNo);
	}

	@Override
	public List<Messenger> alarmList(String memberId) {
		return dao.alarmList(memberId);
	}

	@Override
	public List<String> selectAuthTeacher() {
		return dao.selectAuthTeacher();
	}

	@Override
	public List<Messenger> alarmListMyprofile(String memberId) {
		return dao.alarmListMyprofile(memberId);
	}

	@Override
	public List<Map<String, String>> selectAuth() {
		return dao.selectAuth();
	}

}	
