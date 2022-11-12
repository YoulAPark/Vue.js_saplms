package kr.happyjob.study.stdsst.controller;

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

import kr.happyjob.study.stdsst.model.StdsstEnrollModel;
import kr.happyjob.study.stdsst.service.StdsstEnrollService;

@Controller
@RequestMapping("/supportC/")
public class StdsstEnrollController {
	
	@Autowired
	StdsstEnrollService stdsstEnrollService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	/**
	 * 파일 업로드 샘플 초기화면
	 */
	@RequestMapping("enroll.do")
	public String enroll(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".enroll");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".enroll");

		return "stdsst/enroll";
	}
	
	@RequestMapping("listenroll.do")
	public String listenroll(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listenroll");
		logger.info("   - paramMap : " + paramMap);	
		//int li_no=Integer.parseInt((String)paramMap.get("li_no"));
		//paramMap.put("li_no", li_no);
		//logger.info("   - paramMap : " + li_no + "~~~~~~~~~~~~~~~~~");
		int clickpagenum = Integer.parseInt( String.valueOf(paramMap.get("clickpagenum"))) ;   
		int pagesize = Integer.parseInt( String.valueOf(paramMap.get("pagesize"))) ;  
		int startnum = (clickpagenum - 1) * pagesize;
		
//		int tlscjdgksCnt = service.skdklsdsdgkojeoigpdpjept();
	//	model.add
		/*paramMap.put("loginID",(String) session.getAttribute("loginId"));*/
		paramMap.put("startnum", startnum);
		paramMap.put("pagesize", pagesize);
		
		
		List<StdsstEnrollModel> searchenroll = stdsstEnrollService.listenroll(paramMap);		
		model.addAttribute("searchenroll", searchenroll);
		
		int searchlistcnt = stdsstEnrollService.searchlistcnt(paramMap);
		model.addAttribute("searchlistcnt", searchlistcnt);
		
		logger.info("+ End " + className + ".listenroll");

		return "stdsst/enrolllist";
}
	// 단건 조회
	@RequestMapping("selectenroll.do")
	@ResponseBody
	public Map<String, Object> selectenroll(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectenroll");
		logger.info("   - paramMap : " + paramMap);			
		int ln_no=Integer.parseInt((String)paramMap.get("ln_no"));
		paramMap.put("ln_no", ln_no);
		
		paramMap.put("loginID",(String) session.getAttribute("loginId"));
		
		logger.info("   - loginID : " + (String) session.getAttribute("loginId"));		
		
		StdsstEnrollModel searchone = stdsstEnrollService.selectenroll(paramMap);
		/*logger.info("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"+searchone.getBd_cnt());
		logger.info("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"+searchone.getBd_contents());*/
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		returnmap.put("result", "SUCESS");
		returnmap.put("searchone", searchone);
		
		
		logger.info("+ End " + className + ".selectenroll");

		return returnmap;
	}	
	
	@RequestMapping("insertenroll.do")
	@ResponseBody
	public Map<String, Object> insertenroll(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".insertenroll");
		logger.info("   - paramMap : " + paramMap);			
		
		paramMap.put("loginID",(String) session.getAttribute("loginId"));
		
		String action = String.valueOf(paramMap.get("action")); // jsp에서 쓸떄마다 호출
		
		if("I".equals(action)) {
			paramMap.put("addcnt", +1);
			stdsstEnrollService.insertenroll(paramMap);
			stdsstEnrollService.updateenroll(paramMap);
		} else if("D".equals(action)) {
			paramMap.put("addcnt", -1);
			stdsstEnrollService.deleteenroll(paramMap);
			stdsstEnrollService.updateenroll(paramMap);
		}

		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		returnmap.put("result", "SUCESS");
		
		logger.info("+ End " + className + ".insertenroll");

		return returnmap;
	}		
	// 파일 다운로드
	@RequestMapping("download.do")
	public void download(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".download");
		logger.info("   - paramMap : " + paramMap);			
		
		paramMap.put("loginID",(String) session.getAttribute("loginId"));
		
		StdsstEnrollModel searchone = stdsstEnrollService.selectenroll(paramMap);


		//물리경로 조회해서 담기 
		String file = searchone.getAtt_mul();
		logger.info(" file : " + file + "searchone :" + searchone.getAtt_mul() + "~~~~~~~~~~~~~~~~~~~~~~~~~~");
		byte fileByte[] = FileUtils.readFileToByteArray(new File(file));
		
	    response.setContentType("application/octet-stream");
	    response.setContentLength(fileByte.length);
	    response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(searchone.getAtt_ori(),"UTF-8")+"\";");
	    response.setHeader("Content-Transfer-Encoding", "binary");
	    response.getOutputStream().write(fileByte);
		
	    return;
	}

}
