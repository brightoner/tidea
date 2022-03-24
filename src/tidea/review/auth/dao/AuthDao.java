package tidea.review.auth.dao;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import tidea.review.auth.vo.AuthVo;
import tidea.review.auth.vo.BiznofileVo;

@Mapper("authDao")
public interface AuthDao {

public List<AuthVo> selectMenuList(AuthVo authVo) throws Exception;
	
	public void insertMenu(AuthVo authVo) throws Exception;
	
	public void updateMenu(AuthVo authVo) throws Exception;
	
	public void deleteMenu(AuthVo authVo) throws Exception;
	
	public void updateMenuDtl(AuthVo authVo)throws Exception;
	
	public int selectAuthCdMngListCount(AuthVo vo)throws Exception;
	
	public List<Map<String, Object>> selectAuthCdMngList(AuthVo vo) throws Exception;
	
	public Map<String, Object> selectAuthCdMngDetail(AuthVo vo) throws Exception;
	
	public void insertAuthCdMng(AuthVo vo) throws Exception;
	
	public void updateAuthCdMng(AuthVo vo) throws Exception;
	
	public void deleteAuthCdMng(AuthVo vo) throws Exception;

	public List<Map<String, Object>> selectTopLeftmenuList(Map<String, Object> paramMap) throws Exception;
	
	public int selectCmmnCdMngListCount(AuthVo vo) throws Exception;
	
	public List<Map<String, Object>> selectCmmnCdMngList(AuthVo vo) throws Exception;
	
	public Map<String, Object> selectCmmnCdMngDetail(AuthVo vo) throws Exception;
	
	public void insertCmmnCdMng(AuthVo vo) throws Exception;
	
	public void updateCmmnCdMng(AuthVo vo) throws Exception;
	
	public void deleteCmmnCdMng(AuthVo vo) throws Exception;
	
	
	
	
	
	public List<Map<String, Object>> selectCmmnDtlCdMngDetailList(AuthVo vo) throws Exception;
	
	public void insertCmmnDtlCdMng(AuthVo vo) throws Exception;
	
	public void deleteCmmnDtlCdMng(String codeSe) throws Exception;
	
	
	
	
	// 사용자 관련 *************************************************************************************************
	
	public int selectUsrMngListCount(AuthVo vo) throws Exception;
	
	public List<Map<String, Object>> selectUsrMngList(AuthVo vo) throws Exception;
	
	public Map<String, Object> selectUsrMngDetail(AuthVo vo) throws Exception;
	
	public void insertUsrMng(AuthVo vo) throws Exception;
	
	/**
	 * 관리자가 사용자의 사용여부, 권한 수정
	 * @param vo
	 * @throws Exception
	 */
	public void updateUsrMng(AuthVo vo) throws Exception;
	
	
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
	 * 사용자가 회원정보 삭제 - 탈퇴
	 * @param authVo
	 * @throws Exception
	 */
	public void deleteUserInfo(AuthVo authVo) throws Exception;
	
	
	public void deleteUsrMng(AuthVo vo) throws Exception;
	
	public int duplIdCheck(AuthVo vo) throws Exception;
	
	
	
	
	public void insertAuthDtlMng(AuthVo vo) throws Exception;
	
	public List<AuthVo> selectAuthMenuList(AuthVo vo) throws Exception;
	
	public List<Map<String, Object>> selectMainmenuList(Map<String, Object> paramMap) throws Exception;
	
	public List<Map<String, Object>> selectAllMenuList(Map<String, Object> paramMap) throws Exception;
	
	//성일수정 2019-03-19
//	public String selectCodeNum()throws Exception;

	public List<Map<String, Object>> selectMenuByAuth(Map<String, Object> paramMap);

	public List<Map<String, Object>> selectTopmenuList(Map<String, Object> paramMap);

	public int chkPwdUsrMng(AuthVo vo) throws Exception;
	
	
	
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
	
	
	
	/**
	 * 이용자 회원정보 수정화면 불러오기
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectUserInfoDetail(AuthVo vo) throws Exception;
	
	
	
	
	//기관코드 및 기관상세코드	************************************************************************************************************
	
	public int selectPrOrgMngListCount(AuthVo vo) throws Exception;
	
	public List<Map<String, Object>> selectPrOrgMngList(AuthVo vo) throws Exception;
	
	public Map<String, Object> selectPrOrgMngDetail(AuthVo vo) throws Exception;
	
	public List<Map<String, Object>> selectPrOrgMngDetailList(AuthVo vo) throws Exception;
	
	public void insertPrOrgMng(AuthVo vo) throws Exception;
	
	public void updatePrOrgMng(AuthVo vo) throws Exception;
	
	public void deletePrOrgCdMng(AuthVo vo) throws Exception;
	
	public void insertPrOrgDtlCdMng(AuthVo vo) throws Exception;
	
	public void deletePrOrgDtlCdMng(String codeSe) throws Exception;
	
	
	
// ************* 사업자등록증파일 관련*******************************************************	
		/**
		 * 회원정보에서 사업자등록증파일 select
		 * @param biznofileVo
		 * @return
		 * @throws Exception
		 */
		public List<Map<String, Object>> selectBizNoFile(BiznofileVo biznofileVo) throws Exception;
		
		/**
		 * 회원가입시 사업자등록증파일 insert
		 * @param biznofileVo
		 * @throws Exception
		 */
		public void insertBizNoFile(BiznofileVo biznofileVo) throws Exception;

		/**
		 * 회원정보에서  사업자등록증파일 수정 
		 * @param biznofileVo
		 * @throws Exception
		 */
		public void updateBizNoFile(BiznofileVo biznofileVo) throws Exception; 

		/**
		 * 회원정보 등록 시 사업자등록증파일 삭제
		 * @param biznofileVo
		 * @throws Exception
		 */
		public void deleteBizNoFile(BiznofileVo biznofileVo) throws Exception;
		
		/**
		 * 회원정보  수정 시 사업자등록증파일 삭제
		 * @param biznofileVo
		 * @throws Exception
		 */
		public void delBizNoFile(BiznofileVo biznofileVo) throws Exception;
		
//**************************************************************************	
	
	
	
	
	
	
	
	
	
}
