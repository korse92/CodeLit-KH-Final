package com.kh.codelit.community.study.controller;

import java.io.File;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.codelit.attachment.model.vo.Attachment;
import com.kh.codelit.common.HelloSpringUtils;
import com.kh.codelit.community.study.model.service.StudyService;
import com.kh.codelit.community.study.model.vo.StudyBoard;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/community")
@Slf4j
public class StudyBoardController {
	
	@Autowired
	private StudyService service;
	
	@GetMapping("/studyList.do")
	public void selectBoard(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request) {

		int numPerPage = 10;
		//클릭한 페이지, 총게시글 수전달
		Map<String, Object> param = new HashMap<>();
		param.put("numPerPage", numPerPage);
		param.put("cPage", cPage);
		
		List<StudyBoard> list = service.studyBoardList(param);
		
		int count = service.getListCount();
		String uri = request.getRequestURI();
		String pageBar = HelloSpringUtils.getPageBar(count, cPage, numPerPage, uri);
		
		model.addAttribute("list", list);
		model.addAttribute("pageBar", pageBar);
		
		
	}
	
	@GetMapping(value = {"/studyDetail.do", "/studyUpdate.do"})
	public void selectOneNotice(@RequestParam int stdBrdNo, Model model) {
		
		int result = service.updateCnt(stdBrdNo);
		StudyBoard stdBrd = service.selectOneStudy(stdBrdNo);
		model.addAttribute("stdBrd",stdBrd);
		Attachment attach = service.selectOneAttach(stdBrdNo);
		
		if(attach != null) {
			String attachPath = attach.getContentsAttachPath() +"/"+ attach.getRenamedFilename();
			model.addAttribute("attachPath", attachPath);
			model.addAttribute("attach",attach);
		}
	}
	
	@GetMapping("/studyWrite.do")
	public void BoardWrite() {
		
	}
	@PostMapping("/studyInsert.do")
	public String studyInsert(
				@ModelAttribute StudyBoard studyBoard,
				@RequestParam(required = false) MultipartFile upFile,
				HttpServletRequest request,
				RedirectAttributes redirect,
				Principal pri) throws IllegalStateException, IOException {
		
		String saveDirectory =  request.getServletContext().getRealPath(Attachment.PATH_STUDYBOARD);
		
		File dir = new File(saveDirectory);
		if(!dir.exists())
			dir.mkdir();
		
		studyBoard.setRefMemberId(pri.getName());

		int result = service.insertBoard(studyBoard);
		if(!upFile.isEmpty() || upFile.getSize() > 0) {
		
			File renamedFile = HelloSpringUtils.getRenamedFile(saveDirectory, upFile.getOriginalFilename());
			
			//파일 저장
			upFile.transferTo(renamedFile);
			
			//Attachment객체생성
			Attachment attach = new Attachment(0,studyBoard.getStdBrdNo(),upFile.getOriginalFilename(),renamedFile.getName(),Attachment.CODE_STUDY_BOARD,Attachment.PATH_STUDYBOARD);
			
			int FileInsert = service.insertAttachment(attach);
		}

		String msg = result > 0 ?"등록완료 되었습니다.":"등록 실패하였습니다.";
		redirect.addFlashAttribute("msg",msg);
		return "redirect:/community/studyList.do";
	}
	
	@PostMapping("/studyUpdate.do")
	public String BoardUpdate(@ModelAttribute StudyBoard stdBrd, RedirectAttributes redirect) {
		int result = service.update(stdBrd);
		String msg = result > 0 ? "수정 성공":"수정 실패";
		redirect.addFlashAttribute("msg",msg);
		
		return "redirect:/community/noticeDetail.do?noticeNo="+stdBrd.getStdBrdNo();
	}
	
	@GetMapping("/studyDelete.do")
	public String BoardDelete(@RequestParam int stdBrdNo, RedirectAttributes redirect) {
		int attDel = service.deleteAttach(stdBrdNo);
		int result = service.delete(stdBrdNo);
		String msg = result > 0 ?"삭제 성공" : "삭제 실패";
		redirect.addFlashAttribute("msg", msg);
		return "redirect:/community/studyList.do";
	}
	
}	
