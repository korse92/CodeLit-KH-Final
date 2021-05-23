package com.kh.codelit.counsel.model.service;

import java.util.List;
import java.util.Map;

import com.kh.codelit.counsel.model.vo.Counsel;

public interface CounselService {

	int insertCounsel(Map<String, Object> param);

	List<Counsel> selectCounselList(Map<String, Object> param);

	int getTotalContents(String memberId);

	Map<String, Object> selectOneCounsel(int counselNo);

	List<Counsel> selectCounselListAdmin(Map<String, Object> param);

	int insertCounselAnswer(Map<String, Object> param);


}
