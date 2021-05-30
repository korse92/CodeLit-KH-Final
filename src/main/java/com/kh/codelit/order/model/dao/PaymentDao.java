package com.kh.codelit.order.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.codelit.order.model.vo.Payment;



public interface PaymentDao {

	int insertOrder(Payment payment);

	int insertPayLecture(List<Map<String, Object>> list);

	int deleteBasket(String refMemberId);

	List<Map<String, Object>> selectPayChapter(List<Integer> refLectureNoList);

	int insertPayChapter(Map<String, Object> param);

	int deletePayPick(Map<String, Object> param);

}
