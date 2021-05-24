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

	private String lectureThumbRenamed;
	private String lectureName;
	private String teacherName;
	private int lecturePrice;
	private String lecCatName;
	private String lectureIntro;

	private Double avgLecAssessment;


}
