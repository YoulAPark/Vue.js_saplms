package kr.happyjob.study.stdsmt.controller;

import java.io.Console;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import kr.happyjob.study.login.model.LgnInfoModel;
import kr.happyjob.study.stdsmt.model.StdSmtLecListVo;
import kr.happyjob.study.stdsmt.service.StdSmtLecListService;


@Controller
@RequestMapping("/manageC")
public class StdsmtLecListController {

	@Autowired
	StdSmtLecListService stdSmtLecListService;

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	// 수강번호
	private String li_no;
	
	
	// 초기 메뉴마스터 화면 설정
	@RequestMapping("/lecList.do")
	public String Lecinfo(HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		return "/stdsmt/LecList";

	}

	// 목록 데이터 
	@RequestMapping("/lecListDtl.do")
	public String LecinfoDtl(Model model, @RequestParam Map<String, Object> paramMap, 
			HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws Exception {
		logger.info("수강목록요청받음");
		logger.info("paramMap :" + paramMap);
		paramMap.put("loginID",(String) session.getAttribute("loginId"));
		
		
		int clickpagenum = Integer.parseInt( String.valueOf(paramMap.get("clickpagenum"))) ;   
		int pagesize = Integer.parseInt( String.valueOf(paramMap.get("pagesize"))) ;  
		int startnum = (clickpagenum - 1) * pagesize;
		
		
		// paramMap.put("loginID",(String) session.getAttribute("loginId"));
		paramMap.put("startnum", startnum);
		paramMap.put("pagesize", pagesize);
	
		
		// 수강 목록 리스트 검색
		List<StdSmtLecListVo> StdSmtLecList = stdSmtLecListService.LecList(paramMap);
		model.addAttribute("StdSmtLecList",StdSmtLecList);
		
		// 수강 목록 리스트 건수
		int LecListCnt = stdSmtLecListService.LecListCnt(paramMap);
		model.addAttribute("LecListCnt",LecListCnt);
		
		return "/stdsmt/LecListDtl";
		
	}
	
	//모달 Ajax콜백
	@RequestMapping("/selectLecList.do")
	@ResponseBody
	public Map<String, Object> selectFileupload(String li_no,Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("모달 Ajax콜백 받음");
		logger.info("paramMap  : "+ paramMap);
		logger.info("li_no: "+(String)paramMap.get("li_no"));
		
		paramMap.put("loginID",(String) session.getAttribute("loginId"));
		logger.info("목록에서 세션아이디Id: " + session.getAttribute("loginId"));
		
		StdSmtLecListVo searchone =  stdSmtLecListService.selectLecList(paramMap);
		Map<String, Object> returnmap = new HashMap<String, Object>();
		returnmap.put("result", "success");
		returnmap.put("searchone", searchone);
		logger.info("서치원 : " +returnmap.get(searchone) );
		
		return returnmap;
	}

	
}
