package kr.happyjob.study.admstat.controller;

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

import kr.happyjob.study.admstat.model.AdmstatLecCntModel;
import kr.happyjob.study.admstat.service.AdmstatLecCntService;

@Controller
@RequestMapping("/statistics/")
public class AdmstatLecCntController {
	
	@Autowired
	AdmstatLecCntService admstatLecCntService;
	
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	private final String className = this.getClass().toString();
	
	// 초기화면
	@RequestMapping("lecCnt.do")
	public String lecCnt(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".lecCnt");
		logger.info("   - paramMap : " + paramMap);
		logger.info("+ End " + className + ".lecCnt");	
		
		return "admstat/lecCnt";
	}

	@RequestMapping("listLecCnt.do")
	public String listLecCnt(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listLecCnt");
		logger.info("   - paramMap : " + paramMap);			
		
		int clickpagenum = Integer.parseInt( String.valueOf(paramMap.get("clickpagenum"))) ;   
		int pagesize = Integer.parseInt( String.valueOf(paramMap.get("pagesize"))) ;  
		int startnum = (clickpagenum - 1) * pagesize;
		
		paramMap.put("startnum", startnum);
		paramMap.put("pagesize", pagesize);
		
		
		List<AdmstatLecCntModel> searchlist = admstatLecCntService.listLecCnt(paramMap);		
		model.addAttribute("searchlist", searchlist);
		
		
		int searchlistcnt = admstatLecCntService.searchlistcnt(paramMap);
		model.addAttribute("searchlistcnt", searchlistcnt);
		
		logger.info("+ End " + className + ".listLecCnt");

		return "admstat/lecCntlist";
	}
	
	@RequestMapping("listLecCntchart.do")
	@ResponseBody
	public Map<String, Object> listLecCntchart(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listLecCntchart");
		logger.info("   - paramMap : " + paramMap);			
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		int clickpagenum = Integer.parseInt( String.valueOf(paramMap.get("clickpagenum"))) ;   
		int pagesize = Integer.parseInt( String.valueOf(paramMap.get("pagesize"))) ;  
		int startnum = (clickpagenum - 1) * pagesize;
		
		paramMap.put("startnum", startnum);
		paramMap.put("pagesize", pagesize);
		
		
		List<AdmstatLecCntModel> searchlist = admstatLecCntService.listLecCnt(paramMap);		
		returnMap.put("searchlist", searchlist);
		
		
		int searchlistcnt = admstatLecCntService.searchlistcnt(paramMap);
		returnMap.put("searchlistcnt", searchlistcnt);
		
		
		
		if(searchlistcnt > 0) {
			
			AdmstatLecCntModel firele = searchlist.get(0);
								
			returnMap.put("flinm", firele.getLi_nm());
			returnMap.put("fliap", firele.getLi_ap());
			returnMap.put("fligarden", firele.getLi_garden());
			
		}
		
		logger.info("+ End " + className + ".listLecCntchart");

		return returnMap;
	}
}
