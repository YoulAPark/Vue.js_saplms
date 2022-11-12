package kr.happyjob.study.admjmt.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.admjmt.model.AdmJmtResumeOutputVo;
import kr.happyjob.study.admjmt.model.AdmJmtResumeVo;

public interface AdmJmtResumeService {

	public List<AdmJmtResumeVo> ResumeLmList(Map<String, Object> paramMap) throws Exception;

	public int ResumeLmListCnt(Map<String, Object> paramMap)throws Exception;

	public List<AdmJmtResumeVo> resumeUserList(Map<String, Object> paramMap)throws Exception;

	public int resumeUserListCnt(Map<String, Object> paramMap)throws Exception;

	public AdmJmtResumeOutputVo selectResumeOutput(Map<String, Object> paramMap)throws Exception;

}
