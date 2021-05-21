package com.kh.codelit.counsel.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.codelit.attachment.model.dao.AttachDao;
import com.kh.codelit.attachment.model.vo.Attachment;
import com.kh.codelit.counsel.model.dao.CounselDao;
import com.kh.codelit.counsel.model.vo.Counsel;

import lombok.extern.slf4j.Slf4j;



@Service
@Slf4j
public class CounselServiceImpl implements CounselService{
		
	@Autowired
	private CounselDao dao;
	
	@Autowired
	private AttachDao attachDao;

	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertCounsel(Map<String, Object> param) {
		
		Counsel counsel = (Counsel)param.get("counsel");
		int counselNo = dao.insertCounsel(counsel);
				
		Attachment attach = (Attachment)param.get("attach");
		attach.setRefContentsNo(counsel.getCounselQNo());
		int result = attachDao.insertAttachment(attach);
		
		return result;
	}
	@Override
	public List<Counsel> selectCounselList(Map<String, Object> param){
		return dao.selectCounselList(param);
	}
	@Override
	public int getTotalContents(String memberId) {
		return dao.getTotalContents(memberId);
	}
	
	@Override
	public Map<String, Object> selectOneCounsel(int counselNo) {
		
		Counsel counsel = dao.selectOneCounsel(counselNo);
		
		// 답글여부에 대한 확인용으로 변수 임시사용 (0=답글없음, 1=답글있음)
		int result = dao.selectAnswerBool(counselNo);
		counsel.setCounselQNo(result);
				
		List<Attachment> attachList = attachDao.selectAttachment(counselNo);
		
		Map<String, Object> map = new HashMap<>();
		map.put("counsel", counsel);
		map.put("attach", attachList.get(0) != null ? attachList.get(0) : null);
		
		return map;
	}
	@Override
	public List<Counsel> selectCounselListAdmin(Map<String, Object> param) {

		return dao.selectCounselListAdmin(param);
	}
}
