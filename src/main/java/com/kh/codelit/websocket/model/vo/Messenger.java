package com.kh.codelit.websocket.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Messenger {

	private int rownum;
	private int msgNo;
	private String refWriterId;
	private String refReceiverId;
	private String msgTitle;
	private String msgContent;
	private Date msgDate;
	private String readYN;
	
}
