package com.kh.codelit.lecture.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.codelit.lecture.model.vo.Lecture;

public interface LectureDao {

	List<Map<String, Object>> selectCategoryList();

	int insertLecture(Lecture lecture);

}
