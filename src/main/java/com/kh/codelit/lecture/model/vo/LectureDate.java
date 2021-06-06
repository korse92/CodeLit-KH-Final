package com.kh.codelit.lecture.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class LectureDate {

	private String refMemberId;
	private int refLecCatNo;
	private int lectureNo;
	private String teacherName;
	private String lectureName;
	private String lectureThumbRenamed;
	private int lectureGuideline;
	private int lecturePartNo;
	private String lecturePartTitle;
	private int lecChapterNo;
	private String lecChapterTitle;
	private Date payDate;

	private int count;

}
