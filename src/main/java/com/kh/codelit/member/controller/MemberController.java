package com.kh.codelit.member.controller;


import java.security.Principal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.servletapi.SecurityContextHolderAwareRequestWrapper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.codelit.common.HelloSpringUtils;
import com.kh.codelit.lecture.model.service.LectureService;
import com.kh.codelit.lecture.model.vo.Lecture;
import com.kh.codelit.member.model.service.MemberService;
import com.kh.codelit.member.model.vo.Member;
import com.kh.codelit.websocket.model.service.MessengerService;
import com.kh.codelit.websocket.model.vo.Messenger;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	private MemberService memberService;

	@Autowired
	private LectureService lectureService;

	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;

	@Autowired
	private MessengerService msgService;
	
	@GetMapping("/memberEnroll.do")
	public void memberEnroll() {
		log.debug("회원가입 = {}", "회원가입");
	}

	@PostMapping("/memberEnroll.do")
//	@RequestMapping(value = "/memberEnroll.do", method = RequestMethod.POST)
	public String memberEnroll(
						@ModelAttribute Member member,
						RedirectAttributes redirectAttr
					) {
		log.info("member = {}", member);

		try {
			//암호화 처리
			String rawPassword = member.getPassword();
			String encodedPassword = bcryptPasswordEncoder.encode(rawPassword);
			log.info("rawPassword = {}", rawPassword);
			log.info("encodedPassword = {}", encodedPassword);
			member.setMemberPw(encodedPassword);

			//1. 업무로직
			int result = memberService.insertMember(member);
			String msg =  result > 0 ? "회원 등록 성공!" : "회원 등록 실패!";
			//2. 사용자 피드백 준비 및 리다이렉트
			redirectAttr.addFlashAttribute("msg", msg);
		} catch(Exception e) {
			log.error(e.getMessage(), e);
			throw e;
		}
		return "redirect:/";
	}

	//아이디 중복 확인
	@GetMapping("/chkIdDupl.do")
	public ResponseEntity<?> chkIdDupl(@RequestParam("id") String memberId) {
		//1.업무로직
		Member member = memberService.selectOneMember(memberId);
		boolean usable = (member == null);

		//2. json 변환 객체
		Map<String, Object> map = new HashMap<>();
		map.put("usable", usable);
		map.put("id", memberId);
		map.put("serverTime", new Date());

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON_UTF8);
		return new ResponseEntity<>(map, headers, HttpStatus.OK);
	}

	/* 구글 로그인 */
	@ResponseBody
	@GetMapping("/insertMemberByGoogle.do")
	public String insertMemberByGoogle(Member member, HttpSession session, RedirectAttributes redirectAttr, Member gmember) {
		//구글 로그인
//		member = memberService.loginByGoogle(member);
		String member_ajaxName = gmember.getMemberId();
		log.info("gmemberController = {}", gmember);
		log.info("memberController = {}", member);
		log.info("member_ajaxId = {}", member_ajaxName);

		try {
			//구글 회원가입
			int result = memberService.insertMemberByGoogle(member);
			String msg =  result > 0 ? "회원가입 되었습니다." : "회원가입에 실패하였습니다.";
			//2. 사용자 피드백 준비 및 리다이렉트
			redirectAttr.addFlashAttribute("msg", msg);
			log.debug("msg = {}", msg);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			throw e;
		}

			//구글 로그인
//			member = memberService.loginByGoogle(member);
//			session.setAttribute("memberId", member.getMemberId());
//			redirectAttr.addFlashAttribute("gmember", member);


//		if(member_ajaxId.equals(member.getMemberId())) { //DB에 아이디가 존재할 경우
//			//구글 로그인
//			memberService.loginByGoogle(member);
//			session.setAttribute("memberId", member.getMemberId());
//			redirectAttr.addFlashAttribute("gmember", member);
//		} else { //DB에 아이디가 존재하지 않을 경우
//			//구글 회원가입
//			memberService.insertMemberByGoogle(member);
//
//			//구글 로그인
//			member = memberService.loginByGoogle(member);
//			session.setAttribute("memberId", member.getMemberId());
//			redirectAttr.addFlashAttribute("gmember", member);
//
//		}

		return "redirect:/";
	}

	@GetMapping("/memberLogin.do")
	public void memberLogin() {}

	@PostMapping("/memberLogin.do")
	public void memberLogin_() {
		log.debug("로그인 포스트 {}", "도착");
	}

    @GetMapping("/myProfile.do")
    public ModelAndView myProfile(SecurityContextHolderAwareRequestWrapper requestWrapper,
		  							ModelAndView mav,
		  							Authentication authentication) {

	  log.debug("requestWrapper.isUserInRole('TEACHER') = {}", requestWrapper.isUserInRole("TEACHER"));


	  try {
		  UserDetails userDetails = (UserDetails) authentication.getPrincipal();
		  log.debug("userDetails = {}", userDetails);
		  // userDetails = Member(memberId=teacher, memberPw=$2a$10$X8GL750RHq/TpQh9hVPnd.Krj13dW5QlKAvUIbIIVI.dPVzPYUmd2,
		  //                       memberProfile=null, memberReProfile=null, authorities=[ROLE_TEACHER, ROLE_USER])
		  String memberId =  ((Member) userDetails).getMemberId();
		  log.debug("memberId = {}", memberId); //memberId = teacher

			//lecture.setRefMemberId(((Member)authentication.getPrincipal()).getMemberId());
			//log.debug("myProfileMethod@lecture = {}", lecture);
		  List<Lecture> list = lectureService.selectMyLecture(memberId);
		  log.debug("list = {}", list);
	     // list = [Lecture(lectureNo=0, refLecCatNo=0, refMemberId=null, lectureName=테스트1,
		  
		  List<Messenger> message = msgService.alarmList(memberId);

		  mav.addObject("message",message);
		  mav.addObject("list",list);
		  mav.setViewName("/member/myProfile");

	  }catch(Exception e) {
		  throw e;
	  }

	  return mav;

	  }


    @GetMapping("/streamingCalendar")
    public void streamingCalendar() {
    	log.debug("calendar = {}", "calendar");
    }

    
    @GetMapping("/memberLectureList.do")
    public String MemberLectureList(
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
		String pageBar = HelloSpringUtils.getPageBar(totalContents, cPage, numPerPage, url);

		//3.jsp 위임처리
		model.addAttribute("list", list);
		model.addAttribute("pageBar", pageBar);

		return "/member/memberLectureList";
	}
}