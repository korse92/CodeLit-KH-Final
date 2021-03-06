package com.kh.codelit.teacher.controller;

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
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.servletapi.SecurityContextHolderAwareRequestWrapper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.google.gson.Gson;
import com.kh.codelit.attachment.model.exception.AttachmentException;
import com.kh.codelit.attachment.model.vo.Attachment;
import com.kh.codelit.common.HelloSpringUtils;
import com.kh.codelit.lecture.model.service.LectureService;
import com.kh.codelit.lecture.model.vo.Lecture;
import com.kh.codelit.lecture.model.vo.LectureChapter;
import com.kh.codelit.lecture.model.vo.LecturePart;
import com.kh.codelit.lecture.model.vo.StreamingDate;
import com.kh.codelit.member.model.service.MemberService;
import com.kh.codelit.member.model.vo.Member;
import com.kh.codelit.teacher.model.service.TeacherService;
import com.kh.codelit.teacher.model.vo.Teacher;
import com.kh.codelit.websocket.model.service.MessengerService;
import com.kh.codelit.websocket.model.vo.Messenger;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/teacher")
public class TeacherController {

	@Autowired
	private TeacherService teacherService;

	@Autowired
	private LectureService lectureService;

	@Autowired
	private MemberService memberService;

	@Autowired
	private MessengerService msgService;

	@GetMapping("/teacherRequest.do")
	public ModelAndView teacherRequest(Authentication authentication, ModelAndView mav) {
		log.debug("???????????? ?????? {}", "???????????? ?????? ??????");

		try {
			Member loginMember = (Member) authentication.getPrincipal();
			log.debug("loginMember = {}", loginMember);
			mav.addObject("loginMember", loginMember);

			List<Map<String, Object>> list = lectureService.selectCategoryListInstance();
			mav.addObject("catList", list);

			mav.setViewName("teacher/teacherRequest");
		} catch (Exception e) {
			throw e;
		}

		return mav;
	}

	@PostMapping("/teacherRequest.do")
	public ModelAndView teacherRequest(
				@ModelAttribute Teacher teacher,
				@RequestParam(value = "upFile", required = false) MultipartFile upFile, 
				ModelAndView mav,
				HttpServletRequest request, 
				Authentication authentication
			) {

		int result = 0;
		String msg = null;
		log.debug("{}", "???????????? ????????? ??????");

		try {

			// 0. ?????? ??????
			// ????????????
			// pageContext - request - session - application?????? app??? servletContext??????.
			// ????????? ????????? ??? /??? src/main/webapp??? ?????????. (???????????? ??????)
			String saveDirectory = request.getServletContext().getRealPath("/resources/upload/member");

			// File??? ????????? ????????? ???????????? ?????? ?????????, ???????????? ?????? ?????? ????????? ??? ??????. (?????????)
			File dir = new File(saveDirectory);
			if (!dir.exists()) {
				dir.mkdirs(); // ????????? ?????? ?????? ?????? (???????????? ????????? ??? ????????????)
			}

			if(upFile.isEmpty()) {

				result = teacherService.insertTeacherRequest(teacher);

			} else {

				// ????????? ???????????? ?????? ?????? ????????? ???????????? ??? ??? ??????.
				Member member = memberService.selectOneMember(teacher.getRefMemberId());
				String oldFilePath = request.getServletContext()
						.getRealPath("/resources/upload/member/" + member.getMemberReProfile());

				File oldFile = new File(oldFilePath);

				// ?????????????????? ??????
				File renamedFile = HelloSpringUtils.getRenamedFile(saveDirectory, upFile.getOriginalFilename());

				log.debug("upFile = {}", upFile);
				log.debug("renamedFile = {}", renamedFile);

				// ????????????????????? ????????? ?????? ????????? ??????
				Map<String, String> map = new HashMap<>();
				map.put("memberProfile", upFile.getOriginalFilename());
				map.put("memberReProfile", renamedFile.getName());
				map.put("id", teacher.getRefMemberId());

				// ?????? ?????? ??? ??????????????? ?????? ?????????
				result = teacherService.insertTeacherRequest(teacher, map);

				if (oldFile.isFile()) {
					log.debug("oldFile not null = {}", oldFile);
					oldFile.delete(); // ?????? ?????? ??????					
				}
				upFile.transferTo(renamedFile); // ???????????? ?????????????????? ????????? ????????? ????????????.

				// authentication??? ?????? ?????? ?????? ??????
				member.setMemberProfile(upFile.getOriginalFilename());
				member.setMemberReProfile(renamedFile.getName());

				Authentication newAuthentication = new UsernamePasswordAuthenticationToken(member,
						authentication.getCredentials(), authentication.getAuthorities());
				SecurityContextHolder.getContext().setAuthentication(newAuthentication);

				log.debug("???????????? ??? ????????? ????????? ?????? = {}", ((Member) newAuthentication.getPrincipal()).getMemberProfile());

			} // upfile.isEmpty()

			msg = "?????????????????????";

		} catch (IOException | IllegalStateException e) {
			log.error("?????? ?????? ???????????? ??????", e);
			throw new RuntimeException("???????????? ???????????? ?????? ??????");
		} catch (Exception e) {
			msg = "????????? ??????????????????.";
			throw e;
		}

		FlashMap flashMap = RequestContextUtils.getOutputFlashMap(request);
		flashMap.put("msg", msg);

		mav.setViewName("redirect:/");

		return mav;
	}

	@GetMapping("/teacherDetail.do")
	public void detail(Model model, Principal pri ,Member member ) {

		String refMemberId = pri.getName();
		model.addAttribute("refMemberId", refMemberId);

		Teacher teacher = teacherService.selectOne(refMemberId);
		model.addAttribute("teacher", teacher);
		log.debug("teacher = {}", teacher);

	}

	@PostMapping("/teacherUpdate.do")
	public ModelAndView teacherUpdate(@ModelAttribute Teacher teacher,
			@RequestParam(value = "upFile", required = false) MultipartFile upFile, ModelAndView mav,
			HttpServletRequest request, Authentication authentication) {

		int result = 0;
		String msg = null;

		try {

			// 0. ?????? ??????
			// ????????????
			// pageContext - request - session - application?????? app??? servletContext??????.
			// ????????? ????????? ??? /??? src/main/webapp??? ?????????. (???????????? ??????)
			String saveDirectory = request.getServletContext().getRealPath("/resources/upload/member");

			// File??? ????????? ????????? ???????????? ?????? ?????????, ???????????? ?????? ?????? ????????? ??? ??????. (?????????)
			File dir = new File(saveDirectory);
			if (!dir.exists()) {
				dir.mkdirs(); // ????????? ?????? ?????? ?????? (???????????? ????????? ??? ????????????)
			}

			if (upFile.isEmpty()) {

				result = teacherService.updateModify(teacher);

			} else {

				// ????????? ???????????? ?????? ?????? ????????? ???????????? ??? ??? ??????.
				Member member = memberService.selectOneMember(teacher.getRefMemberId());
				String oldFilePath = request.getServletContext()
						.getRealPath("/resources/upload/member/" + member.getMemberReProfile());
				log.debug("?????????????????? = {}", oldFilePath);
				File oldFile = new File(oldFilePath);

				// ?????????????????? ??????
				File renamedFile = HelloSpringUtils.getRenamedFile(saveDirectory, upFile.getOriginalFilename());

				log.debug("upFile = {}", upFile);
				log.debug("renamedFile = {}", renamedFile);

				// ????????????????????? ????????? ?????? ????????? ??????
				Map<String, String> map = new HashMap<>();
				map.put("memberProfile", upFile.getOriginalFilename());
				map.put("memberReProfile", renamedFile.getName());
				map.put("id", teacher.getRefMemberId());

				// ?????? ?????? ??? ??????????????? ?????? ?????????
				result = teacherService.selectUpdate(teacher, map);

				if (oldFile != null)
					oldFile.delete(); // ?????? ?????? ??????
				upFile.transferTo(renamedFile); // ???????????? ?????????????????? ????????? ????????? ????????????.

				// authentication??? ?????? ?????? ?????? ??????
				member.setMemberProfile(upFile.getOriginalFilename());
				member.setMemberReProfile(renamedFile.getName());

				Authentication newAuthentication = new UsernamePasswordAuthenticationToken(member,
						authentication.getCredentials(), authentication.getAuthorities());
				SecurityContextHolder.getContext().setAuthentication(newAuthentication);

				log.debug("???????????? ??? ????????? ????????? ?????? = {}", ((Member) authentication.getPrincipal()).getMemberProfile());

			} // upfile.isEmpty()



		} catch (IOException | IllegalStateException e) {
			log.error("?????? ?????? ???????????? ??????", e);
			throw new RuntimeException("???????????? ???????????? ?????? ??????");
		} catch (Exception e) {
			msg = "????????? ??????????????????.";
			throw e;
		}

		FlashMap flashMap = RequestContextUtils.getOutputFlashMap(request);
		flashMap.put("msg", msg);

		mav.setViewName("/teacher/teacherProfile");

		return mav;
	}
	


	@GetMapping("/lectureCalList.do")
	public String calList() {
		return null;
	}

	@GetMapping("/teacherProfile.do")
	public ModelAndView myProfile(SecurityContextHolderAwareRequestWrapper requestWrapper, ModelAndView mav,
			Authentication authentication, Principal principal) {
		try {
			UserDetails userDetails = (UserDetails) authentication.getPrincipal();
			String memberId = ((Member) userDetails).getMemberId();
			String refMemberId = principal.getName();

			List<Lecture> list = lectureService.teacherProfileLecture(memberId);
			List<Messenger> msgList = msgService.alarmListMyprofile(memberId);
			Member member = memberService.selectOneMember(memberId);
			List<StreamingDate> streamingDateList = memberService.selectStreamingDateList(refMemberId);

			mav.addObject("member",member);
			mav.addObject("list", list);
			mav.addObject("message",msgList);
			mav.addObject("streamingDateList", streamingDateList);
			mav.setViewName("/teacher/teacherProfile");

		} catch (Exception e) {
			throw e;
		}

		return mav;

	}










}


