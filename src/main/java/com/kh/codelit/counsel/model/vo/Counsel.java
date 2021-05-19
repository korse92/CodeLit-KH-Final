package com.kh.codelit.counsel.model.vo;

import java.sql.Date;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;



@Data
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Counsel {
	
	private String CounselNo;
	private String RefMemberId;
	private String CounselCategory;
	private String CounselTitle;
	private String CounselContent;
	private int Qno;
	private String leval;
	private Date CounselDate;

	
}
