package com.kh.codelit.order.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.codelit.order.model.vo.Basket;

public interface BasketDao {

	List<Basket> selectBasketList(String refMemberId);

	int addBasket(int refLectureNo, String refMemberId);

	int deleteBasket(Map<String, Object> param);

}
