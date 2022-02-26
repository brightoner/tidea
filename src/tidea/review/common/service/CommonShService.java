package tidea.review.common.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import tidea.review.auth.vo.AuthVo;
import tidea.review.common.vo.CommonVo;

public interface CommonShService {
	
	
	/**
	 * <pre>
	 * @param paramMap 
	 * @Method Name  : selectCotCdOrgList
	 * @Method 설명 : 코드성 목록을 불러온다.
	 * </pre>
	 * @작성일   : 2018. 12. 19.
	 * @작성자   : YTK
	 * @변경이력  :
	 */
	public List<Map<String, Object>> selectCotCdOrgList(String code) throws Exception;

	/**
	 * <pre>
	 * @Method Name  : selectYearCombobox
	 * @Method 설명 : 기준년월부터 현재년도+1까지의 년도 리스트를 불러온다.(콤보박스 사용)
	 * </pre>
	 * @작성일   : 2018. 12. 19.
	 * @작성자   : YTK
	 * @변경이력  :
	 */
	public List<Map<String, Object>> selectYearCombobox() throws Exception;
	
	/**
	 * <pre>
	 * @Method Name  : selectAllItemNmList
	 * @Method 설명 : 항목명 전체 목록
	 * </pre>
	 * @작성일   : 2019. 01. 04.
	 * @작성자   : YTK
	 * @변경이력  :
	 */
	public List<Map<String, Object>> selectAllItemNmList() throws Exception;
	
	/**
	 * <pre>
	 * @Method Name  : approvalOrCancelProcess
	 * @Method 설명 : 승인 또는 승인 취소 처리
	 * </pre>
	 * @작성일   : 2019. 01. 04.
	 * @작성자   : YTK
	 * @변경이력  :
	 */
	public void approvalOrCancelProcess(HttpServletRequest request, Model model) throws Exception;
	
	/**
	 * <pre>
	 * @param paramMap 
	 * @Method Name  : selectCmmnCdList
	 * @Method 설명 : 코드성 목록을 불러온다.
	 * </pre>
	 * @작성일   : 2018. 12. 19.
	 * @작성자   : YTK
	 * @변경이력  :
	 */
	public List<Map<String, Object>> selectCmmnCdList(String codeSe) throws Exception;
	
	/**
	 * <pre>
	 * @param paramMap 
	 * @Method Name  : searchPopupList
	 * @Method 설명 : 검색 팝업화면
	 * </pre>
	 * @작성일   : 2019. 1. 21.
	 * @작성자   : CMK
	 * @변경이력  :
	 */
	public void searchPopupList(AuthVo authVo, Model model, HttpServletRequest request) throws Exception;
	
	/**
	 * <pre>
	 * @Method Name  : cnfirmAtCheck
	 * @Method 설명 : 저장하려는 항목이 승인상태인지 체크
	 * </pre>
	 * @작성일   : 2019. 1. 22.
	 * @작성자   : YTK
	 * @변경이력  :
	 */
	public String cnfirmAtCheck(HttpServletRequest request, Model model) throws Exception;
	
	
	
	
	
	/**
	 * <pre>
	 * @param paramMap 
	 * @Method Name  : insertAllCpvStudMstList
	 * @Method 설명 : 수집한 학생정보를 적재한다.
	 * </pre>
	 * @작성일   : 2018. 12. 19.
	 * @작성자   : YTK
	 * @변경이력  :
	 */
	public void insertAllCpvStudMstList(List<Map<String, Object>> pList) throws Exception;
	
	/**
	 * <pre>
	 * @param paramMap 
	 * @Method Name  : deleteAllCpvStudMstList
	 * @Method 설명 : 적재 했던 학생정보를 삭제한다.
	 * </pre>
	 * @작성일   : 2018. 12. 19.
	 * @작성자   : YTK
	 * @변경이력  :
	 */
	public void deleteAllCpvStudMstList() throws Exception;

	
	/**
	 * <pre>
	 * @param paramMap 
	 * @Method Name  : fileDelete
	 * @Method 설명 : 첨부 되었던 파일을 삭제한다.
	 * </pre>
	 * @작성일   : 2019. 02. 12.
	 * @작성자   : PJB
	 * @변경이력  :
	 */
	public String fileDelete(HttpServletRequest request);
	
	/**
	 * <pre>
	 * @param paramMap 
	 * @Method Name  : fileDelete
	 * @Method 설명 : 첨부 되었던 파일을 삭제한다.
	 * </pre>
	 * @작성일   : 2019. 02. 12.
	 * @작성자   : PJB
	 * @변경이력  :
	 */
	public String fileDeleteBF(HttpServletRequest request);
	
	/**
	 * <pre>
	 * @param paramMap 
	 * @Method Name  : fileDelete
	 * @Method 설명 : 첨부 되었던 파일을 삭제한다.
	 * </pre>
	 * @작성일   : 2019. 02. 12.
	 * @작성자   : PJB
	 * @변경이력  :
	 */
	public String fileDeleteAF(HttpServletRequest request);
	

	public String fileDeleteDGRI(HttpServletRequest request);

	
	
}
