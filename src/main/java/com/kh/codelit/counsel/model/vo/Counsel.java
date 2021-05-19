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
	
	private String counselNo;
	private String refMemberId;
	private String counselCategory;
	private String counselTitle;
	private String counselContent;
	private int counselQNo;
	private String counselLeval;
	private Date counselDate;

	
}
