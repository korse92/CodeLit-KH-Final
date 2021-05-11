package com.kh.codelit.test.model.dao;

import com.kh.codelit.test.model.vo.Test;

public interface TestDao {

	Test selectOneTest(String name);

}
