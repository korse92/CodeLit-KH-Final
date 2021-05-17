package com.kh.codelit.attachment.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Attachment {
	
	//저장경로 상수
	public static final String PATH_LECTURE_HANDOUT = "/resources/upload/lecture/handouts";
	public static final String PATH_LECTURE_THUMBNAIL = "/resources/upload/lecture/thumbnails";
	public static final String PATH_NOTICE = "/resources/upload/notice";
	public static final String PATH_STUDYBOARD = "/resources/upload/studyBoard";
	
	//그룹코드 상수
	public static final String CODE_LECTURE_HANDOUT = "LH";
	public static final String CODE_NOTICE = "N";
	public static final String CODE_STUDY_BOARD = "SB";	
	
	private int attachNo;
	private int refContentsNo;//참조하는 컨텐츠(ex. 공지사항, 공부게시판의 게시글) 번호
	private String originalFilename;
	private String renamedFilename;
	private String refContentsGroupCode;//컨텐츠 그룹코드
	
	//컨텐츠 그룹 관련 필드 (attachment테이블 + contents_group테이블 조인해서 사용)
	private String contentsAttachPath;// 첨부파일 저장경로	

}
