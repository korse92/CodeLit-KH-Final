package com.kh.codelit.websocket.model.service;

import java.util.List;
import java.util.Map;

import com.kh.codelit.websocket.model.vo.Messenger;

public interface MessengerService {

	List<Map<String, String>> selectMember();

	int insertMsg(Messenger msg);

	int insertMsgCurrval(Messenger msg);

	List<Map<String, String>> selectAuth(String auth);
	
}
