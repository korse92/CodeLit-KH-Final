package com.kh.codelit.order.model.service;

import java.util.List;

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
	public List<Pick> selectPickList() {
		return pickDao.selectPickList();
	}

}
