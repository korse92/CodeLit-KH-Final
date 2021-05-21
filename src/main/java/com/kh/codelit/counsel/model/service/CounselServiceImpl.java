package com.kh.codelit.counsel.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.kh.codelit.counsel.model.dao.CounselDao;
import com.kh.codelit.counsel.model.vo.Counsel;
import lombok.extern.slf4j.Slf4j;



@Service
@Slf4j
public class CounselServiceImpl implements CounselService{
		
	@Autowired
	private CounselDao dao;

	@Override
	public int insertCounsel(Counsel counsel) {
	
		return dao.insertCounsel(counsel);
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
	public Counsel selectOneCounsel(int counselNo) {
		
		Counsel counsel = dao.selectOneCounsel(counselNo);
		int result = dao.selectAnswerBool(counselNo);
		
		counsel.setCounselQNo(result);
				
		return counsel;
	}
}
