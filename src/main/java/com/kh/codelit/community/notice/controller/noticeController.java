package com.kh.codelit.community.notice.controller;


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
import com.kh.codelit.community.notice.model.service.NoticeService;
import com.kh.codelit.community.notice.model.vo.Notice;
import com.kh.codelit.lecture.model.service.LectureService;
import com.kh.codelit.lecture.model.vo.Lecture;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/community")
@Slf4j
public class noticeController {
	
	@Autowired
	private NoticeService service;
	
	
	@GetMapping("/noticeList.do")
	public void selectBoard(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request) {
		try {
			int numPerPage = 10;
			//클릭한 페이지, 총게시글 수전달
			Map<String, Object> param = new HashMap<>();
			param.put("numPerPage", numPerPage);
			param.put("cPage", cPage);
			
			List<Notice> list = service.noticeList(param);
			
			int count = service.getListCount();
			String uri = HelloSpringUtils.convertToParamUrl(request);
			String pageBar = HelloSpringUtils.getPageBar(count, cPage, numPerPage, uri);
			
			model.addAttribute("list", list);
			model.addAttribute("pageBar", pageBar);
		} catch (Exception e) {
			throw e;
		}
	}
	
	@GetMapping("/noticeWrite.do")
	public void writeAdminBoard() {
		
	}
	
	@PostMapping("/noticeInsert.do")
	public String Enroll(
				@ModelAttribute Notice notice,
				@RequestParam(required = false) MultipartFile upFile,
				HttpServletRequest request,
				RedirectAttributes redirect,
				Principal pri) throws IllegalStateException, IOException {
		
		try {
			String saveDirectory =  request.getServletContext().getRealPath(Attachment.PATH_NOTICE);
			
			File dir = new File(saveDirectory);
			if(!dir.exists())
				dir.mkdir();
			
			notice.setRefMemberId(pri.getName());
			int result = service.insertBoard(notice);
			if(!upFile.isEmpty() || upFile.getSize() > 0) {
			
				File renamedFile = HelloSpringUtils.getRenamedFile(saveDirectory, upFile.getOriginalFilename());
				//파일 저장
				upFile.transferTo(renamedFile);
				
				//Attachment객체생성
				Attachment attach = new Attachment(0,notice.getNoticeNo(),upFile.getOriginalFilename(),renamedFile.getName(),Attachment.CODE_NOTICE,Attachment.PATH_NOTICE);
				
				service.insertAttachment(attach);
			}
	
			String msg = result > 0 ?"등록완료 되었습니다.":"등록 실패하였습니다.";
			redirect.addFlashAttribute("msg",msg);
		} catch (Exception e) {
			throw e;
		}
		return "redirect:/community/noticeList.do";
	}
	
	@GetMapping(value = {"/noticeDetail.do", "/noticeUpdate.do"})
	public void selectOneNotice(@RequestParam int noticeNo, Model model) {
		try {
			int result = service.updateCnt(noticeNo);
			Notice notice = service.selectOneNotice(noticeNo);
			model.addAttribute("notice",notice);
			Attachment attach = service.selectOneAttach(noticeNo);
			if(attach != null) {
				String attachPath = attach.getContentsAttachPath() +"/"+ attach.getRenamedFilename();
				model.addAttribute("attachPath", attachPath);
				model.addAttribute("attach",attach);
			}
		} catch (Exception e) {
			throw e;
		}
	}
	
	@GetMapping("/noticeDelete.do")
	public String deleteNotice(@RequestParam int noticeNo, RedirectAttributes redirect) {
		try {	
			int attDel = service.deleteAttach(noticeNo);
			int result = service.delete(noticeNo);
			String msg = result > 0 ?"삭제 성공" : "삭제 실패";
			redirect.addFlashAttribute("msg", msg);
		} catch (Exception e) {
			throw e;
		}
		return "redirect:/community/noticeList.do";
	}
	
	@PostMapping("/noticeUpdate.do")
	public String updateNotice(@ModelAttribute Notice notice, 
			@RequestParam(required = false) MultipartFile upFile,
			RedirectAttributes redirect,
			HttpServletRequest request
			) throws IllegalStateException, IOException {
		try {
				
			if(!upFile.isEmpty()) {
				// 새로운 파일이 있다면 첨부파일 조회
				Attachment attach = service.selectOneAttach(notice.getNoticeNo());
				log.debug("attach = {}===========================", attach);
				log.debug("upFile = {}===========================", upFile);
				//경로 불러오기
				String saveDirectory =  request.getServletContext().getRealPath(Attachment.PATH_NOTICE);
				if(attach != null) {
					if(upFile.getSize() == 0 && upFile.isEmpty()) {
						String oldPath = request.getServletContext().getRealPath("/resources/upload/notice/" + attach.getOriginalFilename());
						File oldFile = new File(oldPath);
						
						// 기존 파일 삭제
						if(oldFile != null) oldFile.delete(); 
						service.deleteAttach(notice.getNoticeNo());
					} else {
						//파일 객체 생성
						String oldPath = request.getServletContext().getRealPath("/resources/upload/notice/" + attach.getOriginalFilename());
						File oldFile = new File(oldPath);
						
						File renameFile = HelloSpringUtils.getRenamedFile(saveDirectory, upFile.getOriginalFilename());
						// 기존 파일 삭제
						if(oldFile != null) oldFile.delete(); 
						//서버에서 기존 파일 삭제
						int deleteResult = service.deleteAttach(notice.getNoticeNo());	
						// 가져온 파일 업로드
						upFile.transferTo(renameFile); 
						//객체 생성
						attach = new Attachment(0,notice.getNoticeNo(),upFile.getOriginalFilename(),renameFile.getName(),Attachment.CODE_NOTICE,Attachment.PATH_NOTICE);
						log.debug("attach =============", attach);
						//새로운 파일을 서버에 저장
						int insertResult = service.insertAttachment(attach);					
					}
				} else {
					File renamedFile = HelloSpringUtils.getRenamedFile(saveDirectory, upFile.getOriginalFilename());
					//파일 저장
					upFile.transferTo(renamedFile);
					
					//Attachment객체생성
					Attachment attachnew = new Attachment(0,notice.getNoticeNo(),upFile.getOriginalFilename(),renamedFile.getName(),Attachment.CODE_NOTICE,Attachment.PATH_NOTICE);
					
					service.insertAttachment(attachnew);
				}
			}
				int result = service.update(notice);
				String msg = result > 0 ? "수정 성공":"수정 실패";
				redirect.addFlashAttribute("msg",msg);
			} catch (Exception e) {
				throw e;
			}
		return "redirect:/community/noticeDetail.do?noticeNo="+notice.getNoticeNo();
	}
}
	









