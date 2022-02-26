package tidea.review.common.vo;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

public class CommonVo {
	
	private String KEY;                // KEY
	private String PARTCLR_CN;         // 특이사항
	private String DGRI_FILE_NM;       // 학위수여 증빙파일명(해외인턴쉽 전용)
	private String BF_FILE_NM;         // 연수 전 증빙파일명(해외어학연수 전용)
	private String AF_FILE_NM;         // 연수 후 증빙파일명(해외어학연수 전용)
	private String FILE_NM;            // 증빙파일명
	private String DGRI_PRUF_FILE;     // 학위수여 증빙기록파일위치(해외인턴쉽 전용)
	private String BF_PRUF_FILE;       // 연수 전 증빙등록파일위치(해외어학연수 전용)
	private String AF_PRUF_FILE;       // 연수 후 증빙등록파일위치(해외어학연수 전용)
	private String PRUF_FILE;          // 증빙등록파일위치
	private String SEARCH_CNFIRM_AT;   // 승인상태(조회조건 용)
	private String CNFIRM_AT;          // 승인상태
	private String WRTER;              // 작성자
	private String RGSDE;              // 등록일
	private String UPDDE;              // 수정일
	private String TABLE_NM;           // 테이블명
	private String KEY_NM;             // 키명
	private String EMP_ID; 				//외래키로 쓸 사원아이디
	private String EMP_NM;				//사원명
	private String NOWTAB;				//현재탭이름
	
	
	
	private String FILE_PATH;
	
	private String HAKNYEON;
	
	private String YEAR;
	
	private String HAKGI;
	
	private String HAKBEON;
	
	private String search_keyword;
	
	private String search_type;
	
	private int pageBegin;  // #{start}
	
    private int pageEnd;    // #{end}
    
	private String INSERT_ID;
    
    private String INSERT_IP;
    
    private String INSERT_DT;
    
    private String UPDATE_ID;
    
    private String UPDATE_IP;
    
    private String UPDATE_DT;
    
    private Character notPaging;
    
    private String TAB_NAME;
    private String COLUMN_NM;
    private String TEMP_VALUE;
    
    
	public Character getNotPaging() {
		return notPaging;
	}

	public void setNotPaging(Character notPaging) {
		this.notPaging = notPaging;
	}

	public String getSearch_keyword() {
		return search_keyword;
	}

	public void setSearch_keyword(String search_keyword) {
		this.search_keyword = search_keyword;
	}

	public String getSearch_type() {
		return search_type;
	}

	public void setSearch_type(String search_type) {
		this.search_type = search_type;
	}

	public int getPageBegin() {
		return pageBegin;
	}

	public void setPageBegin(int pageBegin) {
		this.pageBegin = pageBegin;
	}

	public int getPageEnd() {
		return pageEnd;
	}

	public void setPageEnd(int pageEnd) {
		this.pageEnd = pageEnd;
	}
	
	public String getINSERT_ID() {
		return INSERT_ID;
	}

	public void setINSERT_ID(String iNSERT_ID) {
		INSERT_ID = iNSERT_ID;
	}

	public String getINSERT_IP() {
		return INSERT_IP;
	}

	public void setINSERT_IP(String iNSERT_IP) {
		INSERT_IP = iNSERT_IP;
	}

	public String getINSERT_DT() {
		return INSERT_DT;
	}

	public void setINSERT_DT(String iNSERT_DT) {
		INSERT_DT = iNSERT_DT;
	}

	public String getUPDATE_ID() {
		return UPDATE_ID;
	}

	public void setUPDATE_ID(String uPDATE_ID) {
		UPDATE_ID = uPDATE_ID;
	}

	public String getUPDATE_IP() {
		return UPDATE_IP;
	}

	public void setUPDATE_IP(String uPDATE_IP) {
		UPDATE_IP = uPDATE_IP;
	}

	public String getUPDATE_DT() {
		return UPDATE_DT;
	}

	public void setUPDATE_DT(String uPDATE_DT) {
		UPDATE_DT = uPDATE_DT;
	}

	public String getHAKNYEON() {
		return HAKNYEON;
	}

	public void setHAKNYEON(String hAKNYEON) {
		HAKNYEON = hAKNYEON;
	}

	public String getHAKGI() {
		return HAKGI;
	}

	public void setHAKGI(String hAKGI) {
		HAKGI = hAKGI;
	}

	public String getHAKBEON() {
		return HAKBEON;
	}

	public void setHAKBEON(String hAKBEON) {
		HAKBEON = hAKBEON;
	}

	public String getYEAR() {
		return YEAR;
	}

	public void setYEAR(String yEAR) {
		YEAR = yEAR;
	}

	public String getFILE_PATH() {
		return FILE_PATH;
	}

	public void setFILE_PATH(String fILE_PATH) {
		FILE_PATH = fILE_PATH;
	}

	public String getFILE_NM() {
		return FILE_NM;
	}

	public void setFILE_NM(String fILE_NM) {
		FILE_NM = fILE_NM;
	}

	public String getPARTCLR_CN() {
		return PARTCLR_CN;
	}

	public void setPARTCLR_CN(String pARTCLR_CN) {
		PARTCLR_CN = pARTCLR_CN;
	}

	public String getBF_FILE_NM() {
		return BF_FILE_NM;
	}

	public void setBF_FILE_NM(String bF_FILE_NM) {
		BF_FILE_NM = bF_FILE_NM;
	}

	public String getAF_FILE_NM() {
		return AF_FILE_NM;
	}

	public void setAF_FILE_NM(String aF_FILE_NM) {
		AF_FILE_NM = aF_FILE_NM;
	}

	public String getBF_PRUF_FILE() {
		return BF_PRUF_FILE;
	}

	public void setBF_PRUF_FILE(String bF_PRUF_FILE) {
		BF_PRUF_FILE = bF_PRUF_FILE;
	}

	public String getAF_PRUF_FILE() {
		return AF_PRUF_FILE;
	}

	public void setAF_PRUF_FILE(String aF_PRUF_FILE) {
		AF_PRUF_FILE = aF_PRUF_FILE;
	}

	public String getPRUF_FILE() {
		return PRUF_FILE;
	}

	public void setPRUF_FILE(String pRUF_FILE) {
		PRUF_FILE = pRUF_FILE;
	}

	public String getCNFIRM_AT() {
		return CNFIRM_AT;
	}

	public void setCNFIRM_AT(String cNFIRM_AT) {
		CNFIRM_AT = cNFIRM_AT;
	}

	public String getWRTER() {
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		@SuppressWarnings("unchecked")
		Map<String, Object> ssLoginInfo = (Map<String, Object>) request.getSession().getAttribute("SS_LOGIN_INFO");
		String userId = ssLoginInfo == null ? "" : String.valueOf(ssLoginInfo.get("USER_ID"));
		if(WRTER != null && !StringUtils.equals("", WRTER)){
			return WRTER;
		}else{
			return userId;
		}
		
	}

	public void setWRTER(String wRTER) {
		WRTER = wRTER;
	}

	public String getRGSDE() {
		return RGSDE;
	}

	public void setRGSDE(String rGSDE) {
		RGSDE = rGSDE;
	}

	public String getUPDDE() {
		return UPDDE;
	}

	public void setUPDDE(String uPDDE) {
		UPDDE = uPDDE;
	}

	public String getKEY() {
		return KEY;
	}

	public void setKEY(String kEY) {
		KEY = kEY;
	}

	public String getSEARCH_CNFIRM_AT() {
		return SEARCH_CNFIRM_AT;
	}

	public void setSEARCH_CNFIRM_AT(String sEARCH_CNFIRM_AT) {
		SEARCH_CNFIRM_AT = sEARCH_CNFIRM_AT;
	}

	public String getTABLE_NM() {
		return TABLE_NM;
	}

	public void setTABLE_NM(String tABLE_NM) {
		TABLE_NM = tABLE_NM;
	}

	public String getKEY_NM() {
		return KEY_NM;
	}

	public void setKEY_NM(String kEY_NM) {
		KEY_NM = kEY_NM;
	}

	public String getDGRI_FILE_NM() {
		return DGRI_FILE_NM;
	}

	public void setDGRI_FILE_NM(String dGRI_FILE_NM) {
		DGRI_FILE_NM = dGRI_FILE_NM;
	}

	public String getDGRI_PRUF_FILE() {
		return DGRI_PRUF_FILE;
	}

	public void setDGRI_PRUF_FILE(String dGRI_PRUF_FILE) {
		DGRI_PRUF_FILE = dGRI_PRUF_FILE;
	}

	public String getEMP_ID() {
		return EMP_ID;
	}

	public void setEMP_ID(String eMP_ID) {
		EMP_ID = eMP_ID;
	}

	public String getEMP_NM() {
		return EMP_NM;
	}

	public void setEMP_NM(String eMP_NM) {
		EMP_NM = eMP_NM;
	}

	public String getNOWTAB() {
		return NOWTAB;
	}

	public void setNOWTAB(String nOWTAB) {
		NOWTAB = nOWTAB;
	}

	public String getTAB_NAME() {
		return TAB_NAME;
	}

	public void setTAB_NAME(String tAB_NAME) {
		TAB_NAME = tAB_NAME;
	}

	public String getCOLUMN_NM() {
		return COLUMN_NM;
	}

	public void setCOLUMN_NM(String cOLUMN_NM) {
		COLUMN_NM = cOLUMN_NM;
	}

	public String getTEMP_VALUE() {
		return TEMP_VALUE;
	}

	public void setTEMP_VALUE(String tEMP_VALUE) {
		TEMP_VALUE = tEMP_VALUE;
	}

	
}
