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
		
		// 아이디가 존재하는지 체크
		int rsIdCheck = loginDao.selectLoginUserIdCheck(userId);
		// 아이디가 존재하는 경우
		if(rsIdCheck > 0){
			
			// 비밀번호가 맞는지 체크
			String rsPwCheck = loginDao.selectLoginPwCheck(paramMap);
			
			// 비밀번호가 일치하는 경우 
			if(StringUtils.equals("Y", rsPwCheck)){
				
				
				//userId에 해당하는 직원 정보 조회
				Map<String, Object> rUserMap = new HashMap<String, Object>();
				
				//*************** 20220223 로그인횟수제한관련 ***********
				loginDao.resetLoginFailCnt(authVo); 	// 로그인 성공시 로그인실패카운트 초기화
				//*************************************************
				
				rUserMap = loginDao.selectEmployeeAuth(userId); // 유저정보 조회
				System.out.println("&&&&&&&&& rUserMap : " + rUserMap);
				
				//********************회원사용유무처리여부***************************
				/*
				String userAtCheck = loginDao.useAtCheck(authVo);
				System.out.println("*********** userAtCheck : " + userAtCheck);
				
				if(userAtCheck == "Y" || userAtCheck.equals("Y")) {
					return "LOGIN_OK";
				}
				else {
					return "userAt_ERROR";
				}
				*/
				//***************************************************************
				
				if(rUserMap == null || rUserMap.equals("")) {	// 로그인 5회 실패로 로그인정보를 못불러올 경우
//					return "pwdCnt_ERROR";
					return "PW_ERROR";
				}else {
					
					System.out.println("=====================================");
					request.getSession().setAttribute("SS_LOGIN_INFO", rUserMap);
					System.out.println("&&&&&&&&& SS_LOGIN_INFO : " + request.getSession().getAttribute("SS_LOGIN_INFO"));
					
					//**********************접수자 특정 ip 관리***************************
					// 접수자 권한일 경우 (AUTH0003) 특정아이피에서만 접속 가능 
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
					else { 
						return "LOGIN_OK";
					}
					//************************************************************
				}
				
				
				
				
			}
			// 비밀번호가 틀린 경우
			else{
				
				//*********** 20220223 비밀번호 회수제한 ********************
				loginDao.updateLoginFailCnt(authVo); // 로그인 실패시 로그인 실패 카운트 증가
				//*************************************************
				return "PW_ERROR";
			}
		}
		
		return "";
	}

	@Override
	public Map<String, Object> selectMngUrl() throws Exception {
		return loginDao.selectMngUrl();
	}

	/**
	 * 로그인시 사용여부 확인
	 * @param projectInfoVo
	 * @return
	 * @throws Exception
	 */
	@Override
	public String useAtCheck(AuthVo authVo) throws Exception {
		return loginDao.useAtCheck(authVo);
	}


}
