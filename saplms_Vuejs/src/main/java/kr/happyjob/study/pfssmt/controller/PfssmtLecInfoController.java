package kr.happyjob.study.pfssmt.controller;

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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import kr.happyjob.study.admpmt.model.AdmpmtClassroomMgtModel;
import kr.happyjob.study.pfssmt.model.PfssmtLecInfoModel;
import kr.happyjob.study.pfssmt.service.PfssmtLecInfoService;

@Controller
public class PfssmtLecInfoController {
	
	@Autowired
	PfssmtLecInfoService service;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	@RequestMapping("/manageD/lecInfo.do")
	private String lecInfo(){
		logger.info("+ Start " + className + ".lecInfo");
		return "/pfssmt/lecInfo";
	}
	
	@RequestMapping("/pfssmt/lectureList.do")
	private String lectureList(Model model, @RequestParam Map<String, Object> paramMap) throws Exception {
		
		logger.info("+ Start " + className + ".lecturelist");
		logger.info("   - paramMap : " + paramMap);	
		
		int clickpagenum = Integer.parseInt( String.valueOf(paramMap.get("clickpagenum"))) ;   
		int pagesize = Integer.parseInt( String.valueOf(paramMap.get("pagesize"))) ;  
		int startnum = (clickpagenum - 1) * pagesize;
		
		paramMap.put("startnum", startnum);
		paramMap.put("pagesize", pagesize);
		
		List<PfssmtLecInfoModel> searchlist = service.lecturelist(paramMap);
		
		model.addAttribute("searchlist", searchlist);
		
		int searchlistcnt = service.searchlistcnt(paramMap);
		
		model.addAttribute("searchlistcnt", searchlistcnt);
		
		logger.info("+ End " + className + ".lecturelist");
		
		return "pfssmt/lecInfoList";
	}
	
	@RequestMapping("/pfssmt/lectureDetail.do")
	@ResponseBody
	private Map<String, Object> selectOneLecture(@RequestParam Map<String, Object> paramMap, Model model) throws Exception{
		logger.info("+ Start " + className + ".seleceOneLecture");
		logger.info("   - paramMap : " + paramMap);
		
		PfssmtLecInfoModel result = service.selectOneLecture(paramMap);
		
		Map<String, Object> returnmap = new HashMap<String,Object>();
					
		returnmap.put("vo", result);
		
		return returnmap;
	}

	@RequestMapping("/pfssmt/writeLec.do")
	@ResponseBody
	public Map<String, Object> writeLec(@RequestParam Map<String, Object> paramMap ,Model model, HttpSession session) throws Exception{
		
		logger.info("+ Start " + className + ".writeLec");
		logger.info("   - paramMap : " + paramMap);	
		
		paramMap.put("loginID", (String) session.getAttribute("loginId"));
		
		String action = String.valueOf(paramMap.get("action"));
		
		if("I".equals(action)){
			service.insertLec(paramMap);
		}else if("U".equals(action)){
			service.updateLec(paramMap);
		}else if("D".equals(action)){
			service.deleteLec(paramMap);
		}
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		returnmap.put("result", "SUCCESS");
		
		logger.info("+ End " + className + ".writeLec");

		return returnmap;
	}
	
	
	@RequestMapping("/pfssmt/classroomNum.do")
	@ResponseBody
	public List<AdmpmtClassroomMgtModel> classroomNum(){
	
		logger.info("+ Start " + className + ".classroomNum");
		
		List<AdmpmtClassroomMgtModel> list = service.classroomNum();
		
		logger.info("+ End " + className + ".classroomNum");
		
		return list;
		
	}
	
}
