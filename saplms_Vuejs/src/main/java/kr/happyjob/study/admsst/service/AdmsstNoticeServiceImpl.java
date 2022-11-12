package kr.happyjob.study.admsst.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.admsst.dao.AdmsstNoticeDao;
import kr.happyjob.study.admsst.model.AdmsstNoticeModel;


@Service
public class AdmsstNoticeServiceImpl implements AdmsstNoticeService{
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	AdmsstNoticeDao admsstNoticeDao;

	
	public List<AdmsstNoticeModel> listNotice(Map<String, Object> paramMap) throws Exception {
		
		List<AdmsstNoticeModel> listNotice = admsstNoticeDao.listNotice(paramMap);
		
		return listNotice;
	}

	
	public int searchlistcnt(Map<String, Object> paramMap) throws Exception {
		
		int searchlistcnt = admsstNoticeDao.searchlistcnt(paramMap);
		
		return searchlistcnt;
	}

	
	public AdmsstNoticeModel selectNotice(Map<String, Object> paramMap) throws Exception {
		
		AdmsstNoticeModel selectupload = admsstNoticeDao.selectNotice(paramMap);
		
		return selectupload;
	}

	
	public void insertNotice(Map<String, Object> paramMap) throws Exception {
		
		admsstNoticeDao.insertNotice(paramMap);
		
		return ;
	}

	
	public void updateNotice(Map<String, Object> paramMap) throws Exception {
		
		admsstNoticeDao.updateNotice(paramMap);
		
		return ;
	}

	@Override
	public void deleteNotice(Map<String, Object> paramMap) throws Exception {
		
		admsstNoticeDao.deleteNotice(paramMap);
		
		return ;
	}

}
