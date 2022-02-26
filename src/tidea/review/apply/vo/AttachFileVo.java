package tidea.review.apply.vo;

public class AttachFileVo {

	
	private String user_id;			// 아이디
	private String aplct_no;		// 출원번호
	private int file_no;			// 파일번호
	private String file_nm;			// 파일이름
	private String file_chng_nm;	// 변환된 파일이름
	private String file_path;		// 파일경로
	private String gubun;			// 첨부파일구분(1:이용자 접수파일 2: 조사원 보강파일)
	
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getAplct_no() {
		return aplct_no;
	}
	public void setAplct_no(String aplct_no) {
		this.aplct_no = aplct_no;
	}
	public int getFile_no() {
		return file_no;
	}
	public void setFile_no(int file_no) {
		this.file_no = file_no;
	}
	public String getFile_nm() {
		return file_nm;
	}
	public void setFile_nm(String file_nm) {
		this.file_nm = file_nm;
	}
	
	public String getFile_chng_nm() {
		return file_chng_nm;
	}
	public void setFile_chng_nm(String file_chng_nm) {
		this.file_chng_nm = file_chng_nm;
	}
	public String getFile_path() {
		return file_path;
	}
	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}
	public String getGubun() {
		return gubun;
	}
	public void setGubun(String gubun) {
		this.gubun = gubun;
	}

	
}
