package com.kh.codelit.lecture.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.codelit.lecture.model.vo.Lecture;
import com.kh.codelit.lecture.model.vo.LectureChapter;
import com.kh.codelit.lecture.model.vo.LectureComment;
import com.kh.codelit.lecture.model.vo.LecturePart;
import com.kh.codelit.lecture.model.vo.StreamingDate;
import com.kh.codelit.member.model.vo.Member;

public interface LectureDao {

	List<Map<String, Object>> selectCategoryList();

	int insertLecture(Lecture lecture);

	List<Lecture> selectLectureList(Map<String, Object> param);

	int getTotalContents(Map<String, Object> param);

	List<Lecture> selectMyLecture(String id);

	List<Map<String, Object>> mainLecture(String memberId);

	Lecture selectOneLecture(Map<String, Object> param);

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

	int insertLecturePart(LecturePart part);

	int insertLectureChapter(LectureChapter chapter);

	int reApplyLecture(int lectureNo);

	List<Lecture> teacherProfileLecture(String memberId);

	int insertStreamingDate(Map<String, Object> streamingDate);


	int cmtInsert(LectureComment lecCmt);

	int cmtUpdate(LectureComment lecCmt);

}
