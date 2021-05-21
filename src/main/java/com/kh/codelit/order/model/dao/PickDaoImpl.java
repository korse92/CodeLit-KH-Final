package com.kh.codelit.order.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.codelit.order.model.vo.Pick;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class PickDaoImpl implements PickDao {
	
	@Autowired
	private SqlSessionTemplate session;

	@Override
	public List<Pick> selectPickList(String refMemberId) {
		return session.selectList("pick.selectPickList", refMemberId);
	}

	@Override
	public int countPick(int refLectureNo, String refMemberId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("refLectureNo", refLectureNo);
		map.put("refMemberId", refMemberId);
		return session.selectOne("pick.countPick", map);
	}

	@Override
	public int addPick(int refLectureNo, String refMemberId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("refLectureNo", refLectureNo);
		map.put("refMemberId", refMemberId);
		return session.insert("pick.addPick", map);
	}

	@Override
	public int deletePick(int pickNo) {
		return session.delete("pick.deletePick", pickNo);
	}

}
