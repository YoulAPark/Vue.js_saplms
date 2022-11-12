package kr.happyjob.study.stdsst.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.stdsst.model.StdsstNoticeModel;
import kr.happyjob.study.system.model.NoticeModel;

public interface StdsstNoticeDao {
	
	// 공지사항 리스트 조회
		public List<StdsstNoticeModel> noticeList(Map<String, Object> paramMap)throws Exception ;

	// 공지사항 개수
		public int noticeCnt2(Map<String, Object> paramMap)throws Exception ;
		
	// 공지사항 상세	
		public StdsstNoticeModel noticeDetail(Map<String, Object> paramMap) throws Exception;

	// 공지사항 클릭시 조회수 1 증가	
		public void updateCnt(Map<String, Object> paramMap)throws Exception;
}
