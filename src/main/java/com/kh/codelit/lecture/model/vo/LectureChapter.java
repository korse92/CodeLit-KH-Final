package com.kh.codelit.lecture.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class LectureChapter {

	private int lecChapterNo;
	private int refLecPartNo;
	private String lecChapterTitle;
	private String lecChapterVideo;
	private String lecChapterReVideo;

}
