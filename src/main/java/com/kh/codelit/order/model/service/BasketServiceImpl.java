package com.kh.codelit.order.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.codelit.order.model.dao.BasketDao;
import com.kh.codelit.order.model.vo.Basket;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class BasketServiceImpl implements BasketService {

	@Autowired
	private BasketDao basketDao;

	@Override
	public List<Basket> selectBasketList(String refMemberId) {
		return basketDao.selectBasketList(refMemberId);
	}

	@Override
	public int addBasket(int refLectureNo, String refMemberId) {
		return basketDao.addBasket(refLectureNo, refMemberId);
	}

	@Override
	public int deleteBasket(Map<String, Object> param) {
		return basketDao.deleteBasket(param);
	}

//	@Override
//	public int selectBasketOne(int refLectureNo, String refMemberId) {
//		return basketDao.selectBasketOne(refLectureNo, refMemberId);
//	}

	@Override
	public int sumBasket(String refMemberId) {
		return basketDao.sumBasket(refMemberId);
	}
}
