package com.kh.codelit.counsel.controller;





import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;



import com.kh.codelit.counsel.model.sevice.CounselService;


import lombok.extern.slf4j.Slf4j;


@Controller
@RequestMapping
@Slf4j
public class counselController {
	@Autowired
	private CounselService counselService;
	
	@GetMapping("/counselList.do")
	public void counselList() {
		
	}
//	public void selectBoard(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request) {
//
//		int numPerPage = 10;
//		//클릭한 페이지, 총게시글 수전달
//		Map<String, Object> param = new HashMap<>();
//		param.put("numPerPage", numPerPage);
//		param.put("cPage", cPage);
//		
//		List<counsel> list = counselService.counselList(param);
//		
//		int count = counselService.getListCount();
//		String uri = request.getRequestURI();
//		String pageBar = HelloSpringUtils.getPageBar(count, cPage, numPerPage, uri);
//		
//		model.addAttribute("list", list);
//		model.addAttribute("pageBar", pageBar);
//		
//		
//	}
}
