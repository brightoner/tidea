package tidea.review.auth.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import tidea.review.auth.vo.AuthVo;

public interface AuthService {
	
	public List<AuthVo> readMenuList(AuthVo authVo) throws Exception;

	public void saveMenu(AuthVo authVo, Model model, HttpServletRequest request) throws Exception;
	
	public void deleteMenu(AuthVo authVo) throws Exception;
	
	/**
	 * <pre>
	 * @Method Name  : authCdMng
	 * @Method 설명 : 권한코드 관리화면
	 * </pre>
	 * @작성일   : 2019. 02. 01.
	 * @작성자   : CMK
	 * @변경이력  :
	 */
	public void authCdMng(HttpServletRequest request, Model model, AuthVo vo) throws Exception;
	
	/**
	 * <pre>
	 * @Method Name  : authCdMngDetail
	 * @Method 설명 : 권한코드 관리화면 상세
	 * </pre>
	 * @작성일   : 2019. 02. 01.
	 * @작성자   : CMK
	 * @변경이력  :
	 */
	public Map<String, Object> authCdMngDetail(AuthVo vo) throws Exception;
	
	/**
	 * <pre>
	 * @Method Name  : saveAuthCdMng
	 * @Method 설명 : 권한코드 관리화면 저장(신규, 수정)
	 * </pre>
	 * @작성일   : 2019. 02. 01.
	 * @작성자   : CMK
	 * @변경이력  :
	 */
	public void saveAuthCdMng(HttpServletRequest request, Model model, AuthVo vo) throws Exception; 
	
	/**
	 * <pre>
	 * @Method Name  : deleteAuthCdMng
	 * @Method 설명 : 권한코드 관리화면 삭제
	 * </pre>
	 * @작성일   : 2019. 02. 01.
	 * @작성자   : CMK
	 * @변경이력  :
	 */
	public void deleteAuthCdMng(HttpServletRequest request, Model model, AuthVo vo) throws Exception;
	
	public List<Map<String, Object>> selectTopLeftmenuList(Map<String, Object> paramMap) throws Exception;
	
	public List<AuthVo> selectMenuList(AuthVo authVo) throws Exception;
	
	/**
	 * <pre>
	 * @Method Name  : cmmnCdMng
	 * @Method 설명 : 공통코드 관리화면
	 * </pre>
	 * @작성일   : 2019. 01. 09.
	 * @작성자   : YTK
	 * @변경이력  :
	 */
	public void cmmnCdMng(HttpServletRequest request, Model model, AuthVo vo) throws Exception;
	
	/**
	 * <pre>
	 * @Method Name  : cmmnCdMngDetail
	 * @Method 설명 : 공통코드 관리화면 상세
	 * </pre>
	 * @작성일   : 2019. 01. 09.
	 * @작성자   : YTK
	 * @변경이력  :
	 */
	
	public Map<String, Object> cmmnCdMngDetail(AuthVo vo) throws Exception;
	
	/**
	 * <pre>
	 * @Method Name  : saveCmmnCdMng
	 * @Method 설명 : 공통코드 관리화면 저장(신규, 수정)
	 * </pre>
	 * @작성일   : 2019. 01. 09.
	 * @작성자   : YTK
	 * @변경이력  :
	 */
	public void saveCmmnCdMng(HttpServletRequest request, Model model, AuthVo vo) throws Exception;
	
	/**
	 * <pre>
	 * @Method Name  : deleteCmmnCdMng
	 * @Method 설명 : 공통코드 관리화면 삭제
	 * </pre>
	 * @작성일   : 2019. 01. 09.
	 * @작성자   : YTK
	 * @변경이력  :
	 */
	public void deleteCmmnCdMng(HttpServletRequest request, Model model, AuthVo vo) throws Exception;
	
	
	/**
	 * <pre>
	 * @Method Name  : cmmnDtlCdMngDetail
	 * @Method 설명 : 공통상세코드 관리화면 상세
	 * </pre>
	 * @작성일   : 2019. 01. 09.
	 * @작성자   : YTK
	 * @변경이력  :
	 */
	
	public List<Map<String, Object>> cmmnDtlCdMngDetail(AuthVo vo) throws Exception;
	
	/**
	 * <pre>
	 * @Method Name  : saveCmmnDtlCdMng
	 * @Method 설명 : 공통상세코드 관리화면 저장
	 * </pre>
	 * @작성일   : 2019. 01. 09.
	 * @작성자   : YTK
	 * @변경이력  :
	 */
	public void saveCmmnDtlCdMng(String codeSe, List<AuthVo> voList) throws Exception;
	

	
	
	/**
	 * <pre>
	 * @Method Name  : usrMng
	 * @Method 설명 : 사용자 관리화면
	 * </pre>
	 * @작성일   : 2019. 02. 19.
	 * @작성자   : LJY
	 * @변경이력  :
	 */
	public void usrMng(HttpServletRequest request, Model model, AuthVo vo) throws Exception;
	
	/**
	 * <pre>
	 * @Method Name  : usrMngDetail
	 * @Method 설명 : 사용자 관리화면 상세
	 * </pre>
	 * @작성일   : 2019. 02. 19.
	 * @작성자   : LJY
	 * @변경이력  :
	 */
	public Map<String, Object> usrMngDetail(AuthVo vo) throws Exception;
	
	
	
	/**
	 * 사용자 신규입력시 아이디 중복체크
	 * @param vo
	 * @throws Exception
	 */
	public int duplIdCheck(AuthVo vo) throws Exception;
	
	/**
	 * <pre>
	 * @Method Name  : saveUsrMng
	 * @Method 설명 : 사용자 관리화면 저장(신규, 수정)
	 * </pre>
	 * @작성일   : 2019. 02. 19.
	 * @작성자   : LJY
	 * @변경이력  :
	 */
	public void saveUsrMng(HttpServletRequest request, Model model, AuthVo vo) throws Exception;
	
	
	
	/**
	 * <pre>
	 * @Method Name  : deleteUsrMng
	 * @Method 설명 : 사용자 관리화면 삭제
	 * </pre>
	 * @작성일   : 2019. 02. 19.
	 * @작성자   : LJY
	 * @변경이력  :
	 */
	public void deleteUsrMng(HttpServletRequest request, Model model, AuthVo vo) throws Exception;
	
	
	
	/**
	 * 사용자가 자신의 회원 정보 수정
	 * @param vo
	 * @throws Exception
	 */
	public void updateUserInfo(AuthVo vo) throws Exception;
	
	/**
	 * 사용자가 회원정보 수정 시 비밀번호 수정 - 이용자
	 * @param vo
	 * @throws Exception
	 */
	public void updatePw(AuthVo vo) throws Exception;
	
	/**
	 * 이용자 회원정보 수정화면 불러오기
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectUserInfoDetail(AuthVo vo) throws Exception;
	
	/**
	 * 사용자 입력(회원가입)
	 * @param vo
	 * @throws Exception
	 */
	public void insertUsrMng(AuthVo vo) throws Exception;
	
	
	/**
	 * 아이디찾기
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public String findUser_Id(AuthVo vo) throws Exception;
	
	/**
	 * 아이디찾기 카운트
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public int findUser_Id_count(AuthVo vo) throws Exception;
	
	/**
	 * 비밀번호찾기 카운트
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public int findUser_Pw_count(AuthVo vo) throws Exception;

	/**
	 * 임시비밀번호 update 
	 * @param vo
	 * @throws Exception
	 */
	public void updateTempPw(AuthVo vo) throws Exception;
	
	/**
	 * 로그인시 미자막 로그인 날짜를 입력
	 * @param authVo
	 * @throws Exception
	 */
	public void updateLastLoginDt(AuthVo authVo) throws Exception;
	
	
	/**
	 * 비밀번호 변경날짜 확인 
	 * @param authVo
	 * @return
	 * @throws Exception
	 */
	public String chkPwChangeDt(AuthVo authVo) throws Exception;
	
	
	/**
	 * 논문 접수 후 보완자료 첨부 시 이용자 메일주소 가져오기 - 보완완료 메일전송시 사용
	 * @param authVo
	 * @return
	 * @throws Exception
	 */
	public String getEmail(AuthVo authVo) throws Exception;
	
	/**
	 * 논문 접수 후 보완자료 첨부시 접수자 이메일주소 가져오기 - 보완완료 메일전송시 사용(접수자도 접수된 사실을 알아야하기때문)
	 * @param authVo
	 * @return
	 * @throws Exception
	 */
	public String getRectEmail(AuthVo authVo) throws Exception;
	
	
	/**
	 * 이용자 우선심사신청시  이용자 이름  불러오기 - 신청메일 메일전송시 사용
	 * @param authVo
	 * @return
	 * @throws Exception
	 */
	public String getName(AuthVo authVo) throws Exception;
	
	
	public List<AuthVo> readAuthMenuList(AuthVo vo) throws Exception;
	/**
	 * <pre>
	 * @Method Name  : saveMenuAuthDtlMng
	 * @Method 설명 : 메뉴권한 관리화면 저장
	 * </pre>
	 * @작성일   : 2019. 02. 13.
	 * @작성자   : HBJ
	 * @변경이력  :
	 */
	public void saveAuthDtlMng(String authCd,List<AuthVo> voList) throws Exception;
	public List<Map<String, Object>> selectMainmenuList(Map<String, Object> paramMap) throws Exception;
	
	public List<Map<String, Object>> selectAllMenuList(Map<String, Object> paramMap) throws Exception;

	public List<Map<String, Object>> selectMenuByAuth(Map<String, Object> paramMap);

	public List<Map<String, Object>> selectTopmenuList(Map<String, Object> paramMap);

	public int chkPwdUsrMng(AuthVo vo, HttpServletRequest request, Model model) throws Exception;
	
	
	
	
	// 기관코드 및 기관상세코드

	
	public void prOrgCdMng(HttpServletRequest request, Model model, AuthVo vo) throws Exception;
	
	public Map<String, Object> prOrgMngDetail(AuthVo vo) throws Exception;
	
	public void savePrOgrMng(HttpServletRequest request, Model model, AuthVo vo) throws Exception;
	
	public void deletePrOrgCdMng(HttpServletRequest request, Model model, AuthVo vo) throws Exception;
	
	public List<Map<String, Object>> prOrgDtlMngDetail(AuthVo vo) throws Exception;
	
	public void savePrOrgDtlCdMng(String codeSe, List<AuthVo> voList) throws Exception;
	
	
	
	
	
	
	
	
	
	
}
