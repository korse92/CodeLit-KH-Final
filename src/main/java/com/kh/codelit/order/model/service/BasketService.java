package com.kh.codelit.order.model.service;

import java.util.List;
import java.util.Map;

import com.kh.codelit.order.model.vo.Basket;

public interface BasketService {

	List<Basket> selectBasketList(String refMemberId);

	int addBasket(int refLectureNo, String refMemberId);

	int deleteBasket(Map<String, Object> param);

}
