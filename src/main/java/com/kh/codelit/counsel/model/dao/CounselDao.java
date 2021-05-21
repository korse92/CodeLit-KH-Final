package com.kh.codelit.counsel.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.codelit.attachment.model.vo.Attachment;
import com.kh.codelit.counsel.model.vo.Counsel;

public interface CounselDao {

	

	int insertCounsel(Counsel counsel);

	List<Counsel> selectCounselList(Map<String, Object> param);

	int getTotalContents(String memberId);

	Counsel selectOneCounsel(int counselNo);

	int selectAnswerBool(int counselNo);


}
