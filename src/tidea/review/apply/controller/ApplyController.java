package tidea.review.apply.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
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
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import tidea.review.apply.service.ApplyService;
import tidea.review.apply.vo.ApplyVo;
import tidea.review.apply.vo.AttachFileVo;
import tidea.review.auth.service.AuthService;
import tidea.review.auth.vo.AuthVo;
import tidea.review.common.service.CommonShService;
import tidea.review.email.service.EmailService;
import tidea.review.email.vo.EmailVo;
import tidea.utils.FileUploadUtil;

@Controller
public class ApplyController {

	
	@Resource(name = "applyService")
	private ApplyService applyService;
	
	@Resource(name = "commonShService")
	private CommonShService commonShService;
	
	@Resource(name = "authService")
	private AuthService authService;
	
	@Resource(name = "emailService")
	private EmailService emailService;
	

	/**
	 * 우선심사신청 리스트
	 * @param request
	 * @param model
	 * @param applyVo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/apply/applyMng.do")
	public String applyInfoList(HttpServletRequest request, Model model, ApplyVo applyVo, HttpSession session) throws Exception{
		
		request.setCharacterEncoding("UTF-8");
		
		// login session으로 user_id 받기 
		@SuppressWarnings("unchecked")
		Map<String, Object> ssLoginInfo = (Map<String, Object>) request.getSession().getAttribute("SS_LOGIN_INFO");
		String user_id = ssLoginInfo == null ? "" : String.valueOf(ssLoginInfo.get("USER_ID"));
		applyVo.setUser_id(user_id);
		
		String aplct_no = request.getParameter("APLCT_NO");
		applyVo.setAplct_no(aplct_no);
		
		String invt_nm = request.getParameter("INVT_NM");
		applyVo.setInvt_nm(invt_nm);
		
		String status = request.getParameter("STATUS");
		applyVo.setStatus(status);
		
		applyService.applyInfoList(request, model, applyVo);
		
		return "/apply/applyMng.tiles";
	}
	
	
	/**
	 * 우선심사신청 등록 페이지
	 * @param request
	 * @param model
	 * @param applyVo
	 * @param attachFileVo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/apply/applyReg.do")
	public String applyReg(HttpServletRequest request, Model model, ApplyVo applyVo, AttachFileVo attachFileVo) throws Exception{
		
		applyService.applyInfoList(request, model, applyVo);

		Map<String, Object> apply = applyService.selectApplyDetail(applyVo);
		model.addAttribute("apply", apply);
		
		return "/apply/applyReg.tiles";
	}
	
	
	/**
	 * 우선심사신청 중복체크
	 * 	- 출원번호
	 * @param request
	 * @param model
	 * @param projectInfoVo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/apply/duplCheck.do")
	public String duplCheck(HttpServletRequest request, Model model,  ApplyVo applyVo) throws Exception {
		
		String aplct_no = request.getParameter("APLCT_NO");
		applyVo.setAplct_no(aplct_no);
		
		int  result = applyService.duplCheck(applyVo);
		
		if(result == 0){
			model.addAttribute("duplCheck", "OK");
			return "jsonView";
		}else {
			model.addAttribute("duplCheck", "Error");
			return "jsonView";
		}
	}
	
	
	/**
	 * 우선심사신청 입력
	 * @param uploadFile
	 * @param request
	 * @param type
	 * @param model
	 * @param applyVo
	 * @param attachFileVo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/apply/insertApply.do")
		public String insertApply(@RequestParam("uploadFile") List<MultipartFile> uploadFile
				, MultipartHttpServletRequest request, String type, Model model, ApplyVo applyVo, AttachFileVo attachFileVo, AuthVo authVo, EmailVo emailVo) throws Exception {
		
		@SuppressWarnings("unchecked")
		Map<String, Object> ssLoginInfo = (Map<String, Object>) request.getSession().getAttribute("SS_LOGIN_INFO");
		String user_id = ssLoginInfo == null ? "" : String.valueOf(ssLoginInfo.get("USER_ID"));
		applyVo.setUser_id(user_id);
		authVo.setUSER_ID(user_id);
		
		String aplct_no = request.getParameter("APLCT_NO");
		applyVo.setAplct_no(aplct_no);
		
		String invt_nm = request.getParameter("INVT_NM");
		applyVo.setInvt_nm(invt_nm);
		
		String aplct_dt = request.getParameter("APLCT_DT");
		applyVo.setAplct_dt(aplct_dt);
		
		String aplct_nm = request.getParameter("APLCT_NM");
		applyVo.setAplct_nm(aplct_nm);
		
		String memo = request.getParameter("MEMO");
		applyVo.setMemo(memo);
		
		String fb_type = request.getParameter("FB_TYPE");
		applyVo.setFb_type(fb_type);
		
		String user_nm = authService.getName(authVo);		// 신청자 이름
		authVo.setUSER_ID(user_id);							// 메일 전송시 사용
		
		applyService.insertApply(applyVo);
		
		
		model.addAttribute("USER_NM", user_nm);
		model.addAttribute("APLCT_NO",aplct_no);
		model.addAttribute("INVT_NM",invt_nm);
		model.addAttribute("APLCT_NM",aplct_nm);
		
		//*** 첨부파일 시작
		//FileUploadUtil 객체생성
		FileUploadUtil fileUploadUtil = new FileUploadUtil();
		
		for(int i = 0; i < uploadFile.size(); i++) {
			
			//파일명 앞에 yyyyMMdd_HHmmss 형식으로 붙여 파일명 중복을 방지 
			Date dt = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
			String yyyyMMddHHmm = sdf.format(dt);
			String yyyyMMdd = yyyyMMddHHmm.substring(0,8);
			String HHmm = yyyyMMddHHmm.substring(8,12);
			
			
			String file_nm = uploadFile.get(i).getOriginalFilename();	//file_nm은 원래 이름
			attachFileVo.setFile_nm(file_nm);
			
			// 파일업로드 결과 값을 path로 받아온다(이미 fileUpload() 메소드에서 해당 경로에 업로드는 끝났음 )
			String file_chng_nm = yyyyMMdd + "_" + HHmm + "_" + file_nm;
			attachFileVo.setFile_chng_nm(file_chng_nm);
			
			String path = fileUploadUtil.fileUpload(request, uploadFile, type);
			String file_path = path;	
			attachFileVo.setFile_path(file_path);
		
			attachFileVo.setAplct_no(aplct_no);
			
			applyService.insertApplyFile(attachFileVo);
		
		}
		//*** 첨부파일 끝
		
		
		//***** 신청완료 메일 발송 	<-- 주의!! 결제화면이있을경우 여기서 메일 보내면 안됨 (결제화면이 없는경우 메일 살릴것) 
		// 메일 발송용 제목, 내용
		String mail = authService.getRectEmail(authVo);	// 접수자 메일주소 
	
		Map<String, Object> tideaEmailInfo = emailService.getTideaEmail(emailVo);	// 기관메일정보를 DB에서 불러옴
		String apply_title = (String) tideaEmailInfo.get("APPLY_TITLE");			// 신청완료 메일 제목 - 티디아접수자에게 가는 메일 , tidea_email 테이블에서 불러옴		
		String apply_content = (String) tideaEmailInfo.get("APPLY_CONTENT");		// 신청완료 메일 내용 - 티디아접수자에게 가는 메일 , tidea_email 테이블에서 불러옴	
		
		String title = user_nm + apply_title;
		String content = user_nm + apply_content + authVo.getUSER_ID();
	
		// 메일보내기
		gmailSend(mail, title, content);
		System.out.println("############## 메일전송 ##############");
		
		//***** 신청완료 메일 발송 끝
		
//		String paramUrl = "?searchYn=Y";
//		// 신규등록 후 조회화면 1페이지로  설정
//		paramUrl += "&curPage=" + 1;
//		paramUrl += "&cols=" + "APPLY_NO,APLCT_NO,APPLY_DT,INVT_NM,ESTIMATE,FB_TYPE,PAY_METHOD,PRICE,STATUS";
//		paramUrl += "&keys=" + "APPLY_NO,APLCT_NO";
//		System.out.println("********** paramUrl : " + paramUrl);
	
//		return "redirect:/apply/applyMng.do" + paramUrl;	// 결제창이 없는경우 리스트화면으로 이동
		return "/payment/payment.tiles";					// 결제창이 있는결우 결제화면으로 이동 
	}
	
	//
	/**
	 * 우선심사 신청 시 결제
	 * @param request
	 * @param model
	 * @param applyVo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/regist/payment.do")
	public String payment(HttpServletRequest request, Model model, ApplyVo applyVo ) throws Exception{
		
		@SuppressWarnings("unchecked")
		Map<String, Object> ssLoginInfo = (Map<String, Object>) request.getSession().getAttribute("SS_LOGIN_INFO");
		String user_id = ssLoginInfo == null ? "" : String.valueOf(ssLoginInfo.get("USER_ID"));
		applyVo.setUser_id(user_id);
		
		String aplct_no = request.getParameter("APLCT_NO");
		applyVo.setAplct_no(aplct_no);
		
		String price = request.getParameter("price");
		applyVo.setPrice(price);
		
		String pay_method = request.getParameter("pay_method");
		applyVo.setPay_method(pay_method);
		
		String discnt_rs = request.getParameter("discnt_rs");
		applyVo.setDiscnt_rs(discnt_rs);
		
		applyService.insertPayment(applyVo);
		applyService.updateStatus(applyVo);
		
		String paramUrl = "?searchYn=Y";
		// 신규등록 후 조회화면 1페이지로  설정
		paramUrl += "&curPage=" + 1;
		paramUrl += "&cols=" + "APPLY_NO,APLCT_NO,APPLY_DT,INVT_NM,ESTIMATE,FB_TYPE,PAY_METHOD,PRICE,STATUS";
		paramUrl += "&keys=" + "APPLY_NO,APLCT_NO";
	
		return "redirect:/apply/applyMng.do" + paramUrl;	
	}
	
	
	/**
	 * 우선심사신청 삭제
	 * @param authVo
	 * @param model
	 * @param request
	 * @param applyVo
	 * @param attachFileVo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/apply/deletApply.do")
	public String deleteApply(AuthVo authVo, Model model, HttpServletRequest request, ApplyVo applyVo, AttachFileVo attachFileVo) throws Exception {
		
		@SuppressWarnings("unchecked")
		Map<String, Object> ssLoginInfo = (Map<String, Object>) request.getSession().getAttribute("SS_LOGIN_INFO");
		String user_id = ssLoginInfo == null ? "" : String.valueOf(ssLoginInfo.get("USER_ID"));
		applyVo.setUser_id(user_id);
		
		String aplct_no = request.getParameter("APLCT_NO");
		applyVo.setAplct_no(aplct_no);
		
		applyService.deleteApply(applyVo);
		
		//결제정보도 같이 삭제
		applyService.deletePayment(applyVo);
		
		//첨부파일도 같이 삭제
		attachFileVo.setAplct_no(aplct_no);
		applyService.deleteApplyFile(attachFileVo);
		
		
		// 중앙행정기관, 전담기관 콤보박스 부분
		applyService.applyInfoList(request, model, applyVo);
		
		String paramUrl = "?searchYn=Y";
		// 신규등록 후 조회화면 1페이지로  설정
		paramUrl += "&curPage=" + 1;
		paramUrl += "&cols=" + "APPLY_NO,APLCT_NO,APPLY_DT,INVT_NM,ESTIMATE,FB_TYPE,PAY_METHOD,PRICE,STATUS";
		paramUrl += "&keys=" + "APPLY_NO,APLCT_NO";
	
		return "redirect:/apply/applyMng.do" + paramUrl;
	}
	

	/**
	 * 우선심사신청 수정
	 * @param uploadFile
	 * @param request
	 * @param type
	 * @param model
	 * @param applyVo
	 * @param attachFileVo
	 * @param authVo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/apply/applyUpdate.do")
		public String applyUpdate(@RequestParam("uploadFile") List<MultipartFile> uploadFile
				, MultipartHttpServletRequest request, String type, Model model, ApplyVo applyVo, AttachFileVo attachFileVo, AuthVo authVo) throws Exception {
		
		@SuppressWarnings("unchecked")
		Map<String, Object> ssLoginInfo = (Map<String, Object>) request.getSession().getAttribute("SS_LOGIN_INFO");
		String user_id = ssLoginInfo == null ? "" : String.valueOf(ssLoginInfo.get("USER_ID"));
		applyVo.setUser_id(user_id);
		
		String aplct_no = request.getParameter("APLCT_NO");
		applyVo.setAplct_no(aplct_no);
		
		String invt_nm = request.getParameter("INVT_NM");
		applyVo.setInvt_nm(invt_nm);
		
		String aplct_dt = request.getParameter("APLCT_DT");
		applyVo.setAplct_dt(aplct_dt);
		
		String aplct_nm = request.getParameter("APLCT_NM");
		applyVo.setAplct_nm(aplct_nm);
		
		String memo = request.getParameter("MEMO");
		applyVo.setMemo(memo);
		
		String fb_type = request.getParameter("FB_TYPE");
		applyVo.setFb_type(fb_type);
		
		applyService.updateApply(applyVo);
		
		
		//*** 첨부파일 시작
		//FileUploadUtil 객체생성
		FileUploadUtil fileUploadUtil = new FileUploadUtil();
		
		for(int i = 0; i < uploadFile.size(); i++) {
			
			//파일명 앞에 yyyyMMdd_HHmmss 형식으로 붙여 파일명 중복을 방지 
			Date dt = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
			String yyyyMMddHHmm = sdf.format(dt);
			String yyyyMMdd = yyyyMMddHHmm.substring(0,8);
			String HHmm = yyyyMMddHHmm.substring(8,12);
			
			
			String file_nm = uploadFile.get(i).getOriginalFilename();	//file_nm은 원래 이름
			attachFileVo.setFile_nm(file_nm);
			
			// 파일업로드 결과 값을 path로 받아온다(이미 fileUpload() 메소드에서 해당 경로에 업로드는 끝났음 )
			String file_chng_nm = yyyyMMdd + "_" + HHmm + "_" + file_nm;
			attachFileVo.setFile_chng_nm(file_chng_nm);
			
			String path = fileUploadUtil.fileUpload(request, uploadFile, type);
//			String file_path = path + file_chng_nm;							
			String file_path = path;							
			attachFileVo.setFile_path(file_path);
		
			attachFileVo.setAplct_no(aplct_no);
	
			
			applyService.insertApplyFile(attachFileVo);
		
		}
		//*** 첨부파일 끝
		
		// 중앙행정기관, 전담기관 콤보박스 부분
		applyService.applyInfoList(request, model, applyVo);
		
		String paramUrl = "?searchYn=Y";
		// 신규등록 후 조회화면 1페이지로  설정
		paramUrl += "&curPage=" + 1;
		paramUrl += "&cols=" + "APPLY_NO,APLCT_NO,APPLY_DT,INVT_NM,ESTIMATE,FB_TYPE,PAY_METHOD,PRICE,STATUS";
		paramUrl += "&keys=" + "APPLY_NO,APLCT_NO";
	
		return "redirect:/apply/applyMng.do" + paramUrl;
	}
	
	
	/**
	 * 우선심사신청 수정화면에서 : 첨부파일 삭제버튼 클릭 --> 첨부파일 삭제
	 * @param request
	 * @param model
	 * @param attachFileVo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/apply/fileDel.do")
	public String fileDel(HttpServletRequest request, Model model, AttachFileVo attachFileVo) throws Exception {
		
		String aplct_no = request.getParameter("APLCT_NO");
		attachFileVo.setAplct_no(aplct_no);
		
		String file_nm = request.getParameter("FILE_NM");
		attachFileVo.setFile_nm(file_nm);
		
		applyService.delApplyFile(attachFileVo);
		
		return "jsonView";
	}
	
	
	/**
	 * 우선심사신청 상세보기
	 * @param request
	 * @param model
	 * @param projectInfoVo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/apply/applyDetail.do")
	public String selectApplyDetail(HttpServletRequest request, Model model, ApplyVo applyVo, AttachFileVo attachFileVo) throws Exception{
		
		// 중앙행정기관, 전담기관 콤보박스 부분
		applyService.applyInfoList(request, model, applyVo);
		
		@SuppressWarnings("unchecked")
		Map<String, Object> ssLoginInfo = (Map<String, Object>) request.getSession().getAttribute("SS_LOGIN_INFO");
		String user_id = ssLoginInfo == null ? "" : String.valueOf(ssLoginInfo.get("USER_ID"));
		applyVo.setUser_id(user_id);
		
		String aplct_no = request.getParameter("APLCT_NO");
		applyVo.setAplct_no(aplct_no);
		
		int apply_no =Integer.parseInt(request.getParameter("APPLY_NO"));
		applyVo.setApply_no(apply_no);
		
		Map<String, Object> apply = applyService.selectApplyDetail(applyVo);
		model.addAttribute("apply",apply);
		
		//	첨부파일 관련
		attachFileVo.setAplct_no(aplct_no);
		
		
		List<Map<String, Object>> fileInfo = applyService.selectApplyFileDetail(attachFileVo);			// 이용자
		List<Map<String, Object>> fileInfo_2 = applyService.selectApplyFileDetail_2(attachFileVo);		// 관리자
		model.addAttribute("fileInfo",fileInfo);
		model.addAttribute("fileInfo_2",fileInfo_2);
		
		
		return "/apply/applyUpdate.tiles";
	}
	
	
	
	/**
	 * SMTP 메일보내기
	 * @param mail
	 * @param title
	 * @param content
	 * @throws Exception 
	 */
		public  void gmailSend(String mail, String title, String content) throws Exception {
      
		EmailVo emailVo = new EmailVo();	
		Map<String, Object> tideaEmailInfo = emailService.getTideaEmail(emailVo);	// 기관메일정보를 DB에서 불러옴
		final String user = (String) tideaEmailInfo.get("EMAIL_ADDR");
		final String password = (String) tideaEmailInfo.get("PASSWORD");

        // SMTP 서버 정보를 설정한다.
        Properties prop = new Properties();
        
     // gmail 사용시
//        prop.put("mail.smtp.host", "smtp.gmail.com"); 
//        prop.put("mail.smtp.port", 465); 
//        prop.put("mail.smtp.auth", "true"); 
//        prop.put("mail.smtp.ssl.enable", "true"); 
//        prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");
        
     // daum 메일  사용시
        prop.put("mail.smtp.host", "smtp.daum.net");	
        prop.put("mail.smtp.port", "465");
        prop.put("mail.smtp.ssl.enable", "true");
        prop.put("mail.smtp.auth", "true");
        
		// 카페24 메일 사용시
//		prop.put("mail.smtp.host", "smtp.cafe24.com");	
//		prop.put("mail.smtp.port", 465); 
//		prop.put("mail.smtp.ssl.enable", "true");
//		prop.put("mail.smtp.auth", "true");
        
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
