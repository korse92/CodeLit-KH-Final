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

	@Override
	public int getReadVal(String name) {
		return session.selectOne("msg.getReadVal", name);
	}

	@Override
	public int updateReadVal(int msgNo) {
		return session.update("msg.updateReadVal",msgNo);
	}

	@Override
	public Messenger selectOneMsg(int msgNo) {
		return session.selectOne("msg.selectOneMsg",msgNo);
	}

	@Override
	public List<Messenger> alarmList(String memberId) {
		return session.selectList("msg.selectList", memberId);
	}

	@Override
	public List<String> selectAuthTeacher() {
		return session.selectList("msg.selectAuth");
	}

	@Override
	public List<Messenger> alarmListMyprofile(String memberId) {
		return session.selectList("msg.alarmListMyprofile", memberId);
	}

	@Override
	public List<Map<String, String>> selectAuth() {
		return session.selectList("msg.selectAuth");
	}

	
}
