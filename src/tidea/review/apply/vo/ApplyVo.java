package tidea.review.apply.vo;

import tidea.review.common.vo.CommonVo;

public class ApplyVo extends CommonVo{
	
	//심사신청정보
		private String apply_no;		// 신청번호
		private String invt_nm;		// 발명의 명칭
		private String aplct_no;	// 출원번호
		private String aplct_dt;	// 출원일자
		private String aplct_nm;	// 출원인
		private String memo;		// 신청내용
		private String apply_dt;	// 신청일 
		private String status;		// 상태(1:신청완료 2:접수완료 3:납품완료)
		private String review_field;// 우선심사분야(1:특허 2:실용신안)
		private String tech_field;	// 기술분야(1:기계 2:전기/전자 3:화학/바이오)
		private String tax_invoice;	// 세금계산서 발행여부 (Y:발행 N:미발행)
		private String cash_receipt;// 현금영수증발행여부 (Y:발행 N:미발행)
		private String receipt_dt;	// 접수일
		private String file_down_dt;// 보완파일다운로드일자
		private String supply_dt;	// 납품일
		
		//결제정보
		private int order_cd;		// 결제번호
		private String user_id;		// 아이디
		private String price;		// 실제비용
		private String order_dt;	// 결제일
		private String pay_method;	// 결제방식(1:카드결제 2:무통장입금 3:계좌이체)
		
		
		
		public String getApply_no() {
			return apply_no;
		}

		public void setApply_no(String apply_no) {
			this.apply_no = apply_no;
		}

		public String getAplct_no() {
			return aplct_no;
		}

		public void setAplct_no(String aplct_no) {
			this.aplct_no = aplct_no;
		}

		public String getInvt_nm() {
			return invt_nm;
		}

		public void setInvt_nm(String invt_nm) {
			this.invt_nm = invt_nm;
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


		public String getPrice() {
			return price;
		}

		public void setPrice(String price) {
			this.price = price;
		}


		public String getOrder_dt() {
			return order_dt;
		}

		public void setOrder_dt(String order_dt) {
			this.order_dt = order_dt;
		}

		public String getPay_method() {
			return pay_method;
		}

		public void setPay_method(String pay_method) {
			this.pay_method = pay_method;
		}

		public String getReview_field() {
			return review_field;
		}

		public void setReview_field(String review_field) {
			this.review_field = review_field;
		}

		public String getTech_field() {
			return tech_field;
		}

		public void setTech_field(String tech_field) {
			this.tech_field = tech_field;
		}

		public String getTax_invoice() {
			return tax_invoice;
		}

		public void setTax_invoice(String tax_invoice) {
			this.tax_invoice = tax_invoice;
		}

		public String getCash_receipt() {
			return cash_receipt;
		}

		public void setCash_receipt(String cash_receipt) {
			this.cash_receipt = cash_receipt;
		}

		public String getReceipt_dt() {
			return receipt_dt;
		}

		public void setReceipt_dt(String receipt_dt) {
			this.receipt_dt = receipt_dt;
		}

		public String getFile_down_dt() {
			return file_down_dt;
		}

		public void setFile_down_dt(String file_down_dt) {
			this.file_down_dt = file_down_dt;
		}

		public String getSupply_dt() {
			return supply_dt;
		}

		public void setSupply_dt(String supply_dt) {
			this.supply_dt = supply_dt;
		}

		
		
}
