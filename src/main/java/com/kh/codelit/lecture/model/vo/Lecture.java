package com.kh.codelit.lecture.model.vo;

import java.util.List;
import java.util.Map;

import com.kh.codelit.attachment.model.vo.Attachment;
import com.kh.codelit.teacher.model.vo.Teacher;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Lecture {

	//lecture테이블 컬럼과 동일
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

	//파트 리스트
	private List<LecturePart> partList;

	//강사 관련
	private String teacherName;
	private Teacher teacher;

	//첨부파일 관련
	private int attachCount;				//첨부파일 개수
	private List<Attachment> attachList;

	//수강후기 관련
	private List<Map<String, Object>> lectureCommentList;
	private double avgLecAssessment; //별점 평균

	//찜,장바구니
	private boolean picked;

}
