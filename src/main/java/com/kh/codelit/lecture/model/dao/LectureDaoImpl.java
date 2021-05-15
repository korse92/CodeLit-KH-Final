
package com.kh.codelit.lecture.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.codelit.lecture.model.vo.Lecture;

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

}
