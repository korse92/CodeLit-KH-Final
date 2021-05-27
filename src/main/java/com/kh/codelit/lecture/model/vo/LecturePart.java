package com.kh.codelit.lecture.model.vo;


import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class LecturePart {

	private int lecturePartNo;
	private int refLectureNo;
	private String lecturePartTitle;

	//챕터 리스트
	private List<LectureChapter> chepterList;

	private LectureChapter[] chapterArr;

}
