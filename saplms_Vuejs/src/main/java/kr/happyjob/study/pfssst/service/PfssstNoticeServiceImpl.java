package kr.happyjob.study.pfssst.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.pfssst.dao.PfssstNoticeDao;
import kr.happyjob.study.pfssst.model.PfssstNoticeModel;

@Service
public class PfssstNoticeServiceImpl implements PfssstNoticeService {

	@Autowired
	PfssstNoticeDao PfssstNoticeDao;

	@Override
	public List<PfssstNoticeModel> noticeList(Map<String, Object> paramMap) throws Exception{

		List<PfssstNoticeModel> noticeList = PfssstNoticeDao.noticeList(paramMap);
		return noticeList;
	}

	@Override
	public int noticeCnt(Map<String, Object> paramMap) throws Exception {
		int noticeCnt = PfssstNoticeDao.noticeCnt(paramMap);
		return noticeCnt;
	}

	@Override
	public PfssstNoticeModel noticeDetail(Map<String, Object> paramMap) throws Exception {

		PfssstNoticeModel pfssstNoticeModel = PfssstNoticeDao.noticeDetail(paramMap);
		return pfssstNoticeModel;
	}
}
