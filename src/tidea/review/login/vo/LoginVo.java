package tidea.review.login.vo;

public class LoginVo {

	private String USER_ID;      // 사용자 아이디
	private String USER_PWD;     // 사용자 비밀번호
	private String USER_NM;      // 사용자명
	
	
	// 로그인 로그 관련
	private String LOGIN_DT;
	private String USER_IP;
	
	
	
	
	public String getUSER_ID() {
		return USER_ID;
	}
	public void setUSER_ID(String uSER_ID) {
		USER_ID = uSER_ID;
	}
	public String getUSER_PWD() {
		return USER_PWD;
	}
	public void setUSER_PWD(String uSER_PWD) {
		USER_PWD = uSER_PWD;
	}
	public String getUSER_NM() {
		return USER_NM;
	}
	public void setUSER_NM(String uSER_NM) {
		USER_NM = uSER_NM;
	}
	public String getLOGIN_DT() {
		return LOGIN_DT;
	}
	public void setLOGIN_DT(String lOGIN_DT) {
		LOGIN_DT = lOGIN_DT;
	}
	public String getUSER_IP() {
		return USER_IP;
	}
	public void setUSER_IP(String uSER_IP) {
		USER_IP = uSER_IP;
	}
	
	
}
