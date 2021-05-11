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
		logger.info("/요청합니다 !!!!!!!!!!!!!!");

        return "forward:index.jsp";        //  �뒳�옒�떆�뿉 ���빐 �씠嫄몃줈 �씤�뜳�뒪 李얠븘媛�寃� �븿.
        // Servers �븯�쐞�뿉 �엳�뒗 web.xml�뿉�꽌 �쎇而댄뙆�씪 吏��젙�븯�뜕 寃껋쓣 �뿬湲곗꽌 吏곸젒 �꽕�젙�빐以�.
	}
	
	/**
	 * 而ㅻ㎤�뱶媛앹껜 �씠�슜�떆 �궗�슜�옄 �엯�젰媛�(String)�쓣 �듅�젙�븘�뱶���엯�쑝濡� ���엯�븷 editor媛앹껜瑜� �꽕�젙
	 * @param binder
	 */
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		//Member.birthday:java.sql.Date ���엯泥섎━
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		//date �엯�젰媛믪쓣 �엯�젰�븯吏��븡�쑝硫� ''�쑝濡� �꽆�뼱�� null濡� 蹂��솚泥섎━媛� �옄�룞�쑝濡� �븞�릺�뼱�꽌 而ㅼ뒪���뿉�뵒�꽣 �깮�꽦
		//而ㅼ뒪���뿉�뵒�꽣 �깮�꽦 : allowEmpty - true(鍮덈Ц�옄�뿴�쓣 null濡� 蹂��솚泥섎━ �뿀�슜)
		PropertyEditor editor = new CustomDateEditor(sdf, true);
		binder.registerCustomEditor(java.sql.Date.class, editor);
		
	}
	
}
