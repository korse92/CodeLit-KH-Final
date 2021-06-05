package com.kh.codelit.community.study.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.codelit.community.study.model.service.CommentService;
import com.kh.codelit.community.study.model.service.StudyService;
import com.kh.codelit.community.study.model.vo.Comment;
import com.kh.codelit.community.study.model.vo.StudyBoard;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/community")
@Slf4j
public class CommentController {
	
	@Autowired
	private CommentService service;
	@Autowired
	private StudyService stdService;

	@PostMapping("/insertComment.do")
	public String cmtInsert(
			@ModelAttribute Comment cmt,
			RedirectAttributes redirect,
			Principal pri) {
		try {
			cmt.setRefMemberId(pri.getName());
			int result = service.insertCmt(cmt);
		}catch (Exception e) {
			throw e;
		}
		return "redirect:/community/studyDetail.do?stdBrdNo="+cmt.getRefStdBrdNo();
	}
	@GetMapping("/updateComment.do")
	public void updateComment(@RequestParam int cmtNo, Model model) {
		try {
			List<Comment> listCmt = stdService.selectCmt(cmtNo);
			model.addAttribute("listCmt", listCmt);
		} catch (Exception e) {
			throw e;
		}
	}
	
	@PostMapping("/updateComment.do")
	public String updateCmt(
			@ModelAttribute Comment cmt,
			RedirectAttributes redirect) {
		try {
			int result = service.update(cmt);
		} catch (Exception e) {
			throw e;
		}
		return "redirect:/community/studyDetail.do?stdBrdNo="+cmt.getRefStdBrdNo();
	}
	@PostMapping("/deleteCmt.do")
	public String deleteCmt(@RequestParam int stdCmtNo) {
		Comment cmt = null;
		try {
			
			cmt = service.selectStdNo(stdCmtNo);
			int result = service.delete(stdCmtNo);
		} catch (Exception e) {
			throw e;
		}		
		return "redirect:/community/studyDetail.do?stdBrdNo="+cmt.getRefStdBrdNo();
	}
	
}
