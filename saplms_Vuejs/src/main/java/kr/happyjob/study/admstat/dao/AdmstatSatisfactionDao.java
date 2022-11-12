package kr.happyjob.study.admstat.dao;

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
import kr.happyjob.study.admstat.model.AdmstatSatisfactionModel;
import kr.happyjob.study.common.comnUtils.ComnCodUtil;
import kr.happyjob.study.stdsst.model.StdsstLecDataModel;
import kr.happyjob.study.system.model.ComnCodUtilModel;
import kr.happyjob.study.system.model.ComnDtlCodModel;

import kr.happyjob.study.system.service.ComnCodService;


public interface  AdmstatSatisfactionDao {
	/** 강의 목록 조회 */
	//listadmsmtLecData 가 쿼리문 ID가 됌.
	public List<AdmstatSatisfactionModel> listSatisfactionList(Map<String, Object> paramMap);
	
	/** 강의 카운트 조회 */
	public int countSatisfactionList(Map<String, Object> paramMap);
	/** 차트 단건 조회 */
	public List<Map<String, Object>> selectSatisfactionList();

	
}
	
	    