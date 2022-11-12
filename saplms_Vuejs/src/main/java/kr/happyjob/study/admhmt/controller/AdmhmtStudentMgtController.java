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
///peopleA/studentMgt.do
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.admhmt.model.AdmhmtStudentMgtModel;
import kr.happyjob.study.admhmt.service.AdmhmtStudentMgtService;

@Controller
@RequestMapping("/peopleA")
public class AdmhmtStudentMgtController {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	AdmhmtStudentMgtService admhmtStudentMgtService;
	
	@RequestMapping("/studentMgt.do")
	public String studentMgt (HttpServletRequest request, HttpServletResponse response)
	throws Exception {

		return "/admhmt/studentMgt";
	}
	
	@RequestMapping("/studentList.do")
	public String studentList(Model model, @RequestParam Map<String, Object> paramMap, 
			HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws Exception {
		logger.info("학생명 콜백함수 호출");
		logger.info("paramMap 호출 :" + paramMap);
		
		int clickpagenum = Integer.parseInt( String.valueOf(paramMap.get("clickpagenum"))) ;   
		int pagesize = Integer.parseInt( String.valueOf(paramMap.get("pagesize"))) ;  
		int startnum = (clickpagenum - 1) * pagesize;
		
		
		// paramMap.put("loginID",(String) session.getAttribute("loginId"));
		paramMap.put("startnum", startnum);
		paramMap.put("pagesize", pagesize);
		
		//학생목록조회
		List<AdmhmtStudentMgtModel> studentList = admhmtStudentMgtService.studentList(paramMap);
		model.addAttribute("studentList",studentList);
		//학생수조회
		int studentListCnt = admhmtStudentMgtService.studentListCnt(paramMap);
		model.addAttribute("studentListCnt",studentListCnt);
		
		return "/admhmt/studentList";
	}
	
	@RequestMapping("/studentRegist.do")
	@ResponseBody
	public Map<String, Object> studentRegist(Model model, @RequestParam Map<String, Object> paramMap, 
			HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws Exception {
		logger.info("로그인 시도 호출");
		logger.info("paramMap 호출 :" + paramMap);
		
		String action = (String)(paramMap.get("action"));
		String result = "SUCCESS";
		String resultMsg;
		
		if("I".equals(action)) {
			admhmtStudentMgtService.studentRegist(paramMap);
			resultMsg = "가입 요청 완료";
		} else {
			result = "FAIL";
			resultMsg = "가입 요청 실패";
		}

		Map<String, Object> returnmap = new HashMap<String, Object>();
		returnmap.put("result", result);
		returnmap.put("resultMsg", resultMsg);
		
		logger.info("+ result " + result + ".registerUser");
		logger.info("+ resultMsg " + resultMsg + ".registerUser");
		logger.info("+ End " + className + ".registerUser");
		return returnmap;
	}
	
	

}
