package com.kh.codelit.admin.model.service;

import java.util.List;
import java.util.Map;


public interface AdminService {

	List<Map<String, Object>> selectAllBySearching(String searchByAdmin);

	List<Map<String, Object>> applyTeacherList();

	int approveTeacher(String id);

	List<Map<String, Object>> applyLectureList();

	int approveLecture(String id);

	
}
