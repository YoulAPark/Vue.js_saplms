package kr.happyjob.study.admstat.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.admstat.model.AdmstatLecCntModel;

public interface AdmstatLecCntService {
	/**  목록 조회 */
	public List<AdmstatLecCntModel> listLecCnt(Map<String, Object> paramMap) throws Exception;
	public int searchlistcnt(Map<String, Object> paramMap) throws Exception;
	
	public AdmstatLecCntModel listLecCntchart(Map<String, Object> paramMap) throws Exception;
}
