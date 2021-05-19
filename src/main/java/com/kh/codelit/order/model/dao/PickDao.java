package com.kh.codelit.order.model.dao;

import java.util.List;

import com.kh.codelit.order.model.vo.Pick;

public interface PickDao {

	List<Pick> selectPickList();

}
