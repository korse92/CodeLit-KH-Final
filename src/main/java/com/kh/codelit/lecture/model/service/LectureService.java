package com.kh.codelit.lecture.model.service;

import java.util.List;
import java.util.Map;

import com.kh.codelit.lecture.model.vo.Lecture;

public interface LectureService {

	List<Map<String, Object>> selectCategoryListInstance();

	int insertLecture(Lecture lecture);


	List<Lecture> selectLectureList(Map<String, Object> param);

	int getTotalContents(Integer catNo);

	List<Lecture> selectMyLecture(String id);

	Map<Integer, Object> getCategoryMapInstance();
}
