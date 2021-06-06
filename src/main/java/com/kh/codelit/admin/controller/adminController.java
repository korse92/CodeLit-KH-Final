package com.kh.codelit.admin.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.kh.codelit.admin.model.service.AdminService;
import com.kh.codelit.common.HelloSpringUtils;
import com.kh.codelit.lecture.model.service.LectureService;
import com.kh.codelit.lecture.model.vo.Lecture;
import com.kh.codelit.member.model.vo.Member;
import com.kh.codelit.order.model.vo.Payment;
import com.kh.codelit.teacher.model.vo.Teacher;

import lombok.extern.slf4j.Slf4j;



@Controller
@RequestMapping("/admin")
@Slf4j
public class adminController {

	@Autowired
	private AdminService adminService;

	@Autowired
	private LectureService lectureService;

	@GetMapping("/manageMemberIndex.do")
	public void manageMemberIndex() {
	}
	@GetMapping("/manageOrder.do")
	public ModelAndView manageOrder(
				@RequestParam(defaultValue = "1", value="cPage") int cPage,
				Principal principal,
				HttpServletRequest request,
				ModelAndView mav
				){

		String memberId = principal.getName();
		int numPerPage = 10;
		Map<String, Object> param = new HashMap<>();
		param.put("cPage", cPage);
		param.put("numPerPage", numPerPage);
		param.put("memberId",memberId);


		try {
			int totalContents = adminService.selectMemberOrderCount(param);
			List<Payment> list = adminService.selectMemberOrderList(param);
			
			String url = HelloSpringUtils.convertToParamUrl(request);
			String pageBar = HelloSpringUtils.getPageBar(totalContents, cPage, numPerPage, url);

			mav.addObject("manageOrderList", list);
			mav.addObject("pageBar", pageBar);
			mav.setViewName("/admin/manageOrder");
		} catch(Exception e) {
			throw e;
		}

		return mav;
	}

	@GetMapping("/manageMember.do")
	public ModelAndView manageMember(
				@RequestParam(defaultValue = "1") int cPage,
				@RequestParam(required = false) String keyword,
				ModelAndView mav,
				HttpServletRequest request
			) {

		int numPerPage = 10;
		Map<String, Object> param = new HashMap<>();
		param.put("cPage", cPage);
		param.put("numPerPage", numPerPage);
		param.put("keyword", keyword);

		try {

			int totalContents = adminService.selecMemberCount(param);
			List<Member> list = adminService.selectMemberList(param);
			log.debug("manageMember = {}", list);

			String url = HelloSpringUtils.convertToParamUrl(request);
			String pageBar = HelloSpringUtils.getPageBar(totalContents, cPage, numPerPage, url);

			mav.addObject("memberList", list);
			mav.addObject("pageBar", pageBar);
			mav.setViewName("/admin/manageMember");

		} catch(Exception e) {
			throw e;

//			FlashMap flashMap = RequestContextUtils.getOutputFlashMap(request);
//			flashMap.put("msg", "회원관리 페이지 호출에 문제가 있습니다.");
//
//			mav.setViewName("redirect:/");
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
				ModelAndView mav,
				@RequestParam(defaultValue = "1") int cPage,
				@RequestParam(required = false) String keyword,
				@RequestParam(required = false) String category,
				HttpServletRequest request
			) {

		int numPerPage = 10;

		Map<String, Object> param = new HashMap<>();
		param.put("numPerPage", numPerPage);
		param.put("cPage", cPage);
		param.put("keyword", keyword);
		if("주 강의분야".equals(category) || category == null) {
			param.put("category", null);
		} else {
			param.put("category", Integer.parseInt(category));
		}

		try {
			int totalContents = adminService.selectTeacherCount(param);
			List<Teacher> list = adminService.selectTeacherList(param);

			String url = HelloSpringUtils.convertToParamUrl(request);
			String pageBar = HelloSpringUtils.getPageBar(totalContents, cPage, numPerPage, url);

			mav.addObject("teacherList", list);
			mav.addObject("pageBar", pageBar);
			mav.setViewName("/admin/manageTeacher");
		} catch (Exception e) {

			throw e;
		}

		return mav;
	}

	@PostMapping("/deleteTeacherAndAuth.do")
	public String deleteTeacherAndAuth(
				@RequestParam String refMemberId,
				RedirectAttributes redirectAttr
			) {

		log.debug("deleteTeacherAndAuth : refMemberId = ", refMemberId);

		String msg = null;
		try {

			int result = adminService.deleteTeacherAndAuth(refMemberId);
			msg = result > 0 ? "삭제에 성공했습니다." : "삭제에 실패했습니다.";


		} catch(Exception e) {
			throw e;
		}

		redirectAttr.addFlashAttribute("msg", msg);

		return "redirect:/admin/manageTeacher.do";
	}


	//강의 신청 목록
	@GetMapping("/applyLectureList.do")
	public ModelAndView applyLectureList(ModelAndView mav) {

		try {
			List<Map<String, Object>> list = adminService.applyLectureList();
			log.debug("list={}", list);

			mav.addObject("list", list);
			mav.setViewName("/admin/applyLectureList");

		} catch (Exception e) {
			// 1 로깅 작업
			log.error(e.getMessage(), e);
			// 2 다시 spring container에 던져줄것
			throw e;
		}
		return mav;
	}

	// 모달에서 강의 승인
	@GetMapping("/approveLecture.do")
	public void approveLecture(@RequestParam int no, Model model) {
		//log.debug("getapproveLecture no = {}", no); 잘나옴
		//지헌 알림관련 추가 코드
		Map<String, Object> param = new HashMap<>();
		param.put("no", no);
		Lecture lec = lectureService.selectOneLecture(param);
		model.addAttribute("lec", lec);

		model.addAttribute("no", no);

	}

	// 모달에서 보낸 강의승인폼
	@PostMapping("/approveLecture.do")
	public String approveLecture_(@RequestParam int no, RedirectAttributes redirectAttr) {
		log.debug("approveLecture no = {}", no);  //안나옴
		String msg = null;
		try {
			int result = adminService.approveLecture(no);
			msg = "강의 승인에 성공하였습니다";

		} catch (Exception e) {
			msg = "강의 승인에 실패하였습니다";
			throw e;
		}
		redirectAttr.addFlashAttribute("msg", msg);

		return "redirect:/admin/applyLectureList.do";

	}

	/**
	 * 강사 신청목록페이지 섹션
	 */

	// 강사신청 목록 출력
	@GetMapping("/applyTeacherList.do")
	public ModelAndView applyTeacherList(ModelAndView mav) {
		try {
			List<Map<String, Object>> list = adminService.applyTeacherList();
			log.debug("applyTeacher list ={}", list);

			mav.addObject("list", list);
			mav.setViewName("/admin/applyTeacherList");

		} catch (Exception e) {
			// 1 로깅 작업
			log.error(e.getMessage(), e);
			// 2 다시 spring container에 던져줄것
			throw e;
		}
		return mav;
	}

	@GetMapping("/approveTeacher.do")
	public void approveTeacher(@RequestParam String id, Model model) {
		model.addAttribute("id", id);

	}

	// 모달에서 보낸 강사 승인폼
	@PostMapping("/approveTeacher.do")
	public String approveTeacher_(@RequestParam String id, RedirectAttributes redirectAttr) {

		String msg = null;
		try {
			int result = adminService.approveTeacher(id);
			msg = "승인에 성공하였습니다";

		} catch (Exception e) {
			msg = "승인에 실패하였습니다";
			throw e;
		}
		redirectAttr.addFlashAttribute("msg", msg);

		return "redirect:/admin/applyTeacherList.do";

	}

	// 강사 승인 취소 -> 삭제처리
	@PostMapping("/deleteTeacher.do")
	public String deleteTeacher(@RequestParam String id, RedirectAttributes redirectAttr) {
		String msg = null;
		log.debug("id = {}", id);

		try {

			int result = adminService.deleteTeacher(id);
			msg = "강사 신청 거절에 성공하였습니다.";
			log.debug("result={}", result);
		} catch (Exception e) {
			msg = "강사 신청 거절에 실패하였습니다";
			throw e;
		}
		redirectAttr.addFlashAttribute("msg", msg); // session에 담았다가 다음 redirect떄 불러오는것 | addAttribute : redirect시 경로를
													// /spring?msg=수정성공 이런식으로 넘어감
		return "redirect:/admin/applyTeacherList.do";
	}

	// 강의 신청 목록에서 삭제처리
	@PostMapping("/deleteLecture")
	public String deleteLecture(@RequestParam int no, RedirectAttributes redirectAttr) {
		String msg = null;
		try {

			int result = adminService.deleteLecture(no);
			msg = "강의 신청 거절에 성공하였습니다.";

		} catch (Exception e) {
			msg = "강사 신청 거절에 실패하였습니다";
			throw e;
		}

		redirectAttr.addFlashAttribute("msg", msg);
		return "redirect:/admin/applyLectureList.do";
	}

	@GetMapping("/manageLectureBoard.do")
	public ModelAndView manageLectureBoard(
								@RequestParam(defaultValue = "1") int cPage,
								ModelAndView mav,
								@RequestParam(required = false) String searchKeyword,
								@RequestParam(required = false) String category,
								@RequestParam(required = false) String searchType,
								HttpServletRequest request) {

		log.debug("searchKeyword = {} ", searchKeyword);
		log.debug("category = {}", category);
		log.debug("searchType = {}", searchType);

		// 1 .사용자 입력값
		int numPerPage = 10;

		Map<String, Object> param = new HashMap<>();
		param.put("numPerPage", numPerPage);
		param.put("cPage", cPage);
		param.put("searchKeyword", searchKeyword);
		param.put("searchType", searchType);
		// log.debug(" manageLectureBoard - param = {}", param);

		if("카테고리".equals(category) || category == null) {
			param.put("category", null);
		} else {
			param.put("category", Integer.parseInt(category));
		}

		try {

			// 2. 업무로직
			// a. contents 영역 -> mybatis의 rowBounds 사용
			List<Map<String, Object>> list = adminService.selectAllLecture(param);
			//log.debug("manageLectureBoard - list = {}", list);

			// b. pageBar 영역
			int totalContents = adminService.getTotalContents(param);
			// log.debug("totalContents = {}", totalContents);
			String paramUrl = HelloSpringUtils.convertToParamUrl(request);
//			if(category != null || searchKeyword != null || searchType != null)
//				url += "?category=" + category + "&searchKeyword=" + searchKeyword + "&searchType=" + searchType;

			log.debug("paramUrl = {}", paramUrl);

			String pageBar = HelloSpringUtils.getPageBar(totalContents, cPage, numPerPage, paramUrl);
			log.debug("pageBar = {}", pageBar);
			// 3. jsp처리 위임 model.addAttribute("list",list);
			mav.addObject("lecBoardList", list);
			mav.addObject("pageBar", pageBar);
			mav.setViewName("/admin/manageLectureBoard");

	} catch (Exception e) {
		throw e;
	}
		return mav;
  }

	@GetMapping("/rejectPlayingLecture.do")
	public void rejectPlayingLecture(@RequestParam int no, Model model) {
		//log.debug("getapproveLecture no = {}", no);
		Map<String, Object> param = new HashMap<>();
		param.put("no", no);
		Lecture lec = lectureService.selectOneLecture(param);
		model.addAttribute("lec", lec);

		model.addAttribute("no", no);
	}

	@PostMapping("/rejectPlayingLecture.do")
	public String rejectPlayingLecture_(@RequestParam int no, RedirectAttributes redirectAttr) {

		String msg = null;
		try {
			int result = adminService.rejectPlayingLecture(no);
			msg = "강의 정지에 성공하였습니다";

		} catch (Exception e) {
			msg = "강의 정지에 실패하였습니다";
			throw e;
		}
		redirectAttr.addFlashAttribute("msg", msg);

		return "redirect:/admin/manageLectureBoard.do";


	}

	@GetMapping("/data.do")
	public void data(
				Model model
			) {
		
		try {
			// 클릭 상위 강의
			List<Map<String, Object>> clickList = adminService.selectClickRank();
			List<Map<String, Object>> categorySales = adminService.selectCategorySales();
			List<Map<String, Object>> categorySalesSummary = adminService.selectCategorySalesSummary();
			
			model.addAttribute("clickList", clickList);
			model.addAttribute("categorySales", categorySales);
			model.addAttribute("categorySalesSummary", categorySalesSummary);
			
		} catch(Exception e) {
			throw e;
		}
	}
	
	@ResponseBody
	@GetMapping("/userClick.do")
	public List<Map<String, Object>> userClick(
				@RequestParam String userName
			) {
		
		List<Map<String, Object>> userClickList = null;
		
		try {
			userClickList = adminService.selectUserClick(userName);

		} catch(Exception e) {
			throw e;
		}
		
		return userClickList;
	}

	/*
	 * @GetMapping("/searchCategory.do/{type}")
	 *
	 * @ResponseBody public List<Map<String, Object>> searchCategory(@PathVariable
	 * int type) { log.debug("type = {}", type);
	 *
	 * List<Map<String, Object>> list = adminService.searchCategory(type); //new
	 * ArrayList<Map<String,Object>>(); //Map<String, Object> map = new HashMap<>();
	 * log.debug("list", list);
	 *
	 * return list; }
	 */

}
