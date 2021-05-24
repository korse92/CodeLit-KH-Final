package com.kh.codelit.order.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.codelit.order.model.vo.Basket;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class BasketDaoImpl implements BasketDao {

	@Autowired
	private SqlSessionTemplate session;

	@Override
	public List<Basket> selectBasketList(String refMemberId) {
		return session.selectList("basket.selectBasketList", refMemberId);
	}

	@Override
	public int addBasket(int refLectureNo, String refMemberId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("refLectureNo", refLectureNo);
		map.put("refMemberId", refMemberId);
		return session.insert("basket.addBasket", map);
	}

	@Override
	public int deleteBasket(Map<String, Object> param) {
		return session.delete("basket.deleteBasket", param);
	}

//	@Override
//	public int selectBasketOne(int refLectureNo, String refMemberId) {
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("refLectureNo", refLectureNo);
//		map.put("refMemberId", refMemberId);
//		return session.selectOne("basket.selectBasketOne", map);
//	}

	@Override
	public int sumBasket(String refMemberId) {
		return session.selectOne("basket.sumBasket", refMemberId);
	}


}
