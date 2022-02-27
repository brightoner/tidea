package tidea.review.auth.vo;

import java.util.List;

import tidea.review.common.vo.CommonVo;

public class AuthVo extends CommonVo {

	/** 메뉴관리 VO */
	private String menu_id;             /* 메뉴 고유ID */ 
	private String menu_nm;             /* 메뉴 명 */ 
	private int menu_levl;              /* 메뉴레벨 */ 
	private String menu_prts_id;        /* 상위 메뉴 ID */ 
	private String menu_use_yn;         /* 메뉴 사용여부 */
	private String menu_use_auth;         /* 메뉴 사용권한 */
	private String menu_use_authChk;    /*메뉴 사용권한저장체크*/
	private int menu_ord;               /* 메뉴순서 */ 
	private String top_menu_yn;         /* 상단 메뉴 여부 */ 
	private String left_menu_yn;        /* 왼쪽 메뉴 여부 */ 
	private String del_yn;              /* 하위메뉴삭제여부 */ 
	private String menu_rol_list;       /* 메뉴권한 */ 
	private String rol_save_yn; 		/* 권한수정여부 */ 
	private String menu_url; 		    /* 권한수정여부 */ 
	private String Save_type;
	private String tagName;
	private String help_ko;
	private String help_eng;
	private String etc;
			
	private String lvl;     // 메뉴 레벨
	private String url;     // 메뉴 URL
	private String menuNm;  // 메뉴 명
	private String menuOrd; // 메뉴 순서
	private List<AuthVo> subList; // 서브 메뉴
	private boolean selYn = false; // 메뉴 선택여부
	
	/** 권한관리 VO */
	private String AUTH_CD;  // 권한코드
	private String AUTH_NM;  // 권한명

	/** 권한관리 검색조건 VO */
	private String SEARCH_AUTH_CD;  
	private String SEARCH_AUTH_NM;
	
	
	/** 공통코드 및 공통상세코드 관리 VO */
	
	private String SEARCH_CODE_NM;      // 코드명(조회용)
	
	private String CMMN_CD_ID;          // 공통코드 ID
	private String CODE_SE;             // 코드구분
	private String CODE_NM;             // 코드명
	private String CODE_DC;             // 코드설명
	private String CMMN_DTL_CD_ID;      // 공통상세코드 ID
	private String DTLCODE;             // 상세코드
	private String DTLCODE_NM;          // 상세코드명
	private String DTLCODE_ENG_NM;      // 상세코드명
	private String DTLCODE_DC;          // 상세코드설명
	private String ORDR;                // 순서
	private String USE_AT;              // 사용여부
	private String SAUPJA_NO;			// 사업기관 번호
	private String ADDRESS;				// 사업기관 주소
	private String OFFICE_REG_NO;		// 사업자등록번호
	private String OFFICE_OWNER_NM;		// 회사 대표 이름

	
	/** 사용자 관리 VO */
	private String RGSDE;				// 등록날짜
	private String USER_NM;				// 사용자 이름
	private String USER_ID;				// 사용자 아이디
	private String USER_PWD;			// 사용자 비밀번호
	private String EMAIL;				// 사용자 E_mail
	private String LAST_LOGIN_DT;		// 마지막접속날짜
	private String MOBILE;				// 핸드폰
	private String OFFICE_NM;			// 기업명
	private String OFFICE_PHONE;		// 회사전화번호
	private String PWD_CHANGE_DT;		// 비밀번호변경일
	
	
	/** 관리자 검색조건 */
	private String SEARCH_USR_ID;			   // 아이디 검색
	private String SEARCH_USR_NM;			   // 이름 검색
	
	
	
	public AuthVo() {
		
	}
	
	public AuthVo(String menu_id, String menu_nm, int menu_levl, String menu_prts_id, String menu_use_yn,
			String menu_use_auth, String menu_use_authChk, int menu_ord, String top_menu_yn, String left_menu_yn,
			String del_yn, String menu_rol_list, String rol_save_yn, String menu_url, String save_type, String tagName,
			String help_ko, String help_eng, String etc, String lvl, String url, String menuNm, String menuOrd,
			List<AuthVo> subList, boolean selYn, String aUTH_CD, String aUTH_NM, String sEARCH_AUTH_CD,
			String sEARCH_AUTH_NM, String sEARCH_CODE_NM, String cMMN_CD_ID, String cODE_SE, String cODE_NM,
			String cODE_DC, String cMMN_DTL_CD_ID, String dTLCODE, String dTLCODE_NM, String dTLCODE_ENG_NM,
			String dTLCODE_DC, String oRDR, String uSE_AT, String sAUPJA_NO, String aDDRESS, String oFFICE_REG_NO,
			String oFFICE_OWNER_NM, String rGSDE, String uSER_NM, String uSER_ID, String uSER_PWD, String eMAIL,
			String lAST_LOGIN_DT, String mOBILE, String oFFICE_NM, String oFFICE_PHONE, String pWD_CHANGE_DT,
			String sEARCH_USR_ID, String sEARCH_USR_NM) {
		super();
		this.menu_id = menu_id;
		this.menu_nm = menu_nm;
		this.menu_levl = menu_levl;
		this.menu_prts_id = menu_prts_id;
		this.menu_use_yn = menu_use_yn;
		this.menu_use_auth = menu_use_auth;
		this.menu_use_authChk = menu_use_authChk;
		this.menu_ord = menu_ord;
		this.top_menu_yn = top_menu_yn;
		this.left_menu_yn = left_menu_yn;
		this.del_yn = del_yn;
		this.menu_rol_list = menu_rol_list;
		this.rol_save_yn = rol_save_yn;
		this.menu_url = menu_url;
		Save_type = save_type;
		this.tagName = tagName;
		this.help_ko = help_ko;
		this.help_eng = help_eng;
		this.etc = etc;
		this.lvl = lvl;
		this.url = url;
		this.menuNm = menuNm;
		this.menuOrd = menuOrd;
		this.subList = subList;
		this.selYn = selYn;
		AUTH_CD = aUTH_CD;
		AUTH_NM = aUTH_NM;
		SEARCH_AUTH_CD = sEARCH_AUTH_CD;
		SEARCH_AUTH_NM = sEARCH_AUTH_NM;
		SEARCH_CODE_NM = sEARCH_CODE_NM;
		CMMN_CD_ID = cMMN_CD_ID;
		CODE_SE = cODE_SE;
		CODE_NM = cODE_NM;
		CODE_DC = cODE_DC;
		CMMN_DTL_CD_ID = cMMN_DTL_CD_ID;
		DTLCODE = dTLCODE;
		DTLCODE_NM = dTLCODE_NM;
		DTLCODE_ENG_NM = dTLCODE_ENG_NM;
		DTLCODE_DC = dTLCODE_DC;
		ORDR = oRDR;
		USE_AT = uSE_AT;
		SAUPJA_NO = sAUPJA_NO;
		ADDRESS = aDDRESS;
		OFFICE_REG_NO = oFFICE_REG_NO;
		OFFICE_OWNER_NM = oFFICE_OWNER_NM;
		RGSDE = rGSDE;
		USER_NM = uSER_NM;
		USER_ID = uSER_ID;
		USER_PWD = uSER_PWD;
		EMAIL = eMAIL;
		LAST_LOGIN_DT = lAST_LOGIN_DT;
		MOBILE = mOBILE;
		OFFICE_NM = oFFICE_NM;
		OFFICE_PHONE = oFFICE_PHONE;
		PWD_CHANGE_DT = pWD_CHANGE_DT;
		SEARCH_USR_ID = sEARCH_USR_ID;
		SEARCH_USR_NM = sEARCH_USR_NM;
	}

	@Override
	public String toString() {
		return "AuthVo [menu_id=" + menu_id + ", menu_nm=" + menu_nm + ", menu_levl=" + menu_levl + ", menu_prts_id="
				+ menu_prts_id + ", menu_use_yn=" + menu_use_yn + ", menu_use_auth=" + menu_use_auth
				+ ", menu_use_authChk=" + menu_use_authChk + ", menu_ord=" + menu_ord + ", top_menu_yn=" + top_menu_yn
				+ ", left_menu_yn=" + left_menu_yn + ", del_yn=" + del_yn + ", menu_rol_list=" + menu_rol_list
				+ ", rol_save_yn=" + rol_save_yn + ", menu_url=" + menu_url + ", Save_type=" + Save_type + ", tagName="
				+ tagName + ", help_ko=" + help_ko + ", help_eng=" + help_eng + ", etc=" + etc + ", lvl=" + lvl
				+ ", url=" + url + ", menuNm=" + menuNm + ", menuOrd=" + menuOrd + ", subList=" + subList + ", selYn="
				+ selYn + ", AUTH_CD=" + AUTH_CD + ", AUTH_NM=" + AUTH_NM + ", SEARCH_AUTH_CD=" + SEARCH_AUTH_CD
				+ ", SEARCH_AUTH_NM=" + SEARCH_AUTH_NM + ", SEARCH_CODE_NM=" + SEARCH_CODE_NM + ", CMMN_CD_ID="
				+ CMMN_CD_ID + ", CODE_SE=" + CODE_SE + ", CODE_NM=" + CODE_NM + ", CODE_DC=" + CODE_DC
				+ ", CMMN_DTL_CD_ID=" + CMMN_DTL_CD_ID + ", DTLCODE=" + DTLCODE + ", DTLCODE_NM=" + DTLCODE_NM
				+ ", DTLCODE_ENG_NM=" + DTLCODE_ENG_NM + ", DTLCODE_DC=" + DTLCODE_DC + ", ORDR=" + ORDR + ", USE_AT="
				+ USE_AT + ", SAUPJA_NO=" + SAUPJA_NO + ", ADDRESS=" + ADDRESS + ", OFFICE_REG_NO=" + OFFICE_REG_NO
				+ ", OFFICE_OWNER_NM=" + OFFICE_OWNER_NM + ", RGSDE=" + RGSDE + ", USER_NM=" + USER_NM + ", USER_ID="
				+ USER_ID + ", USER_PWD=" + USER_PWD + ", EMAIL=" + EMAIL + ", LAST_LOGIN_DT=" + LAST_LOGIN_DT
				+ ", MOBILE=" + MOBILE + ", OFFICE_NM=" + OFFICE_NM + ", OFFICE_PHONE=" + OFFICE_PHONE
				+ ", PWD_CHANGE_DT=" + PWD_CHANGE_DT + ", SEARCH_USR_ID=" + SEARCH_USR_ID + ", SEARCH_USR_NM="
				+ SEARCH_USR_NM + "]";
	}

	public String getMenu_id() {
		return menu_id;
	}
	public void setMenu_id(String menu_id) {
		this.menu_id = menu_id;
	}
	public String getMenu_nm() {
		return menu_nm;
	}
	public void setMenu_nm(String menu_nm) {
		this.menu_nm = menu_nm;
	}
	public int getMenu_levl() {
		return menu_levl;
	}
	public void setMenu_levl(int menu_levl) {
		this.menu_levl = menu_levl;
	}
	public String getMenu_prts_id() {
		return menu_prts_id;
	}
	public void setMenu_prts_id(String menu_prts_id) {
		this.menu_prts_id = menu_prts_id;
	}
	public String getMenu_use_yn() {
		return menu_use_yn;
	}
	public void setMenu_use_yn(String menu_use_yn) {
		this.menu_use_yn = menu_use_yn;
	}
	public int getMenu_ord() {
		return menu_ord;
	}
	public void setMenu_ord(int menu_ord) {
		this.menu_ord = menu_ord;
	}
	public String getTop_menu_yn() {
		return top_menu_yn;
	}
	public void setTop_menu_yn(String top_menu_yn) {
		this.top_menu_yn = top_menu_yn;
	}
	public String getLeft_menu_yn() {
		return left_menu_yn;
	}
	public void setLeft_menu_yn(String left_menu_yn) {
		this.left_menu_yn = left_menu_yn;
	}
	public String getDel_yn() {
		return del_yn;
	}
	public void setDel_yn(String del_yn) {
		this.del_yn = del_yn;
	}
	public String getMenu_rol_list() {
		return menu_rol_list;
	}
	public void setMenu_rol_list(String menu_rol_list) {
		this.menu_rol_list = menu_rol_list;
	}
	public String getRol_save_yn() {
		return rol_save_yn;
	}
	public void setRol_save_yn(String rol_save_yn) {
		this.rol_save_yn = rol_save_yn;
	}
	public String getMenu_url() {
		return menu_url;
	}
	public void setMenu_url(String menu_url) {
		this.menu_url = menu_url;
	}
	public String getSave_type() {
		return Save_type;
	}
	public void setSave_type(String save_type) {
		Save_type = save_type;
	}
	public String getTagName() {
		return tagName;
	}
	public void setTagName(String tagName) {
		this.tagName = tagName;
	}
	public String getHelp_ko() {
		return help_ko;
	}
	public void setHelp_ko(String help_ko) {
		this.help_ko = help_ko;
	}
	public String getHelp_eng() {
		return help_eng;
	}
	public void setHelp_eng(String help_eng) {
		this.help_eng = help_eng;
	}
	public String getEtc() {
		return etc;
	}
	public void setEtc(String etc) {
		this.etc = etc;
	}
	public String getLvl() {
		return lvl;
	}
	public void setLvl(String lvl) {
		this.lvl = lvl;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getMenuNm() {
		return menuNm;
	}
	public void setMenuNm(String menuNm) {
		this.menuNm = menuNm;
	}
	public String getMenuOrd() {
		return menuOrd;
	}
	public void setMenuOrd(String menuOrd) {
		this.menuOrd = menuOrd;
	}
	public List<AuthVo> getSubList() {
		return subList;
	}
	public void setSubList(List<AuthVo> subList) {
		this.subList = subList;
	}
	public boolean isSelYn() {
		return selYn;
	}
	public void setSelYn(boolean selYn) {
		this.selYn = selYn;
	}
	public String getCODE_SE() {
		return CODE_SE;
	}
	public void setCODE_SE(String cODE_SE) {
		CODE_SE = cODE_SE;
	}
	public String getCODE_NM() {
		return CODE_NM;
	}
	public void setCODE_NM(String cODE_NM) {
		CODE_NM = cODE_NM;
	}
	public String getCODE_DC() {
		return CODE_DC;
	}
	public void setCODE_DC(String cODE_DC) {
		CODE_DC = cODE_DC;
	}
	public String getDTLCODE() {
		return DTLCODE;
	}
	public void setDTLCODE(String dTLCODE) {
		DTLCODE = dTLCODE;
	}
	public String getDTLCODE_NM() {
		return DTLCODE_NM;
	}
	public void setDTLCODE_NM(String dTLCODE_NM) {
		DTLCODE_NM = dTLCODE_NM;
	}
	public String getDTLCODE_DC() {
		return DTLCODE_DC;
	}
	public void setDTLCODE_DC(String dTLCODE_DC) {
		DTLCODE_DC = dTLCODE_DC;
	}
	public String getORDR() {
		return ORDR;
	}
	public void setORDR(String oRDR) {
		ORDR = oRDR;
	}
	public String getUSE_AT() {
		return USE_AT;
	}
	public void setUSE_AT(String uSE_AT) {
		USE_AT = uSE_AT;
	}
	public String getSEARCH_CODE_NM() {
		return SEARCH_CODE_NM;
	}
	public void setSEARCH_CODE_NM(String sEARCH_CODE_NM) {
		SEARCH_CODE_NM = sEARCH_CODE_NM;
	}
	public String getCMMN_CD_ID() {
		return CMMN_CD_ID;
	}
	public void setCMMN_CD_ID(String cMMN_CD_ID) {
		CMMN_CD_ID = cMMN_CD_ID;
	}
	public String getCMMN_DTL_CD_ID() {
		return CMMN_DTL_CD_ID;
	}
	public void setCMMN_DTL_CD_ID(String cMMN_DTL_CD_ID) {
		CMMN_DTL_CD_ID = cMMN_DTL_CD_ID;
	}
	public String getDTLCODE_ENG_NM() {
		return DTLCODE_ENG_NM;
	}
	public void setDTLCODE_ENG_NM(String dTLCODE_ENG_NM) {
		DTLCODE_ENG_NM = dTLCODE_ENG_NM;
	}
	public String getAUTH_CD() {
		return AUTH_CD;
	}
	public void setAUTH_CD(String aUTH_CD) {
		AUTH_CD = aUTH_CD;
	}
	public String getAUTH_NM() {
		return AUTH_NM;
	}
	public void setAUTH_NM(String aUTH_NM) {
		AUTH_NM = aUTH_NM;
	}
	public String getSEARCH_AUTH_CD() {
		return SEARCH_AUTH_CD;
	}
	public void setSEARCH_AUTH_CD(String sEARCH_AUTH_CD) {
		SEARCH_AUTH_CD = sEARCH_AUTH_CD;
	}
	public String getSEARCH_AUTH_NM() {
		return SEARCH_AUTH_NM;
	}
	public void setSEARCH_AUTH_NM(String sEARCH_AUTH_NM) {
		SEARCH_AUTH_NM = sEARCH_AUTH_NM;
	}
	public String getMenu_use_auth() {
		return menu_use_auth;
	}
	public void setMenu_use_auth(String menu_use_auth) {
		this.menu_use_auth = menu_use_auth;
	}
	public String getMenu_use_authChk() {
		return menu_use_authChk;
	}
	public void setMenu_use_authChk(String menu_use_authChk) {
		this.menu_use_authChk = menu_use_authChk;
	}
	
	public String getSEARCH_USR_NM() {
		return SEARCH_USR_NM;
	}
	public void setSEARCH_USR_NM(String sEARCH_USR_NM) {
		SEARCH_USR_NM = sEARCH_USR_NM;
	}
	public String getSEARCH_USR_ID() {
		return SEARCH_USR_ID;
	}
	public void setSEARCH_USR_ID(String sEARCH_USR_ID) {
		SEARCH_USR_ID = sEARCH_USR_ID;
	}
	
	
	public String getRGSDE() {
		return RGSDE;
	}
	public void setRGSDE(String rGSDE) {
		RGSDE = rGSDE;
	}
	public String getUSER_NM() {
		return USER_NM;
	}
	public void setUSER_NM(String uSER_NM) {
		USER_NM = uSER_NM;
	}
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
	public String getEMAIL() {
		return EMAIL;
	}
	public void setEMAIL(String eMAIL) {
		EMAIL = eMAIL;
	}
	

	public String getSAUPJA_NO() {
		return SAUPJA_NO;
	}


	public void setSAUPJA_NO(String sAUPJA_NO) {
		SAUPJA_NO = sAUPJA_NO;
	}

	public String getADDRESS() {
		return ADDRESS;
	}


	public void setADDRESS(String aDDRESS) {
		ADDRESS = aDDRESS;
	}


	public String getLAST_LOGIN_DT() {
		return LAST_LOGIN_DT;
	}


	public void setLAST_LOGIN_DT(String lAST_LOGIN_DT) {
		LAST_LOGIN_DT = lAST_LOGIN_DT;
	}


	public String getMOBILE() {
		return MOBILE;
	}


	public void setMOBILE(String mOBILE) {
		MOBILE = mOBILE;
	}


	public String getOFFICE_NM() {
		return OFFICE_NM;
	}


	public void setOFFICE_NM(String oFFICE_NM) {
		OFFICE_NM = oFFICE_NM;
	}


	public String getOFFICE_PHONE() {
		return OFFICE_PHONE;
	}


	public void setOFFICE_PHONE(String oFFICE_PHONE) {
		OFFICE_PHONE = oFFICE_PHONE;
	}


	public String getPWD_CHANGE_DT() {
		return PWD_CHANGE_DT;
	}


	public void setPWD_CHANGE_DT(String pWD_CHANGE_DT) {
		PWD_CHANGE_DT = pWD_CHANGE_DT;
	}

	public String getOFFICE_REG_NO() {
		return OFFICE_REG_NO;
	}

	public void setOFFICE_REG_NO(String oFFICE_REG_NO) {
		OFFICE_REG_NO = oFFICE_REG_NO;
	}

	public String getOFFICE_OWNER_NM() {
		return OFFICE_OWNER_NM;
	}

	public void setOFFICE_OWNER_NM(String oFFICE_OWNER_NM) {
		OFFICE_OWNER_NM = oFFICE_OWNER_NM;
	}


	
	
	
}
