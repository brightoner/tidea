package tidea.review.login.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import tidea.review.auth.service.AuthService;
import tidea.review.auth.vo.AuthVo;
import tidea.review.login.service.LoginService;
import tidea.review.login.vo.LoginVo;
import tidea.utils.EgovHttpSessionBindingListener;
import tidea.utils.IpAddressUtil;

@Controller
public class LoginController {
	
	@Resource(name = "loginService")
	private LoginService loginService;
	
	@Resource(name = "authService")
	private AuthService authService;
	

	
	@RequestMapping(value="/admin/superAdmin.do")
	public String superAdmin(HttpServletRequest request,Model model) throws Exception{
		request.getSession().invalidate();
		return "redirect:/login/login.do";
			
	}
	
	/**
	 * <pre>
	 * @Method Name  : login
	 * @Method 설명 : 관리자 분기처리 메소드 
	 * </pre>
	 * @작성일   : 2019. 2. 19.
	 * @작성자   : HBJ
	 * @변경이력  :
	 */
	@RequestMapping(value="/branch/branch.do")
	public String branch(HttpServletRequest request,Model model) throws Exception{
		@SuppressWarnings("unchecked")
		Map<String, Object> ssLoginInfo = (Map<String, Object>) request.getSession().getAttribute("SS_LOGIN_INFO");
		
		if(null != ssLoginInfo){
			System.err.println(ssLoginInfo.size());
			if(StringUtils.equals(String.valueOf(ssLoginInfo.get("AUTH")), "AUTH0001")){
				Map<String,Object> mngInfo = loginService.selectMngUrl();
				return "redirect:"+mngInfo.get("MENU_URL")+"?ACTIVE_TOP_MENU=TOP_9&ACTIVE_SUB_MENU="+mngInfo.get("MENU_ID");
			}
		}
		request.getSession().invalidate();
		return "redirect:/login/login.do";
			
	}
	
	
	
	/**
	 * <pre>
	 * @Method Name  : login
	 * @Method 설명 : 로그인화면 
	 * </pre>
	 * @작성일   : 2019. 1. 11.
	 * @작성자   : CMK
	 * @변경이력  :
	 */
	@RequestMapping(value="/login/login.do")
	public String login(HttpServletRequest request, Model model) throws Exception {
		String id = request.getParameter("id");
		if(null == id || StringUtils.equals("", id)){
			return "/login/login";
		}
		byte[] decryptByte = Base64.decodeBase64(id.getBytes());
		String decryptId = new String(decryptByte);
		model.addAttribute("id", id);
		model.addAttribute("decryptid", decryptId);
		return "/login/login";
	}
	
	@RequestMapping(value="/login/join.do")
	public String join(HttpServletRequest request, Model model) throws Exception {
		
		return "/login/join.tiles";
	}
	
	/**
	 * <pre>
	 * @Method Name  : goLogin
	 * @Method 설명 : 로그인 처리 
	 * </pre>
	 * @작성일   : 2019. 1. 29.
	 * @작성자   : YTK
	 * @변경이력  :
	 */
	@RequestMapping(value="/login/goLogin.do")
	public String goLogin(HttpServletRequest request, Model model, AuthVo authVo, LoginVo loginVo) throws Exception {
		
		String id = request.getParameter("id") == null ? "" : request.getParameter("id");
		if(!StringUtils.equalsIgnoreCase("", id)){
			byte[] decryptByte = Base64.decodeBase64(id.getBytes());
			String decryptId = new String(decryptByte);
			
			request.setAttribute("USER_ID", decryptId);
			request.setAttribute("USER_PWD", "X");
		}
		
		String loginErrorCode = loginService.goLogin(request, model, authVo);
		System.out.println(loginErrorCode);
		// 아이디와 패스워드가 모두 일치하는 경우
		/* if(StringUtils.equals("LOGIN_OK", loginErrorCode)){
			System.out.println("============ 사 용 자 =============");
			System.out.println(StringUtils.equals("MNGLOGIN_OK", loginErrorCode));
			System.out.println(StringUtils.equals("MNGLOGIN_OK", loginErrorCode));
			return "redirect:/sample/samplemain.do";
		*/
		
		if(loginErrorCode.equals("LOGIN_OK")){
			System.out.println("============ 사 용 자 =============");
			System.out.println(loginErrorCode.equals("LOGIN_OK"));
			
			//************ 비밀번호 변경주기 관련*****************
			// 현재 날짜
			Date now = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String today = sdf.format(now);
			// pwd_change_dt 불러오기
			String pw_change_dt = authService.chkPwChangeDt(authVo);
			
			if(pw_change_dt.compareTo(today) < 0) {		// today가 커서 변경 메시지를 보내야함
				return "redirect:/regist/updatePw2.do";
			}
			//*********************************************
			
			
			//********** 다중로그인 방지 ***********************
			EgovHttpSessionBindingListener listener = new EgovHttpSessionBindingListener();
			request.getSession().setAttribute(authVo.getUSER_ID(), listener);	
			//*********************************************
			
			
			//************* 로그인 접속 로그관련 ************
			@SuppressWarnings("unchecked")
			Map<String, Object> ssLoginInfo = (Map<String, Object>) request.getSession().getAttribute("SS_LOGIN_INFO");
			String user_id = ssLoginInfo == null ? "" : String.valueOf(ssLoginInfo.get("USER_ID"));
			loginVo.setUSER_ID(user_id);
			String user_ip = IpAddressUtil.getIpAddress(request);
			loginVo.setUSER_IP(user_ip);
			
			loginService.insertLoginLog(loginVo);
			//****************************************
			
			return "redirect:/sample/samplemain.do";
			
		}else if(StringUtils.equals("MNGLOGIN_OK", loginErrorCode)){
			System.out.println("============ 관 리 자 =============");
			System.out.println(StringUtils.equals("MNGLOGIN_OK", loginErrorCode));
			
			Map<String,Object> mngInfo = loginService.selectMngUrl();
			System.out.println(mngInfo);
			System.out.println(request.getSession().getAttribute("SS_LOGIN_INFO"));
			return "redirect:"+mngInfo.get("MENU_URL")+"?ACTIVE_TOP_MENU=TOP_9&ACTIVE_SUB_MENU="+mngInfo.get("MENU_ID");
		}
		
		//**********************접수자 특정 ip 관리***************************
		else if(loginErrorCode.equals("loginErrorCode")) {
			System.out.println("******** loginErrorCode : " + loginErrorCode);
			System.out.println("============= 접수자, 슈퍼관리자 ip에러 =================");
			model.addAttribute("loginErrorCode", loginErrorCode);
		}
		//***************************************************************
		
		// 아이디가 틀린 경우
		else{
			model.addAttribute("loginErrorCode", loginErrorCode);
		}
		
		return "/login/login";
	}
	
	
	/**
	 * <pre>
	 * @Method Name  : goLogin
	 * @Method 설명 : 로그아웃 처리 
	 * </pre>
	 * @작성일   : 2019. 1. 29.
	 * @작성자   : YTK
	 * @변경이력  :
	 */
	@RequestMapping(value="/login/goLogout.do")
	public String goLogout(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		
		// 모든 세션 초기화 - 다중로그인 방지를 위해서는 로그아웃시 세션 초기화를 해야한다
		request.getSession().invalidate();
		
			return "/login/login";
	}
	
	
	
	
	
}
