package kr.happyjob.study.stdsmt.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
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
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.stdsmt.model.StdsmtSurveyContentModel;
import kr.happyjob.study.stdsmt.model.StdsmtSurveyModel;
import kr.happyjob.study.stdsmt.service.StdsmtSurveyService;

@Controller
@RequestMapping("/manageC/")
public class StdsmtSurveyController {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	StdsmtSurveyService service;
	
	// 학생이 설문조사에 참여해야 할 수강목록 메인 
	@RequestMapping("survey.do")
	public String survey(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("+ Start " + className + ".survey");
		logger.info("   - paramMap : " + paramMap);
		
		String loginId = (String) session.getAttribute("loginId");
		model.addAttribute("loginId", loginId);
		
		logger.info("+ End " + className + ".survey");
		
		return "stdsmt/survey";
	}
	
	// 학생이 설문조사에 참여해야 할 수강목록 리스트
	@RequestMapping("surveyList.do")
	public String surveyList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception{
		logger.info("+ Start " + className + ".surveyList");
		logger.info("   - paramMap : " + paramMap);
		
		int clickpagenum = Integer.parseInt(String.valueOf(paramMap.get("clickpagenum")));
		int pagesize = Integer.parseInt(String.valueOf(paramMap.get("pagesize")));
		int startnum = (clickpagenum - 1)*pagesize;
		
		String loginId = (String) session.getAttribute("loginId");
		paramMap.put("startnum", startnum);
		paramMap.put("pagesize", pagesize);
		paramMap.put("loginId", loginId);

		// 오늘 일자(시간 제외, yyyy-MM-dd)
		LocalDate date = LocalDate.now();
		DateTimeFormatter today = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		paramMap.put("lecEdate", date.format(today));
		
		int surveyLecListCnt = service.surveyLecListCnt(paramMap);
		model.addAttribute("surveyLecListCnt", surveyLecListCnt);
		
		List<StdsmtSurveyModel> surveyLecList = service.surveyLecList(paramMap);
		model.addAttribute("surveyLecList", surveyLecList);
		
		logger.info("+ End " + className + ".surveyList");
		
		return "stdsmt/surveyList";
	}
	
	// 설문조사 항목 리스트
	@RequestMapping("surveyContentList.do")
	public String surveyContentList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception{
		
		logger.info("+ Start " + className + ".surveyContentList");
		logger.info("   - paramMap : " + paramMap);
		
		List<StdsmtSurveyContentModel> surveyContentList = service.surveyContentList(paramMap);
		model.addAttribute("surveyContentList", surveyContentList);

		int surveyContentCnt = service.surveyContentCnt(paramMap);
		model.addAttribute("surveyContentCnt", surveyContentCnt);
		
		int li_no = Integer.parseInt(String.valueOf(paramMap.get("lecNo")));
		model.addAttribute("lecNo", li_no);
		
		int confirmNo = Integer.parseInt(String.valueOf(paramMap.get("confirmNo")));
		model.addAttribute("confirmNo", confirmNo);
		
		logger.info("+ End " + className + ".surveyContentList");	
		
		return "stdsmt/surveyContentList";
	}

	// 설문 저장
	@RequestMapping("saveSurvey.do")
	@ResponseBody
	public Map<String, Object> saveSurvey(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception{
		
		logger.info("+ Start " + className + ".saveSurvey");
		logger.info("   - paramMap : " + paramMap);
		
		// 오늘 일자(시간 제외, yyyy-MM-dd)
		LocalDate date = LocalDate.now();
		DateTimeFormatter today = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		paramMap.put("surveyDate", date.format(today));
		
		service.insertSurvey(paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		returnmap.put("result", "SUCESS");
		
		logger.info("+ End " + className + ".saveSurvey");	
		
		return returnmap;
	}
	

}
