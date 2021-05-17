package com.kh.codelit.lecture.model.vo;

import java.util.List;

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
	
	private int attachCount;				//첨부파일 개수
	private List<Attachment> attachList;
	
}
