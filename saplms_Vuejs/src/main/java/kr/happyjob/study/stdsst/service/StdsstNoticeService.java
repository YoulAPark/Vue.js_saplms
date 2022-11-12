package kr.happyjob.study.stdsst.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.stdsst.model.StdsstNoticeModel;
import kr.happyjob.study.system.model.ComnGrpCodModel;
import kr.happyjob.study.system.model.NoticeModel;

public interface StdsstNoticeService {
	
//	공지사항리스트 출력
	public List<StdsstNoticeModel> getNoticeList(Map<String, Object> paramMap) throws Exception;

//  공지사항 총 개수
	public int getNoticeCnt(Map<String, Object> paramMap) throws Exception;
	
//	공지사항 상세
	public StdsstNoticeModel noticeDetail(Map<String, Object> paramMap)throws Exception ;

	public void updateCnt(Map<String, Object> paramMap) throws Exception;
	
}
