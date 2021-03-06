package com.kh.codelit.order.model.service;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.codelit.order.model.dao.BasketDao;
import com.kh.codelit.order.model.dao.PaymentDao;
import com.kh.codelit.order.model.vo.Basket;
import com.kh.codelit.order.model.vo.Payment;

import lombok.extern.slf4j.Slf4j;



@Service
@Slf4j
public class PaymentServiceImpl implements PaymentService {

	@Autowired
	private PaymentDao paymentDao;

	@Autowired
	private BasketDao basketDao;
	
	
	
	@Override
	public int insertPayment(Payment payment) {
		
		
		
		// 장바구니 리스트 가져옴
		List<Basket> basketList = basketDao.selectBasketList(payment.getRefMemberId());
		
		
		
		// 장바구니 번호들 가져옴
		List<Integer> refLectureNoList = new ArrayList<>();
		for(Basket basket : basketList) {
			refLectureNoList.add(basket.getRefLectureNo());
		}
		payment.setRefLectureNo(refLectureNoList);

		
		
		// payment 집어넣기 
		int a = paymentDao.insertOrder(payment);
		if(a <= 0) {return 0;}
		log.debug("insertOrdrer = {}", "성공");
		
		
		
		// pay_lecture 집어넣기
		List<Map<String, Object>> list = new ArrayList<>();
		
		String payCode = payment.getPayCode();
		List<Integer> integerList = payment.getRefLectureNo();		
		
		Map<String, Object> param = null;
		for(int n : integerList) {
			log.debug("payment.getRefLectureNo = {}", n);
			param = new HashMap<>();
			param.put("payCode", payCode);
			param.put("no", n);
			log.debug("param no = {}", param.get("no") == null ? "없음" : param.get("no"));
			list.add(param);
		}
		// param에 주문번호, 강의번호 담겨있음
		
		int b = paymentDao.insertPayLecture(list);
		if(b <= 0) {return 0;}
		log.debug("insertPayLecture = {}", "성공");
		
		
		
		// basket 삭제하기
		int c = paymentDao.deleteBasket(payment.getRefMemberId());
		log.debug("deleteBasket = {}", "성공");
		
		
		
		// 찜 삭제하기
		param = new HashMap<>();
		param.put("refMemberId", payment.getRefMemberId());
		param.put("refLectureNoList", refLectureNoList);
		int d = paymentDao.deletePayPick(param);
		
				
				
		// 챕터번호들 가져오기
		List<Map<String, Object>> chapList = paymentDao.selectPayChapter(refLectureNoList);
		log.debug("chapList = {}", chapList);
		
		
		
		// progress 집어넣기 (수강진도)
		param.put("chapList", chapList);
		int e = paymentDao.insertPayChapter(param);
		
		
		
		return e;
		
	} // paymentHandling
	
}
