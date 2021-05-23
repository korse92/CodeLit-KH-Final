package com.kh.codelit.lecture.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.codelit.lecture.model.vo.Lecture;

public interface LectureDao {

	List<Map<String, Object>> selectCategoryList();

	int insertLecture(Lecture lecture);

	List<Lecture> selectLectureList(Map<String, Object> param);

	int getTotalContents(Integer catNo);

	List<Lecture> selectMyLecture(String id);

	Lecture selectOneLecture(int no);

	List<Map<String, Object>> selectLectureCmtList(int no);

}
