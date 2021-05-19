package com.kh.codelit.counsel.controller;

import java.io.File;
import java.security.Principal;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.codelit.community.notice.model.vo.Notice;
import com.kh.codelit.counsel.model.service.CounselService;
import com.kh.codelit.counsel.model.vo.Counsel;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/counsel")
@Slf4j
public class ConuselController {

	@Autowired
	private CounselService service;
	
	@GetMapping("/counselList.do")
	public void selelctBoard() {
		
	}
	@GetMapping("/counselWrite.do")
	public void counselwriteBoard() {
		
	}
	@PostMapping("/counselInsert.do")
	public String Eroll (@ModelAttribute Counsel counsel,
	@RequestParam(required = false) MultipartFile upFile,
	HttpServletRequest request,
	Model model,
	RedirectAttributes redirect,
	Principal pri) {
		log.debug("upFile = {}", upFile);
		String saveDirectory =  request.getServletContext().getRealPath("/resources/upload/counsel");
		File dir = new File(saveDirectory);
		if(!dir.exists())
		dir.mkdir();
	counsel.setRefMemberId(pri.getName());

	//int result = service.insertCounsel(counsel);
//	String msg = result > 0 ?"등록완료 되었습니다.":"등록 실패하였습니다.";
//	redirect.addFlashAttribute("msg",msg);

	return "redirect:/counsel/counselList.do";


	}


}
