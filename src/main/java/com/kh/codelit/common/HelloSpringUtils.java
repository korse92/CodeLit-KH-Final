package com.kh.codelit.common;

import java.io.File;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class HelloSpringUtils {
	
	/**
	 * totalPage 전체 페이지 수    올림(114 / 10) 114 = totalContents, 10 = numPerPage
	 * pageBarSize 페이지바의 페이지 수
	 * pageStart ~ pageEnd 페이지 바 범위
	 * pageNo 증감변수
	 * 
	 * < 1 2 3 4 5 > : 이전버튼 비활성화
	 * < 6 7 8 9 10 >
	 * < 11 12 >  : 다음버튼 비활성화
	 * 
	 */
	public static String getPageBar(int totalContents, int cPage, int numPerPage, String url) {
		StringBuilder pageBar = new StringBuilder();
		
		int pageBarSize = 5;
		int totalPage = (int)Math.ceil((double)totalContents / numPerPage); //올림처리
		
		
		// ? :경로와 사용자 입력값 사이
		// & :사용자 입력값 사이는 &로 연결
		
		// /spring/board/boardList?cPage=
		url = url + (url.indexOf("?") > -1 ? "&" : "?") + "cPage=";
		 				//사용자입력값 있는경우는 & 아니면 ?
		/**
		*   현재 url은 String형 -> String 클래스의 indexIF 메소드 사용.
		*	indexOf() 메서드는 호출한 String 객체(문자열)에서 주어진 값과 일치하는 첫 번째 인덱스를 반환.  일치하는 값이 없으면 -1을 반환
		*   indexOf로 검사시 ? 의  위치가 나오는데 위치는 무조건 0보다 같거나 크다
		*   맨왼쪽에 있으면 0이고 1씩 늘어난다 -> 없으면 -1을 리턴한다
		*/	
		
	//		url이 String형인데,
	//		String 클래스에 indexOf 메소드가 있거든요. 그래서 모든 문자열에 대고 indexOf 메소드를 쓸 수 있는거고,,
	//		그래서 url.indexOf("?") 일케 쓸 수 있는데, 여기 매개인자로 넣어준게 uri에 있는지 찾아주는거고, 있으면 어디 위치에 있는지 그 위치(index)를 리턴해서 줘요.
	//  ?가 없으면 -1를 리턴하고, uri의 맨 첫 번째 글자가 ?라 치면 0을 리턴하는 식. 두 번째 글자가 ?면 1 리턴이고...
	//		따라서 존재하면 무조건 -1보다 큰 값을 리턴하기 때문에, &를 넣어주는거고, 아니면 ?를 넣어주는거
	//	
		
		// 1 2 3 4 5 : 현재페이지에 상관없이 시작은 (pageStart)1, 끝은(pageEnd) 5
		// 6 7 8 9 10 : 현재페이지에 상관없이 시작은(pageStart) 6, 끝은(pageEnd) 10
		//페이지바의 시작과 끝 번호
		int pageStart = ((cPage - 1) / pageBarSize) * pageBarSize + 1;
		int pageEnd = pageStart + pageBarSize - 1;
	
		//증감변수
		int pageNo = pageStart;
		
		pageBar.append("<nav><ul class=\"pagination justify-content-center pagination-sm\">\n");
		
		//이전 영역
		if(pageNo == 1) {
			pageBar.append("<li class=\"page-item disabled\">\r\n" + 
					"      <a class=\"page-link\" href=\"#\" tabindex=\"-1\">&laquo;</a>\r\n" + 
					"    </li>\n");
		}
		else {
			pageBar.append("<li class=\"page-item\">\r\n" + 
					"      <a class=\"page-link\" href=\"javascript:paging(" + (pageNo - 1) + ")\" tabindex=\"-1\">&laquo;</a>\r\n" + 
					"    </li>\n");
		}
		
		//페이지 No 영역
		while(pageNo <= pageEnd && pageNo <= totalPage) {
			//현재페이지인 경우, 링크비활성화
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
			pageBar.append("<li class=\"page-item\">\r\n" + 
					"      <a class=\"page-link\" href=\"#\">&raquo;</a>\r\n" + 
					"    </li>\n");
		}
		else {
			pageBar.append("<li class=\"page-item\">\r\n" + 
					"      <a class=\"page-link\" href=\"javascript:paging(" + pageNo + ")\">&raquo;</a>\r\n" + 
					"    </li>\n");
		}
		
		pageBar.append("</ul></nav>\n");
		pageBar.append("<script>function paging(pageNo){ location.href = '" + url + "' + pageNo; }</script>");
		
		return pageBar.toString();

	}

	public static File getRenamedFile(String saveDirectory, String oldName) {
		File newFile = null;
		
		
		//파일명 새로 부여 : 20210216_135645123_123.jpg : 연원일시분초_난수세자리.기본파일확장자
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS_");
		DecimalFormat df = new DecimalFormat("000");  //세자리 숫자로 만들기, 자리가 비어있으면 0으로 채워줌
		
		//확장자 가져오기
		String ext = "";
		
		int dot = oldName.lastIndexOf("."); // .의 위치를 찾음
		if(dot > -1)
			ext = oldName.substring(dot);  // .jpg 가 담겨있음
		
		//새로운 파일명
		String newName = 
				sdf.format(new Date()) +  df.format(Math.random() * 999) + ext; // 연월일시분초 + 난수세자리 + 파일확장자
		
		//새로운 파일객체 경로 지정
		//java.io.File.File(String parent, String child)
		newFile = new File(saveDirectory, newName); // 부모 디렉토리 가져옴, 파일 생성자에 전달해주는 인자가 경로랑 파일명임
		//존재하지 않는 파일객체를 바라보는 자바 객체가 됨.
		
		return newFile;
	}

}
