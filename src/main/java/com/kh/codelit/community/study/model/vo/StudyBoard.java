package com.kh.codelit.community.study.model.vo;

import java.util.Date;

import com.kh.codelit.community.notice.model.vo.Notice;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class StudyBoard {

	private int stdBrdNo;
	private String refMemberId;
	private int refLectureNo;
	private String stdBrdTitle;
	private String stdBrdContent;
	private Date stdBrdDate;
	private int stdBrdCount;
	private int rownum;
	private String lectureName;

}
