package com.kh.codelit.community.notice.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Notice {
	
	private int noticeNo;
	private String refMemberId;
	private String noticeTitle;
	private String noticeContent;
	private Date noticeDate;
	private int noticeCount;
	private int rownum;
	
}
