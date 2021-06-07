package com.kh.codelit.member.controller;


import java.io.File;
import java.io.IOException;
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
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.codelit.common.HelloSpringUtils;
import com.kh.codelit.lecture.model.service.LectureService;
import com.kh.codelit.lecture.model.vo.Lecture;
import com.kh.codelit.lecture.model.vo.LectureDate;
import com.kh.codelit.lecture.model.vo.StreamingDate;
import com.kh.codelit.member.model.service.MemberService;
import com.kh.codelit.member.model.vo.Member;
import com.kh.codelit.order.model.service.BasketService;
import com.kh.codelit.order.model.service.PickService;
import com.kh.codelit.order.model.vo.Basket;
import com.kh.codelit.order.model.vo.Pick;
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

	@Autowired
	private PickService pickService;

	@Autowired
	private BasketService basketService;

	@GetMapping("/memberEnroll.do")
	public void memberEnroll() {
		log.debug("회원가입 = {}", "회원가입");
	}

	@PostMapping("/memberEnroll.do")
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

//	@GetMapping("/memberDetail.do")
//	public void memberDetail(Model model ,Principal pri){
//
//		String memberId = pri.getName();
//
//		model.addAttribute("id",memberId);
//		Member member = memberService.selectDetail(memberId);
//		 model.addAttribute("member", member);
//		 log.debug("member = {}", member);
//
//	}
	@GetMapping("/memberDetail.do")
	  public void detail(Model model, Principal pri  ) {


		  String MemberId = pri.getName();
		  model.addAttribute("refMemberId", MemberId);

		  Member member = memberService.selectOneMember(MemberId);
		  model.addAttribute("member", member);
		  log.debug("member = {}", member);

		  }


	@PostMapping("/memberUpdate.do")
	public String membetUpdate(
						@ModelAttribute Member member,
						RedirectAttributes redirectAttr,
						@RequestParam(value = "upFile", required = false) MultipartFile upFile,
						HttpServletRequest request, Authentication oldAuthentication) {

		int result = 0;
		log.info("member = {}", member);

		try {
			String saveDirectory = request.getServletContext().getRealPath("/resources/upload/member");
			// File은 오로지 파일만 가리키는 것이 아니라, 존재하지 않는 것도 가리킬 수 있음. (생성용)
			File dir = new File(saveDirectory);
			if (!dir.exists()) {
				dir.mkdirs(); // 복수개 폴더 생성 가능 (경로상에 없는거 다 만들어줌)
			}

			String rawPassword = member.getPassword();
			String encodedPassword = bcryptPasswordEncoder.encode(rawPassword);
			log.info("rawPassword = {}", rawPassword);
			log.info("encodedPassword = {}", encodedPassword);
			member.setMemberPw(encodedPassword);

			if(!upFile.isEmpty()) {

				// 디비를 가져와야 기존 파일 삭제가 필요한지 알 수 있다.
				member = memberService.selectOneMember(member.getMemberId());
				String oldFilePath = request.getServletContext()
						.getRealPath("/resources/upload/member/" + member.getMemberReProfile());

				File oldFile = new File(oldFilePath);//암호화 처리

				File renamedFile = HelloSpringUtils.getRenamedFile(saveDirectory, upFile.getOriginalFilename());

				log.debug("upFile = {}", upFile);
				log.debug("renamedFile = {}", renamedFile);


				// 티처 정보 및 파일네임을 담은 메소드
				if (oldFile != null)
					oldFile.delete(); // 기존 파일 삭제
				upFile.transferTo(renamedFile); // 업로드한 파일데이터를 지정한 파일에 저장한다.

				// authentication에 담긴 멤버 정보 변경
				member.setMemberProfile(upFile.getOriginalFilename());
				member.setMemberReProfile(renamedFile.getName());

				log.debug("변경된 프로필 확인 = {}", ((Member) oldAuthentication.getPrincipal()).getMemberProfile());
			}

			result = memberService.updateMember(member);
			String msg =  result > 0 ? "수정  성공!" : "수정 실패!";

			if(result > 0) {
				Authentication newAuthentication =
						new UsernamePasswordAuthenticationToken(
									member,
									oldAuthentication.getCredentials(),
									oldAuthentication.getAuthorities()
								);
				SecurityContextHolder.getContext().setAuthentication(newAuthentication);
			}

			//2. 사용자 피드백 준비 및 리다이렉트
			redirectAttr.addFlashAttribute("msg", msg);

			} catch (IOException | IllegalStateException e) {
				log.error("강사 수정 첨부파일 오류", e);
				throw new RuntimeException("강사수정 첨부파일 저장 오류");
			} catch (Exception e) {
				log.error(e.getMessage(), e);
				throw e;
			}

		return "redirect:/member/memberDetail.do";
	}

	@PostMapping("/deleteMember.do")
	public String deleteMember(
			@RequestParam String memberId ,
			RedirectAttributes redirectAttr,

			SecurityContextHolderAwareRequestWrapper requestWrapper) {

		/*
		 * List<SimpleGrantedAuthority> authorities = (List<SimpleGrantedAuthority>)
		 * authentication.getAuthorities();
		 * log.debug("requestWrapper.isUserInRole(\"ADMIN\") = {}",
		 * requestWrapper.isUserInRole("ADMIN"));
		 * log.debug("authorities.contains(\"ROLE_ADMIN\") = {}",
		 * authorities.contains(new SimpleGrantedAuthority("ROLE_ADMIN")));//권한
		 * 체크(equals, hashCode 오버라이딩되서 가능) log.debug("authentication = {}",
		 * authorities);
		 */


		log.debug("deleteMember = {}", memberId);
		if(requestWrapper.isUserInRole("TEACHER")) {
			redirectAttr.addFlashAttribute("msg","회원정보를 삭제할수 없습니다");
			} else if(!requestWrapper.isUserInRole("TEACHER")) {
			//현준님이 만든 회원탈퇴 비지니스 로직
				int result = memberService.deleteMember(memberId);
				redirectAttr.addFlashAttribute("msg","성공적으로 회원정보를 삭제했습니다");
				SecurityContextHolder.clearContext();
			}



			return "redirect:/";
	}



    @GetMapping("/myProfile.do")
    public ModelAndView myProfile(SecurityContextHolderAwareRequestWrapper requestWrapper,
		  							ModelAndView mav,
		  							Authentication authentication, Principal principal) {

	  try {
		  UserDetails userDetails = (UserDetails) authentication.getPrincipal();
		  String memberId =  ((Member) userDetails).getMemberId();
		  String refMemberId = principal.getName();

		  Member member = memberService.selectOneMember(memberId);
		  List<Lecture> lectureList = memberService.getLectureList(memberId);
		  List<Messenger> msgList = msgService.alarmListMyprofile(memberId);
		  List<Pick> pickList = pickService.selectPickList(memberId);
		  List<Basket> basketList = basketService.selectBasketList(memberId);
		  List<StreamingDate> streamingDateList = memberService.selectStreamingDateList(refMemberId);
		  List<LectureDate> lectureDateList = memberService.selectLectureDateList(refMemberId);

		  mav.addObject("member",member);
		  mav.addObject("basketList", basketList);
		  mav.addObject("message", msgList);
		  mav.addObject("pickList", pickList);
		  mav.addObject("lectureList",lectureList);
		  mav.addObject("streamingDateList", streamingDateList);
		  mav.addObject("lectureDateList", lectureDateList);

		  mav.setViewName("/member/myProfile");

	  }catch(Exception e) {
		  throw e;
	  }

	  return mav;

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
		Map<String, Object> param = new HashMap<>();
		param.put("numPerPage", numPerPage);
		param.put("catNo", catNo);
		param.put("cPage", cPage);
		param.put("memberId", memberId);

		//2. 업무로직
		//a. contents영역
		List<Map<String, String>> list = memberService.selectLectureList(param);

		//b. pageBar영역
		int totalContents = memberService.getTotalContents(memberId);


		String url = HelloSpringUtils.convertToParamUrl(request);
		String pageBar = HelloSpringUtils.getPageBar(totalContents, cPage, numPerPage, url);

		//3.jsp 위임처리
		model.addAttribute("list", list);
		model.addAttribute("pageBar", pageBar);

		return "/member/memberLectureList";
	}

    @GetMapping("/myCalendar.do")
    public void myCalendar(Model model, HttpServletRequest request) {
    	log.debug("calendar = {}", "calendar");

//    	Gson gson = new Gson();

//    	model.addAttribute("streamingDateList", streamingDateList);

//    	String streamingDates = gson.toJson(streamingDateList);
//    	model.addAttribute("streamingDates", streamingDates);
//    	log.debug("streamingDates = {}", streamingDates);
    }

    @GetMapping("/myStreamingCal.do")
    @ResponseBody
    public List<StreamingDate> myStreamingCal(HttpServletRequest request, Principal principal) {

    	String refMemberId = principal.getName();
    	log.debug("refMemberId = {}", refMemberId);

    	List<StreamingDate> streamingDateList = memberService.selectStreamingDateList(refMemberId);
    	log.debug("streamingDateList = {}", streamingDateList);

    	return streamingDateList;
    }

    @GetMapping("/myLectureCal.do")
    @ResponseBody
    public List<LectureDate> myLectureCal(HttpServletRequest request, Principal principal) {

    	String refMemberId = principal.getName();
    	log.debug("refMemberId", refMemberId);

    	List<LectureDate> lectureDateList = memberService.selectLectureDateList(refMemberId);
    	log.debug("lectureDateList = {}", lectureDateList);

    	int count = memberService.countMyLecture(refMemberId);
    	log.debug("count = {}", count);

    	return lectureDateList;
    }
}