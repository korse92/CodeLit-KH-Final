package com.kh.codelit.order.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Pick {
	
	private int pickNo;
	private String refMemberId;
	private int refLectureNo;
	private Date pickDate;
	
	private String lectureThumbRenamed;
	private String lectureName;
	private String teacherName;
	private int lecturePrice;
	private String lecCatName;
	private String lectureIntro;
	
	private Double avgLecAssessment;


}
