package tidea.review.email.contoller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import tidea.review.email.service.EmailService;
import tidea.review.email.vo.EmailVo;

@Controller
public class EmailController {

	@Resource(name = "emailService")
	private EmailService emailService;
	
	
	

	/**
	 * 티디아 이메일 관련정보
	 * 	- 이메일 ID, PW // 우선심사신청, 접수 메일 내용
	 * @param request
	 * @param model
	 * @param emailVo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/email/emailMng.do")
	public String tideaEmailInfo(HttpServletRequest request, Model model, EmailVo emailVo) throws Exception{
		
		Map<String, Object> tideaEmailInfo = emailService.getTideaEmail(emailVo);
		
		model.addAttribute("tideaEmailInfo", tideaEmailInfo);
		
		return "/email/updateTideaEmail.tiles";
	}
	
	
	/**
	 * 티디아 이메일 관련정보 수정
	 * 	- 이메일 ID, PW // 우선심사신청, 접수 메일 내용
	 * @param request
	 * @param model
	 * @param emailVo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/email/updateTideaEmail.do")
	public String updateTideaEmail(HttpServletRequest request, Model model, EmailVo emailVo) throws Exception{
		
		
		String email_addr = request.getParameter("EMAIL_ADDR");
		emailVo.setEmail_addr(email_addr);
		
		String password = request.getParameter("PASSWORD");
		emailVo.setPassword(password);
		
		String apply_title = request.getParameter("APPLY_TITLE");
		emailVo.setApply_title(apply_title);
		
		String apply_content = request.getParameter("APPLY_CONTENT");
		emailVo.setApply_content(apply_content);
		
		String receipt_title = request.getParameter("RECEIPT_TITLE");
		emailVo.setReceipt_title(receipt_title);
		
		String receipt_content = request.getParameter("RECEIPT_CONTENT");
		emailVo.setReceipt_content(receipt_content);
		
		emailService.updateTideaEmail(emailVo);
		
		return "redirect:/login/login.do";
	}
	
	
}
