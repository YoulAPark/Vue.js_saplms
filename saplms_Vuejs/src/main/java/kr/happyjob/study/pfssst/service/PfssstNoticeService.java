package kr.happyjob.study.pfssst.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.pfssst.model.PfssstNoticeModel;

public interface PfssstNoticeService {

	// 공지사항 리스트 조회
	public List<PfssstNoticeModel> noticeList(Map<String, Object> paramMap)throws Exception ;
	
	// 공지사항 목록 카운트 조회
	public int noticeCnt(Map<String, Object> paramMap)throws Exception ;
	
	// 공지사항 단건 조회
	public PfssstNoticeModel noticeDetail(Map<String, Object> paramMap)throws Exception ;
	
	
}
