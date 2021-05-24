package com.kh.codelit.order.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.codelit.order.model.dao.OrderDao;

import lombok.extern.slf4j.Slf4j;



@Service
@Slf4j
public class OrderServiceImpl implements OrderService {

	@Autowired
	private OrderDao orderDao;
	
	
}
