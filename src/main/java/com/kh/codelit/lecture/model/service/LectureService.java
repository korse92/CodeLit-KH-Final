package com.kh.codelit.lecture.model.service;

import java.util.List;
import java.util.Map;

public interface LectureService {

	List<Map<String, Object>> selectCategoryList();

	List<Map<String, Object>> selectCategoryListInstance();
}
