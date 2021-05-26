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

	private String payCode;
	private String refMemberId;
	private int payNo;
	private int payCost;
	private Date payDate;
	
	private List<Integer> refLectureNo;
}
