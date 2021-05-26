package com.kh.codelit.teacher.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;



@Data
@AllArgsConstructor
@NoArgsConstructor
public class Teacher {

	private String refMemberId;
	private String teacherName;
	private String teacherPhone;
	private int refLecCatNo;
	private String teacherIntroduce;
	private String teacherLink;
	private String teacherBank;
	private String teacherAccount;
	private String teacherAccName;
	
	private String memberProfile;
	private String memberReProfile;
}
