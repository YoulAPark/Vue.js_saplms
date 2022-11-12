package kr.happyjob.study.pfssmt.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.pfssmt.model.AssignMgtModel;
import kr.happyjob.study.pfssmt.service.AssignMgtService;

@Controller
@RequestMapping("/manageD/")
public class PfssmtAssignMgtController {
	
	@Autowired
	AssignMgtService assignMgtService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	  
	/**
	 * 파일 업로드 샘플 초기화면
	 */
	@RequestMapping("assignMgt.do")
	public String assignMgt(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".initComnCod");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".initComnCod");

		return "pfssmt/AssignMgt";
	}

	@RequestMapping("listAssignMgt.do")
	public String listAssignMgt(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listFileupload");
		logger.info("   - paramMap : " + paramMap);			
		
		int clickpagenum = Integer.parseInt( String.valueOf(paramMap.get("clickpagenum"))) ;   
		int pagesize = Integer.parseInt( String.valueOf(paramMap.get("pagesize"))) ;  
		int startnum = (clickpagenum - 1) * pagesize;
		
		paramMap.put("startnum", startnum);
		paramMap.put("pagesize", pagesize);
		
		
		List<AssignMgtModel> searchlist = assignMgtService.listAssignMgt(paramMap);		
		model.addAttribute("searchlist", searchlist);
		
		int searchlistcnt = assignMgtService.searchlistcnt(paramMap);
		model.addAttribute("searchlistcnt", searchlistcnt);
		
		logger.info("+ End " + className + ".listFileupload");

		return "pfssmt/AssignMgtList";
	}
		
	@RequestMapping("selectAssignMgt.do")
	@ResponseBody
	public Map<String, Object> selectAssignMgt(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectFileupload");
		logger.info("   - paramMap : " + paramMap);			
		
		AssignMgtModel searchone = assignMgtService.selectAssignMgt(paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		returnmap.put("result", "SUCESS");
		returnmap.put("searchone", searchone);
		
		logger.info("+ End " + className + ".selectFileupload");

		return returnmap;
	}	

	@RequestMapping("saveFileupload.do")
	@ResponseBody
	public Map<String, Object> saveFileupload(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".saveFileupload");
		logger.info("   - paramMap : " + paramMap);			
		
		paramMap.put("loginID",(String) session.getAttribute("loginId"));
		
		String action = String.valueOf(paramMap.get("action"));
		
		if("I".equals(action)) {
			assignMgtService.insertFileupload(paramMap);
		} else if("U".equals(action)) {
			assignMgtService.updateFileupload(paramMap);
		} else if("D".equals(action)) {
			assignMgtService.deleteFileupload(paramMap);
		}
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		returnmap.put("result", "SUCESS");
		
		logger.info("+ End " + className + ".saveFileupload");

		return returnmap;
	}		
	
	@RequestMapping("saveAssignMgtatt.do")
	@ResponseBody
	public Map<String, Object> saveAssignMgtatt(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".saveAssignMgtatt");
		logger.info("   - paramMap : " + paramMap);			
		
		paramMap.put("loginID",(String) session.getAttribute("loginId"));
		
		String action = String.valueOf(paramMap.get("action"));
		
		if("I".equals(action)) {
			assignMgtService.insertFileuploadatt(paramMap,request);
		} else if("U".equals(action)) {
			assignMgtService.updateFileuploadatt(paramMap,request);
		} else if("D".equals(action)) {
			assignMgtService.deleteFileuploadatt(paramMap);
		}
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		returnmap.put("result", "SUCESS");
		
		logger.info("+ End " + className + ".saveAssignMgtatt");

		return returnmap;
	}
	
	@RequestMapping("downloadfile.do")
	public void downloadfile(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".downloadfile");
		logger.info("   - paramMap : " + paramMap);			
		
		AssignMgtModel searchone = assignMgtService.selectAssignMgt(paramMap);


		//물리경로 조회해서 담기 
		String file = searchone.getAtt_mul();

		byte fileByte[] = FileUtils.readFileToByteArray(new File(file));
		
	    response.setContentType("application/octet-stream");
	    response.setContentLength(fileByte.length);
	    response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(searchone.getAtt_ori(),"UTF-8")+"\";");
	    response.setHeader("Content-Transfer-Encoding", "binary");
	    response.getOutputStream().write(fileByte);
		
	    return;
	}
	
	
}  
