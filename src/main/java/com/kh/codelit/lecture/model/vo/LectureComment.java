package com.kh.codelit.lecture.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class LectureComment {

	private int refLectureNo;
	private String refMemberId;
	private int lecAssessment;
	private String lecComment;
	private Date lecCmtEnrollDate;

}
