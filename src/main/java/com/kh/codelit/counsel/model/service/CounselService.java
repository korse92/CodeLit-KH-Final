package com.kh.codelit.counsel.model.service;

import java.util.List;
import java.util.Map;

import com.kh.codelit.counsel.model.vo.Counsel;

public interface CounselService {

	int insertCounsel(Counsel counsel);

	List<Counsel> selectCounselList(Map<String, Object> param);

	int getTotalContents(String memberId);

	Counsel selectOneCounsel(int counselNo);


}
