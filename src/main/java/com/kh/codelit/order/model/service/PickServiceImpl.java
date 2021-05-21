package com.kh.codelit.order.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.codelit.order.model.dao.PickDao;
import com.kh.codelit.order.model.vo.Pick;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class PickServiceImpl implements PickService {
	
	@Autowired
	private PickDao pickDao;

	@Override
	public List<Pick> selectPickList(String refMemberId) {
		return pickDao.selectPickList(refMemberId);
	}

	@Override
	public int countPick(int refLectureNo, String refMemberId) {
		return pickDao.countPick(refLectureNo, refMemberId);
	}

	@Override
	public int addPick(int refLectureNo, String refMemberId) {
		return pickDao.addPick(refLectureNo, refMemberId);
	}

	@Override
	public int deletePick(int pickNo) {
		return pickDao.deletePick(pickNo);
	}

}
