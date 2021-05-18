package com.kh.codelit.counsel.model.vo;

import java.util.Date;

import com.kh.codelit.community.notice.model.vo.Notice;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@NoArgsConstructor
@AllArgsConstructor
public class counsel {

	private int counselNo;
	private String refMemberId;
	private String counselcategory;
	
	private String counselTitle;
	private String counselContent;

	private int counselqno;
	private Date counselDate;



}
