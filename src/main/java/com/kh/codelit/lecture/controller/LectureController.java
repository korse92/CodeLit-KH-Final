package com.kh.codelit.lecture.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.kh.codelit.attachment.model.exception.AttachmentException;
import com.kh.codelit.attachment.model.vo.Attachment;
import com.kh.codelit.common.HelloSpringUtils;
import com.kh.codelit.lecture.model.exception.LectureException;
import com.kh.codelit.lecture.model.service.LectureService;
import com.kh.codelit.lecture.model.vo.Lecture;
import com.kh.codelit.lecture.model.vo.LectureChapter;
import com.kh.codelit.lecture.model.vo.LectureComment;
import com.kh.codelit.lecture.model.vo.LecturePart;
import com.kh.codelit.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;



@Slf4j
@Controller
@RequestMapping("/lecture")
public class LectureController {

	@Autowired
	private LectureService lectureService;

	@GetMapping("/lectureEnroll.do")
	public void lectureEnroll() {
	}

	@PostMapping("/lectureEnroll.do")
	public String lectureEnroll(
			@ModelAttribute Lecture lecture,
			@RequestParam(required = false) MultipartFile lectureThumbnail,
			@RequestParam(value = "lectureHandout", required = false) MultipartFile[] lectureHandouts,
			@RequestParam String curriculum,
			@RequestParam(value = "chapterVideo", required = false) MultipartFile[] chapterVideos,
			@RequestParam(value = "videoChapNoArr", required = false) String videoChapNoArrJsonStr,
			@RequestParam(required = false) String streamingDates,
			HttpServletRequest request,
			Authentication authentication,
			RedirectAttributes redirectAttr) {

		try {
			//0. ????????? ??????
			log.debug("lecture(????????? Set ???) = {}", lecture);

			Gson gson = new Gson();

			LecturePart[] lecturePartArr = gson.fromJson(curriculum, LecturePart[].class);
			log.debug("lecturePartArr = {}", lecturePartArr);

			int[] videoChapNoArr = gson.fromJson(videoChapNoArrJsonStr, int[].class);
			List<Integer> videoChapNoList = Arrays.stream(videoChapNoArr).boxed().collect(Collectors.toList());
			log.debug("videoChapNoArr = {}", videoChapNoArr);
			log.debug("videoChapNoList = {}", videoChapNoList);

			//List<StreamingDate> streamingDateList = new ArrayList<>();
			Map<String, Object>[] streamingDateArr = null;

			if("S".equals(lecture.getLectureType())) {
				log.debug("streamingDates = {}", streamingDates);
				streamingDateArr = gson.fromJson(streamingDates, Map[].class);

				log.debug("streamingDateArr = {}", streamingDateArr);

//				for(Map<String, String> date : streamingDateArr) {
//					log.debug("date = {}", date);
//					StreamingDate streamingDate = new StreamingDate();
//					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//					streamingDate.setStreamingTitle(date.get("title"));
//					streamingDate.setStreamingStartDate(sdf.parse(date.get("start")));
//					streamingDate.setStreamingEndDate(sdf.parse(date.get("end")));
//
//					streamingDateList.add(streamingDate);
//				}
//				log.debug("streamingDateList = {}", streamingDateList);
			}

			//0.?????? ?????? ??? Attachment?????? ??????/????????? Filename Set
			String thumbnailsSaveDirectory =
					request.getServletContext().getRealPath(Attachment.PATH_LECTURE_THUMBNAIL);
			String handoutsSaveDirectory =
					request.getServletContext().getRealPath(Attachment.PATH_LECTURE_HANDOUT);
			String videosSaveDirectory =
					request.getServletContext().getRealPath(Attachment.PATH_LECTURE_VIDEO);

			File dirThumb = new File(thumbnailsSaveDirectory);
			if(!dirThumb.exists()) {
				dirThumb.mkdirs(); // ????????? ?????? ?????? ?????? (???????????? ????????? ??? ????????????)
			}

			File dirHandout = new File(handoutsSaveDirectory);
			if(!dirHandout.exists()) {
				dirHandout.mkdirs(); // ????????? ?????? ?????? ?????? (???????????? ????????? ??? ????????????)
			}

			File dirVideo = new File(videosSaveDirectory);
			if(!dirVideo.exists()) {
				dirVideo.mkdirs();
			}

			if(!lectureThumbnail.isEmpty() || !(lectureThumbnail.getSize() == 0)) {
				log.debug("lectureThumbnail = {}", lectureThumbnail);
				log.debug("lectureThumbnail.name = {}", lectureThumbnail.getOriginalFilename());
				log.debug("lectureThumbnail.size = {}", lectureThumbnail.getSize());

				//????????? ????????? ??????
				File renamedFile = HelloSpringUtils.getRenamedFile(thumbnailsSaveDirectory, lectureThumbnail.getOriginalFilename());
				//?????? ??????
				lectureThumbnail.transferTo(renamedFile);

				lecture.setLectureThumbOrigin(lectureThumbnail.getOriginalFilename());
				lecture.setLectureThumbRenamed(renamedFile.getName());
			}

			List<Attachment> attachList = new ArrayList<>();

			for(MultipartFile lectureHandout : lectureHandouts) {
				if(lectureHandout.isEmpty() || lectureHandout.getSize() == 0)
					continue;

				log.debug("lectureHandout = {}", lectureHandouts);
				log.debug("lectureHandout.name = {}", lectureHandout.getOriginalFilename());
				log.debug("lectureHandout.size = {}", lectureHandout.getSize());

				//????????? ????????? ??????
				File renamedFile = HelloSpringUtils.getRenamedFile(handoutsSaveDirectory, lectureHandout.getOriginalFilename());
				//?????? ??????
				lectureHandout.transferTo(renamedFile);
				//Attachment?????? ??????
				Attachment attach = new Attachment();
				attach.setOriginalFilename(lectureHandout.getOriginalFilename());
				attach.setRenamedFilename(renamedFile.getName());
				attach.setRefContentsGroupCode(Attachment.CODE_LECTURE_HANDOUT);

				attachList.add(attach);
			}

			int vIdx = 0;
			int prevChapterArrlength = 0;
			for(int i = 0; i < lecturePartArr.length; i++) {
				log.debug("lecturePart[{}] = {}", i, lecturePartArr[i]);

				//?????? 1: ?????? 1~3 012
				//?????? 2: ?????? 1~3 012
				//?????? 3: ?????? 1~3 012
				//videoChapNoArr = [0, 2, 7, 8]

				LectureChapter[] lectureChapterArr = lecturePartArr[i].getChapterArr();
				int ChapterArrlength = lectureChapterArr.length;

				if(i > 0)
					prevChapterArrlength += lecturePartArr[i-1].getChapterArr().length;

				for(int j = 0; j < ChapterArrlength; j++) {
					//??????3 ????????? : prev : 6 + ?????? 012

					//????????? : 6+0 = 6;
					if(videoChapNoList.contains(prevChapterArrlength + j)) {
						while(chapterVideos[vIdx].isEmpty() || chapterVideos[vIdx].getSize() == 0) {
							vIdx++;
						}

						//log.debug("vIdx = {}", vIdx);

						MultipartFile currentChapterVideo = chapterVideos[vIdx++];
						log.debug("currentChapterVideo = {}", currentChapterVideo);
						log.debug("currentChapterVideo.name = {}", currentChapterVideo.getOriginalFilename());
						log.debug("currentChapterVideo.size = {}", currentChapterVideo.getSize());

						File renamedFile = HelloSpringUtils.getRenamedFile(videosSaveDirectory, currentChapterVideo.getOriginalFilename());
						currentChapterVideo.transferTo(renamedFile);

						lectureChapterArr[j].setLecChapterVideo(currentChapterVideo.getOriginalFilename());
						lectureChapterArr[j].setLecChapterReVideo(renamedFile.getName());
					}
					log.debug("lectureChapter[{}] = {}", j, lectureChapterArr[j]);
				}
			}

			//1. ????????????
			lecture.setAttachList(attachList);
			lecture.setRefMemberId(((Member)authentication.getPrincipal()).getMemberId());

			Map<String, Object> param = new HashMap<>();
			param.put("lecture", lecture);
			param.put("lecturePartArr", lecturePartArr);
			//param.put("streamingDateList", streamingDateList);
			param.put("streamingDateArr", streamingDateArr);

			log.debug("lecture(????????? Set ???) = {}", lecture);

			int result = lectureService.insertLecture(param);

			//2. ????????? ?????????
			String msg = result > 0 ? "?????? ?????? ??????!" : "?????? ?????? ??????!";
			redirectAttr.addFlashAttribute("msg", msg);

		} catch (IOException | IllegalStateException e) {
			log.error("???????????? ?????? ??????!", e);
			throw new AttachmentException("???????????? ?????? ??????!"); //Checked Exception??? throw??? ?????? ????????? ?????????, ????????? ?????? ????????? ????????? ????????????.
		} catch (Exception e) {
			log.error("?????? ?????? ??????!", e);
			throw new LectureException("???????????? ??????!");
		}

		return "redirect:/lecture/lectureEnroll.do";
	}

	@GetMapping(value = {"/lectureList.do/{catNo}", "/lectureList.do"})
	public String lectureList(
			@PathVariable(required = false) Integer catNo,
			@RequestParam(defaultValue = "1") int cPage,
			@RequestParam(required = false) String searchKeyword,
			HttpServletRequest request,
			Model model,
			Principal principal) {
		//1. ????????? ?????????
		if(catNo == null)
			catNo = 0;
		int numPerPage = 12;
		String memberId = principal != null ? principal.getName() : null;
		log.debug("catNo = {}", catNo);
		log.debug("cPage = {}", cPage);
		log.debug("memberId = {}", memberId);

		Map<String, Object> param = new HashMap<>();
		param.put("numPerPage", numPerPage);
		param.put("cPage", cPage);
		param.put("catNo", catNo);
		param.put("memberId", memberId);
		param.put("searchKeyword", searchKeyword);

		//2. ????????????
		//a. contents??????
		List<Lecture> list = lectureService.selectLectureList(param);
		List<Object> orderedlectureNoList = lectureService.selectOrderedLectureList(memberId);
		log.debug("list = {}", list);
		log.debug("orderedlectureNoList = {}", orderedlectureNoList);

		//b. pageBar??????
		int totalContents = lectureService.getTotalContents(param);
		String url = HelloSpringUtils.convertToParamUrl(request);
		log.debug("totalContents = {}", totalContents);
		log.debug("url = {}", url);
		String pageBar = HelloSpringUtils.getPageBar(totalContents, cPage, numPerPage, url);

		//3.jsp ????????????
		model.addAttribute("list", list);
		model.addAttribute("orderedlectureNoList", orderedlectureNoList);
		model.addAttribute("pageBar", pageBar);

		return "lecture/lectureList";
	}

	@GetMapping("/lectureDetail.do")
	public ModelAndView lectureDetail(HttpServletRequest request,
									  @RequestParam int no,
									  ModelAndView mav,
									  Authentication authentication) {
		//1. ????????????
		Map<String, Object> param = new HashMap<>();
		param.put("no", no);
		String memberId = null;

		if(authentication != null) {
			// ????????? ??????
			Member loginMember = (Member)authentication.getPrincipal();
			log.debug("loginMember id = {}", loginMember);
			memberId = loginMember.getMemberId();

			//map????????? ????????????
			param.put("refMemberId", memberId);
			log.debug("param = {}", param);

			//??????id ?????? ?????????
			int clickCount = lectureService.clickCount(param);
			log.debug("clickCountresult = {}", clickCount);
		}

		Lecture lecture = lectureService.selectOneLecture(param);
		lecture.setLectureCommentList(lectureService.selectLectureCmtList(no));

		List<Object> orderedlectureNoList = lectureService.selectOrderedLectureList(memberId);
		log.debug("orderedlectureNoList = {}", orderedlectureNoList);
		int numPerCmtPage = 5;
		int totalCmtPage = (int)Math.ceil((double)lecture.getLectureCommentList().size() / numPerCmtPage);
		log.debug("lecture = {}", lecture);
		log.debug("totalCmtPage = {}", totalCmtPage);

		//2. jsp ??????
		mav.addObject("lecture", lecture);
		mav.addObject("numPerCmtPage", numPerCmtPage);
		mav.addObject("totalCmtPage", totalCmtPage);
		mav.addObject("orderedlectureNoList", orderedlectureNoList);
		mav.addObject("memberId", memberId);
		mav.setViewName("lecture/lectureDetail");

		return mav;
	}


	@GetMapping("/mainSearchResult.do")
	public ModelAndView mainSearchResult(
									ModelAndView mav,
									@RequestParam(required = false) String keyword,
									HttpServletRequest request,
									Principal principal
		)
	{

		//log.debug("?????? ?????? ???????????? ?????? ???@searchKeyword = {}", keyword);

	try {
		String memberId = principal != null ? principal.getName() : null;
		log.debug("result-memberId = {}", memberId);

		Map<String, Object> param = new HashMap<>();
		param.put("searchKeyword", keyword);
		param.put("memberId", memberId);
		log.debug("param = {}", param);

		List<Map<String, Object>> list = lectureService.mainSearchResult(param);
		log.debug("mainSearchResult@list = {}", list);
		List<Object> orderedlectureList = lectureService.selectOrderedLectureList(memberId);
		log.debug("orderedlectureList = {}", orderedlectureList);

		mav.addObject("list",list);
		mav.addObject("orderedlectureList", orderedlectureList);
		mav.setViewName("/lecture/mainSearchResult");
	}catch(Exception e) {
		throw e;
	}

		return mav;
	}



	@GetMapping("/lecture.do")
	public void lecture(
				// ??????????????? ?????????????????? ?????????. (?????????????????? ?????????, ??? ??????????????? -1 ??????)
				@RequestParam(required=true, value="lectureNo") int lectureNo,
				@RequestParam(defaultValue="-1") int chapterNo,
				Model model,
				Authentication authentication

			) {

		try {
			// ????????? ??????
			Member loginMember = (Member)authentication.getPrincipal();
			log.debug("loginMember = {}", loginMember);
			String refMemberId = loginMember.getMemberId();
			log.debug("loginMember id = {}", loginMember.getMemberId());


			// ????????????
			Map<String, Object> param = new HashMap<>();
			param.put("refMemberId", refMemberId);
			param.put("no", lectureNo);

			// ?????? ??????
			Lecture lecture = lectureService.selectOneLecture(param);

			if(!lecture.isEnrolled()) {
				throw new RuntimeException("?????? ?????? ????????? ????????????.");
			}

			// ??????????????? ?????????????????? ?????? (chapterNo, yn)
			List<Map<String, Object>> progList = lectureService.selectLectureProgress(param);

			log.debug("{}", lecture);
			log.debug("{}", progList);
			log.debug("partlist = {}", lecture.getPartList());

			int playPosition = 0;
			// ????????? ??????????????? ????????? yn ?????? ??????
			if(chapterNo == -1) {
				// ????????? ?????? ?????? ????????? : ??? ?????? ????????????
				playPosition = Integer.parseInt((progList.get(0).get("chapterNo")).toString());

				// ????????? ?????? ???????????? yn?????? ??????
				for(int i=1; i<progList.size(); i++) {
					// Y??? ?????? ?????? ????????? ??? ?????? ??? ?????? ????????? ?????? (?????? Y?????? ????????? ??????)
					if(!progList.get(i).get("yn").equals("Y")) {
						playPosition = Integer.parseInt((progList.get(i-1).get("chapterNo")).toString());
						break;
					}
				}
			} else {
				playPosition = chapterNo;
			}

			log.debug("????????? ?????? ?????? = {}", playPosition);
			// ??????????????? ?????? ?????? ?????? ????????????.
			String videoRename = lectureService.selectVideoRename(playPosition);

			// refMemberId, refLectureNo, chapterNo 3?????? ?????? ???????????????.
			param.put("chapterNo", playPosition);
			// ????????? ???????????? yn??? Y??? ?????????. (param?????? memberId, chapterNo ??????)
			int result = lectureService.updateProgress(param);

			for(Map<String, Object> prog : progList) {
				if(Integer.parseInt(prog.get("chapterNo").toString()) == playPosition) {
					prog.put("yn", "Y");
				}
			}


			model.addAttribute("lecture", lecture);
			model.addAttribute("progList", progList);
			// ?????? ???????????? ??? ???????????????
			model.addAttribute("playPosition", playPosition);
			model.addAttribute("videoRename", videoRename);

		} catch(Exception e) {
			throw e;

		}

	}



	@GetMapping("/myAllLecture.do")
	public ModelAndView myAllLecture(ModelAndView mav,
									 Authentication authentication,
									 HttpServletRequest request,
									 @RequestParam(defaultValue ="1") int cPage) {


		//???????????????
		int numPerPage = 10;

	try {
		// ????????? ??????
		Member loginTeacher = (Member)authentication.getPrincipal();
		log.debug("loginTeacher = {}", loginTeacher);
		loginTeacher.getMemberId();
		log.debug("loginTeacher.id = {}", loginTeacher.getMemberId());
		//loginTeacher.id = teacher

		Map<String, Object> param = new HashMap<>();
		param.put("cPage", cPage);
		param.put("numPerPage", numPerPage);
		param.put("teacherId", loginTeacher.getMemberId());
		log.debug("???????????? ??? ?????? ?????? param = {}", param);

		// b. pageBar ??????
		int totalContents = lectureService.getTeacherTotalContents(param);
		log.debug("????????? ?????? totalContents = {}", totalContents);
		List<Map<String,Object>> list = lectureService.myAllLecture(param);
		log.debug("list = {}", list);


		String url = HelloSpringUtils.convertToParamUrl(request);
		log.debug("url = {}", url);
		String pageBar = HelloSpringUtils.getPageBar(totalContents, cPage, numPerPage, url);
		log.debug("pageBar = {}", pageBar);

		mav.addObject("list",list);
		mav.addObject("pageBar",pageBar);
		mav.setViewName("/teacher/myAllLecture");

	}catch(Exception e) {
		throw e;
	}
		return mav;
	}

	@PostMapping("/cmtInsert.do")
	public String cmtInsert(@ModelAttribute LectureComment lecCmt, Principal principal, RedirectAttributes redirectAttr) {
		String memberId = principal.getName();
		lecCmt.setRefMemberId(memberId);

		int result = lectureService.cmtInsert(lecCmt);
		boolean reviewOpen = true;

		String msg = result > 0 ? "?????? ?????? ??????!" : "?????? ?????? ??????!";
		redirectAttr.addFlashAttribute("msg", msg);
		redirectAttr.addFlashAttribute("reviewOpen", reviewOpen);

		log.debug("refMemberId = {}", principal.getName());
		log.debug("lecCmt = {}", lecCmt);

		return "redirect:/lecture/lectureDetail.do?no=" + lecCmt.getRefLectureNo();
	}

	@PostMapping("/cmtUpdate.do")
	public String cmtUpdate(@ModelAttribute LectureComment lecCmt, RedirectAttributes redirectAttr) {
		int result = lectureService.cmtUpdate(lecCmt);
		boolean reviewOpen = true;
		String msg = result > 0 ? "?????? ?????? ??????" : "?????? ?????? ??????";

		redirectAttr.addFlashAttribute("msg", msg);
		redirectAttr.addFlashAttribute("reviewOpen", reviewOpen);

		return "redirect:/lecture/lectureDetail.do?no=" + lecCmt.getRefLectureNo();
	}


	@PostMapping("/reApplyLecture.do")
	public String reApplyLecture_(@RequestParam int lectureNo,
							   RedirectAttributes redirectAttr) {
		//log.debug("/reApplyLecture.do post?????? = {}", lectureNo);
		String msg = null;
	try {
		int result = lectureService.reApplyLecture(lectureNo);
		msg = "?????? ???????????? ?????????????????????";
	}catch(Exception e) {
		msg = "?????? ???????????? ?????????????????????";
		throw e;
	}
		redirectAttr.addFlashAttribute("msg", msg);
		return "redirect:/lecture/myAllLecture.do";
	}

}