package tidea.review.email.vo;

public class EmailVo {

	
	/** 티디아 기관메일정보 관리 VO **/
	private String email_addr;			// 티디아 기관메일 주소
	private String password;			// 티디아 기관 메일 비번
	private String apply_title;			// 접수완료메일제목(접수자가 받는메일)
	private String apply_content;		// 접수완료메일내용(접수자가 받는메일)
	private String receipt_title;		// 심사보완완료메일제목(신청자가 받는메일)
	private String receipt_content;		// 심사보완완료메일제목(신청자가 받는메일)
	
	
	public EmailVo() {
		
	}
	
	public EmailVo(String email_addr, String password, String apply_title, String apply_content, String receipt_title,
			String receipt_content) {
		super();
		this.email_addr = email_addr;
		this.password = password;
		this.apply_title = apply_title;
		this.apply_content = apply_content;
		this.receipt_title = receipt_title;
		this.receipt_content = receipt_content;
	}

	@Override
	public String toString() {
		return "EmailVo [email_addr=" + email_addr + ", password=" + password + ", apply_title=" + apply_title
				+ ", apply_content=" + apply_content + ", receipt_title=" + receipt_title + ", receipt_content="
				+ receipt_content + "]";
	}

	public String getEmail_addr() {
		return email_addr;
	}

	public void setEmail_addr(String email_addr) {
		this.email_addr = email_addr;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getApply_title() {
		return apply_title;
	}

	public void setApply_title(String apply_title) {
		this.apply_title = apply_title;
	}

	public String getApply_content() {
		return apply_content;
	}

	public void setApply_content(String apply_content) {
		this.apply_content = apply_content;
	}

	public String getReceipt_title() {
		return receipt_title;
	}

	public void setReceipt_title(String receipt_title) {
		this.receipt_title = receipt_title;
	}

	public String getReceipt_content() {
		return receipt_content;
	}

	public void setReceipt_content(String receipt_content) {
		this.receipt_content = receipt_content;
	}

	
}
