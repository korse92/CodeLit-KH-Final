package com.kh.codelit.order.model.service;

import java.util.List;

import com.kh.codelit.order.model.vo.Pick;

public interface PickService {

	List<Pick> selectPickList(String refMemberId);

	int countPick(int refLectureNo, String refMemberId);

	int addPick(int refLectureNo, String refMemberId);

	int deletePick(int pickNo);

}
