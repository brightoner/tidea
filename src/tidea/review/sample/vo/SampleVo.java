package tidea.review.sample.vo;

import tidea.review.common.vo.CommonVo;

public class SampleVo extends CommonVo {
	
	// 조회용 SET/GET
	private String SEARCH_COL1;
	private String SEARCH_COL2;
	private String SEARCH_COL3;
	
	private String SN;
	private String COL1;
	private String COL2;
	private String COL3;
	
	
	public String getSN() {
		return SN;
	}
	public void setSN(String sN) {
		SN = sN;
	}
	public String getCOL1() {
		return COL1;
	}
	public void setCOL1(String cOL1) {
		COL1 = cOL1;
	}
	public String getCOL2() {
		return COL2;
	}
	public void setCOL2(String cOL2) {
		COL2 = cOL2;
	}
	public String getCOL3() {
		return COL3;
	}
	public void setCOL3(String cOL3) {
		COL3 = cOL3;
	}
	public String getSEARCH_COL1() {
		return SEARCH_COL1;
	}
	public void setSEARCH_COL1(String sEARCH_COL1) {
		SEARCH_COL1 = sEARCH_COL1;
	}
	public String getSEARCH_COL2() {
		return SEARCH_COL2;
	}
	public void setSEARCH_COL2(String sEARCH_COL2) {
		SEARCH_COL2 = sEARCH_COL2;
	}
	public String getSEARCH_COL3() {
		return SEARCH_COL3;
	}
	public void setSEARCH_COL3(String sEARCH_COL3) {
		SEARCH_COL3 = sEARCH_COL3;
	}
	
}
