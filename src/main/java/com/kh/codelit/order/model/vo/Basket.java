package com.kh.codelit.order.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Basket {
	
	private int basketNo;
	private int refLectureNo;
	private String refMemberId;
	private Date basketDate;
	

}
