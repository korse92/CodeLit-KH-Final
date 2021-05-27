package com.kh.codelit.order.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.security.Principal;
import java.sql.Blob;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.codelit.order.model.service.PaymentService;
import com.kh.codelit.order.model.vo.Payment;

import lombok.extern.slf4j.Slf4j;



@Controller
@Slf4j
@RequestMapping("/order")
public class PaymentController {

	@Autowired
	private PaymentService paymentService;
	
	
	
	@PostMapping("/paymentHandling.do")
	public String paymentHandling(
				@ModelAttribute Payment payment,
				RedirectAttributes redirectAttr,
				Principal pri
			) {
		
		log.debug("paymentHandling payment = {}", payment);
		String address = null;
		String msg = null;
		
		try {
			
			int result = paymentService.paymentHandling(payment);
			msg = result > 0 ? "주문에 성공했습니다." : "문제가 발생했습니다. 관리자에게 문의하십시오.";
//			address = result > 0 ? "redirect:/order/orderSuccess.do" : "redirect:/";
			address = result > 0 ? "redirect:/" : "redirect:/";
			
		} catch(Exception e) {
			throw e;
		}
		
		return address;
	}


	
	@GetMapping("/testInPayment.do")
	public String testInPayment(
				Model model,
				HttpServletRequest request
			) throws Exception {
		
		log.debug("/testInPayment.do = {}", "도착");
		
	    Blob blob = null;
	    BufferedInputStream bis = null;
	    String fileName = "/resources/upload/notice/test.mp4";
	    String saveDirectory =  request.getServletContext().getRealPath(fileName);
	    
	    
	    try {
	    	bis = new BufferedInputStream(new FileInputStream(saveDirectory));
	    	
	    	byte[] bytes = new byte[10485760];
	    	
	    	bis.read(bytes);
	   
	        blob = new javax.sql.rowset.serial.SerialBlob(bytes); 
	   
	        model.addAttribute("blob", blob);
	        
	    } catch (Exception e) {
	        throw e;
	   
	    } finally {
	        try {
	        	bis.close();
	        } catch (Exception e) {
	        }
	    }
	  
	    return "/order/test";
	}
	
//	@Autowired
//	private ServletContext servletContext;
//	
//	@ResponseBody
//	@GetMapping("/video.do")
//	public blob fileReturn(
//				HttpServletRequest request
//			) {
//		
//		String fileName = "test.mp4";
//		String directory = "/resources/upload/board";
//	    String saveDirectory = servletContext.getRealPath(directory);
//	    File file = new File(saveDirectory, fileName);
//	    
//	    Blob blob = null;
//	    BufferedInputStream bis = null;
//
//	    String bisRoute = directory + fileName;
//	    
//	    bisRoute = servletContext.getRealPath(bisRoute);
//	    
//	    try {
//	    	bis = new BufferedInputStream(new FileInputStream(bisRoute));
//	    	
//	    	byte[] bytes = new byte[10485760];
//	    	
//	    	bis.read(bytes);
//	   
//	        blob = new javax.sql.rowset.serial.SerialBlob(bytes); 
//	   
//	        
//	    } catch (Exception e) {
//	        throw e;
//	   
//	    } finally {
//	        try {
//	        	bis.close();
//	        } catch (Exception e) {
//	        }
//	    }
//	    
//		return blob;
//	}
	
}
