package com.kh.codelit.common;

import java.io.File;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class HelloSpringUtils {

	/**
	 * 
	 * totalPage 전체페이지수 올림(totalContents / numPerPage)
	 * pageBarSize 페이지바의 페이지수
	 * pageStart ~ pageEnd 페이지바 범위
	 * pageNo 증감변수
	 * 
	 * < 1 2 3 4 5 > 이전버튼 비활성화
	 * < 6 7 8 9 10 >
	 * < 11 12 > 다음버튼 비활성화
	 * 
	 * @param totalContents
	 * @param cPage
	 * @param numPerPage
	 * @param url
	 * @return
	 */
	public static String getPageBar(int totalContents, int cPage, int numPerPage, String url) {
		StringBuilder pageBar = new StringBuilder();
		
		int pageBarSize = 5;
		int totalPage = (int)Math.ceil((double)totalContents / numPerPage);
		
//		/spring/board/boardList?cPage=
//		/spring/board/boardList?searchType=memberId&searchKeyward=a&cPage=
		url = url + (url.indexOf("?") > -1 ? "&" : "?") + "cPage=";
		
		// 1 2 3 4 5 : pageStart 1 ~ pageEnd 5
		// 6 7 8 9 10 : pageStart 6 ~ pageEnd 10
		int pageStart = ((cPage - 1) / pageBarSize) * pageBarSize + 1;
		int pageEnd = pageStart + pageBarSize - 1;
		
		//증감변수
		int pageNo = pageStart;
		
		pageBar.append("<nav><ul class=\"pagination justify-content-center pagination-sm\">\n");
		
		//이전 영역
		if(pageNo == 1) {
			pageBar.append("<li class=\"page-item disabled\">\r\n"
					+ "\t<a class=\"page-link\" href=\"#\">Previous</a>\r\n"
					+ "</li>\n");
		}
		else {
			pageBar.append("<li class=\"page-item\">\r\n"
					+ "\t<a class=\"page-link\" href=\"javascript:paging(" + (pageNo - 1) +")\">Previous</a>\r\n"
					+ "</li>\n");
		}
		
		//페이지 No 영역
		while(pageNo <= pageEnd && pageNo <= totalPage) {
			//현재페이지인 경우,링크 비활성화
			if(pageNo == cPage) {
				pageBar.append("<li class=\"page-item active\"><a class=\"page-link\" href=\"#\">" + pageNo + "</a></li>\n");				
			}
			else {
				pageBar.append("<li class=\"page-item\"><a class=\"page-link\" href=\"javascript:paging(" + pageNo + ")\">" + pageNo + "</a></li>\n");
			}
			pageNo++;			
		}
		
		//다음 영역
		if(pageNo > totalPage) {
			pageBar.append("<li class=\"page-item disabled\">\r\n"
					+ "\t<a class=\"page-link\" href=\"#\">Next</a>\r\n"
					+ "</li>\n");
			
		}
		else {
			pageBar.append("<li class=\"page-item\">\r\n"
					+ "\t<a class=\"page-link\" href=\"javascript:paging(" + pageNo +")\">Next</a>\r\n"
					+ "</li>\n");
		}
		
		pageBar.append("</ul></nav>\n");
		pageBar.append("<script>function paging(pageNo){ location.href = '" + url + "' + pageNo; }</script>");
		
		return pageBar.toString();
	}

	public static File getRenamedFile(String saveDirectory, String oldName) {
		File newFile = null;

		// 파일명 새로 부여 : 20210216_135645123_123.jpg : 연원일시분초_난수세자리.기본파일확장자
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS_");
		DecimalFormat df = new DecimalFormat("000"); // 세자리 숫자로 만들기, 자리가 비어있으면 0으로 채워줌

		// 확장자 가져오기
		String ext = "";

		int dot = oldName.lastIndexOf("."); // .의 위치를 찾음
		if (dot > -1)
			ext = oldName.substring(dot); // .jpg 가 담겨있음

		// 새로운 파일명
		String newName = sdf.format(new Date()) + df.format(Math.random() * 999) + ext; // 연월일시분초 + 난수세자리 + 파일확장자

		// 새로운 파일객체 경로 지정
		// java.io.File.File(String parent, String child)
		newFile = new File(saveDirectory, newName); // 부모 디렉토리 가져옴, 파일 생성자에 전달해주는 인자가 경로랑 파일명임
		// 존재하지 않는 파일객체를 바라보는 자바 객체가 됨.

		return newFile;
	}

}
