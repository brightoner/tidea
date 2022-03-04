package tidea.review.receipt.vo;

import tidea.review.common.vo.CommonVo;

public class ReceiptVo extends CommonVo{
	
	//심사신청정보
		private int apply_no;		// 신청번호
		private String invt_nm;		// 발명의 명칭
		private String aplct_no;		// 출원번호
		private String aplct_dt;	// 출원일자
		private String aplct_nm;	// 출원인
		private String memo;		// 신청내용
		private String apply_dt;	// 신청일 
		private String status;		// 상태
		
		//결제정보
		private int order_cd;	// 신청번호
		private String user_id;		// 아이디
		private String user_nm;		// 사용자이름
		private int price;			// 실제비용
		private int expct_cost;		// 예상견적
		private String order_dt;	// 결제일
		private String confirm_dt;	// 결제승인일
		private String account_no;	// 계좌번호
		private String pay_method;	// 결제방식(1:카드결제 2:무통장입금 3:계좌이체)
		
		

	

		public String getInvt_nm() {
			return invt_nm;
		}

		public void setInvt_nm(String invt_nm) {
			this.invt_nm = invt_nm;
		}

		public int getApply_no() {
			return apply_no;
		}

		public void setApply_no(int apply_no) {
			this.apply_no = apply_no;
		}

		public String getAplct_no() {
			return aplct_no;
		}

		public void setAplct_no(String aplct_no) {
			this.aplct_no = aplct_no;
		}

		public String getAplct_dt() {
			return aplct_dt;
		}

		public void setAplct_dt(String aplct_dt) {
			this.aplct_dt = aplct_dt;
		}

		public String getAplct_nm() {
			return aplct_nm;
		}

		public void setAplct_nm(String aplct_nm) {
			this.aplct_nm = aplct_nm;
		}

		public String getMemo() {
			return memo;
		}

		public void setMemo(String memo) {
			this.memo = memo;
		}

		public int getExpct_cost() {
			return expct_cost;
		}

		public void setExpct_cost(int expct_cost) {
			this.expct_cost = expct_cost;
		}

		public String getApply_dt() {
			return apply_dt;
		}

		public void setApply_dt(String apply_dt) {
			this.apply_dt = apply_dt;
		}

		public String getStatus() {
			return status;
		}

		public void setStatus(String status) {
			this.status = status;
		}
		
		public int getOrder_cd() {
			return order_cd;
		}

		public void setOrder_cd(int order_cd) {
			this.order_cd = order_cd;
		}

		public String getUser_id() {
			return user_id;
		}

		public void setUser_id(String user_id) {
			this.user_id = user_id;
		}

		public String getUser_nm() {
			return user_nm;
		}

		public void setUser_nm(String user_nm) {
			this.user_nm = user_nm;
		}

		public int getPrice() {
			return price;
		}

		public void setPrice(int price) {
			this.price = price;
		}

		public String getOrder_dt() {
			return order_dt;
		}

		public void setOrder_dt(String order_dt) {
			this.order_dt = order_dt;
		}

		public String getConfirm_dt() {
			return confirm_dt;
		}

		public void setConfirm_dt(String confirm_dt) {
			this.confirm_dt = confirm_dt;
		}

		public String getAccount_no() {
			return account_no;
		}

		public void setAccount_no(String account_no) {
			this.account_no = account_no;
		}

		public String getPay_method() {
			return pay_method;
		}

		public void setPay_method(String pay_method) {
			this.pay_method = pay_method;
		}
	
	
	
	
}
