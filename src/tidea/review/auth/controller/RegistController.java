package tidea.review.auth.controller;

import java.util.Map;
import java.util.Properties;

import javax.annotation.Resource;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import tidea.review.auth.service.AuthService;
import tidea.review.auth.vo.AuthVo;
import tidea.review.common.service.CommonShService;
import tidea.review.email.service.EmailService;
import tidea.review.email.vo.EmailVo;
import tidea.review.login.service.LoginService;
import tidea.utils.EncryptUtil;

@Controller
public class RegistController {

	@Resource(name = "authService")
	private AuthService authService;
	
	@Resource(name = "loginService")
	private LoginService loginService;
	
	@Resource(name = "emailService")
	private EmailService emailService;
	
	@Resource(name = "commonShService")
	private CommonShService commonShService;
	
	/**
	 * 신규 사용자 등록시 아이디 중복 체크
	 * @param request
	 * @param model
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/regist/duplIdCheck.do")
	public String duplIdCheck(HttpServletRequest request, Model model, AuthVo vo) throws Exception{
		String user_id = request.getParameter("INSERT_USER_ID");
		vo.setUSER_ID(user_id);
		
		int result = authService.duplIdCheck(vo);
		
		if(result == 0){
			model.addAttribute("duplIdCheck", "OK");
			return "jsonView";
		}else {
			model.addAttribute("duplIdCheck", "Error");
			return "jsonView";
		}
	}
	
	
	/**
	 * 회원가입
	 * @param request
	 * @param model
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/regist/insertUsrMng.do")
	public String insertUsrMng(HttpServletRequest request, Model model, AuthVo vo) throws Exception {
		
		String USER_ID = request.getParameter("INSERT_USER_ID");
		vo.setUSER_ID(USER_ID);
		
		String password = request.getParameter("USER_PWD");
		
		if(password == null || password == "" || password.equals("")) {
			vo.setUSER_PWD("");
		}else {
			String Encrypt = EncryptUtil.sha256(password);
			vo.setUSER_PWD(Encrypt);
		}
		
		String USER_NM = request.getParameter("USER_NM");
		vo.setUSER_NM(USER_NM);
		
		String EMAIL = request.getParameter("INSER_USER_EMAIL");
		vo.setEMAIL(EMAIL);
		
		String AUTH_CD = "AUTH0004";
		vo.setAUTH_CD(AUTH_CD);
		
		String OFFICE_NM = request.getParameter("OFFICE_NM");
		vo.setOFFICE_PHONE(OFFICE_NM);
		
		String OFFICE_PHONE = request.getParameter("OFFICE_PHONE");
		vo.setOFFICE_PHONE(OFFICE_PHONE);
		
		String OFFICE_REG_NO = request.getParameter("OFFICE_REG_NO");
		vo.setOFFICE_REG_NO(OFFICE_REG_NO);
		
		
		authService.insertUsrMng(vo);
		
		return "redirect:/login/login.do";
		
	}
	
	
	//회원가입
	@RequestMapping(value = "/regist/regist.do")
	public String regist() {
		return "/regist/regist.tiles";
	}
	
	//아이디,페스워드 찾기
	@RequestMapping(value = "/regist/idPwFind.do")
	public String idPwFind() {
		return "/regist/idPwFind.tiles";
	}
	
	// 아이디 찾기
	@RequestMapping(value = "/regist/idFind.do")
	public String idFind(HttpServletRequest request, Model model, AuthVo vo) throws Exception{
		
		String email = request.getParameter("INSER_USER_EMAIL");
		vo.setEMAIL(email);
		
		String user_nm = request.getParameter("INSER_USER_NM");
		vo.setUSER_NM(user_nm);
		
		int result = authService.findUser_Id_count(vo);
		String user_id = authService.findUser_Id(vo);
		
		if(result == 1) {
			model.addAttribute("idFind", "OK");
			model.addAttribute("USER_ID", user_id);
		}else{
			model.addAttribute("idFind", "Error");
		}
		
		return "jsonView";
	}
		
	//패스워드찾기
	@RequestMapping(value =  "/regist/passFind.do")
	public String passFind2(HttpServletRequest request, Model model, AuthVo vo) throws Exception {
		
		String email = request.getParameter("EMAIL");
		vo.setEMAIL(email);
		
		String user_nm = request.getParameter("USER_NM");
		vo.setUSER_NM(user_nm);
		
		String user_id = request.getParameter("INSER_USER_ID");
		vo.setUSER_ID(user_id);

		
		int result = authService.findUser_Pw_count(vo);
		if(result == 1) {
			
			/*
			 1. 난수패스워드 생성	int user_pwd = (int)(Math.random() * (99999 - 10000 + 1)) + 10000; // int user_pwd = (int)(Math.random()*10000)+999;
			 2. 난수패스워드 sha256으로 변환 
			 3. user_tb테이블의 user_pwd에 저장
			 4. 난수패스워드 이메일 발송 
			*/
			// 난수 비밀번호를 sha256 암호화
			String user_pwd = Integer.toString((int)(Math.random()*10000)+999);
			String Encrypt = EncryptUtil.sha256(user_pwd);
			vo.setUSER_PWD(Encrypt);
			
			// 임시 비밀번호 update
			authService.updateTempPw(vo);
			
			// 메일 발송용 제목, 내용
			String newLine = System.getProperty("line.separator");	// 문자열 줄바꿈시 사용
			
			String mail = email;
			String title = "티디아 우선심사시스템 입니다. 회원님의 임시 비밀번호를 발송하였습니다.";
			String content = "안녕하십니까? 티디아 우선심사시스템 입니다." + newLine +  "회원님의 임시비밀번호는"+ user_pwd +"입니다." + "감사합니다.";
			
			// 메일보내기
			gmailSend(mail, title, content);
			System.out.println("############ 메일전송 ############");
			
			model.addAttribute("pwFind", "OK");
			
		}else{
			model.addAttribute("pwFind", "Error");
		}
		return "jsonView";
	}
		
	/**
	 * 회원정보  (마이페이지)
	 * @param request
	 * @param model
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/regist/userInfo.do")
	public String userInfo(HttpServletRequest request, Model model, AuthVo vo) throws Exception{
		
		// login session으로 user_id 받기 
		@SuppressWarnings("unchecked")
		Map<String, Object> ssLoginInfo = (Map<String, Object>) request.getSession().getAttribute("SS_LOGIN_INFO");
		String user_id = ssLoginInfo == null ? "" : String.valueOf(ssLoginInfo.get("USER_ID"));
		vo.setUSER_ID(user_id);
		
		Map<String, Object> UserInfo = authService.selectUserInfoDetail(vo);
		
		model.addAttribute("UserInfo", UserInfo);
		
		return "/regist/updateUserInfo.tiles";
	}
	
	
	/**
	 * 회원정보 수정 - 이용자
	 * @param request
	 * @param model
	 * @param authVo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/regist/updateUserInfo.do")
	public String updateUserInfo(HttpServletRequest request, Model model, AuthVo vo) throws Exception{
		
		@SuppressWarnings("unchecked")
		Map<String, Object> ssLoginInfo = (Map<String, Object>) request.getSession().getAttribute("SS_LOGIN_INFO");
		String user_id = ssLoginInfo == null ? "" : String.valueOf(ssLoginInfo.get("USER_ID"));
		vo.setUSER_ID(user_id);
		
		String USER_NM = request.getParameter("USER_NM");
		vo.setUSER_NM(USER_NM);
		
		String EMAIL = request.getParameter("EMAIL");
		vo.setEMAIL(EMAIL);
		
		String MOBILE = request.getParameter("MOBILE");
		vo.setMOBILE(MOBILE);
		
		String OFFICE_NM = request.getParameter("OFFICE_NM");
		vo.setOFFICE_PHONE(OFFICE_NM);
		
		String OFFICE_PHONE = request.getParameter("OFFICE_PHONE");
		vo.setOFFICE_PHONE(OFFICE_PHONE);
		
		String OFFICE_REG_NO = request.getParameter("OFFICE_REG_NO");
		vo.setOFFICE_REG_NO(OFFICE_REG_NO);
		
		authService.updateUserInfo(vo);
		
		return "redirect:/login/login.do";
	}
	
	
	
	/**
	 * 패스워드변경 이동용 컨트롤러
	 * @param request
	 * @param model
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/regist/updatePw1.do")
	public String updatePw1(HttpServletRequest request, Model model, AuthVo vo) throws Exception{
	
		return "/regist/updatePw.tiles";
	}
	
	
	/**
	 * 비밀번호변경주기가 지났을경우 비밀번호변경화면 이동용 컨트롤러
	 * @param request
	 * @param model
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/regist/updatePw2.do")
	public String updatePw2(HttpServletRequest request, Model model, AuthVo vo) throws Exception{
	
		return "/regist/updatePw2.tiles";
	}
	
	
	
	/**
	 * 사용자가 회원정보 수정 시 비밀번호 수정 - 이용자
	 * @param request
	 * @param model
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/regist/updatePw.do")
	public String updatePw(HttpServletRequest request, Model model, AuthVo vo) throws Exception{
		
		
		// login session으로 user_id 받기 
		@SuppressWarnings("unchecked")
		Map<String, Object> ssLoginInfo = (Map<String, Object>) request.getSession().getAttribute("SS_LOGIN_INFO");
		String user_id = ssLoginInfo == null ? "" : String.valueOf(ssLoginInfo.get("USER_ID"));
		vo.setUSER_ID(user_id);
		
		String password = request.getParameter("USER_PWD");
		
		if(password == null || password == "" || password.equals("")) {
			vo.setUSER_PWD("");
		}else {
			String Encrypt = EncryptUtil.sha256(password);
			vo.setUSER_PWD(Encrypt);
		}
		
		authService.updatePw(vo);
		
		
		Map<String, Object> UserInfo = authService.selectUserInfoDetail(vo);
		model.addAttribute("UserInfo", UserInfo);
		return "/regist/updateUserInfo.tiles";
	}
	
		
		
	//SMTP 메일보내기
//	public static void gmailSend(String mail, String title, String content) {
	public  void gmailSend(String mail, String title, String content) throws Exception {
		EmailVo emailVo = new EmailVo();	
		Map<String, Object> tideaEmailInfo = emailService.getTideaEmail(emailVo);	// 기관메일정보를 DB에서 불러옴
		final String user = (String) tideaEmailInfo.get("EMAIL_ADDR");
		final String password = (String) tideaEmailInfo.get("PASSWORD");
    

        // SMTP 서버 정보를 설정한다.
        Properties prop = new Properties();
        
        // gmail  사용시
//        prop.put("mail.smtp.host", "smtp.gmail.com"); 
//        prop.put("mail.smtp.port", 465); 
//        prop.put("mail.smtp.auth", "true"); 
//        prop.put("mail.smtp.ssl.enable", "true"); 
//        prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");
        
        // daum 메일  사용시
//      prop.put("mail.smtp.host", "smtp.daum.net");	
//      prop.put("mail.smtp.port", "465");
//      prop.put("mail.smtp.ssl.enable", "true");
//      prop.put("mail.smtp.auth", "true");
        
     // 카페24 메일 사용시
     		prop.put("mail.smtp.host", "smtp.cafe24.com");	
     		prop.put("mail.smtp.port", 465);
     		prop.put("mail.smtp.ssl.enable", "true");
     		prop.put("mail.smtp.auth", "true");
        
        Session session = Session.getDefaultInstance(prop, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, password);
            }
        });

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(user));

            //수신자메일주소
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(mail)); 

            // Subject
            message.setSubject(title); //메일 제목을 입력

            // Text
            message.setText(content);    //메일 내용을 입력

            // send the message
            Transport.send(message); ////전송
        } catch (AddressException e) {
            e.printStackTrace();
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
	
	
	
	
	
	
	
}
