package kr.happyjob.study.stdsmt.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.stdsmt.model.StdSmtLecListVo;


public interface StdSmtLecListService {
	
	//수강목록 리스트
	public List<StdSmtLecListVo> LecList(Map<String, Object> paramMap) throws Exception;
	//수강목록 데이터 건수
	public int LecListCnt(Map<String, Object> paramMap) throws Exception;
	//모달 Ajax콜백
	public StdSmtLecListVo selectLecList(Map<String, Object> paramMap) throws Exception;

}
