package kr.happyjob.study.admjmt.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.admjmt.dao.AdmJmtResumeDao;
import kr.happyjob.study.admjmt.model.AdmJmtResumeOutputVo;
import kr.happyjob.study.admjmt.model.AdmJmtResumeVo;

@Service
public class AdmJmtResumeServiceImpl implements AdmJmtResumeService{

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	AdmJmtResumeDao admJmtResumeDao;

	@Override
	public List<AdmJmtResumeVo> ResumeLmList(Map<String, Object> paramMap) throws Exception {
		List<AdmJmtResumeVo> ResumeList =  admJmtResumeDao.ResumeLmList(paramMap);
		return ResumeList;
	}

	@Override
	public int ResumeLmListCnt(Map<String, Object> paramMap) throws Exception {
		int ResumeLmListCnt = admJmtResumeDao.ResumeLmListCnt(paramMap);
		return ResumeLmListCnt;
	}

	@Override
	public List<AdmJmtResumeVo> resumeUserList(Map<String, Object> paramMap) throws Exception {
		List<AdmJmtResumeVo> resumeUserList = admJmtResumeDao.resumeUserList(paramMap);
		return resumeUserList;
	}

	@Override
	public int resumeUserListCnt(Map<String, Object> paramMap) throws Exception {
		int resumeUserListCnt = admJmtResumeDao.resumeUserListCnt(paramMap);
		return resumeUserListCnt;
	}

	@Override
	public AdmJmtResumeOutputVo selectResumeOutput(Map<String, Object> paramMap) throws Exception {
		AdmJmtResumeOutputVo selectResumeOutput = admJmtResumeDao.selectResumeOutput(paramMap);
		return selectResumeOutput;
	}
	
	
}
