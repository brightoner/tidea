package tidea.review.login.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import tidea.review.auth.vo.AuthVo;
import tidea.review.login.vo.LoginVo;

public interface LoginService {

	public String goLogin(HttpServletRequest request, Model model, AuthVo authVo ) throws Exception;
	
	public Map<String, Object> selectMngUrl() throws Exception;
	
	
	/**
	 * 우선심사등록시 연간회원, 일반회원구분 - 결제금액을 구분하기 위해
	 * @param AuthVo
	 * @return
	 * @throws Exception
	 */
	public String chkAnnualUser(AuthVo AuthVo) throws Exception;
	
	/**
	 * 로그인 접속 로그입력
	 * @param loginVo
	 * @throws Exception
	 */
	public void insertLoginLog(LoginVo loginVo) throws Exception;
	
	
	/**
	 * 로그인 실패 5번이상 && 10분미만일결우를 체크 하기위한 
	 * @param userId
	 * @return
	 * @throws Exception
	 */
//	public Map<String, Object> selectFailInfo(String userId) throws Exception;

	
	
}
