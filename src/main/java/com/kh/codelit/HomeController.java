package com.kh.codelit;

import java.beans.PropertyEditor;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {		
		logger.info("/ 요청");

        return "home";        //  슬래시에 대해 이걸로 인덱스 찾아가게 함.
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
	
}
