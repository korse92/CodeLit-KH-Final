package com.kh.codelit.lecture.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.codelit.common.HelloSpringUtils;
import com.kh.codelit.lecture.model.service.LectureService;
import com.kh.codelit.lecture.model.vo.Lecture;
import com.kh.codelit.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;



@Slf4j
@Controller
@RequestMapping("/lecture")
public class LectureController {

	@Autowired
	private LectureService lectureService;

	@GetMapping(value = {"/lectureList.do/{catNo}", "/lectureList.do"})
	public String lectureList(
			@PathVariable(required = false) Integer catNo,
			@RequestParam(defaultValue = "1") int cPage,
			HttpServletRequest request,
			Model model,
			Principal principal) {
		//1. 사용자 입력값
		if(catNo == null)
			catNo = 0;
		int numPerPage = 12;
		String memberId = principal != null ? principal.getName() : null;
		log.debug("catNo = {}", catNo);
		log.debug("cPage = {}", cPage);
		log.debug("memberId = {}", memberId);
		Map<String, Object> param = new HashMap<>();
		param.put("numPerPage", numPerPage);
		param.put("catNo", catNo);
		param.put("cPage", cPage);
		param.put("memberId", memberId);

		//2. 업무로직
		//a. contents영역
		List<Lecture> list = lectureService.selectLectureList(param);
		log.debug("list = {}", list);

		//b. pageBar영역
		int totalContents = lectureService.getTotalContents(catNo);
		String url = HelloSpringUtils.convertToParamUrl(request);
		log.debug("totalContents = {}", totalContents);
		log.debug("url = {}", url);
		String pageBar = HelloSpringUtils.getPageBar(totalContents, cPage, numPerPage, url);

		//3.jsp 위임처리
		model.addAttribute("list", list);
		model.addAttribute("pageBar", pageBar);

		return "lecture/lectureList";
	}

	@GetMapping("/lectureDetail.do")
	public ModelAndView lectureDetail(HttpServletRequest request,
									  @RequestParam int no,
									  ModelAndView mav,
									  Authentication authentication) {
		//1. 업무로직
	
		
		// 로그인 정보
		Member loginMember = (Member)authentication.getPrincipal();
		//log.debug("loginMember = {}", loginMember);
		loginMember.getMemberId();
		log.debug("loginMember id = {}", loginMember);

		
		Lecture lecture = lectureService.selectOneLecture(no);
		lecture.setLectureCommentList(lectureService.selectLectureCmtList(no));
		int numPerCmtPage = 5;
		int totalCmtPage = (int)Math.ceil((double)lecture.getLectureCommentList().size() / numPerCmtPage);
		log.debug("lecture = {}", lecture);
		log.debug("totalCmtPage = {}", totalCmtPage);
		
		
		//map객체에 담아보기
		Map<String,Object> param = new HashMap<>();
		param.put("ref_member_id", loginMember.getMemberId());
		param.put("no", no);
		log.debug("param = {}", param);
		
		//강의id 담아 클릭수
		int result = lectureService.clickCount(param);
		log.debug("clickCountresult = {}", result);

		//2. jsp 위임
		mav.addObject("lecture", lecture);
		mav.addObject("numPerCmtPage", numPerCmtPage);
		mav.addObject("totalCmtPage", totalCmtPage);
		mav.setViewName("lecture/lectureDetail");

		return mav;
	}

	
	@GetMapping("/mainSearchResult.do")
	public ModelAndView mainSearchResult(ModelAndView mav,
										@RequestParam(required = false) String keyword
										) 
	{
		
		//log.debug("메인 검색 컨트롤러 연결 완@searchKeyword = {}", keyword);
		
	try {
		Map<String, Object> param = new HashMap<>();
		param.put("searchKeyword", keyword);
		log.debug("param = {}", param);
		
		List<Map<String, Object>> list = lectureService.mainSearchResult(param);
		log.debug("mainSearchResult@list = {}", list);
		
		mav.addObject("list",list);
		mav.setViewName("/lecture/mainSearchResult");
	}catch(Exception e) {
		throw e;
	}
	
		return mav;
	}
	
	@GetMapping("/lecture.do")
	public void lecture(
			
			) {
		
		try {
			
		} catch(Exception e) {
			
		}
		
	}
	
	
}
