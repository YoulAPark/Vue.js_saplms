package kr.happyjob.study.admhmt.controller;

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

import kr.happyjob.study.admhmt.model.AdmhmtProfessorMgtModel;
import kr.happyjob.study.admhmt.service.AdmhmtProfessorMgtService;

@Controller
@RequestMapping("/peopleA/")
public class AdmhmtProfessorMgtController {
	
	@Autowired
	AdmhmtProfessorMgtService professorMgtService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@RequestMapping("professorMgt.do")
	public String professorMgt(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".professorMgt");
		logger.info("   - paramMap : " + paramMap);
		logger.info("+ End " + className + ".professorMgt");
		
		return "admhmt/professorMgt";
	}
	
	@RequestMapping("professorList.do")
	public String ListProsessor(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".ListProsessor");
		logger.info("   - paramMap : " + paramMap);
		
		int clickpagenum = Integer.parseInt( String.valueOf(paramMap.get("clickpagenum"))) ;   
		int pagesize = Integer.parseInt( String.valueOf(paramMap.get("pagesize"))) ;  
		int startnum = (clickpagenum - 1) * pagesize;

		paramMap.put("startnum", startnum);
		paramMap.put("pagesize", pagesize);

		
		List<AdmhmtProfessorMgtModel> professorList = professorMgtService.professorList(paramMap);	
		model.addAttribute("professorList", professorList);
		
		int searchlistcnt = professorMgtService.searchlistcnt(paramMap);
		model.addAttribute("searchlistcnt", searchlistcnt);
		
		logger.info("+ End " + className + ".ListProsessor");
		
		return "admhmt/professorList";
	}
	
	@RequestMapping("pfsregister.do")
	@ResponseBody
	public Map<String, Object> registerProfessor(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception{
		logger.info("+ Start " + className + ".registerProfessor");
		logger.info("   - paramMap : " + paramMap);
		
		String action = (String)paramMap.get("action");
		String result = "SUCCESS";
		String resultMsg;
		
		if("I".equals(action)) {
			   
			   professorMgtService.registerProfessor(paramMap);
			   resultMsg = "가입 요청 완료";
		} else {
			   
			   result = "FAIL";
			   resultMsg = "가입 요청 실패";
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		   
		logger.info("+ End " + className + ".registerUser");
		   
		return resultMap;
	}
}
