package kr.happyjob.study.pfssmt.controller;

import java.util.List;
import java.util.Map;

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

import kr.happyjob.study.pfssmt.model.PfsSmtSurveyRstVo;
import kr.happyjob.study.pfssmt.service.PfsSmtSurveyRstService;

///manageD/surveyRst.do

@Controller
@RequestMapping("/manageD")
public class PfsSmtSurveyRstController {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	PfsSmtSurveyRstService pfsSmtSurveyRstService;  
	
	@RequestMapping("/surveyRst.do")
	public String SurveyRstinfo (HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		return "/pfssmt/surveyRst";

	}
	
	@RequestMapping("/surveyRstList.do")
	public String LecinfoDtl(Model model, @RequestParam Map<String, Object> paramMap, 
			HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws Exception {
		logger.info("목록 조회 콜백함수 호출");
		logger.info("paramMap 호출 :" + paramMap);
		
		
		int clickpagenum = Integer.parseInt( String.valueOf(paramMap.get("clickpagenum"))) ;   
		int pagesize = Integer.parseInt( String.valueOf(paramMap.get("pagesize"))) ;  
		int startnum = (clickpagenum - 1) * pagesize;
		
		
		paramMap.put("loginID",(String) session.getAttribute("loginId"));
		paramMap.put("startnum", startnum);
		paramMap.put("pagesize", pagesize);
		
		
		logger.info("loginID , startnum, pagesize :" + paramMap);
		
		List<PfsSmtSurveyRstVo> surveyRstList = pfsSmtSurveyRstService.surveyRstList(paramMap);
		model.addAttribute("surveyRstList",surveyRstList);
		
		int SurveyRstCnt = pfsSmtSurveyRstService.SurveyRstCnt(paramMap);
		model.addAttribute("SurveyRstCnt",SurveyRstCnt);
		logger.info("목록 조회 콜백함수 종료");
		 
		
		return "pfssmt/surveyRstList";
	}
	
	
}
