package com.kh.codelit.order.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.codelit.order.model.vo.Pick;

public interface PickDao {

	List<Pick> selectPickList(String refMemberId);

//	int selectPickOne(int refLectureNo, String refMemberId);

	int addPick(int refLectureNo, String refMemberId);

	int deletePick(Map<String, Object> param);

}
