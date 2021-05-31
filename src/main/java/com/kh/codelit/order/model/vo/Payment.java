package com.kh.codelit.order.model.vo;

import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;



@Data
@NoArgsConstructor
@AllArgsConstructor
public class Payment {

	private String payCode; //주문번호
	private String refMemberId; //결제한 iD
	private int payNo; 
	private int payCost;   //결제금액
	private Date payDate;  //
	
	private List<Integer> refLectureNo;
	private int count;//강의 갯수 
}
