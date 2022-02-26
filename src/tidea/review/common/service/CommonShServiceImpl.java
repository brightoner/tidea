package tidea.review.common.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import tidea.review.auth.vo.AuthVo;
import tidea.review.common.dao.CommonShDao;
import tidea.review.common.vo.CommonVo;
import tidea.utils.PagingUtil;

@Service("commonShService")
public class CommonShServiceImpl implements CommonShService {
	
	@Resource
	private CommonShDao commonShDao;
	

	
	public List<Map<String, Object>> selectCotCdOrgList(String code) throws Exception {
		
		List<Map<String, Object>> list = commonShDao.selectCotCdOrgList(code);
		
		return list;
	}
	
	
	
	public List<Map<String, Object>> selectYearCombobox() throws Exception {
		
		List<Map<String, Object>> list = commonShDao.selectYearCombobox();
		
		return list;
		
	}
	
	
	public List<Map<String, Object>> selectAllItemNmList() throws Exception {
		return commonShDao.selectAllItemNmList();
	}
	
	public void approvalOrCancelProcess(HttpServletRequest request, Model model) throws Exception {
		
		String gubun = request.getParameter("GUBUN") == null ? "" : request.getParameter("GUBUN");
		String apprKey = request.getParameter("APPR_KEY") == null ? "" : request.getParameter("APPR_KEY");
		String[] apprKeyArr = apprKey.split(",");
		
		for(int i = 0; i < apprKeyArr.length; i++){
			
			String key = apprKeyArr[i]; // 키
			String tableName = "USER"; //테이블명 추출
			
			CommonVo paramVo = new CommonVo();
			paramVo.setKEY(key);
			paramVo.setCNFIRM_AT(gubun);
			paramVo.setTABLE_NM("RAS_"+tableName + "_TB");
			paramVo.setKEY_NM("EMP"+ "_ID");
			
			commonShDao.updateApprovalOrCancelProcess(paramVo);
			
		}
		
	}
	
	public List<Map<String, Object>> selectCmmnCdList(String codeSe) throws Exception {
		
		List<Map<String, Object>> list = commonShDao.selectCmmnCdList(codeSe);
		
		return list;
	}
	
	public void searchPopupList(AuthVo authVo, Model model, HttpServletRequest request) throws Exception {
		
		// 현재페이지 유지
		int curPage = 1;
		String tempPage = request.getParameter("curPage");
		if(!(tempPage == null || tempPage == "")){
			curPage = Integer.parseInt(tempPage);
		}
		
		// 파라메터 map
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		
		// 테이터 리스트 카운트
		int totalCnt = commonShDao.searchPopupListCount(authVo);
		
		PagingUtil pageUtil = new PagingUtil(totalCnt, curPage);
		authVo.setPageBegin(pageUtil.getPageBegin());
		authVo.setPageEnd(pageUtil.getPageEnd());
		
		// 데이터 리스트(그리드)
		List<AuthVo> dataList = commonShDao.searchPopupList(authVo);
		
		model.addAttribute("divId", request.getParameter("divId"));
		model.addAttribute("dataList", dataList);
		model.addAttribute("asuthVo", authVo);
		model.addAttribute("paging", pageUtil);
		
	}
	
	public String cnfirmAtCheck(HttpServletRequest request, Model model) throws Exception {
		
		String key = request.getParameter("EMP_ID"); // 키
		String tableName = "USER"; //테이블명 추출
		System.err.println(tableName+"테이블네임");
		CommonVo paramVo = new CommonVo();
		paramVo.setKEY(key);
		paramVo.setTABLE_NM("RAS_"+tableName + "_TB");
		paramVo.setKEY_NM("EMP"+ "_ID");
		
		String cnfirmAt = commonShDao.cnfirmAtCheck(paramVo);
		
		return cnfirmAt;
	}
	
	
	public void insertAllCpvStudMstList(List<Map<String, Object>> pList) throws Exception {
		commonShDao.insertAllCpvStudMstList(pList);
	}
	
	public void deleteAllCpvStudMstList() throws Exception {
		commonShDao.deleteAllCpvStudMstList();
	}

	public String fileDelete(HttpServletRequest request) {
		System.out.println("1");
		//업로드된 경로 가져오기
		String path = request.getParameter("PRUF_FILE");
		//키 가져오기
    	String key = request.getParameter("EMP_ID");
    	
    	//테이블명 추출
    	String tableName = "USER";
    	//쿼리의 파라미터로 넘기기 위해 commvo 객체 생성
    	CommonVo paramVo = new CommonVo();
		paramVo.setKEY(key);
		//_TB와 _ID를 붙여 테이블명과 테이블내 아이디 컬럼을 설정 해준다
		paramVo.setTABLE_NM("RAS_"+tableName + "_TB");
		paramVo.setKEY_NM("EMP"+ "_ID");
		
		//업로드 된 경로를 이용한 파일 객체 생성
    	File file = new File(path);
    	boolean result = false;
    	try{
    		// 파일이 존재 하는지 체크
    		// 없을경우 파일을 삭제하지 않는다.
    	    if(file.exists()){
    	    	System.out.println("2");
    	    	result = file.delete();
    	    }
    	    System.out.println("3");
    	    commonShDao.fileDelete(paramVo);
    	}catch(Exception e){
    		e.printStackTrace();
    		System.out.println("5");
    	}
    	if(result){
    		System.out.println("6");
    		return "O";
    	}else{
    		System.out.println("7");
    		return "X";
    	}
	}
	public String fileDeleteBF(HttpServletRequest request) {
		//업로드된 경로 가져오기
		String path = request.getParameter("BF_PRUF_FILE");
		//키 가져오기
    	String key = request.getParameter("EMP_ID");
    	
    	//테이블명 추출
    	String tableName = "USER";
    	//쿼리의 파라미터로 넘기기 위해 commvo 객체 생성
    	CommonVo paramVo = new CommonVo();
		paramVo.setKEY(key);
		//_TB와 _ID를 붙여 테이블명과 테이블내 아이디 컬럼을 설정 해준다
		paramVo.setTABLE_NM("RAS_"+tableName + "_TB");
		paramVo.setKEY_NM("EMP"+ "_ID");
		
		//업로드 된 경로를 이용한 파일 객체 생성
    	File file = new File(path);
    	boolean result = false;
    	try{
    		// 파일이 존재 하는지 체크
    		// 없을경우 파일을 삭제하지 않는다.
    	    if(file.exists()){
    	    	result = file.delete();
    	    }
    	    commonShDao.fileDeleteBF(paramVo);
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    	if(result){
    		return "O";
    	}else{
    		return "X";
    	}
	}
	public String fileDeleteAF(HttpServletRequest request) {
		//업로드된 경로 가져오기
		String path = request.getParameter("AF_PRUF_FILE");
		//키 가져오기
    	String key = request.getParameter("EMP_ID");
    	
    	//테이블명 추출
    	String tableName = "USER";
    	//쿼리의 파라미터로 넘기기 위해 commvo 객체 생성
    	CommonVo paramVo = new CommonVo();
		paramVo.setKEY(key);
		//_TB와 _ID를 붙여 테이블명과 테이블내 아이디 컬럼을 설정 해준다
		paramVo.setTABLE_NM("RAS_"+tableName + "_TB");
		paramVo.setKEY_NM("EMP"+ "_ID");
		
		//업로드 된 경로를 이용한 파일 객체 생성
    	File file = new File(path);
    	boolean result = false;
    	try{
    		// 파일이 존재 하는지 체크
    		// 없을경우 파일을 삭제하지 않는다.
    	    if(file.exists()){
    	    	result = file.delete();
    	    }
    	    commonShDao.fileDeleteAF(paramVo);
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    	if(result){
    		return "O";
    	}else{
    		return "X";
    	}
	}

	public String fileDeleteDGRI(HttpServletRequest request) {
		//업로드된 경로 가져오기
				String path = request.getParameter("DGRI_PRUF_FILE");
				System.out.println("******************************************************");
				System.out.println("path : " + path);
				System.out.println("******************************************************");
				//키 가져오기
		    	String key = request.getParameter("EMP_ID");
		    	
		    	//테이블명 추출
		    	String tableName = "USER";
		    	//쿼리의 파라미터로 넘기기 위해 commvo 객체 생성
		    	CommonVo paramVo = new CommonVo();
				paramVo.setKEY(key);
				//_TB와 _ID를 붙여 테이블명과 테이블내 아이디 컬럼을 설정 해준다
				paramVo.setTABLE_NM("RAS_"+tableName + "_TB");
				paramVo.setKEY_NM("EMP"+ "_ID");
				
				//업로드 된 경로를 이용한 파일 객체 생성
		    	File file = new File(path);
		    	boolean result = false;
		    	try{
		    		// 파일이 존재 하는지 체크
		    		// 없을경우 파일을 삭제하지 않는다.
		    	    if(file.exists()){
		    	    	result = file.delete();
		    	    }
		    	    commonShDao.fileDeleteDGRI(paramVo);
		    	}catch(Exception e){
		    		e.printStackTrace();
		    	}
		    	if(result){
		    		return "O";
		    	}else{
		    		return "X";
		    	}
			}
	
	
		
}
