package kr.happyjob.study.admsmt.controller;

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

import kr.happyjob.study.admsmt.model.AdmsmtSurveyMgtModel;
import kr.happyjob.study.admsmt.service.AdmsmtSurveyMgtService;

@Controller
@RequestMapping("/manageA/")
public class AdmsmtSurveyMgtController {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	AdmsmtSurveyMgtService service;

	// 관리자 설문관리 페이지 메인
	@RequestMapping("surveyMgt.do")
	public String surveyMgt(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("+ Start " + className + ".surveyMgt");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".surveyMgt");
		return "admsmt/surveyMgt";
	}
	
	// 설문결과가 있는 강의 리스트
	@RequestMapping("surveyMgtList.do")
	public String surveyMgtList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("+ Start " + className + ".surveyMgtList");
		logger.info("   - param : " + paramMap);
		
		int clickpagenum = Integer.parseInt(String.valueOf(paramMap.get("clickpagenum"))) ;   
		int pagesize = Integer.parseInt(String.valueOf(paramMap.get("pagesize"))) ;   
		int startnum = (clickpagenum - 1)*pagesize;
		
		paramMap.put("startnum", startnum);
		paramMap.put("pagesize", pagesize);
		
		int listSurveyCnt = service.listSurveyCnt(paramMap);
		model.addAttribute("listSurveyCnt", listSurveyCnt);
		
		List<AdmsmtSurveyMgtModel> listSurvey = service.listSurvey(paramMap);
		model.addAttribute("listSurvey", listSurvey);
		
		logger.info("+ End " + className + ".surveyMgtList");
		
		return "admsmt/surveyMgtList";
	}
	
	// 강의당 학생들의 설문결과 조회
	@RequestMapping("selectSurveyList.do")
	public String selectSurveyList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("+ Start " + className + ".selectSurveyList");
		logger.info("   - param : " + paramMap);
		
		int clickpagenum = Integer.parseInt(String.valueOf(paramMap.get("clickpagenum"))) ;   
		int pagesize = Integer.parseInt(String.valueOf(paramMap.get("pagesize"))) ;   
		int startnum = (clickpagenum - 1)*pagesize;
		paramMap.put("startnum", startnum);
		paramMap.put("pagesize", pagesize);
		
		int li_no = Integer.parseInt(String.valueOf(paramMap.get("li_no")));   
		paramMap.put("li_no", li_no);

		int selectSurveyListCnt = service.selectSurveyListCnt(paramMap);
		model.addAttribute("selectSurveyListCnt", selectSurveyListCnt);
		
		List<AdmsmtSurveyMgtModel> selectSurveyList = service.selectSurveyList(paramMap);
		model.addAttribute("selectSurveyList", selectSurveyList);
		
		model.addAttribute("clickpagenum", clickpagenum);
		
		logger.info("+ End " + className + ".selectSurveyList");
		
		return "admsmt/selectSurveyList";
	}
}






















