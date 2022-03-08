package tidea.review.login.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import tidea.review.auth.vo.AuthVo;

public interface LoginService {

	public String goLogin(HttpServletRequest request, Model model, AuthVo authVo ) throws Exception;
	
	public Map<String, Object> selectMngUrl() throws Exception;
	
	/**
	 * 로그인시 사용여부 확인
	 * @param projectInfoVo
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
	
	
}
