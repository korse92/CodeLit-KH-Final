package com.kh.codelit.lecture.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.codelit.attachment.model.dao.AttachDao;
import com.kh.codelit.attachment.model.vo.Attachment;
import com.kh.codelit.lecture.model.dao.LectureDao;
import com.kh.codelit.lecture.model.vo.Lecture;
import com.kh.codelit.lecture.model.vo.LectureChapter;
import com.kh.codelit.lecture.model.vo.LectureComment;
import com.kh.codelit.lecture.model.vo.LecturePart;
import com.kh.codelit.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;



@Service
@Slf4j
public class LectureServiceImpl implements LectureService {

	@Autowired
	private LectureDao lectureDao;

	@Autowired
	private AttachDao attachDao;

	private static List<Map<String, Object>> categoryListInstance; //싱글톤 객체로 처리
	private static Map<Integer, Object> categoryMapInstance;

	@Override
	public List<Map<String, Object>> selectCategoryListInstance() {
		if(categoryListInstance == null || categoryListInstance.isEmpty()) {
			categoryListInstance = lectureDao.selectCategoryList();
			log.debug("categoryListInstance 생성 = {}", categoryListInstance);
		}

		return categoryListInstance;
	}


	@Override
	public Map<Integer, Object> getCategoryMapInstance() {
		if(categoryListInstance == null || categoryListInstance.isEmpty())
			categoryListInstance = selectCategoryListInstance();

		if(categoryMapInstance == null || categoryMapInstance.isEmpty()) {
			categoryMapInstance = new HashMap<>();
			for(Map<String, Object> category : categoryListInstance) {
				Integer no = (Integer)category.get("no");
				String name = (String)category.get("name");
				categoryMapInstance.put(no, name);
			}
			log.debug("categoryMapInstance 생성 = {}", categoryMapInstance);
		}

		return categoryMapInstance;
	}

	@Override
	public int insertLecture(Map<String, Object> param) {
		int result = 0;
		Lecture lecture = (Lecture)param.get("lecture");
		LecturePart[] leturePartArr = (LecturePart[])param.get("lecturePartArr");

		//1. lecture객체 등록
		result = lectureDao.insertLecture(lecture);
		log.debug("lecture.no = {}", lecture.getLectureNo());//insert한 lecture 번호 확인

		//2.첨부파일 등록
		if(!lecture.getAttachList().isEmpty()) {
			for(Attachment attach : lecture.getAttachList()) {
				attach.setRefContentsNo(lecture.getLectureNo());
				result = attachDao.insertAttachment(attach);
			}
		}
		//3.쿼리큘럼 등록
		if(leturePartArr != null || leturePartArr.length > 0) {
			for(LecturePart part : leturePartArr) {
				part.setRefLectureNo(lecture.getLectureNo());
				result = lectureDao.insertLecturePart(part);
				log.debug("part.no = {}", part.getLecturePartNo());//insert한 lecturePart 번호 확인

				LectureChapter[] chapterArr = part.getChapterArr();

				if(chapterArr != null || chapterArr.length > 0) {
					for(LectureChapter chapter : chapterArr) {
						chapter.setRefLecPartNo(part.getLecturePartNo());
						result = lectureDao.insertLectureChapter(chapter);
					}
				}
			}
		}

		return result;
	}

	@Override
	public List<Lecture> selectLectureList(Map<String, Object> param) {
		return lectureDao.selectLectureList(param);
	}

	@Override
	public int getTotalContents(Map<String, Object> param) {
		return lectureDao.getTotalContents(param);
	}

	@Override
	public List<Lecture> selectMyLecture(String id) {
		return lectureDao.selectMyLecture(id);
	}


	@Override
	public List<Map<String, Object>> mainLecture(String memberId) {
		return lectureDao.mainLecture(memberId);
	}


	@Override
	public Lecture selectOneLecture(int no) {
		return lectureDao.selectOneLecture(no);
	}

	@Override
	public List<Map<String, Object>> selectLectureCmtList(int no) {
		return lectureDao.selectLectureCmtList(no);
	}


	@Override
	public int clickCount(Map<String, Object> param) {
		return lectureDao.clickCount(param);
	}


	@Override
	public List<Map<String, Object>> rollingLecList() {
		return lectureDao.rollingLecList();
	}


	@Override
	public List<Map<String, Object>> mainSearchResult(Map<String, Object> param) {
		return lectureDao.mainSearchResult(param);
	}


	@Override
	public List<Map<String, Object>> myAllLecture(Map<String,Object> param) {
		return lectureDao.myAllLecture(param);
	}


	@Override
	public int getTeacherTotalContents(Map<String, Object> param) {

		return lectureDao.getTeacherTotalContents(param);
	}


	@Override
	public List<Map<String, Object>> selectLectureProgress(Map<String, Object> param) {

		return lectureDao.selectLectureProgress(param);
	}


	@Override
	public int updateProgress(Map<String, Object> param) {

		return lectureDao.updateProgress(param);
	}


	@Override
	public String selectVideoRename(int playPosition) {

		return lectureDao.selectVideoRename(playPosition);
	}




	@Override
	public List<Object> selectOrderedLectureList(String memberId) {
		return lectureDao.selectOrderedLectureList(memberId);
	}

	@Override
	public int reApplyLecture(int lectureNo) {
		return lectureDao.reApplyLecture(lectureNo);
	}
	

	@Override
	public List<Lecture> teacherProfileLecture(String memberId) {
		return lectureDao.teacherProfileLecture(memberId);
	}
	

	@Override
	public int cmtInsert(LectureComment lecCmt) {
		return lectureDao.cmtInsert(lecCmt);
	}





}
