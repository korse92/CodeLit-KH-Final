package com.kh.codelit.lecture.model.vo;

import java.util.List;
import java.util.Map;

import com.kh.codelit.attachment.model.vo.Attachment;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Lecture {
	
	private int lectureNo;
	private int refLecCatNo;
	private String refMemberId;
	private String lectureName;
	private String lectureType;
	private String lectureIntro;
	private String lectureThumbOrigin;
	private String lectureThumbRenamed;
	private int lecturePrice;
	private String lectureAcceptYn;
	private int lectureGuideline;
	
	//첨부파일 관련
	private int attachCount;				//첨부파일 개수
	private List<Attachment> attachList;
	
	//수강후기 관련
	private List<Map<String, Object>> lectureCommentList;
	private double avgLecAssessment; //
	
}
