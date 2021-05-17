package com.kh.codelit.community.student.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Comment {
	
	private int stdCmtNo;
	private int refStdBrdNo;
	private String refMemberId;
	private String stdCmtContent;
	private Date stdCmtDate;
}
