package com.kh.codelit;

import java.beans.PropertyEditor;
import java.security.Principal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.beans.propertyeditors.CustomNumberEditor;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

import com.kh.codelit.lecture.model.service.LectureService;
import com.kh.codelit.lecture.model.vo.Lecture;

import lombok.extern.slf4j.Slf4j;

/**
 * Handles requests for the application home page.
 */
@Controller
@Slf4j
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	
	@Autowired
	private LectureService lectureService;
	
    //다국어 처리
	@Autowired SessionLocaleResolver localeResolver; 
	@Autowired MessageSource messageSource;

	/*
	
	@RequestMapping(value = "/i18n.do", method = RequestMethod.GET)
    public String i18n(Locale locale, HttpServletRequest request, Model model) {

        // RequestMapingHandler로 부터 받은 Locale 객체를 출력해 봅니다.
        logger.info("CodeLit: Welcome i18n! The client locale is {}.", locale);

        // localeResolver 로부터 Locale 을 출력해 봅니다.
        logger.info("CodeLit: Session locale is {}.", localeResolver.resolveLocale(request));

        //messageSource의 가장 기본 적인 사용법
        //message.getMessage(메세지 키값, 대체할 값이 있을경우 값의 배열, 메세지 기본값, 로케일);
        logger.info("CodeLit: MainMenu : {}", messageSource.getMessage("MainMenu", null, "default text", locale));
        logger.info("CodeLit: menu.join : {}", messageSource.getMessage("menu.join", null, "default text", locale));
        logger.info("CodeLit: not.exist : {}", messageSource.getMessage("not.exist", null, "default text", locale));
        //logger.info("not.exist 기본값 없음 : {}", messageSource.getMessage("not.exist", null, locale));
       

        
        // JSP 페이지에서 EL 을 사용해서 arguments 를 넣을 수 있도록 값을 보낸다.
        model.addAttribute("menu.join", messageSource.getMessage("msg.first", null, locale));

        return "i18n";
   }

	
	@RequestMapping(value = "/changeLocale", method = RequestMethod.GET)
	public String home(
					   Model model,
					   HttpServletRequest request,
					   HttpServletResponse response,
					   @RequestParam(required = false) String locale,
					   Principal principal) {		
		
		logger.info("/홈 요청");
		
		HttpSession session = request.getSession();
        Locale lo = null;
        
        //step. 파라메터에 따라서 로케일 생성, 기본은 KOREAN 
        if (locale.matches("en")) {
                lo = Locale.ENGLISH;
        } else {
                lo = Locale.KOREAN;
        }
        // step. Locale을 새로 설정한다.          session.setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, lo);
        // step. 해당 컨트롤러에게 요청을 보낸 주소로 돌아간다.
        String redirectURL = "redirect:" + request.getHeader("referer");
        
        return redirectURL;
	
	}

	
	**/
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, 
					   Model model,
					   HttpServletRequest request,
					   Principal principal) {		
		
		logger.info("/홈 요청");
		
		 // localeResolver 로부터 Locale 을 출력해 봅니다.
         //logger.info("CodeLit: Session locale is {}.", localeResolver.resolveLocale(request));
        // RequestMapingHandler로 부터 받은 Locale 객체를 출력해 봅니다.
        // logger.info("CodeLit: Welcome i18n! The client locale is {}.", locale);
		
		
	try {	
		String memberId = principal != null ? principal.getName() : null;
		//log.debug("home-memberId = {}", memberId);
		List<Object> orderedlectureList = lectureService.selectOrderedLectureList(memberId);
		//log.debug("orderedlectureList = {}", orderedlectureList);
		List<Map<String, Object>> list = lectureService.mainLecture(memberId);
		//log.debug("list = {}", list);
		List<Map<String, Object>> rollingList = lectureService.rollingLecList();
		log.debug("rollingList = {}", rollingList);
		
		model.addAttribute("list", list);
		model.addAttribute("orderedlectureList", orderedlectureList);
		model.addAttribute("rollingList", rollingList);
		
	}catch (Exception e) {
		
		throw e;
	}
		return "forward:index.jsp";      
        
        //  슬래시에 대해 이걸로 인덱스 찾아가게 함.
        // Servers 하위에 있는 web.xml에서 웰컴파일 지정하던 것을 여기서 직접 설정해줌.
	}
	
	
	
	
	
	
	
	
	
	
	/**
	 * 커맨드객체 이용시 사용자 입력값(String)을 특정필드타입으로 대입할 editor객체를 설정
	 * @param binder
	 */
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		//Member.birthday:java.sql.Date 타입처리
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		//date 입력값을 입력하지않으면 ''으로 넘어와 null로 변환처리가 자동으로 안되어서 커스텀에디터 생성
		//커스텀에디터 생성 : allowEmpty - true(빈문자열을 null로 변환처리 허용)
		PropertyEditor editor = new CustomDateEditor(sdf, true);
		binder.registerCustomEditor(java.sql.Date.class, editor);
		
	}
	
	@GetMapping("/error/accessDenied.do")
	public void accesDenied() {}
	
}
