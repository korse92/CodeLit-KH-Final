package com.kh.codelit.order.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.codelit.order.model.vo.Payment;

import lombok.extern.slf4j.Slf4j;



@Repository
@Slf4j
public class PaymentDaoImpl implements PaymentDao {

	@Autowired
	private SqlSessionTemplate session;

	@Override
	public int insertOrder(Payment payment) {

		return session.insert("order.insertOrder", payment);
	}

	@Override
	public int insertPayLecture(List<Map<String, Object>> list) {

		return session.insert("order.insertPayLecture", list);
	}

	@Override
	public int deleteBasket(String refMemberId) {

		return session.delete("order.deleteBasket", refMemberId);
	}
	
	
}
