package com.kh.codelit.lecture.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class StreamingDate {

	int refLectureNo;
	String streamingTitle;
	Date streamingStartDate;
	Date streamingEndDate;

}