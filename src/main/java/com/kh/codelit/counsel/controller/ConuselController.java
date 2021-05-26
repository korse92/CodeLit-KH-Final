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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.codelit.attachment.model.vo.Attachment;
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
	public ModelAndView selelctBoard(
		@RequestParam(defaultValue = "1") int cPage,
		HttpServletRequest request,
		Authentication authentication,
		ModelAndView mav) {
		
		try {
			//1. 사용자 입력값
			int numPerPage = 10;
			
			String memberId = ((Member)authentication.getPrincipal()).getMemberId();
			log.debug("counseList memberId = {}", memberId);
			
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
			String paramUrl = HelloSpringUtils.convertToParamUrl(request);
			String pageBar = HelloSpringUtils.getPageBar(totalContents, cPage, numPerPage, paramUrl);
			
			//3.jsp 위임처리
			mav.addObject("list", list);
			mav.addObject("pageBar", pageBar);
			
			mav.setViewName("counsel/counselList");
		} catch(Exception e) {
			throw e;
		}
		
		return mav;
	}
	
	@GetMapping("/counselDetail.do")
	public void counseDetail(
				@RequestParam int counselNo,
				Model model
			) {
		
		log.debug("counselNo = {}", counselNo);
		
		try {
			Map<String, Object> map = service.selectOneCounsel(counselNo);

			Counsel counsel = (Counsel)map.get("counsel");
			log.debug("counsel = {}", counsel);
			
			Attachment attach = (Attachment)map.get("attach");
			
			model.addAttribute("counsel", counsel);
			model.addAttribute("attach", attach != null ? attach : null);
			
		} catch(Exception e) {
			throw e;
		}
		
	}
	
	
	
	@GetMapping("/counselWrite.do")
	public void counselWrite() {
		
	}
	
	@PostMapping("/counselWrite.do")
	public ModelAndView counselWrite(
			@ModelAttribute Counsel counsel,
			@RequestParam(value="upFile", required = false) MultipartFile upFile,
			HttpServletRequest request,
			ModelAndView mav,
			RedirectAttributes redirectAttr,
			Authentication authentication) throws Exception {
		
		try {
			log.debug("upFile = {}", upFile);
			
			counsel.setRefMemberId(((Member)authentication.getPrincipal()).getMemberId());
			log.debug("counsel = {}", counsel);
			
			File renamedFile = null;
			Attachment attach = null;
			if(!upFile.isEmpty()) {
				String saveDirectory =  request.getServletContext().getRealPath(Attachment.PATH_COUNSEL);
				
				File dir = new File(saveDirectory);
				if(!dir.exists())
					dir.mkdir();
				
				renamedFile = HelloSpringUtils.getRenamedFile(saveDirectory, upFile.getOriginalFilename());
				
				attach = new Attachment();
				attach.setOriginalFilename(upFile.getOriginalFilename());
				attach.setRenamedFilename(renamedFile.getName());
				attach.setRefContentsGroupCode(Attachment.CODE_COUNSEL);
				attach.setContentsAttachPath(Attachment.PATH_COUNSEL);
			}
			
			Map<String, Object> param = new HashMap<>();
			param.put("counsel", counsel);
			param.put("attach", attach != null ? attach : null);
			
			int result = service.insertCounsel(param);
			
			if(!upFile.isEmpty()) {
				upFile.transferTo(renamedFile);				
			}
			
			String msg = result > 0 ?"등록완료 되었습니다.":"등록 실패하였습니다.";
			redirectAttr.addFlashAttribute("msg",msg);
			
			mav.setViewName("redirect:/counsel/counselList.do");
			
		} catch(Exception e) {
			throw e;
		}
		
		return mav;

	}

	
	
	@GetMapping("/counselListAdmin.do")
	public void counselListAdmin(
				Model model,
				@RequestParam(defaultValue = "1") int cPage,
				HttpServletRequest request
			) {
		
		try {
			//1. 사용자 입력값
			int numPerPage = 10;
			
			Map<String, Object> param = new HashMap<>();
			param.put("numPerPage", numPerPage);
			param.put("cPage", cPage);
			
			//2. 업무로직
			//a. contents영역
			List<Counsel> list = service.selectCounselListAdmin(param);
			log.debug("list = {}", list);
			
			//b. pageBar영역
			int totalContents = service.getTotalContents(null);
			String paramUrl = HelloSpringUtils.convertToParamUrl(request);
			String pageBar = HelloSpringUtils.getPageBar(totalContents, cPage, numPerPage, paramUrl);
			
			//3.jsp 위임처리
			model.addAttribute("list", list);
			model.addAttribute("pageBar", pageBar);
			
		} catch(Exception e) {
			throw e;
		}
		
	}
	
	@GetMapping("/counselAnswer.do")
	public void counselAnswer(
				@RequestParam int counselNo,
				Model model
			) {
		
		log.debug("counselNo = {}", counselNo);
		
		try {
			Map<String, Object> map = service.selectOneCounsel(counselNo);

			Counsel counsel = (Counsel)map.get("counsel");
			log.debug("counsel = {}", counsel);
			
			Attachment attach = (Attachment)map.get("attach");
			
			model.addAttribute("counsel", counsel);
			model.addAttribute("attach", attach != null ? attach : null);
			
		} catch(Exception e) {
			throw e;
		}
		
	}
	
	@PostMapping("/counselAnswer.do")
	public String counselAnswer(
				@ModelAttribute Counsel counsel,
				@RequestParam(value= "upFile", required = false) MultipartFile upFile,
				HttpServletRequest request,
				RedirectAttributes redirectAttr,
				Authentication authentication
			) throws Exception {
		
		log.debug("counselAnswer 진입 = {}", counsel);
		log.debug("upFile = {}", upFile);
		log.debug("upFile Name = {}", upFile.getOriginalFilename());
		
		try {
			// 로그인 정보
			Member loginMember = (Member)authentication.getPrincipal();
			
			// counsel 객체에 정보 담음
			counsel.setRefMemberId(loginMember.getMemberId());
			counsel.setCounselLevel(2);
			
			Attachment attach = null;
			File renamedFile = null;
			if(!upFile.isEmpty()) {
				
				// 파일 저장 경로
				String saveDirectory =  request.getServletContext().getRealPath(Attachment.PATH_COUNSEL);
				
				// 경로 없으면 생성
				File dir = new File(saveDirectory);
				if(!dir.exists())
					dir.mkdir();
				
				// 리네임드파일 생성
				renamedFile = HelloSpringUtils.getRenamedFile(saveDirectory, upFile.getOriginalFilename());
				
				// attach 객체 생성 및 정보 담기
				attach = new Attachment();
				attach.setContentsAttachPath(Attachment.PATH_COUNSEL);
				attach.setRefContentsGroupCode(Attachment.CODE_COUNSEL);
				attach.setOriginalFilename(upFile.getOriginalFilename());
				attach.setRenamedFilename(renamedFile.getName());
			}
			
			// map 객체에 두 객체 담기
			Map<String, Object> param = new HashMap<>();
			param.put("counsel", counsel);
			param.put("attach", attach != null ? attach : null);
			
			int result = service.insertCounselAnswer(param);
			log.debug("inserCounselAnswer 메소드 = {}", "성공");
			
			if(!upFile.isEmpty()) {
				upFile.transferTo(renamedFile);
			}
			redirectAttr.addFlashAttribute("msg", "답변이 등록되었습니다.");
		} catch(Exception e) {
			throw e;
		}
		
		return "redirect:/counsel/counselListAdmin.do";
	}
	
	
}