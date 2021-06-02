
package com.kh.codelit.lecture.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.codelit.lecture.model.vo.Lecture;
import com.kh.codelit.lecture.model.vo.LectureChapter;
import com.kh.codelit.lecture.model.vo.LectureComment;
import com.kh.codelit.lecture.model.vo.LecturePart;
import com.kh.codelit.lecture.model.vo.StreamingDate;

import lombok.extern.slf4j.Slf4j;



@Slf4j
@Repository
public class LectureDaoImpl implements LectureDao {

	@Autowired
	private SqlSessionTemplate session;

	@Override
	public List<Map<String, Object>> selectCategoryList() {
		return session.selectList("lecture.selectCategoryList");
	}

	@Override
	public int insertLecture(Lecture lecture) {
		return session.insert("lecture.insertLecture", lecture);
	}

	@Override
	public List<Lecture> selectLectureList(Map<String, Object> param) {
		int cPage = (int)param.get("cPage");

		int limit = (int)param.get("numPerPage");
		int offset = (cPage - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);

		return session.selectList("lecture.selectLectureList", param, rowBounds);
	}

	@Override
	public int getTotalContents(Map<String, Object> param) {
		return session.selectOne("lecture.getTotalContents", param);
	}

	@Override
	public List<Lecture> selectMyLecture(String id) {
		return session.selectList("lecture.selectMyLecture", id);
	}

	@Override
	public Lecture selectOneLecture(Map<String, Object> param) {
		return session.selectOne("lecture.selectOneLecture", param);
	}

	@Override
	public List<Map<String, Object>> selectLectureCmtList(int no) {
		return session.selectList("lecture.selectLectureCmtList", no);
	}

	@Override
	public List<Map<String, Object>> mainLecture(String memberId) {

		return session.selectList("lecture.mainLecture", memberId);
	}

	@Override
	public int clickCount(Map<String, Object> param) {
		return session.update("lecture.clickCount", param);
	}

	@Override
	public List<Map<String, Object>> rollingLecList() {
		return session.selectList("lecture.rollingLecList");
	}

	@Override
	public List<Map<String, Object>> mainSearchResult(Map<String, Object> param) {
		return session.selectList("lecture.mainSearchResult", param);
	}

	@Override
	public List<Map<String, Object>> myAllLecture(Map<String,Object> param) {
		int cPage = (int)param.get("cPage");
		int limit = (int)param.get("numPerPage");
		int offset = (cPage - 1) * limit;

		RowBounds rowBounds = new RowBounds(offset, limit);
		//	log.debug("강의자 내강의목록dao param = {}", param);
		return session.selectList("lecture.myAllLecture", param, rowBounds);
	}

	@Override
	public int getTeacherTotalContents(Map<String, Object> param) {

		return session.selectOne("lecture.getTeacherTotalContents", param);
	}

	@Override
	public List<Map<String, Object>> selectLectureProgress(Map<String, Object> param) {

		return session.selectList("lecture.selectLectureProgress", param);
	}

	@Override
	public int updateProgress(Map<String, Object> param) {

		return session.update("lecture.updateProgress", param);
	}

	@Override
	public String selectVideoRename(int playPosition) {

		return session.selectOne("lecture.selectVideoRename", playPosition);
	}

	@Override
	public List<Object> selectOrderedLectureList(String memberId) {
		return session.selectList("order.selectOrderedLectureList", memberId);
	}

	@Override
	public int insertLecturePart(LecturePart part) {
		return session.insert("lecture.insertLecturePart", part);
	}

	@Override
	public int insertLectureChapter(LectureChapter chapter) {
		return session.insert("lecture.insertLectureChapter", chapter);
	}

	@Override
	public int reApplyLecture(int lectureNo) {
	return session.update("lecture.reApplyLecture", lectureNo);
	}

	@Override
	public List<Lecture> teacherProfileLecture(String memberId) {
		return session.selectList("lecture.teacherProfileLecture", memberId);
	}

	@Override
	public int insertStreamingDate(Map<String, Object> streamingDate) {
		return session.insert("lecture.insertStreamingDate", streamingDate);
	}

	public int cmtInsert(LectureComment lecCmt) {
		return session.insert("lecture.cmtInsert", lecCmt);
	}

	@Override
	public int cmtUpdate(LectureComment lecCmt) {
		return session.update("lecture.cmtUpdate", lecCmt);
	}
}
