package com.kh.codelit.order.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.codelit.order.model.service.BasketService;
import com.kh.codelit.order.model.service.OrderService;
import com.kh.codelit.order.model.vo.Basket;
import com.kh.codelit.order.model.vo.Order;

import lombok.extern.slf4j.Slf4j;



@Controller
@Slf4j
@RequestMapping("/order")
public class OrderController {

	@Autowired
	private OrderService orderService;
	
	@Autowired
	private BasketService basketService;
	
	
	
	@PostMapping("/orderHandling.do")
	public String orderHandling(
				@ModelAttribute Order order,
				RedirectAttributes redirectAttr,
				Principal pri
			) {
		
		log.debug("orderHandling order = {}", order);
		String address = null;
		
		try {
			List<Basket> basketList = basketService.selectBasketList(order.getRefMemberId());
			
			
			
		} catch(Exception e) {
			throw e;
		}
		
		return null;
	}
	
	
}
