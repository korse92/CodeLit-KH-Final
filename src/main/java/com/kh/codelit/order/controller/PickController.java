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
import com.kh.codelit.order.model.service.PickService;
import com.kh.codelit.order.model.vo.Pick;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/order")
public class PickController {

	@Autowired
	private PickService pickService;

	@GetMapping("pick.do")
	public void pick(Model model, Principal pri) {
		String refMemberId = pri.getName();
		model.addAttribute("refMemberId", refMemberId);
		List<Pick> pickList = pickService.selectPickList(refMemberId);
//		log.debug("refMemberIdPick = {}", refMemberId);
//		log.debug("pickList = {}", pickList);

		model.addAttribute("pickList", pickList);
	}

	@PostMapping("addPick.do")
	public String addPick(
						@ModelAttribute Pick pick,
						@ModelAttribute Lecture lecture,
						RedirectAttributes redirectAttr,
						Principal pri,
						HttpServletRequest request
			) throws IllegalStateException, IOException {

		pick.setRefMemberId(pri.getName());
		pick.setRefLectureNo(lecture.getLectureNo());
		pick.setPickNo(pick.getPickNo());
		log.debug("refMemberIdAddPick = {}", pick.getRefMemberId());
		log.debug("refLectureNoAddPick = {}", pick.getRefLectureNo());
		log.debug("lectureNoAddPick = {}", lecture.getLectureNo());
		log.debug("PickNoAddPick = {}", pick.getPickNo());

		int result = pickService.addPick(pick.getRefLectureNo(), pick.getRefMemberId());

			log.debug("pick = {}", pick);
//			int count = pickService.countPick(pick.getRefLectureNo(), pick.getRefMemberId());
//			log.debug("count = {}", count);
//			if(count == 0) {
//				int add = pickService.addPick(pick.getRefLectureNo(), pick.getRefMemberId());
//				log.debug("add = {}", add);
//			} else {
//				int delete = pickService.deletePick(pick.getPickNo());
//				log.debug("delete = {}", delete);
//			}

		return "redirect:" + request.getHeader("Referer");

	}

	@PostMapping("deletePick.do")
	public String deletePick(
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

		int delete = pickService.deletePick(param);
		log.debug("delete = {}", delete);

		return "redirect:" + request.getHeader("Referer");

	}


}
