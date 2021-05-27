package com.kh.codelit.websocket.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.codelit.websocket.model.vo.Messenger;

public interface MessengerDAO {

	int insertMsg(Messenger msg);

	List<Map<String, String>> selectAuth(String auth);

	List<Messenger> alarmList(Map<String, Object> param);

	int getListCount(String name);

	int getReadVal(String name);

	int updateReadVal(int msgNo);

	Messenger selectOneMsg(int msgNo);

	List<Messenger> alarmList(String memberId);

	List<String> selectAuthTeacher();


}
