package com.kh.codelit.lecture.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.codelit.lecture.model.vo.Lecture;
import com.kh.codelit.member.model.vo.Member;

public interface LectureDao {

	List<Map<String, Object>> selectCategoryList();

	int insertLecture(Lecture lecture);

	List<Lecture> selectLectureList(Map<String, Object> param);

	int getTotalContents(Integer catNo);

	List<Lecture> selectMyLecture(String id);

	List<Map<String, Object>> mainLecture();

	Lecture selectOneLecture(int no);

	List<Map<String, Object>> selectLectureCmtList(int no);

	int clickCount(Map<String, Object> param);

	List<Map<String, Object>> rollingLecList();

	List<Map<String, Object>> mainSearchResult(Map<String, Object> param);

	List<Map<String, Object>> myAllLecture(Map<String,Object> param);

	int getTeacherTotalContents(Map<String, Object> param);

}
