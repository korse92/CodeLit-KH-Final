package com.kh.codelit.counsel.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.codelit.common.HelloSpringUtils;
import com.kh.codelit.counsel.model.service.CounselService;
import com.kh.codelit.counsel.model.vo.Counsel;
import com.kh.codelit.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/counsel")
@Slf4j
public class ConuselController {

	@Autowired
	private CounselService service;
	
	@GetMapping("/counselList.do")
	public String selelctBoard(
		@RequestParam(defaultValue = "1") int cPage,
		HttpServletRequest request,
		Authentication authentication,
		Model model) {
		
		try {
			//1. 사용자 입력값
			int numPerPage = 10;
			
			String memberId = ((Member)authentication.getPrincipal()).getMemberId();
			
			Map<String, Object> param = new HashMap<>();
			param.put("numPerPage", numPerPage);
			param.put("cPage", cPage);
			param.put("memberId", memberId);
			
			//2. 업무로직
			//a. contents영역
			List<Counsel> list = service.selectCounselList(param);
			log.debug("list = {}", list);
			
			
			//b. pageBar영역
			int totalContents = service.getTotalContents(memberId);
			String url = request.getRequestURI();
			log.debug("url = {}", url);
			String pageBar = HelloSpringUtils.getPageBar(totalContents, cPage, numPerPage, url);
			
			//3.jsp 위임처리
			model.addAttribute("list", list);
			model.addAttribute("pageBar", pageBar);
			
		} catch(Exception e) {
			throw e;
		}
		
		return "counsel/counselList";
	}
	
	@GetMapping("/counselDetail.do")
	public void counseDetail(
				@RequestParam int counselNo,
				Model model
			) {
		
		log.debug("counselNo = {}", counselNo);
		
		try {
			Counsel counsel = service.selectOneCounsel(counselNo);
			log.debug("counsel = {}", counsel);
			
			model.addAttribute("counsel", counsel);
			
		} catch(Exception e) {
			throw e;
		}
		
	}
	
	
	
	@GetMapping("/counselWrite.do")
	public void counselWrite() {
		
	}
	
	@PostMapping("/counselWrite.do")
	public String counselWrite(
			@ModelAttribute Counsel counsel,
			@RequestParam(required = false) MultipartFile upFile,
			HttpServletRequest request,
			Model model,
			RedirectAttributes redirectAttr,
			Authentication authentication) {
		
		try {
			log.debug("upFile = {}", upFile);
			
			String saveDirectory =  request.getServletContext().getRealPath("/resources/upload/counsel");
			
			File dir = new File(saveDirectory);
			if(!dir.exists())
				dir.mkdir();
			
			counsel.setRefMemberId(((Member)authentication.getPrincipal()).getMemberId());
			
			log.debug("counsel = {}", counsel);
			
			int result = service.insertCounsel(counsel);
			String msg = result > 0 ?"등록완료 되었습니다.":"등록 실패하였습니다.";
			redirectAttr.addFlashAttribute("msg",msg);
			
		} catch(Exception e) {
			throw e;
		}
		
		return "redirect:/counsel/counselList.do";

	}

}
