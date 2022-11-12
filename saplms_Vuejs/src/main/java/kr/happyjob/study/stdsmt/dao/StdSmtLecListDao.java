package kr.happyjob.study.stdsmt.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.stdsmt.model.StdSmtLecListVo;

public interface StdSmtLecListDao {
	
	//수강목록 리스트 LecList 가 쿼리문 ID가 됌.
	public List<StdSmtLecListVo> LecList(Map<String, Object> paramMap);

	//수강목록 데이터 건수
	public int LecListCnt(Map<String, Object> paramMap);
	//모달 Ajax콜백
	public StdSmtLecListVo selectLecList(Map<String, Object> paramMap);
}
