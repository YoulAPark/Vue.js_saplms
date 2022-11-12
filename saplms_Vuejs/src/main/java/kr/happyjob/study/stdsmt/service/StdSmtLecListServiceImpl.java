package kr.happyjob.study.stdsmt.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.stdsmt.dao.StdSmtLecListDao;
import kr.happyjob.study.stdsmt.model.StdSmtLecListVo;



@Service
public class StdSmtLecListServiceImpl implements StdSmtLecListService{
	@Autowired
	StdSmtLecListDao stdSmtLecListDao;

	// 수강목록리스트
	@Override
	public List<StdSmtLecListVo> LecList(Map<String, Object> paramMap) throws Exception {
		//List<LecModel> LecList = stdsmtDao.listLec(paramMap);
		List<StdSmtLecListVo> LecListVo = stdSmtLecListDao.LecList(paramMap);
		
		return LecListVo;
	}
	//수강목록 데이터 건수
	@Override
	public int LecListCnt(Map<String, Object> paramMap) throws Exception {
		int LecListCnt = stdSmtLecListDao.LecListCnt(paramMap);
		return LecListCnt;
	}
	//모달 Ajax콜백
	@Override
	public StdSmtLecListVo selectLecList(Map<String, Object> paramMap) throws Exception {
		StdSmtLecListVo selectLecList = stdSmtLecListDao.selectLecList(paramMap);
		return selectLecList;
	}
	
	
	
	

}
