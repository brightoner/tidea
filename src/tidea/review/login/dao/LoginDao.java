package tidea.review.login.dao;

import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import tidea.review.auth.vo.AuthVo;

@Mapper("loginDao")
public interface LoginDao {
	
	public int selectLoginUserIdCheck(String userId) throws Exception;
	
	public String selectLoginPwCheck(Map<String, Object> paramMap) throws Exception;
	
	public Map<String, Object> selectManagerInfo(String userId) throws Exception;
	
	public Map<String, Object> selectMngUrl() throws Exception;

	public Map<String, Object> selectEmployeeAuth(String userId) throws Exception;

	/**
	 * 로그인시 사용여부 확인
	 * @param authVo
	 * @return
	 * @throws Exception
	 */
	public String useAtCheck(AuthVo authVo) throws Exception;
	
	/**
	 * 우선심사등록시 연간회원, 일반회원구분 - 결제금액을 구분하기 위해
	 * @param AuthVo
	 * @return
	 * @throws Exception
	 */
	public String chkAnnualUser(AuthVo AuthVo) throws Exception;
	
	
	/**
	 * 로그인 실패시 로그인 실패 카운트 증가
	 * @param authVo
	 * @throws Exception
	 */
	public void updateLoginFailCnt(AuthVo authVo) throws Exception;
	
	
	/**
	 * 로그인 성공시 로그인실패카운트 초기화
	 * @param authVo
	 * @throws Exception
	 */
	public void resetLoginFailCnt(AuthVo authVo) throws Exception;
	
	
	
	
	
	
	
	
	
	
	
	
	
}
