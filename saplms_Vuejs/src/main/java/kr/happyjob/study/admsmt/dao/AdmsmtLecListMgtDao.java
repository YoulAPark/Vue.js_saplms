package kr.happyjob.study.admsmt.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.admsmt.model.AdmsmtLecListMgtModel;
import kr.happyjob.study.admsst.model.FileuploadModel;
import kr.happyjob.study.common.comnUtils.ComnCodUtil;
import kr.happyjob.study.stdsst.model.StdsstLecDataModel;
import kr.happyjob.study.system.model.ComnCodUtilModel;
import kr.happyjob.study.system.model.ComnDtlCodModel;

import kr.happyjob.study.system.service.ComnCodService;


public interface  AdmsmtLecListMgtDao {
	/** 강의 목록 조회 */
	//listadmsmtLecData 가 쿼리문 ID가 됌.
	public List<AdmsmtLecListMgtModel> listAdmsmtLecList(Map<String, Object> paramMap);
	   
	/** 수강인원 목록 조회 */
	public List<AdmsmtLecListMgtModel> listAdmsmtLecPersonList(Map<String, Object> paramMap);
	
	/** 강의목록 카운트 조회 */
	public int countListAdmsmtLecList(Map<String, Object> paramMap);
		
	/** 수강인원 카운트 조회 */
	public int countListAdmsmtLecPersonList(Map<String, Object> paramMap);
	
	/** 강의목록 단건 조회 */
	public AdmsmtLecListMgtModel selectAdmsmtLecList(Map<String, Object> paramMap);

	/** 수강인원 단건 조회 */
	public AdmsmtLecListMgtModel selectAdmsmtLecPersonList(Map<String, Object> paramMap);
	
//	휴학 업데이트
	public void updateSb_yn(Map<String, Object> paramMap);
	
}
	
	    