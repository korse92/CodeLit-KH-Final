package com.kh.codelit.admin.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.kh.codelit.admin.model.service.AdminService;
import com.kh.codelit.member.model.vo.Member;
import com.kh.codelit.teacher.model.vo.Teacher;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin")
@Slf4j
public class adminController {
	
	@Autowired
	private AdminService adminService;
	
	
	/**
	 * 강의자 신청 리스트
	 */
	@GetMapping("/applyTeacherList.do")
	public void applyTeacherList() {}
	/*
	 * @GetMapping("/applyTeacherList.do") public void
	 * applyTeacherList(@RequestParam(defaultValue = "1") int cPage, Model model,
	 * HttpServletRequest request) {
	 * 
	 * //cPage: 현재페이지 값이 안넘어가도 기본값 1이 있어서 오류 발생안함
	 * 
	 * //1. 사용자 입력값 처리 int numPerPage = 5; //한페이지당 몇개
	 * 
	 * log.debug("cPage = {}", cPage);
	 * 
	 * Map<String, Object> param = new HashMap<>(); param.put("numPerPage",
	 * numPerPage); param.put("cPage", cPage);
	 * 
	 * //2. 업무로직 List<teacher> list = adminService.applyTeacherList(param);
	 * log.debug("list = {}" ,list );
	 * 
	 * //a. contents영역의 페이징처리 -> mybatis의 rowBounds이용 //b. pageBar 영역의 페이징처리 int
	 * totalContents = adminService.getTotalContents(); //전체 게시글 수
	 * log.debug("totalContents ={}", totalContents); String url =
	 * request.getRequestURI(); log.debug("url = {}",url); String pageBar =
	 * HelloSpringUtils.getPageBar(totalContents, cPage, numPerPage, url);
	 * 
	 * 
	 * //3. jsp처리 위임 model.addAttribute("list",list);
	 * model.addAttribute("pageBar",pageBar);
	 * 
	 * }
	 */
	
	
	@GetMapping("/manageMemberIndex.do")
	public void manageMemberIndex() {}
	
	@GetMapping("/manageMember.do")
	public ModelAndView manageMember(
				ModelAndView mav
			) {
		
		try {
			List<Member> list = adminService.selectMemberList();
			mav.addObject("memberList", list);
			mav.setViewName("/admin/manageMember");
		} catch(Exception e) {
			mav.addObject("msg", "호출에 문제가 있습니다.");
			mav.setViewName("/");
		}
		
		return mav;
	}
	
	
	@PostMapping("/deleteMember.do")
	public String deleteMember(
				@RequestParam String memberId,
				HttpServletRequest request
			) {
			
		log.debug("deleteMember = {}", memberId);
		String msg = null;
		
		try {
			int result = adminService.deleteMember(memberId);
			msg = "id : " + memberId + " - 탈퇴처리에 성공하였습니다.";
			
		} catch(Exception e) {
			msg = "id : " + memberId + " - 탈퇴처리에 실패하였습니다.";
			throw e;
		}
		
		FlashMap flashMap = RequestContextUtils.getOutputFlashMap(request);
		flashMap.put("msg", msg);
		
		return "redirect:/admin/manageMember.do";
	}
	
	@GetMapping("/manageTeacher.do")
	public ModelAndView manageTeacher(
				ModelAndView mav
			
			) {
		
		try {
			List<Teacher> list = adminService.selectTeacherList();
			mav.addObject("teacherList", list);
			mav.setViewName("/admin/manageTeacher");
		} catch (Exception e) {
			
			throw e;
		}
		
		return mav;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	@GetMapping("/applyLectureList.do")
	public void applyLectureList() {
		
	}
	@GetMapping("/manageLectureBoard.do")
	public void manageLectureBoard() {
		
	}
	@GetMapping("/rejectTeacherRight.do")
	public void rejectTeacherRight() {
		
	}
	@PostMapping("/rejectTeacherRight.do")
	public void rejectTeacherRight_() {
		log.debug("강사 권한 해지 {}", "도착");
	}
	
	


}
