package com.kh.codelit.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class AdminDaoImpl implements AdminDao {
	
	@Autowired
	private SqlSessionTemplate session;

	
	/**
	 * RowBounds : mybatis가 제공하는 paging기능
	 * - offset : 건너뛸 행수
	 * - limit : 한페이지당 게시물수
	 */
	/*
	 * @Override public List<ApplyTeacher> applyTeacherList(Map<String, Object>
	 * param) { //mybaits의 페이징 기능 : rowBounds 객체 생성 //첫인자(건너뛸 행 수): offset | 두번쨰
	 * 인자(한 페이징당 게시물 수) : limit(=numPerPage)
	 * 
	 * int cPage = (int)param.get("cPage");
	 * 
	 * int limit = (int)param.get("numPerPage"); int offset = (cPage - 1) * limit;
	 * //1페이지에 0, 2페이지에5, 3페이지에 10,,,, -> int offset = (cPage - 1) * limit;
	 * RowBounds rowBounds = new RowBounds(offset, limit);
	 * 
	 * return session.selectList("admin.applyTeacherList", null, rowBounds);
	 * 
	 * }
	 * 
	 * @Override public int getTotalContents() {
	 * 
	 * return session.selectOne("admin.getTotalContents"); //1행 1열짜리값 얻어오기 }
	 */

	
	@Override
	public List<Map<String, Object>> selectAllBySearching(String searchByAdmin) {
		return session.selectList("admin.selectAllBySearching", searchByAdmin);
	}


	@Override
	public List<Map<String, Object>> applyTeacherList() {
		return session.selectList("admin.applyTeacherList");
	}


	@Override
	public int approveTeacher(String id) {
		return session.insert("admin.approveTeacher", id);
	}


	@Override
	public List<Map<String, Object>> applyLectureList() {
		return session.selectList("admin.applyLectureList");
	}


	@Override
	public int approveLecture(String id) {
		return session.update("admin.approveLecture", id);
	}


	@Override
	public int deleteTeacher(String id) {
		return session.delete("admin.deleteTeacher", id);
	}


	@Override
	public int deleteLecture(String id) {
		return session.delete("admin.deleteLecture", id);
	}


	@Override
	public List<Map<String, Object>> selectAllLecture(Map<String, Object> param) {
		//강의 관리게시판 : myBatis의 rowBounds -> 페이징 기능
		//offSet : 건너뛸 행 수
		//limit : 한 페이지당 게시물 수 (= numPerPage)
		int cPage = (int)param.get("cPage");
		int limit = (int)param.get("numPerPage");
		int offset = (cPage - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return session.selectList("admin.selectAllLecture", null, rowBounds);
	}


	@Override
	public int getTotalContents() {
		//카운트 그룹함수로 1행 1열짜리 갖고올거임
		return session.selectOne("admin.getTotalContents");
	}

	


}
