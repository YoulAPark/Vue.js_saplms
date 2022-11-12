package kr.happyjob.study.stdsmt.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import kr.happyjob.study.stdsmt.model.StdsmtAnswerModel;
import kr.happyjob.study.stdsmt.model.StdsmtExamModel;
import kr.happyjob.study.stdsmt.service.StdsmtExamService;

@Controller
public class StdsmtExamController {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	StdsmtExamService service;
	
	
	@RequestMapping("/manageC/exam.do")
	private String exam(){
		logger.info("+ Start " + className + ".exam");
		return "/stdsmt/exam";
	}
	
	@RequestMapping("/stdsmt/examLecList.do")
	private String examLecList(@RequestParam Map<String, Object> paramMap, Model model, HttpSession session){
		
		logger.info("+ Start " + className + ".examLecList");
		logger.info("   - paramMap : " + paramMap);
		
		int clickpagenum = Integer.parseInt( String.valueOf(paramMap.get("clickpagenum"))) ;   
		int pagesize = Integer.parseInt( String.valueOf(paramMap.get("pagesize"))) ;  
		int startnum = (clickpagenum - 1) * pagesize;
		
		paramMap.put("loginID", (String)session.getAttribute("loginId"));
		
		paramMap.put("startnum", startnum);
		paramMap.put("pagesize", pagesize);
		
		List<StdsmtExamModel> searchlist = service.examLecList(paramMap);
		model.addAttribute("searchlist", searchlist);
		
		
		int searchlistcnt = service.searchlistcnt(paramMap);
		model.addAttribute("searchlistcnt", searchlistcnt);
		
		logger.info("+ End " + className + ".examLecList");
		
		return "stdsmt/examLecList";
	}
	
	@RequestMapping("/stdsmt/selectoneExampaper.do")
	private String selectoneExampaper(@RequestParam Map<String, Object> paramMap, Model model, HttpSession session){
		
		logger.info("+ Start " + className + ".selectoneExampaper");
		logger.info("   - param : " + paramMap);
		
		paramMap.put("loginID", (String)session.getAttribute("loginId"));
		
		List<StdsmtExamModel> quelist = service.selectoneExampaper(paramMap);
		model.addAttribute("quelist", quelist);
		
		logger.info("+ End " + className + ".selectoneExampaper");
		
		return "stdsmt/questionList";
	}
	
	@RequestMapping("/stdsmt/insertAnswerPaper.do")
	@ResponseBody
	private void insertAnswerPaper(@RequestParam Map<String, Object> paramMap, HttpSession session){
		
		logger.info("+ Start " + className + ".insertAnswerPaper");
		logger.info("   - param : " + paramMap);
		
		int qst_cd;		//문항 번호
		String ss_answer;	//학생이 제출한 답
		int score;		//문항 배점
		String answer;		//정답
		
		
		String paramString = (String) paramMap.get("paramString");
		StringTokenizer st = new StringTokenizer(paramString,"/");
		
		while(st.hasMoreTokens()){
			qst_cd = Integer.parseInt(st.nextToken());
			ss_answer = st.nextToken();
			score = Integer.parseInt(st.nextToken());
			
			paramMap.put("loginID", (String)session.getAttribute("loginId"));
			paramMap.put("qst_cd", qst_cd);
			paramMap.put("ss_answer", ss_answer);
			
			logger.info("토큰 3개 : " + qst_cd + ", " + ss_answer + ", " + score);

			answer = service.selectForGrading(paramMap);	//SELECT (정답 조회)
			
			logger.info("정답 조회 완료");
			
			if(answer.equals(ss_answer)){
				paramMap.put("ss_score", score);
			}else{
				paramMap.put("ss_score", 0);
			}	
			service.insertAnswerPaper(paramMap);
		}
	}
	
	@RequestMapping("/stdsmt/selectResultpaper.do")
	private String selectResultpaper(@RequestParam Map<String, Object> paramMap, Model model, HttpSession session){
		
		logger.info("+ Start " + className + ".selectResultpaper");
		logger.info("   - param : " + paramMap);
		
		paramMap.put("loginID", (String)session.getAttribute("loginId"));
		
		List<StdsmtExamModel> quelist = service.selectResultpaper(paramMap);
		model.addAttribute("quelist", quelist);
		
		String sum_score = service.sum_score(paramMap);
		model.addAttribute("sum_score", sum_score);
		
		logger.info("+ End " + className + ".selectResultpaper");
		
		return "stdsmt/questionList";
	}

}
