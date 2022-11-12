package kr.happyjob.study.stdsst.controller;

import java.io.File;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
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

import kr.happyjob.study.stdsst.model.StdsstLecDataModel;
import kr.happyjob.study.stdsst.service.StdsstLecDataService;

@Controller
@RequestMapping("/supportC/")


public class StdsstLecDataController {
	@Autowired
	StdsstLecDataService stdsstLecDataService;	
	
	/**
	 *  초기화면
	 */
	@RequestMapping("lecData.do")
	public String lecData(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
	    
		return "stdsst/lecData";
	}
	
//	학습자료 목록
	@RequestMapping("listLecDataCod.do")
	public String listLecDataCod(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
//		List<StdsstLecDataModel> searchlist=stdsstLecDataService.listStdsstLecData(paramMap);
//		
//		model.addAttribute("searchlist", searchlist);
//		 
//		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;												// 페이지 시작 row 번호
				
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		// 공통 그룹코드 목록 조회
		List<StdsstLecDataModel> listLecDataModel = stdsstLecDataService.listStdsstLecData(paramMap);
		model.addAttribute("listLecDataModel", listLecDataModel);
		
		// 공통 그룹코드 목록 카운트 조회
		int totalCount = stdsstLecDataService.countListStdsstLecData(paramMap);
		model.addAttribute("totalLecDataCod", totalCount);
		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageLecDataCod",currentPage);
		
		                                                             
		return "stdsst/lecDataList";
	}
	
//	학습자료 단건조회
	@RequestMapping("selectLecDataCod.do")
	@ResponseBody
	public Map<String, Object> selectComnGrpCod (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
	
		// 공통 그룹 코드 단건 조회
		StdsstLecDataModel selectLecDataModel = stdsstLecDataService.selectStdsstLecData(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("selectLecDataModel", selectLecDataModel);
		
	
		return resultMap;
	}
	
	
//	파일 다운로드
	@RequestMapping("downloadfile.do")
	public void downloadfile(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		response.setCharacterEncoding("UTF-8");

		response.setContentType("text/html; charset=UTF-8");
		StdsstLecDataModel searchone = stdsstLecDataService.selectStdsstLecData(paramMap);
	
		//물리경로 조회해서 담기 
		String file = searchone.getAtt_mul();
		String msg ="파일이 존재하지 않습니다.";
		if(file==null){
			PrintWriter w = response.getWriter();
			 w.write("<script>alert('"+msg+"');history.go(-1);</script>");
		       w.flush();
		       w.close();
		}else{
		byte fileByte[] = FileUtils.readFileToByteArray(new File(file));
		
	    response.setContentType("application/octet-stream");
	    response.setContentLength(fileByte.length);
	    response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(searchone.getAtt_ori(),"UTF-8")+"\";");
	    response.setHeader("Content-Transfer-Encoding", "binary");
	    response.getOutputStream().write(fileByte);
		}
	    return ;
	   
	}
	
	
}
	
	