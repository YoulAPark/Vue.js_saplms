package kr.happyjob.study.admsmt.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.admsmt.model.AdmsmtLecListMgtModel;
import kr.happyjob.study.admsmt.service.AdmsmtLecListMgtService;
import kr.happyjob.study.stdsst.model.StdsstLecDataModel;
import kr.happyjob.study.system.model.ComnDtlCodModel;
import kr.happyjob.study.admsmt.dao.AdmsmtLecListMgtDao;

@Service
public class AdmsmtLecListMgtServiceImpl implements AdmsmtLecListMgtService {
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	 
	@Autowired
	AdmsmtLecListMgtDao admsmtLecListMgtDao;

	
	/** 강의 목록 조회 */
	@Override
	public List<AdmsmtLecListMgtModel> listAdmsmtLecList(Map<String, Object> paramMap) throws Exception {
		List<AdmsmtLecListMgtModel> admsmtLecList = admsmtLecListMgtDao.listAdmsmtLecList(paramMap);
		
		return admsmtLecList;
	}

	/** 수강인원 목록 조회 */
	@Override
	public List<AdmsmtLecListMgtModel> listAdmsmtLecPersonList(Map<String, Object> paramMap) throws Exception {
		List<AdmsmtLecListMgtModel> admsmtLecPersonList = admsmtLecListMgtDao.listAdmsmtLecPersonList(paramMap);
		
		return admsmtLecPersonList;
	}

	/** 강의목록 카운트 조회 */
	@Override
	public int countListAdmsmtLecList(Map<String, Object> paramMap) throws Exception {
		int totalCountAdmsmtLecList = admsmtLecListMgtDao.countListAdmsmtLecList(paramMap);
		
		return totalCountAdmsmtLecList;
	}

	/** 수강인원 카운트 조회 */
	@Override
	public int countListAdmsmtLecPersonList(Map<String, Object> paramMap) throws Exception {
		int totalCountAdmsmtLecPersonList = admsmtLecListMgtDao.countListAdmsmtLecPersonList(paramMap);
		
		return totalCountAdmsmtLecPersonList;
	}

	/** 강의목록 단건 조회 */
	@Override
	public AdmsmtLecListMgtModel selectAdmsmtLecList(Map<String, Object> paramMap) throws Exception {
		AdmsmtLecListMgtModel selectAdmsmtLecList = admsmtLecListMgtDao.selectAdmsmtLecList(paramMap);
		return selectAdmsmtLecList;
	}

	/** 수강인원 단건 조회 */
	@Override
	public AdmsmtLecListMgtModel selectAdmsmtLecPersonList(Map<String, Object> paramMap) throws Exception {
		AdmsmtLecListMgtModel selectAdmsmtLecPersonList = admsmtLecListMgtDao.selectAdmsmtLecPersonList(paramMap);
		return selectAdmsmtLecPersonList;
	}

	@Override
	public void updateSb_yn(Map<String, Object> paramMap) throws Exception {
	
		admsmtLecListMgtDao.updateSb_yn(paramMap);
		
		return ;
		
	}

	
	
	
	
	

	
}
