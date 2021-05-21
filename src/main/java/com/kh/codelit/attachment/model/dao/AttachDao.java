package com.kh.codelit.attachment.model.dao;

import java.util.List;

import com.kh.codelit.attachment.model.vo.Attachment;

public interface AttachDao {

	int insertAttachment(Attachment attach);

	List<Attachment> selectAttachment(int no);

}
