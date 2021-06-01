package com.kh.codelit.lecture.model.service;

import java.util.List;
import java.util.Map;

import com.kh.codelit.lecture.model.vo.Lecture;
import com.kh.codelit.lecture.model.vo.LectureComment;

public interface LectureService {

	List<Map<String, Object>> selectCategoryListInstance();

	int insertLecture(Map<String, Object> param);

	List<Lecture> selectLectureList(Map<String, Object> param);

	int getTotalContents(Map<String, Object> param);

	List<Lecture> selectMyLecture(String id);

	Map<Integer, Object> getCategoryMapInstance();

	List<Map<String, Object>> mainLecture(String memberId);

	Lecture selectOneLecture(int no);

	List<Map<String, Object>> selectLectureCmtList(int no);

	int clickCount(Map<String, Object> param);

	List<Map<String, Object>> rollingLecList();

	List<Map<String, Object>> mainSearchResult(Map<String, Object> param);

	List<Map<String, Object>> myAllLecture(Map<String,Object> param);

	int getTeacherTotalContents(Map<String, Object> param);

	List<Map<String, Object>> selectLectureProgress(Map<String, Object> param);

	int updateProgress(Map<String, Object> param);

	String selectVideoRename(int playPosition);

	List<Object> selectOrderedLectureList(String memberId);

	int cmtInsert(LectureComment lecCmt);

	int reApplyLecture(int lectureNo);

	List<Lecture> teacherProfileLecture(String memberId);

	int cmtUpdate(LectureComment lecCmt);

}
