package com.kh.codelit.member.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.codelit.member.model.service.MemberService;
import com.kh.codelit.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
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

}
