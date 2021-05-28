package com.kh.codelit.admin.model.dao;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.codelit.member.model.vo.Member;
import com.kh.codelit.order.model.vo.Payment;
import com.kh.codelit.teacher.model.vo.Teacher;

import lombok.extern.slf4j.Slf4j;



@Slf4j
@Repository
public class AdminDaoImpl implements AdminDao {
	
	@Autowired
	private SqlSessionTemplate session;

	
	
	@Override
	public List<Member> selectMemberList(Map<String, Object> param) {

		int cPage = (int)param.get("cPage");
		
		int limit = (int)param.get("numPerPage");
		int offset = (cPage - 1) * limit; // 1 -> 0, 2 -> 5, 3 -> 10....
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		String keyword = (String)param.get("keyword");
		
		return session.selectList("admin.selectMemberList", param, rowBounds);			
	}

	@Override
	public int deleteMember(String memberId) {

		return session.delete("admin.deleteMember", memberId);
	}

	@Override
	public List<Teacher> selectTeacherList(Map<String, Object> param) {
		
		int cPage = (int)param.get("cPage");
		
		int limit = (int)param.get("numPerPage");
		int offset = (cPage - 1) * limit; // 1 -> 0, 2 -> 5, 3 -> 10....
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		String keyword = (String)param.get("keyword");
		
		return session.selectList("admin.selectTeacherList", param, rowBounds);

	}
	
	@Override
	public List<Payment> selectMemberOrderList(Map<String, Object> param) {
	int cPage = (int)param.get("cPage");
		
		int limit = (int)param.get("numPerPage");
		int offset = (cPage - 1) * limit; // 1 -> 0, 2 -> 5, 3 -> 10....
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		
		
		return session.selectList("admin.selectMemberOrderList", param, rowBounds);		
	}

	/**
	 * RowBounds : mybatis가 제공하는 paging기능
	 * - offset : 건너뛸 행수
	 * - limit : 한페이지당 게시물수
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
	public int approveLecture(int no) {
		return session.update("admin.approveLecture", no);
	}


	@Override
	public int deleteTeacher(String id) {
		return session.delete("admin.deleteTeacher", id);
	}


	@Override
	public int deleteLecture(int no) {
		return session.delete("admin.deleteLecture", no);
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
		
		return session.selectList("admin.selectAllLecture",param, rowBounds);
	}


	@Override
	public int getTotalContents(Map<String, Object> param) {
		//카운트 그룹함수로 1행 1열짜리 갖고올거임
		return session.selectOne("admin.getTotalContents", param);
	}

	@Override
	public List<Map<String, Object>> searchCategory(int type) {
		return session.selectList("admin.searchCategory", type);
	}

	@Override
	public int rejectPlayingLecture(int no) {
		return session.update("admin.rejectPlayingLecture", no);
	}



	@Override
	public int selectMemberCount(Map<String, Object> param) {
		
		return session.selectOne("admin.selectMemberCount", param);
	}

	@Override
	public int selectTeacherCount(Map<String, Object> param) {



		return session.selectOne("admin.selectTeacherCount", param);
	}

	@Override
	public int selectMemberOrderCount(Map<String, Object> param) {
		
		return session.selectOne("admin.selectMemberOrderCount", param);
	}

	@Override

	public List<Member> selectMemberOrderList(String memberId) {
		
		return session.selectList("admin.selectMemberOrderList",memberId);
	}
	public int deleteTeacherAndAuth(String refMemberId) {

		return session.delete("admin.deleteTeacherAndAuth", refMemberId);
	}

	@Override
	public int deleteTeacherAndAuth2(String refMemberId) {

		return session.delete("admin.deleteTeacherAndAuth2", refMemberId);

	}





	


}
