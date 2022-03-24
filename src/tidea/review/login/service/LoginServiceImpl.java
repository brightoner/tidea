package tidea.review.login.service;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import tidea.oraclejava.EncodeHash;
import tidea.review.auth.dao.AuthDao;
import tidea.review.auth.vo.AuthVo;
import tidea.review.login.dao.LoginDao;
import tidea.review.login.vo.LoginVo;
import tidea.utils.IpAddressUtil;

@Service("loginService")
public class LoginServiceImpl implements LoginService {
	
	@Resource
	private LoginDao loginDao;
	
	@Resource
	private AuthDao authDao;
	

	
	public String goLogin(HttpServletRequest request, Model model, AuthVo authVo) throws Exception {
		
		String userId = "";
		String userPw = "";
		String aaa = "";
		if(StringUtils.equalsIgnoreCase("X", String.valueOf(request.getAttribute("USER_PWD")))){
			userId = (String) request.getAttribute("USER_ID");
			userPw = (String) request.getAttribute("USER_PWD");
			aaa = EncodeHash.sha256(userPw);
		}else{
			userId = (String) request.getParameter("USER_ID");
			userPw = (String) request.getParameter("USER_PWD");
			aaa = EncodeHash.sha256(userPw);
		}
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("USER_ID", userId);
		paramMap.put("USER_PWD", aaa);
		
		// 로그인 실패 5번이상 && 10분미만일결우를 체크 하기위해 
		Map<String, Object> failMap = new HashMap<String, Object>();
		failMap = loginDao.selectFailInfo(userId); // 로그인 실패카운드, 마지막 로그인 시도시간, 로그인가능여부 확인
		
		if(failMap == null || failMap.equals("")) {	// 아이디를 넣지 않고 로그인 버튼을 누를경우				
			return "loginErrorCode";
		}
		
		int login_fail_cnt = Integer.parseInt(String.valueOf(failMap.get("LOGIN_FAIL_COUNT")));	// 실패카운드
		int diffMinutes = Integer.parseInt(String.valueOf(failMap.get("LOGIN_TRY_DT")));		// 시도시간
		String login_at = String.valueOf(failMap.get("LOGIN_AT"));								// 로그인가능여부
		
		
		int rsIdCheck = loginDao.selectLoginUserIdCheck(userId);	// 아이디가 존재하는지 체크
		
		// 아이디가 존재하는 경우
		if(rsIdCheck > 0){
			
			String rsPwCheck = loginDao.selectLoginPwCheck(paramMap);	// 비밀번호가 맞는지 체크
			
			if(StringUtils.equals("Y", rsPwCheck)){					// 비밀번호가 일치하는 경우 
				if(login_at.equals("N") && diffMinutes <= 10) {		// 로그인 가능여부 N 이고, 시간이 10분이 지나지 않았을 경우 ==> 로그인 X
					return "pwCnt_ERROR";
				}else {												// 로그인 가능여부 Y 이고, 시간이 10분이 지난경우 ==> 로그인 o
				
					Map<String, Object> rUserMap = new HashMap<String, Object>();	//userId에 해당하는 직원 정보 조회
					
					loginDao.resetLoginFailCnt(authVo); 			// 로그인 성공시 로그인실패카운트 초기화, 로그인 가능여부 Y, 로그인 시간 최신화
					
					rUserMap = loginDao.selectEmployeeAuth(userId); // 유저정보 조회
					
					if(rUserMap == null || rUserMap.equals("")) {	// 로그인 5회 실패로 로그인정보를 못불러올 경우 ==> 로그인 X
						return "PW_ERROR";
					}else {											// 로그인된 경우
						
						System.out.println("=====================================");
						request.getSession().setAttribute("SS_LOGIN_INFO", rUserMap);
						System.out.println("&&&&&&&&& SS_LOGIN_INFO : " + request.getSession().getAttribute("SS_LOGIN_INFO"));
						
						
						//**********************접수자 특정 ip 관리***************************
						// 밑에 if문에서 사용하고자 하는 ip를 넣어준다
						String ip = IpAddressUtil.getIpAddress(request);	// 현재 실제로 접속된 ip4 아이피
						System.out.println("@@@@@@@ ip : " + ip);
						if("AUTH0003".equals(rUserMap.get("AUTH_CD")) || rUserMap.get("AUTH_CD") == "AUTH0003") {			// AUTH0003 : 접수담당자
							if("192.168.1.118".equals(ip) || ip == "192.168.1.118") {	
								return "LOGIN_OK";
							}else {
								return "loginErrorCode";
							}
						}else if ("AUTH0001".equals(rUserMap.get("AUTH_CD")) || rUserMap.get("AUTH_CD") == "AUTH0001") {	// AUTH0001 : 슈퍼관리자
							if("192.168.1.118".equals(ip) || ip == "192.168.1.118") {	
								return "LOGIN_OK";
							}else {
								return "loginErrorCode";
							}
						}
						//***************************************************************
						else { 
							return "LOGIN_OK";
						}
					}
				
				}
			}else{		// 비밀번호가 틀린 경우 (로그인 X)
				
				if(login_fail_cnt < 5) {								// 로그인실패 카운트가 < 5
					loginDao.updateLoginFailCnt(authVo); 				// 로그인 실패시 로그인 실패 카운트 증가, 로그인 시도 시간 최신화
					return "PW_ERROR";
				}else if(login_at.equals("N") && diffMinutes <= 10) {	// 로그인 여부 N && 10분이 안지났을경우
					return "pwCnt_ERROR";
				}else {
					return "";
				}
			}
		}
		
		return "";
	}

	
	
	@Override
	public Map<String, Object> selectMngUrl() throws Exception {
		return loginDao.selectMngUrl();
	}


	
	/**
	 * 우선심사등록시 연간회원, 일반회원구분 - 결제금액을 구분하기 위해
	 * @param AuthVo
	 * @return
	 * @throws Exception
	 */
	@Override
	public String chkAnnualUser(AuthVo AuthVo) throws Exception {
		return loginDao.chkAnnualUser(AuthVo);
	}

	
	/**
	 * 로그인 접속 로그입력
	 * @param loginVo
	 * @throws Exception
	 */
	@Override
	public void insertLoginLog(LoginVo loginVo) throws Exception {
		loginDao.insertLoginLog(loginVo);
		
	}


}
