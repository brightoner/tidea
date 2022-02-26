package tidea.utils;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;

public class ComponentUtil {

	public static String dataGridSetting(List<Map<String, Object>> listMap, HttpServletRequest request) {

		String str = "";
		// 그리드에 표출될 컬럼
		String cols = request.getParameter("cols") == null ? "" : request.getParameter("cols");
		String[] colsArr = cols.split(",");
		// 키 값
		String key = request.getParameter("keys") == null ? "" : request.getParameter("keys");
		String[] keyArr = key.split(",");

		String gridCheckboxYn = request.getParameter("gridCheckboxYn") == null ? ""
				: request.getParameter("gridCheckboxYn");

		if (null != listMap) {

			for (int i = 0; i < listMap.size(); i++) {
				Map<String, Object> rowMap = listMap.get(i);
				str += "<tr>";

				for (int j = 0; j < colsArr.length; j++) {
					if (StringUtils.equals("Y", gridCheckboxYn)) {
						if (j == 0) {
							str += "<td><input type=\"checkbox\" id=\"\" name=\"gridCheck\" value=\"\"></td>";
						} else {
							String tmpVal = rowMap.get(colsArr[j]) == null ? ""
									: String.valueOf(rowMap.get(colsArr[j]));
							str += "<td>" + tmpVal + "</td>";
						}
					} else {
						String tmpVal = rowMap.get(colsArr[j]) == null ? "" : String.valueOf(rowMap.get(colsArr[j]));
						str += "<td>" + tmpVal + "</td>";
					}
				}

				for (int j = 0; j < keyArr.length; j++) {
					str += "<input type=\"hidden\" id=\"" + keyArr[j] + i + "\" name=\"" + keyArr[j] + i
							+ "\"  value=\"" + rowMap.get(keyArr[j]) + "\" />";
				}
				str += "</tr>";
			}
		}

		request.setAttribute("gridRowCnt", listMap.size());

		return str;
	}

	public static String dataGridSettingShowMore(List<Map<String, Object>> listMap, HttpServletRequest request) {

		String str = "";
		// 그리드에 표출될 컬럼
		String cols = request.getParameter("cols") == null ? "" : request.getParameter("cols");
		String[] colsArr = cols.split(",");
		// 키 값
		String key = request.getParameter("keys") == null ? "" : request.getParameter("keys");
		String[] keyArr = key.split(",");

		String gridCheckboxYn = request.getParameter("gridCheckboxYn") == null ? ""
				: request.getParameter("gridCheckboxYn");

		if (null != listMap) {

			for (int i = 0; i < listMap.size(); i++) {
				Map<String, Object> rowMap = listMap.get(i);
				str += "<tr>";

				for (int j = 0; j < colsArr.length; j++) {
					if (StringUtils.equals("Y", gridCheckboxYn)) {
						if (j == 0) {
							str += "<td><input type=\"checkbox\" id=\"\" name=\"gridCheck\" value=\"\"></td>";
						} else {
							String tmpVal = rowMap.get(colsArr[j]) == null ? ""
									: String.valueOf(rowMap.get(colsArr[j]));
							str += "<td>" + tmpVal + "</td>";
						}
					} else {
						String tmpVal = rowMap.get(colsArr[j]) == null ? "" : String.valueOf(rowMap.get(colsArr[j]));
						String[] tmpVal_list = tmpVal.split(",");
						if (colsArr[j].equals("LICENSE_LIST") && tmpVal_list.length > 1) {
							str += "<td>" + tmpVal_list[0]
									+ " <span onclick=\"return false;\" onmouseout=\"javascript:hideAll(this);return false;\" onmouseover=\"javascript:showMore(this,event);return false;\" id=\""
									+ colsArr[j] + "_" + i + "-Btn" + "\" class=\"moreBtn\">More</span> <div id=\""
									+ colsArr[j] + "_" + i + "-list"
									+ "\" class=\"moreDiv showMoreBtn::after\" style=\"position: absolute; background-color: #fff; border: solid; padding: 5px; display:none; margin-left: 25px; margin-top:-5px;\">";
							
							for (int k = 0; k < tmpVal_list.length; k++) {
								str += tmpVal_list[k] + "</br>";
							}
							
							str += "</div></td>";
						} else {
							str += "<td>" + tmpVal + "</td>";
						}
					}
				}

				for (int j = 0; j < keyArr.length; j++) {
					str += "<input type=\"hidden\" id=\"" + keyArr[j] + i + "\" name=\"" + keyArr[j] + i
							+ "\"  value=\"" + rowMap.get(keyArr[j]) + "\" />";
				}
				str += "</tr>";
			}
		}

		request.setAttribute("gridRowCnt", listMap.size());

		return str;
	}
	
	public static String dataGridSettingSalaryTotal(List<Map<String, Object>> listMap, HttpServletRequest request) {
		String str = "";
		// 그리드에 표출될 컬럼
//		"DEPART,EMP_ID,EMP_NM,BASIC_SALARY, BONUS, SUNDRY_ALLOWANCE, VEHICLE_MAINTENANCE_EXPENSES, TRANSPORTATION_EXPENSES, FOOD_EXPENSES, TUITION_SUBSIDIES, TRAVEL_EXPENSES, OTHER_ALLOWANCES, RESEARCH_ACTIVITY_EXPENSES, PREVIOUS_MONTH_SETTLEMENT, NATIONAL_PENSION, HEALTH_INSURANCE, NURSING_CARE_INSURANCE, EMPLOYMENT_INSURANCE, MUTUAL_AID_INSURANCE, HEALTH_INSURANCE_SETTLEMENT, INCOME_TAX, RESIDENT_TAX, INCOME_TAX_SETTLEMENT, RESIDENT_TAX_SETTLEMENT, NATIONAL_PENSION_SETTLEMENT, TOTAL_AMOUNT_PAY, TOTAL_DEDUCTIBLE, AMOUNT_DEDUCTED"
		String cols = request.getParameter("cols") == null ? "" : request.getParameter("cols");
		String[] colsArr = cols.split(",");
		// 키 값
		String key = request.getParameter("keys") == null ? "" : request.getParameter("keys");
		String[] keyArr = key.split(",");

		String gridCheckboxYn = request.getParameter("gridCheckboxYn") == null ? ""
				: request.getParameter("gridCheckboxYn");

		if (null != listMap) {

			for (int i = 0; i < listMap.size(); i++) {
				Map<String, Object> rowMap = listMap.get(i);
				if (rowMap.get("EMP_ID").equals("총합")) {
					if (rowMap.containsKey("DEPART")) {
						str += "<tr style=\"font-weight: bold;background-color: #DDDDFF;\">";
					} else {
						str += "<tr style=\"font-weight: bold;background-color: slategray;color: white;\">";
					}
				} else if(rowMap.get("EMP_ID").equals("부서계")) {
					str += "<tr style=\"font-weight: bold;background-color: #CCCCFF;\">";
				} else {
					str += "<tr>";
				}

				for (int j = 0; j < colsArr.length; j++) {
					if (StringUtils.equals("Y", gridCheckboxYn)) {
						if (j == 0) {
							str += "<td><input type=\"checkbox\" id=\"\" name=\"gridCheck\" value=\"\"></td>";
						} else {
						String tmpVal = rowMap.get(colsArr[j]) == null ? ""	: String.valueOf(rowMap.get(colsArr[j]));
						str += "<td>" + tmpVal + "</td>";
						}
					} else {
						if( j > 3){
							String tmpVal = rowMap.get(colsArr[j]) == null ? "" : String.format("%,d", Integer.parseInt(String.valueOf(rowMap.get(colsArr[j]))));
							str += "<td>" + tmpVal + "</td>";
						}else{
							String tmpVal = rowMap.get(colsArr[j]) == null ? ""	: String.valueOf(rowMap.get(colsArr[j]));
							str += "<td>" + tmpVal + "</td>";
						}
						
					}
				}

				for (int j = 0; j < keyArr.length; j++) {
					str += "<input type=\"hidden\" id=\"" + keyArr[j] + i + "\" name=\"" + keyArr[j] + i
							+ "\"  value=\"" + rowMap.get(keyArr[j]) + "\" />";
				}
				str += "</tr>";
			}
		}

		request.setAttribute("gridRowCnt", listMap.size());

		return str;
	}
	
	public static String dataGridSettingSalaryList(List<Map<String, Object>> listMap, HttpServletRequest request) {
		String str = "";
		// 그리드에 표출될 컬럼
		String cols = request.getParameter("cols") == null ? "" : request.getParameter("cols");
		String[] colsArr = cols.split(",");
		// 키 값
		String key = request.getParameter("keys") == null ? "" : request.getParameter("keys");
		String[] keyArr = key.split(",");

		String gridCheckboxYn = request.getParameter("gridCheckboxYn") == null ? ""
				: request.getParameter("gridCheckboxYn");

		if (null != listMap) {

			for (int i = 0; i < listMap.size(); i++) {
				Map<String, Object> rowMap = listMap.get(i);
				str += "<tr>";

				for (int j = 0; j < colsArr.length; j++) {
					if (StringUtils.equals("Y", gridCheckboxYn)) {
						if (j == 0) {
							str += "<td><input type=\"checkbox\" id=\"\" name=\"gridCheck\" value=\"\"></td>";
						} else {
							if(j > 4){
								String tmpVal = rowMap.get(colsArr[j]) == null ? "" : String.format("%,d", Integer.parseInt(String.valueOf(rowMap.get(colsArr[j]))));
								str += "<td>" + tmpVal + "</td>";
							}else{
							
							String tmpVal = rowMap.get(colsArr[j]) == null ? ""
									: String.valueOf(rowMap.get(colsArr[j]));
							str += "<td>" + tmpVal + "</td>";
							}
						}
					} else {
						String tmpVal = rowMap.get(colsArr[j]) == null ? "" : String.valueOf(rowMap.get(colsArr[j]));
						str += "<td>" + tmpVal + "</td>";
					}
				}

				for (int j = 0; j < keyArr.length; j++) {
					str += "<input type=\"hidden\" id=\"" + keyArr[j] + i + "\" name=\"" + keyArr[j] + i
							+ "\"  value=\"" + rowMap.get(keyArr[j]) + "\" />";
				}
				str += "</tr>";
			}
		}

		request.setAttribute("gridRowCnt", listMap.size());

		return str;
	}
	

	public static Map<String, Object> dataSplit(String data) {

		String str = "";
		String cols = data == null ? "" : data;
		String[] colsArr = cols.split(",");
		Map<String, Object> dataMap = new HashMap<String, Object>();
		for (int i = 0; i < colsArr.length; i++) {
			dataMap.put(i + "", colsArr[i]);
		}
		return dataMap;
	}

}
