package kr.happyjob.study.stdsst.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.stdsst.dao.StdsstNoticeDao;
import kr.happyjob.study.stdsst.model.StdsstNoticeModel;
import kr.happyjob.study.system.dao.NoticeDao;
import kr.happyjob.study.system.model.NoticeModel;



@Service
public class StdsstNoticeServiceImpl implements StdsstNoticeService{

	@Autowired
	StdsstNoticeDao noticeDao;
	
	@Override//공지사항 출력
	public List<StdsstNoticeModel> getNoticeList(Map<String, Object> paramMap) throws Exception {
		List<StdsstNoticeModel> noticeList=noticeDao.noticeList(paramMap);
		return noticeList;
	}

	@Override
	public int getNoticeCnt(Map<String, Object> paramMap) throws Exception {
		int total=noticeDao.noticeCnt2(paramMap);
		return total;
	}

	@Override
	public StdsstNoticeModel noticeDetail(Map<String, Object> paramMap) throws Exception {
		
		StdsstNoticeModel noticeModel = noticeDao.noticeDetail(paramMap);
		return noticeModel;
	}

	@Override
	public void updateCnt(Map<String, Object> paramMap) throws Exception {
		noticeDao.updateCnt(paramMap);
		
	}



	
	

}
