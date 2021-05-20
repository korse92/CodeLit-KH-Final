package com.kh.codelit.counsel.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.codelit.counsel.model.vo.Counsel;
import com.kh.codelit.lecture.model.vo.Lecture;

public interface CounselDao {

	

	int insertCounsel(Counsel counsel);

	List<Counsel> selectCounselList(Map<String, Object> param);

	int getTotalContents(Integer catNo);

}
