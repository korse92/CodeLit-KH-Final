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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.codelit.attachment.model.vo.Attachment;
import com.kh.codelit.common.HelloSpringUtils;
import com.kh.codelit.community.study.model.service.CommentService;
import com.kh.codelit.community.study.model.service.StudyService;
import com.kh.codelit.community.study.model.vo.Comment;
import com.kh.codelit.community.study.model.vo.StudyBoard;
import com.kh.codelit.lecture.model.vo.Lecture;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/community")
@Slf4j
public class StudyBoardController {
	
	@Autowired
	private StudyService service;
	@Autowired
	private CommentService cmtService;
	
	@GetMapping("/studyList.do")
	public ModelAndView selectBoard(
			@RequestParam(defaultValue = "1") int cPage, 
			ModelAndView mav,
			@RequestParam(required = false) String searchType,
			@RequestParam(required = false) String searchKeyword,
			HttpServletRequest request) {
		try {
			int numPerPage = 10;
			//클릭한 페이지, 총게시글 수전달
			Map<String, Object> param = new HashMap<>();
			param.put("numPerPage", numPerPage);
			param.put("cPage", cPage);
			param.put("searchKeyword", searchKeyword);
			param.put("searchType", searchType);
			
			List<Map<String, Object>> list = service.studyBoardList(param);
			
			int count = service.getListCount();
			String uri = request.getRequestURI();
			if(searchKeyword != null || searchType != null)
				uri +="&searchKeyword=" + searchKeyword + "&searchType=" + searchType;
			Map<String, String[]> paramMap = request.getParameterMap();
			for(String key : paramMap.keySet()) {
				log.debug("key = {}", key);
				String[] valArr = paramMap.get(key);
				log.debug("valArr = {}", valArr);
			}
			
			String pageBar = HelloSpringUtils.getPageBar(count, cPage, numPerPage, uri);
			mav.addObject("list", list);
			mav.addObject("pageBar", pageBar);
			mav.setViewName("/community/studyList");
		} catch (Exception e) {
			throw e;
		}
		return mav;
	}
	
	@GetMapping(value = {"/studyDetail.do", "/studyUpdate.do"})
	public void selectOneNotice(@RequestParam int stdBrdNo, Model model) {
		try {
			int result = service.updateCnt(stdBrdNo);
			StudyBoard stdBrd = service.selectOneStudy(stdBrdNo);
			Attachment attach = service.selectOneAttach(stdBrdNo);
			List<Lecture> lec = service.selectLec();
			List<Comment> listCmt = service.selectCmt(stdBrdNo);
			
			log.debug("stdBrd ===========###===== {}", stdBrd);
			
			model.addAttribute("stdBrd",stdBrd);
			model.addAttribute("list",lec);
			if(listCmt != null) {
				model.addAttribute("listCmt", listCmt);
			}
			
			if(attach != null) {
				String attachPath = attach.getContentsAttachPath() +"/"+ attach.getRenamedFilename();
				model.addAttribute("attachPath", attachPath);
				model.addAttribute("attach",attach);
			}
		} catch (Exception e) {
			throw e;
		}
	}
	
	@GetMapping("/studyWrite.do")
	public void BoardWrite(Model model) {
		try {
			List<Lecture> list = service.selectLec();
			model.addAttribute("list",list);
		} catch (Exception e) {
			throw e;
		}
	}
	
	@PostMapping("/studyInsert.do")
	public String studyInsert(
				@ModelAttribute StudyBoard studyBoard,
				@RequestParam(required = false) MultipartFile upFile,
				@RequestParam(value = "selectBox") int lecNo,
				HttpServletRequest request,
				RedirectAttributes redirect,
				Principal pri) throws Exception {
		try {
			String saveDirectory =  request.getServletContext().getRealPath(Attachment.PATH_STUDYBOARD);
			
			File dir = new File(saveDirectory);
			if(!dir.exists())
				dir.mkdir();
			
			studyBoard.setRefMemberId(pri.getName());
			studyBoard.setRefLectureNo(lecNo);
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
		}catch (Exception e) {
			throw e;
		}
		return "redirect:/community/studyList.do";
	}
	
	@PostMapping("/studyUpdate.do")
	public String BoardUpdate(
				@ModelAttribute StudyBoard stdBrd,
				@RequestParam(required = false) MultipartFile upFile,
				@RequestParam(value = "selectBox") int lecNo,
				RedirectAttributes redirect,
				HttpServletRequest request,
				Principal pri) {
		try {
			if(!upFile.isEmpty()) {
				// 새로운 파일이 있다면 첨부파일 조회
				Attachment attach = service.selectOneAttach(stdBrd.getStdBrdNo());
				//경로 불러오기
				String saveDirectory =  request.getServletContext().getRealPath(Attachment.PATH_STUDYBOARD);
				if(attach != null) {
					if(upFile.getSize() == 0 && upFile.isEmpty()) {
						String oldPath = request.getServletContext().getRealPath("/resources/upload/notice/" + attach.getOriginalFilename());
						File oldFile = new File(oldPath);
						
						// 기존 파일 삭제
						if(oldFile != null) oldFile.delete(); 
						service.deleteAttach(stdBrd.getStdBrdNo());
					} else {
						//파일 객체 생성
						String oldPath = request.getServletContext().getRealPath("/resources/upload/notice/" + attach.getOriginalFilename());
						File oldFile = new File(oldPath);
						
						File renameFile = HelloSpringUtils.getRenamedFile(saveDirectory, upFile.getOriginalFilename());
						// 기존 파일 삭제
						if(oldFile != null) oldFile.delete(); 
						//서버에서 기존 파일 삭제
						int deleteResult = service.deleteAttach(stdBrd.getStdBrdNo());	
						// 가져온 파일 업로드
						upFile.transferTo(renameFile); 
						//객체 생성
						attach = new Attachment(0,stdBrd.getStdBrdNo(),upFile.getOriginalFilename(),renameFile.getName(),Attachment.CODE_STUDY_BOARD,Attachment.PATH_STUDYBOARD);
						//새로운 파일을 서버에 저장
						int insertResult = service.insertAttachment(attach);					
					}
				} else {
					File renamedFile = HelloSpringUtils.getRenamedFile(saveDirectory, upFile.getOriginalFilename());
					//파일 저장
					upFile.transferTo(renamedFile);
					
					//Attachment객체생성
					Attachment attachnew = new Attachment(0,stdBrd.getStdBrdNo(),upFile.getOriginalFilename(),renamedFile.getName(),Attachment.CODE_STUDY_BOARD,Attachment.PATH_STUDYBOARD);
					
					service.insertAttachment(attachnew);
				}
			}
			
			stdBrd.setRefLectureNo(lecNo);
			stdBrd.setRefMemberId(pri.getName());
			Lecture lec = service.selectOneLec(lecNo);
			stdBrd.setLectureName(lec.getLectureName());
			
			log.debug("stdBrd ============{}", stdBrd);
			int result = service.update(stdBrd);
			String msg = result > 0 ? "수정 성공":"수정 실패";
			redirect.addFlashAttribute("msg",msg);
		} catch (Exception e) {

		}
		return "redirect:/community/studyDetail.do?stdBrdNo="+stdBrd.getStdBrdNo();
	}
	
	@PostMapping("/studyDelete.do")
	public String BoardDelete(@RequestParam int stdBrdNo, RedirectAttributes redirect) {
		try {
			service.deleteAttach(stdBrdNo);
			service.deleteStdCmt(stdBrdNo);
			int result = service.delete(stdBrdNo);
			
			String msg = result > 0 ?"삭제 성공" : "삭제 실패";
			redirect.addFlashAttribute("msg", msg);
		}catch (Exception e) {
			throw e;
		}
		return "redirect:/community/studyList.do";
	}
	
}	
