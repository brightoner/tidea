package tidea.review.receipt.controller;

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

import tidea.review.apply.vo.AttachFileVo;
import tidea.review.auth.service.AuthService;
import tidea.review.auth.vo.AuthVo;
import tidea.review.common.service.CommonShService;
import tidea.review.email.service.EmailService;
import tidea.review.email.vo.EmailVo;
import tidea.review.receipt.service.ReceiptService;
import tidea.review.receipt.vo.ReceiptVo;
import tidea.utils.FileUploadUtil;

@Controller
public class ReceiptController {

	
	@Resource(name = "receiptService")
	private ReceiptService receiptService;
	
	@Resource(name = "commonShService")
	private CommonShService commonShService;
	
	@Resource(name = "authService")
	private AuthService authService;
	
	@Resource(name = "emailService")
	private EmailService emailService;
	
	

	/**
	 * 우선신청접수 리스트
	 * @param request
	 * @param model
	 * @param applyVo
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/receipt/receiptMng.do")
	public String receiptInfoList(HttpServletRequest request, Model model, ReceiptVo receiptVo, HttpSession session) throws Exception{
		
		request.setCharacterEncoding("UTF-8");
		
		String aplct_no = request.getParameter("APLCT_NO");
		receiptVo.setAplct_no(aplct_no);
		
		String invt_nm = request.getParameter("INVT_NM");
		receiptVo.setInvt_nm(invt_nm);
		
		String status = request.getParameter("STATUS");
		receiptVo.setStatus(status);
		
		receiptService.receiptInfoList(request, model, receiptVo);
		
		return "/receipt/receiptMng.tiles";
	}
	
	
	/**
	 * 우선신청접수 등록 페이지
	 * @param request
	 * @param model
	 * @param applyVo
	 * @param attachFileVo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/receipt/receiptReg.do")
	public String receiptReg(HttpServletRequest request, Model model, ReceiptVo receiptVo, AttachFileVo attachFileVo) throws Exception{
		
		receiptService.receiptInfoList(request, model, receiptVo);

		Map<String, Object> receipt = receiptService.selectReceiptDetail(receiptVo);
		model.addAttribute("receipt", receipt);
		
		return "/receipt/receiptReg.tiles";
	}
	
	
	/**
	 * 우선신청접수 중복체크
	 * 	- 출원번호
	 * @param request
	 * @param model
	 * @param applyVo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/receipt/duplCheck.do")
	public String duplCheck(HttpServletRequest request, Model model,  ReceiptVo receiptVo) throws Exception {
		
		String aplct_no = request.getParameter("APLCT_NO");
		receiptVo.setAplct_no(aplct_no);
		
		int  result = receiptService.duplCheck(receiptVo);
		
		if(result == 0){
			model.addAttribute("duplCheck", "OK");
			return "jsonView";
		}else {
			model.addAttribute("duplCheck", "Error");
			return "jsonView";
		}
	}
	
	
	/**
	 * 우선신청접수 입력
	 * @param uploadFile
	 * @param request
	 * @param type
	 * @param model
	 * @param applyVo
	 * @param attachFileVo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/receipt/insertReceipt.do")
		public String insertReceipt(@RequestParam("uploadFile") List<MultipartFile> uploadFile
				, MultipartHttpServletRequest request, String type, Model model, ReceiptVo receiptVo, AttachFileVo attachFileVo) throws Exception {
		
		String aplct_no = request.getParameter("APLCT_NO");
		receiptVo.setAplct_no(aplct_no);
		
		String invt_nm = request.getParameter("INVT_NM");
		receiptVo.setInvt_nm(invt_nm);
		
		String aplct_dt = request.getParameter("APLCT_DT");
		receiptVo.setAplct_dt(aplct_dt);
		
		String aplct_nm = request.getParameter("APLCT_NM");
		receiptVo.setAplct_nm(aplct_nm);
		
		String memo = request.getParameter("MEMO");
		receiptVo.setMemo(memo);
		
		String status = request.getParameter("STATUS");
		receiptVo.setStatus(status);
		
		receiptService.insertReceipt(receiptVo);
		
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
		
			String path = fileUploadUtil.fileUpload(request, uploadFile, type);
			String file_path = path;							
			attachFileVo.setFile_path(file_path);
		
			attachFileVo.setAplct_no(aplct_no);
	
			receiptService.insertReceiptFile_2(attachFileVo);
		
		}
		//*** 첨부파일 끝
		
		String paramUrl = "?searchYn=Y";
		// 신규등록 후 조회화면 1페이지로  설정
		paramUrl += "&curPage=" + 1;
//		paramUrl += "&cols=" + "APPLY_NO,APLCT_NO,USER_ID,APPLY_DT,INVT_NM,ESTIMATE,PAY_METHOD,PRICE,STATUS";
		paramUrl += "&cols=" + "APPLY_NO,RECEIPT_DT,USER_ID,APLCT_NO,INVT_NM,PAY_METHOD,PRICE,STATUS,FILE_DOWN_DT";
		paramUrl += "&keys=" + "APPLY_NO,APLCT_NO,USER_ID,INVT_NM,STATUS";
	
		return "redirect:/receipt/receiptMng.do" + paramUrl;
	}
	

	/**
	 * 우선신청접수 삭제
	 * @param authVo
	 * @param model
	 * @param request
	 * @param applyVo
	 * @param attachFileVo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/receipt/deletReceipt.do")
	public String deleteReceipt(AuthVo authVo, Model model, HttpServletRequest request, ReceiptVo receiptVo, AttachFileVo attachFileVo) throws Exception {
		
		String aplct_no = request.getParameter("APLCT_NO");
		receiptVo.setAplct_no(aplct_no);
		
		receiptService.deleteReceipt(receiptVo);
		
		//첨부파일도 같이 삭제
		attachFileVo.setAplct_no(aplct_no);
		
		// 중앙행정기관, 전담기관 콤보박스 부분
		receiptService.receiptInfoList(request, model, receiptVo);
		
		String paramUrl = "?searchYn=Y";
		// 신규등록 후 조회화면 1페이지로  설정
		paramUrl += "&curPage=" + 1;
//		paramUrl += "&cols=" + "APPLY_NO,APLCT_NO,USER_ID,APPLY_DT,INVT_NM,ESTIMATE,PAY_METHOD,PRICE,STATUS";
		paramUrl += "&cols=" + "APPLY_NO,RECEIPT_DT,USER_ID,APLCT_NO,INVT_NM,PAY_METHOD,PRICE,STATUS,FILE_DOWN_DT";
		paramUrl += "&keys=" + "APPLY_NO,APLCT_NO,USER_ID,INVT_NM,STATUS";
	
		return "redirect:/receipt/receiptMng.do" + paramUrl;
	}
	

	/**
	 * 우선신청접수 수정
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
	@RequestMapping(value="/receipt/receiptUpdate.do")
		public String receiptUpdate(@RequestParam("uploadFile") List<MultipartFile> uploadFile
				, MultipartHttpServletRequest request, String type, Model model, ReceiptVo receiptVo, AttachFileVo attachFileVo, AuthVo authVo, String USER_ID, EmailVo emailVo) throws Exception {
		
		String user_id1 = USER_ID;
		String user_id = user_id1.substring(1);
		receiptVo.setUser_id(user_id);
		
		String aplct_no = request.getParameter("APLCT_NO");
		receiptVo.setAplct_no(aplct_no);
		
		String invt_nm = request.getParameter("INVT_NM");
		receiptVo.setInvt_nm(invt_nm);
		
		String aplct_dt = request.getParameter("APLCT_DT");
		receiptVo.setAplct_dt(aplct_dt);
		
		String aplct_nm = request.getParameter("APLCT_NM");
		receiptVo.setAplct_nm(aplct_nm);
		
		String memo = request.getParameter("MEMO");
		receiptVo.setMemo(memo);
		
		String status = request.getParameter("STATUS");
		receiptVo.setStatus(status);
		
		String receipt_dt = request.getParameter("RECEIPT_DT");
		receiptVo.setReceipt_dt(receipt_dt);
		
		String supply_dt = request.getParameter("SUPPLY_DT");
		receiptVo.setSupply_dt(supply_dt);
		
		receiptService.updateReceipt(receiptVo);
		
		
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
			
			receiptService.insertReceiptFile_2(attachFileVo);
		
		}
		//*** 첨부파일 끝
		
	
		//********* 메일전송 
		if(status == "3" || status.equals("3")) {		// status가 7(보완완료)일때만 전송한다
			
			authVo.setUSER_ID(user_id);
			String mail = authService.getEmail(authVo);			// 신청자(이용자) 메일주소
			
			Map<String, Object> tideaEmailInfo = emailService.getTideaEmail(emailVo);	// 기관메일정보를 DB에서 불러옴
			String receipt_title = (String) tideaEmailInfo.get("RECEIPT_TITLE");		// 보완완료 메시지 제목 - 신청자에게 가는 메일, tidea_email 테이블에서 불러옴
			String receipt_content = (String) tideaEmailInfo.get("RECEIPT_CONTENT");	// 보완완료 메시지 내용 - 신정자에게 가는 메일, tidea_email 테이블에서 불러옴
			
			String title = receipt_title;
			String content = receipt_content;
			
			// 메일보내기
			gmailSend(mail, title, content);
			System.out.println("############## 메일전송 ##############");
		}
		
		//********* 메일전송 끝
		
		
		receiptService.receiptInfoList(request, model, receiptVo);
		
		String paramUrl = "?searchYn=Y";
		// 신규등록 후 조회화면 1페이지로  설정
		paramUrl += "&curPage=" + 1;
//		paramUrl += "&cols=" + "APPLY_NO,APLCT_NO,USER_ID,APPLY_DT,INVT_NM,ESTIMATE,PAY_METHOD,PRICE,STATUS";
		paramUrl += "&cols=" + "APPLY_NO,RECEIPT_DT,USER_ID,APLCT_NO,INVT_NM,PAY_METHOD,PRICE,STATUS,FILE_DOWN_DT";
		paramUrl += "&keys=" + "APPLY_NO,APLCT_NO,USER_ID,INVT_NM,STATUS";
	
		return "redirect:/receipt/receiptMng.do" + paramUrl;
	}
	
	/**
	 * 우선신청접수 수정화면에서 : 첨부파일 삭제버튼 클릭 --> 첨부파일 삭제
	 * @param request
	 * @param model
	 * @param attachFileVo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/receipt/fileDel.do")
	public String fileDel(HttpServletRequest request, Model model, AttachFileVo attachFileVo) throws Exception {
		
		String aplct_no = request.getParameter("APLCT_NO");
		attachFileVo.setAplct_no(aplct_no);
		
		String file_nm = request.getParameter("FILE_NM");
		attachFileVo.setFile_nm(file_nm);
		
		receiptService.delReceiptFile_2(attachFileVo);
		
		return "jsonView";
	}
	
	
	/**
	 * 우선신청접수 상세보기
	 * @param request
	 * @param model
	 * @param applyVo
	 * @param attachFileVo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/receipt/receiptDetail.do")
	public String selectReceiptDetail(HttpServletRequest request, Model model, ReceiptVo receiptVo, AttachFileVo attachFileVo) throws Exception{
		
		// 중앙행정기관, 전담기관 콤보박스 부분
		receiptService.receiptInfoList(request, model, receiptVo);
		
		
		String user_id = request.getParameter("USER_ID");
		receiptVo.setUser_id(user_id);
		
		String aplct_no = request.getParameter("APLCT_NO");
		receiptVo.setAplct_no(aplct_no);
		
		int apply_no = Integer.parseInt(request.getParameter("APPLY_NO"));
		receiptVo.setApply_no(apply_no);
		
		Map<String, Object> receipt = receiptService.selectReceiptDetail(receiptVo);
		System.out.println("********* receipt : " + receipt);
		model.addAttribute("receipt",receipt);
		
		//	첨부파일 관련
		attachFileVo.setAplct_no(aplct_no);
		
		
		List<Map<String, Object>> fileInfo = receiptService.selectReceiptFileDetail(attachFileVo); 		// 이용자 첨부파일
		List<Map<String, Object>> fileInfo_2 = receiptService.selectReceiptFileDetail_2(attachFileVo);	// 접수원 첨부파일
		model.addAttribute("fileInfo",fileInfo);
		model.addAttribute("fileInfo_2",fileInfo_2);
		
		return "/receipt/receiptUpdate.tiles";
	}
	
	
	
	//SMTP 메일보내기
	public  void gmailSend(String mail, String title, String content) throws Exception {
		
		EmailVo emailVo = new EmailVo();	
		Map<String, Object> tideaEmailInfo = emailService.getTideaEmail(emailVo);		// 기관메일정보를 DB에서 불러옴
		final String user = (String) tideaEmailInfo.get("EMAIL_ADDR");
		final String password = (String) tideaEmailInfo.get("PASSWORD");

        // SMTP 서버 정보를 설정한다.
        Properties prop = new Properties();
        
//        // gmail  사용시
        prop.put("mail.smtp.host", "smtp.gmail.com"); 
        prop.put("mail.smtp.port", 465); 
        prop.put("mail.smtp.auth", "true"); 
        prop.put("mail.smtp.ssl.enable", "true"); 
        prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");
        
        // daum 메일  사용시
//      prop.put("mail.smtp.host", "smtp.daum.net");	
//      prop.put("mail.smtp.port", "465");
//      prop.put("mail.smtp.ssl.enable", "true");
//      prop.put("mail.smtp.auth", "true");
        
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

