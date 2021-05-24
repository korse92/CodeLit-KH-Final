package com.kh.codelit.order.controller;

import java.io.IOException;
import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.codelit.lecture.model.vo.Lecture;
import com.kh.codelit.order.model.service.BasketService;
import com.kh.codelit.order.model.vo.Basket;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/order")
public class BasketController {

	@Autowired
	private BasketService basketService;

	@GetMapping("basket.do")
	public void basket(Model model, Principal pri) {
		String refMemberId = pri.getName();
		List<Basket> basketList = basketService.selectBasketList(refMemberId);
		log.debug("refMemberIdPick = {}", refMemberId);
		log.debug("basketList = {}", basketList);

		int sumBasket = 0;

		if(!basketList.isEmpty())
			sumBasket = basketService.sumBasket(refMemberId);

		log.debug("sumBasket = {}", sumBasket);

		model.addAttribute("refMemberId", refMemberId);
		model.addAttribute("basketList", basketList);
		model.addAttribute("count", basketList.size());
		model.addAttribute("sumBasket", sumBasket);
	}

	@PostMapping("addBasket.do")
	public String addBasket(
			@ModelAttribute Basket basket,
			@ModelAttribute Lecture lecture,
			RedirectAttributes redirectAttr,
			Principal principal,
			HttpServletRequest request
			) throws IllegalStateException, IOException, NullPointerException {


		basket.setRefMemberId(principal.getName());
		basket.setRefLectureNo(lecture.getLectureNo());
		basket.setBasketNo(basket.getBasketNo());

		log.debug("refMemberId = {}", basket.getRefMemberId());
		log.debug("refLectureNo = {}", basket.getRefLectureNo());
		log.debug("lectureNo = {}", lecture.getLectureNo());
		log.debug("basketNo = {}", basket.getBasketNo());

		int result = basketService.addBasket(basket.getRefLectureNo(), basket.getRefMemberId());
		log.debug("basket = {}", basket);

		return "redirect:" + request.getHeader("Referer");
	}

	@PostMapping("deleteBasket.do")
	public String deleteBasket(
						@RequestParam int lectureNo,
						Principal principal,
						RedirectAttributes redirectAttr,
						HttpServletRequest request
			) {
		String memberId = principal.getName();
		log.debug("lectureNo = {}", lectureNo);
		Map<String, Object> param = new HashMap<>();
		param.put("memberId", memberId);
		param.put("lectureNo", lectureNo);

		int result = basketService.deleteBasket(param);
		log.debug("delete = {}", result);

		return "redirect:" + request.getHeader("Referer");
	}

//	@GetMapping("selectBasketOne.do")
//	public int selectBasketOne(@ModelAttribute Basket basket) {
//		int result = basketService.selectBasketOne(basket.getRefLectureNo(), basket.getRefMemberId());
//		return result;
//	}


}
