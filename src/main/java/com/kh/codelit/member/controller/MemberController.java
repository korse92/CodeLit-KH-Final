package com.kh.codelit.member.controller;

import java.beans.PropertyEditor;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.MediaType;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.kh.codelit.member.model.service.MemberService;
import com.kh.codelit.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

/**
 * 
 * Model
 * 	- view단에서 처리할 데이터 저장소. Map객체
 * 	1. Model<<interface>>
 * 		- viewName 리턴
 * 		- addAttribute(k,v)
 * 	2. ModelMap
 * 		- viewName 리턴
 * 		- addAttribute(k,v)
 * 	3. ModelAndView
 * 		- ViewName(jsp위치, redirect location) 포함, ModelAndView객체 리턴
 * 		- addObject(k,v)
 * 		- RedirectAttributes객체와 함께 사용하지 말것.
 * 
 * 
 * @ModelAttribute
 * 1. 메소드 레벨
 * 		- 해당 메소드의 리턴값을 model에 저장해서 모든 요청에 사용.
 * 2. 메소드 매개변수에 지정
 * 		- model에 저장된 동일한 이름의 속성(session)이 있는 경우, getter로써 사용할 수 있다.
 * 		- 해당 매개변수를 model속성으로 저장
 * 			- 커맨드객체에 @ModelAttribute(속성명)으로 지정
 * 			- 단순 사용자 입력값은 @RequestParam 으로 처리할 것.
 * 
 * 
 * */
@Slf4j
@Controller
@RequestMapping("/member")
@SessionAttributes(value = {"loginMember"})
public class MemberController {
	
	//@Slf4J 
	//private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(LogExample.class);

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@ModelAttribute("common")
	public Map<String, Object> common(){
		log.info("@ModelAttribute - common 실행!");
		Map<String, Object> map = new HashMap<>();
		map.put("adminEmail", "admin@spring.kh.com");
		return map;
	}
	
	@GetMapping("/memberEnroll.do")
	public void memberEnroll() {
		//ViewTranslator에 의해서, 요청url에서 jsp주소를 추론한다.
//		return "member/memberEnroll";
	}
	
	@PostMapping("/memberEnroll.do")
	//커맨드객체로?
	public String memberEnroll(Member member, RedirectAttributes redirectAttr) {
		log.info("member = {}", member);
		
		try {
			//0. 암호화처리
			String rawPassword = member.getPassword();
			String encodedPassword = bcryptPasswordEncoder.encode(rawPassword);
			log.info("rawPassword = {}", rawPassword);
			log.info("encodedPassword = {}", encodedPassword);
			member.setPassword(encodedPassword);
			
			//1. 업무로직
			int result = memberService.insertMember(member);
			String msg =  result > 0 ? "회원 등록 성공!" : "회원 등록 실패!";		
			//2. 사용자 피드백 준비 및 리다이렉트
			redirectAttr.addFlashAttribute("msg", msg);
			} catch(Exception e) {
				//1.로깅작업
				log.error(e.getMessage(), e);
				//2.다시 spring container에 던질 것.
				throw e; //에러페이지로 넘어가기 혹은 커스텀예외 던지기
			}
			return "redirect:/";
		}
	
	/*
	 * 커맨드객체 이용시 사용자 입력값(String)을 특정필드타입으로 변환할 editor객체를 설정하는 메소드
	 * @param binder
	 * */
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		//Member.birthday:java.sql.Date
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		//커스텀에디터(포맷, 비어있는 값) 생성 : allowEmpty - true (빈 문자열을 null로 변환처리 허용)
		PropertyEditor editor = new CustomDateEditor(sdf, true);
		//이거(Date.class) 변환할때는 에디터를 써주어라.
		binder.registerCustomEditor(java.sql.Date.class, editor);
	}
	
	@GetMapping("/login.do")
	public ModelAndView login(ModelAndView mav) {
		// /WEB-INF/views/member/login.jsp
		mav.addObject("test", "hello world");
		mav.setViewName("member/login");
		return mav;
	}
	
	@PostMapping("/login.do")
	//리다이렉트 할거라 스트링을 명시한다.
	//@RequestParam 필수요소
	public ModelAndView login(
			@RequestParam String id,
			@RequestParam String password,
			ModelAndView mav,
			HttpServletRequest request
	) {
		try {
			
		log.info("id = {}, password = {}", id, password);
		//1. 업무로직 : 해당 id의 member 조회
		Member member = memberService.selectOneMember(id);
		log.info("member = {}", member);
		//log.info("encodedPassword = {}", bcryptPasswordEncoder.encode(password));
		
		//2. 로그인 여부 처리
		if(member != null && bcryptPasswordEncoder.matches(password, member.getPassword())) {
			//로그인 성공
			//기본값으로 request scope 속성에 저장된다.
			//클래스레벨에 @SessionAttributes("loginMember") 지정하면, session scope에 저장.
			//session.setAttribute를 원함.
			mav.addObject("loginMember", member);
		}
		else {
			//로그인 실패
//			redirectAttr.addFlashAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
			FlashMap flashMap = RequestContextUtils.getOutputFlashMap(request);
			flashMap.put("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
		}
		
		//3. 사용자 피드백 및 리다이렉트
		} catch(Exception e) {
			//1. logging
			log.error(e.getMessage(), e);
			//2. spring container에게 예외를 다시 던져서 error페이지로 이동시킨다.
			throw e; //다시 던지는 것. 스프링에게 알려주는 것
		}
		mav.setViewName("redirect:/");
		return mav;
	}
	
	/*
	 * @SessionAttributes 를 통한 로그인은
	 * SessionStatus객체를 통해서 사용완료처리함으로 로그아웃한다.
	 * 
	 * @return
	 * 
	 * */
	@GetMapping("/logout.do")
	public String logout(SessionStatus sessionStatus) {
		if(!sessionStatus.isComplete())
			sessionStatus.setComplete();		
		return "redirect:/";
	}
	
	@GetMapping("/memberDetail.do")
	public ModelAndView memberDetail(@ModelAttribute("loginMember") Member loginMember,  ModelAndView mav) {
		log.info("loginMember = {}", loginMember);
		mav.setViewName("member/memberDetail");
		return mav;
	}
	
	
	/**
	 * Spring Ajax
	 * 1. 응답스트림 직접 작성  : 응답출력스트림에 json문자열 출력
	 * 2. BeanNameViewResolver : jsonView라는 bean을 이용해서 json출력
	 * 3. @ResponseBody : handler의 리턴객체를 messageConverter빈에 의해 json 변환 출력
	 * 4. ResponseEntity
	 * 
	 * @param id
	 * @return
	 */
	@GetMapping("/checkIdDuplicate1.do")
	public String checkIdDuplicate1(@RequestParam String id, Model model) {
		log.debug("id = {}", id);
		//1.업무로직 (DB 가서 물어보기)
		Member member = memberService.selectOneMember(id);
		//2.model속성 지정(jsonView에 의해 json문자열로 변환후, 응답출력)
		boolean usable = member == null;
		model.addAttribute("usable", usable);
		model.addAttribute("name", "홍길동");
		model.addAttribute("num", 123);
		
		return "jsonView";
	}


}
