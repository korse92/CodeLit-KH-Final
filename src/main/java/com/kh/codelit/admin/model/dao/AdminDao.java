package com.kh.codelit.admin.model.dao;

import java.util.List;
import java.util.Map;

public interface AdminDao {

	List<Map<String, Object>> selectAllBySearching(String searchByAdmin);

	List<Map<String, Object>> applyTeacherList();

	int approveTeacher(String id);

	List<Map<String, Object>> applyLectureList();

	int approveLecture(String id);

	int deleteTeacher(String id);

	int deleteLecture(String id);


	

}
