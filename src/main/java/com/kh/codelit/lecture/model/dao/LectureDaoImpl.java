
package com.kh.codelit.lecture.model.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.codelit.lecture.model.vo.Lecture;
import com.kh.codelit.member.model.vo.Member;

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
	public int getTotalContents(Integer catNo) {
		return session.selectOne("lecture.getTotalContents", catNo);
	}

	@Override
	public List<Lecture> selectMyLecture(String id) {
		return session.selectList("lecture.selectMyLecture", id);
	}

	@Override
	public Lecture selectOneLecture(int no) {
		return session.selectOne("lecture.selectOneLecture", no);
	}

	@Override
	public List<Map<String, Object>> selectLectureCmtList(int no) {
		return session.selectList("lecture.selectLectureCmtList", no);
	}

	@Override
	public List<Map<String, Object>> mainLecture() {
		
		return session.selectList("lecture.mainLecture");
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

}
