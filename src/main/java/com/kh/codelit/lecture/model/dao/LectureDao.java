package com.kh.codelit.lecture.model.dao;

import java.util.List;
import java.util.Map;

public interface LectureDao {

	List<Map<String, Object>> selectCategoryList();

}
