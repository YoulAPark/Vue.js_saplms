package kr.happyjob.study.admpmt.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.admpmt.model.AdmpmtClassroomMgtModel;
import kr.happyjob.study.admpmt.service.AdmpmtClassroomMgtService;


@Controller
public class AdmpmtClassroomMgtController {
	
	@Autowired
	AdmpmtClassroomMgtService service;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
		
	
	@RequestMapping("/manageF/classMgt.do")
	private String classMgt(){
		logger.info("+ Start " + className + ".classMgt");
		return "/admpmt/classroomMgt";
	}
	
	@RequestMapping("/admpmt/classroomList.do")
	private String classroomList(@RequestParam Map<String, Object> paramMap, Model model) throws Exception {
		
		logger.info("+ Start " + className + ".classroomList");
		logger.info("   - paramMap : " + paramMap);
		
		int clickpagenum = Integer.parseInt( String.valueOf(paramMap.get("clickpagenum"))) ;   
		int pagesize = Integer.parseInt( String.valueOf(paramMap.get("pagesize"))) ;  
		int startnum = (clickpagenum - 1) * pagesize;
		
		paramMap.put("startnum", startnum);
		paramMap.put("pagesize", pagesize);
		
		List<AdmpmtClassroomMgtModel> searchlist = service.classroomList(paramMap);
		
		model.addAttribute("searchlist", searchlist);
		
		int searchlistcnt = service.searchlistcnt(paramMap);
		model.addAttribute("searchlistcnt", searchlistcnt);
		
		logger.info("+ End " + className + ".classroomList");
		
		return "admpmt/classroomMgtList";
	}
	
	@RequestMapping("/admpmt/classEquipList.do")
	private String classEquipList(@RequestParam int li_no, Model model){
		
		logger.info("+ Start " + className + ".classEquipList");
		logger.info("   - paramMap : " + li_no);
		
		List<AdmpmtClassroomMgtModel> equiplist = service.classEquipList(li_no);
		
		model.addAttribute("equiplist", equiplist);
		
		logger.info("+ End " + className + ".classEquipList");
		
		return "admpmt/classEquipList";
	}
	
	@RequestMapping("/admpmt/insertClassroom.do")
	@ResponseBody
	private Map<String, Object> insertClassroom(@RequestParam Map<String, Object> paramMap){
		
		logger.info("+ Start " + className + ".insertClassroom");
		logger.info("   - paramMap : " + paramMap);	
		
		String action = String.valueOf(paramMap.get("action"));
		
		if("I".equals(action)){
			service.insertClassroom(paramMap);
		}else if("U".equals(action)){
			service.updateClassroom(paramMap);
		}else if("D".equals(action)){
			service.deleteClassroom(paramMap);
		}
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		logger.info("+ End " + className + ".insertClassroom");
		
		return returnmap;
	}
	
	@RequestMapping("/admpmt/insertEquip.do")
	@ResponseBody
	private Map<String, Object> insertEquip(@RequestParam Map<String, Object> paramMap){
		
		logger.info("+ Start " + className + ".insertEquip");
		logger.info("   - paramMap : " + paramMap);	
		
		String action = String.valueOf(paramMap.get("action"));
		
		if("I".equals(action)){
			service.insertEquip(paramMap);
		}else if("U".equals(action)){
			service.updateEquip(paramMap);
		}else if("D".equals(action)){
			service.deleteEquip(paramMap);
		}
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		logger.info("+ End " + className + ".insertEquip");
		
		return returnmap;
	}
	
	@RequestMapping("/admpmt/searchoneClassroom.co")
	@ResponseBody
	private Map<String, Object> searchoneClassroom(@RequestParam Map<String, Object> paramMap){
		
		logger.info("+ Start " + className + ".searchoneClassroom");
		logger.info("   - paramMap : " + paramMap);	
		
		AdmpmtClassroomMgtModel result = service.searchoneClassroom(paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		returnmap.put("result", result);
		
		logger.info("+ End " + className + ".searchoneClassroom");
		
		return returnmap;
	}
	
	@RequestMapping("/admpmt/searchoneEquip.do")
	@ResponseBody
	private Map<String, Object> searchoneEquip(@RequestParam Map<String, Object> paramMap){
		
		logger.info("+ Start " + className + ".searchoneEquip");
		logger.info("   - paramMap : " + paramMap);	
		
		AdmpmtClassroomMgtModel result = service.searchoneEquip(paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		returnmap.put("result", result);
		
		logger.info("+ End " + className + ".searchoneEquip");
		
		return returnmap;
	}
}
