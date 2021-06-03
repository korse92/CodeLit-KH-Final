package com.kh.codelit.lecture.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class StreamingDate {

	private int refLectureNo;
	private String streamingTitle;
	private Date streamingStartDate;
	private Date streamingEndDate;

	private String refMemberId;
	private String lectureName;
	private String teacherName;
	private String streamingStartTime;
	private String streamingEndTime;
	private String lectureThumbRenamed;

}