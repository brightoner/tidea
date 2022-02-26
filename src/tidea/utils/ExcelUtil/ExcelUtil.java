package tidea.utils.ExcelUtil;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor.HSSFColorPredefined;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.web.multipart.MultipartFile;

import tidea.utils.FileUploadUtil;

//엑셀 다운로드 및 업로드를 위한 엑셀 유틸


public class ExcelUtil{
	
		public static List<Map<String, String>> read(HttpServletRequest request, MultipartFile file){
			//변환시키기 위하여 excel 폴더에 업로드하기 위한 파일업로드 객체 생성
			FileUploadUtil upload = new FileUploadUtil();
			//업로드 한후 업로드 위치를 리턴 받아 String 변수에 담음
			String location = upload.fileUploadRealPath(request, file, "excel");
			ExcelReadOption excelFile = new ExcelReadOption();
			
			excelFile.setFilePath(location);
			
			List<Map<String, String>> list = ExcelRead.read(excelFile);
			File deleteFile = new File(excelFile.getFilePath());
			if(deleteFile.exists()){
				deleteFile.delete();
			}
			return list;
		}
		/*******************************************************/
		/*			   	  엑셀 다운로드를 위한 Exceldown 메소드	   	       */
		/* 			    DB에서 조회한 dataList를 파라미터로 받는다.		   */
		/*  기존 jsp에서 사용하던 cols,colsNm를 화면 폼 에서 히든타입으로 추가시켜줘야 한다. */
		/*******************************************************/
		public static void Exceldown(HttpServletRequest request, HttpServletResponse response, List<Map<String, Object>> dataList) throws IOException{
			//컬럼명 추출을 위한 컬럼명배열 생성
			String cols = request.getParameter("excelCols");
			String[] columnArr = cols.split(",");
			
			//엑셀상단 제목을 위한 헤더배열 생성
			String colsNm = request.getParameter("excelColsNm");
			String[] headerArr = colsNm.split(",");
			
			// 워크북 생성
		    Workbook wb = new HSSFWorkbook();
		    Sheet sheet = wb.createSheet("게시판");
		    Row row = null;
		    Cell cell = null;
		    int rowNo = 0;


		    // 테이블 헤더용 스타일
		    CellStyle headStyle = wb.createCellStyle();

		    // 가는 경계선을 가집니다.
		    headStyle.setBorderTop(BorderStyle.THIN);
		    headStyle.setBorderBottom(BorderStyle.THIN);
		    headStyle.setBorderLeft(BorderStyle.THIN);
		    headStyle.setBorderRight(BorderStyle.THIN);



		    // 배경색은 노란색입니다.
		    headStyle.setFillForegroundColor(HSSFColorPredefined.YELLOW.getIndex());
		    headStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);



		    // 데이터는 가운데 정렬합니다.
		    headStyle.setAlignment(HorizontalAlignment.CENTER);



		    // 데이터용 경계 스타일 테두리만 지정
		    CellStyle bodyStyle = wb.createCellStyle();
		    bodyStyle.setBorderTop(BorderStyle.THIN);
		    bodyStyle.setBorderBottom(BorderStyle.THIN);
		    bodyStyle.setBorderLeft(BorderStyle.THIN);
		    bodyStyle.setBorderRight(BorderStyle.THIN);
		    // 헤더 생성
		    row = sheet.createRow(rowNo++);
		    for (int i=1; i<headerArr.length; i++){
		    	cell = row.createCell(i-1);
			    cell.setCellStyle(headStyle);
			    cell.setCellValue(headerArr[i]);
		    };
		    // 데이터 부분 생성
		    for(int i=0; i<dataList.size(); i++) {
		    	row = sheet.createRow(rowNo++);
		    	for(int j=1; j<columnArr.length; j++){
		    		cell = row.createCell(j-1);
		    		cell.setCellStyle(bodyStyle);
		    		String value = null;
		    		//BigDecimal 에러 발생 이유로 분기 처리
		    		if(dataList.get(i).get(columnArr[j]) instanceof BigDecimal){
		    			value = ((BigDecimal)dataList.get(i).get(columnArr[j])).toString();
		    		}else{
		    			value = (String) dataList.get(i).get(columnArr[j]);
		    		}
		    			cell.setCellValue(value);
		    		}
		    		
		    		
		    	}
		    // 컨텐츠 타입과 파일명 지정
		    String fileName = request.getSession().getAttribute("SS_ACTIVE_SUB_MENU_NM") == null ? "ExcelExport" : String.valueOf(request.getSession().getAttribute("SS_ACTIVE_SUB_MENU_NM"));
		    response.setContentType("ms-vnd/excel");
		    response.setHeader("Content-Disposition", "attachment;filename="+new String(fileName.getBytes("euc-kr"),"8859_1")+".xls");
		   
		    // 엑셀 출력
		    wb.write(response.getOutputStream());
		    wb.close();
		    

		}
		public static void ExceldownSelectAllMember(HttpServletRequest request, HttpServletResponse response, List<Map<String, Object>> dataList) throws IOException{
			//컬럼명 추출을 위한 컬럼명배열 생성
			String cols = request.getParameter("excelCols");
			String[] columnArr = cols.split(",");
			
			//엑셀상단 제목을 위한 헤더배열 생성
			String colsNm = request.getParameter("excelColsNm");
			String[] headerArr = colsNm.split(",");
			
			// 워크북 생성
			Workbook wb = new HSSFWorkbook();
			Sheet sheet = wb.createSheet("직원총괄표");
			Row row = null;
			Cell cell = null;
			int rowNo = 0;
			
			
			// 테이블 헤더용 스타일
			CellStyle headStyle = wb.createCellStyle();
			
			// 가는 경계선을 가집니다.
			headStyle.setBorderTop(BorderStyle.THIN);
			headStyle.setBorderBottom(BorderStyle.THIN);
			headStyle.setBorderLeft(BorderStyle.THIN);
			headStyle.setBorderRight(BorderStyle.THIN);
			
			
			
			// 배경색은 노란색입니다.
			headStyle.setFillForegroundColor(HSSFColorPredefined.YELLOW.getIndex());
			headStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
			
			
			
			// 데이터는 가운데 정렬합니다.
			headStyle.setAlignment(HorizontalAlignment.CENTER);
			
			
			
			// 데이터용 경계 스타일 테두리만 지정
			CellStyle bodyStyle = wb.createCellStyle();
			bodyStyle.setBorderTop(BorderStyle.THIN);
			bodyStyle.setBorderBottom(BorderStyle.THIN);
			bodyStyle.setBorderLeft(BorderStyle.THIN);
			bodyStyle.setBorderRight(BorderStyle.THIN);
			// 헤더 생성
			row = sheet.createRow(rowNo++);
			for (int i=1; i<headerArr.length; i++){
				cell = row.createCell(i-1);
				cell.setCellStyle(headStyle);
				cell.setCellValue(headerArr[i]);
			};
			// 데이터 부분 생성
			for(int i=0; i<dataList.size(); i++) {
				row = sheet.createRow(rowNo++);
				for(int j=1; j<columnArr.length; j++){
					cell = row.createCell(j-1);
					cell.setCellStyle(bodyStyle);
					String value = null;
					//BigDecimal 에러 발생 이유로 분기 처리
					if(dataList.get(i).get(columnArr[j]) instanceof BigDecimal){
						value = ((BigDecimal)dataList.get(i).get(columnArr[j])).toString();
					}else{
						value = (String) dataList.get(i).get(columnArr[j]);
					}
					cell.setCellValue(value);
				}
				
				
			}
			// 컨텐츠 타입과 파일명 지정
			String fileName = request.getSession().getAttribute("SS_ACTIVE_SUB_MENU_NM") == null ? "ExcelExport" : String.valueOf(request.getSession().getAttribute("SS_ACTIVE_SUB_MENU_NM"));
			response.setContentType("ms-vnd/excel");
			response.setHeader("Content-Disposition", "attachment;filename="+new String(fileName.getBytes("euc-kr"),"8859_1")+".xls");
			
			// 엑셀 출력
			wb.write(response.getOutputStream());
			wb.close();
			
			
		}
		
		public static void ExceldownSelectRetireMember(HttpServletRequest request, HttpServletResponse response, List<Map<String, Object>> dataList) throws IOException{
			//컬럼명 추출을 위한 컬럼명배열 생성
			String cols = request.getParameter("excelCols");
			String[] columnArr = cols.split(",");
			
			//엑셀상단 제목을 위한 헤더배열 생성
			String colsNm = request.getParameter("excelColsNm");
			String[] headerArr = colsNm.split(",");
			
			// 워크북 생성
			Workbook wb = new HSSFWorkbook();
			Sheet sheet = wb.createSheet("퇴직자목록");
			Row row = null;
			Cell cell = null;
			int rowNo = 0;
			
			
			// 테이블 헤더용 스타일
			CellStyle headStyle = wb.createCellStyle();
			
			// 가는 경계선을 가집니다.
			headStyle.setBorderTop(BorderStyle.THIN);
			headStyle.setBorderBottom(BorderStyle.THIN);
			headStyle.setBorderLeft(BorderStyle.THIN);
			headStyle.setBorderRight(BorderStyle.THIN);
			
			
			
			// 배경색은 노란색입니다.
			headStyle.setFillForegroundColor(HSSFColorPredefined.YELLOW.getIndex());
			headStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
			
			
			
			// 데이터는 가운데 정렬합니다.
			headStyle.setAlignment(HorizontalAlignment.CENTER);
			
			
			
			// 데이터용 경계 스타일 테두리만 지정
			CellStyle bodyStyle = wb.createCellStyle();
			bodyStyle.setBorderTop(BorderStyle.THIN);
			bodyStyle.setBorderBottom(BorderStyle.THIN);
			bodyStyle.setBorderLeft(BorderStyle.THIN);
			bodyStyle.setBorderRight(BorderStyle.THIN);
			// 헤더 생성
			row = sheet.createRow(rowNo++);
			for (int i=1; i<headerArr.length; i++){
				cell = row.createCell(i-1);
				cell.setCellStyle(headStyle);
				cell.setCellValue(headerArr[i]);
			};
			// 데이터 부분 생성
			for(int i=0; i<dataList.size(); i++) {
				row = sheet.createRow(rowNo++);
				for(int j=1; j<columnArr.length; j++){
					cell = row.createCell(j-1);
					cell.setCellStyle(bodyStyle);
					String value = null;
					//BigDecimal 에러 발생 이유로 분기 처리
					if(dataList.get(i).get(columnArr[j]) instanceof BigDecimal){
						value = ((BigDecimal)dataList.get(i).get(columnArr[j])).toString();
					}else{
						value = (String) dataList.get(i).get(columnArr[j]);
					}
					cell.setCellValue(value);
				}
				
				
			}
			// 컨텐츠 타입과 파일명 지정
			String fileName = request.getSession().getAttribute("SS_ACTIVE_SUB_MENU_NM") == null ? "ExcelExport" : String.valueOf(request.getSession().getAttribute("SS_ACTIVE_SUB_MENU_NM"));
			response.setContentType("ms-vnd/excel");
			response.setHeader("Content-Disposition", "attachment;filename="+new String(fileName.getBytes("euc-kr"),"8859_1")+".xls");
			
			// 엑셀 출력
			wb.write(response.getOutputStream());
			wb.close();
			
			
		}
		
		public static void ExceldownHw(HttpServletRequest request, HttpServletResponse response, List<Map<String, Object>> dataList) throws IOException{
			//컬럼명 추출을 위한 컬럼명배열 생성
			String cols = request.getParameter("excelCols");
			String[] columnArr = cols.split(",");
			
			//엑셀상단 제목을 위한 헤더배열 생성
			String colsNm = request.getParameter("excelColsNm");
			String[] headerArr = colsNm.split(",");
			
			// 워크북 생성
		    Workbook wb = new HSSFWorkbook();
		    Sheet sheet = wb.createSheet("하드웨어자산현황");
		    Row row = null;
		    Cell cell = null;
		    int rowNo = 0;

		    

		    // 테이블 헤더용 스타일
		    CellStyle headStyle = wb.createCellStyle();

		    // 가는 경계선을 가집니다.
		    headStyle.setBorderTop(BorderStyle.THIN);
		    headStyle.setBorderBottom(BorderStyle.THIN);
		    headStyle.setBorderLeft(BorderStyle.THIN);
		    headStyle.setBorderRight(BorderStyle.THIN);



		    // 배경색은 노란색입니다.
		    headStyle.setFillForegroundColor(HSSFColorPredefined.YELLOW.getIndex());
		    headStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		    
		    //제목용 스타일 및 폰트
		    CellStyle titleStyle = wb.createCellStyle();
		    Font titleFontStyle = wb.createFont();
		    titleFontStyle.setBold(true);
		    titleFontStyle.setFontHeightInPoints((short) 14);;
		    
		    //제목용 스타일
		    titleStyle.setAlignment(HorizontalAlignment.CENTER);
		    titleStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		    titleStyle.setBorderTop(BorderStyle.MEDIUM);
		    titleStyle.setBorderBottom(BorderStyle.MEDIUM);
		    titleStyle.setBorderLeft(BorderStyle.MEDIUM);
		    titleStyle.setBorderRight(BorderStyle.MEDIUM);
		    titleStyle.setFont(titleFontStyle);
		    

		    // 데이터는 가운데 정렬합니다.
		    headStyle.setAlignment(HorizontalAlignment.CENTER);
		    
		    // 데이터용 경계 스타일 테두리만 지정
		    CellStyle bodyStyle = wb.createCellStyle();
		    //세로 중앙정렬
		    bodyStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		    bodyStyle.setBorderTop(BorderStyle.THIN);
		    bodyStyle.setBorderBottom(BorderStyle.THIN);
		    bodyStyle.setBorderLeft(BorderStyle.THIN);
		    bodyStyle.setBorderRight(BorderStyle.THIN);
		    bodyStyle.setWrapText(true);
		    row = sheet.createRow(rowNo++);
		    
		    for (int i=1; i<headerArr.length; i++){
		    	cell = row.createCell(i-1);
		    	cell.setCellValue("하드웨어 자산 대장");
		    	cell.setCellStyle(titleStyle);
		    }
		    row = sheet.createRow(rowNo++);
		    for (int i=1; i<headerArr.length; i++){
		    	cell = row.createCell(i-1);
		    	cell.setCellValue("하드웨어 자산 대장");
		    	cell.setCellStyle(titleStyle);
		    }
		    //셀 병합
		    sheet.addMergedRegion(new CellRangeAddress(0, 1, 0, headerArr.length-2));
		    // 헤더 생성
		    row = sheet.createRow(rowNo++);
		    
		    for (int i=1; i<headerArr.length; i++){
		    	cell = row.createCell(i-1);
			    cell.setCellStyle(headStyle);
			    cell.setCellValue(headerArr[i]);
		    };
		    // 데이터 부분 생성
		    for(int i=0; i<dataList.size(); i++) {
		    	row = sheet.createRow(rowNo++);
		    	for(int j=1; j<columnArr.length; j++){
		    		cell = row.createCell(j-1);
		    		cell.setCellStyle(bodyStyle);
		    		String value = null;
		    		//BigDecimal 에러 발생 이유로 분기 처리
		    		if(dataList.get(i).get(columnArr[j]) instanceof BigDecimal){
		    			value = ((BigDecimal)dataList.get(i).get(columnArr[j])).toString();
		    		}else{
		    			value = (String) dataList.get(i).get(columnArr[j]);
		    		}
		    			cell.setCellValue(value);
		    		}
		    }
		    
		    for(int i=0; i<headerArr.length; i++){
		    	sheet.autoSizeColumn(i);
		    	//sheet.setColumnWidth(i, (sheet.getColumnWidth(i)+(short)1024));
		    }
		    
		    // 컨텐츠 타입과 파일명 지정
		    String fileName = "하드웨어 자산 대장";
		    response.setContentType("ms-vnd/excel");
		    response.setHeader("Content-Disposition", "attachment;filename="+new String(fileName.getBytes("euc-kr"),"8859_1")+".xls");
		   
		    // 엑셀 출력
		    wb.write(response.getOutputStream());
		    wb.close();
		    

		}
		
		public static void ExceldownSw(HttpServletRequest request, HttpServletResponse response, List<Map<String, Object>> dataList) throws IOException{
			//컬럼명 추출을 위한 컬럼명배열 생성
			String cols = request.getParameter("excelCols");
			String[] columnArr = cols.split(",");
			
			//엑셀상단 제목을 위한 헤더배열 생성
			String colsNm = request.getParameter("excelColsNm");
			String[] headerArr = colsNm.split(",");
			
			// 워크북 생성
		    Workbook wb = new HSSFWorkbook();
		    Sheet sheet = wb.createSheet("소프트웨어 자산 대장");
		    Row row = null;
		    Cell cell = null;
		    int rowNo = 0;

		    

		    // 테이블 헤더용 스타일
		    CellStyle headStyle = wb.createCellStyle();

		    // 가는 경계선을 가집니다.
		    headStyle.setBorderTop(BorderStyle.THIN);
		    headStyle.setBorderBottom(BorderStyle.THIN);
		    headStyle.setBorderLeft(BorderStyle.THIN);
		    headStyle.setBorderRight(BorderStyle.THIN);



		    // 배경색은 노란색입니다.
		    headStyle.setFillForegroundColor(HSSFColorPredefined.YELLOW.getIndex());
		    headStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		    
		    //제목용 스타일 및 폰트
		    CellStyle titleStyle = wb.createCellStyle();
		    Font titleFontStyle = wb.createFont();
		    titleFontStyle.setBold(true);
		    titleFontStyle.setFontHeightInPoints((short) 14);;
		    
		    //제목용 스타일
		    titleStyle.setAlignment(HorizontalAlignment.CENTER);
		    titleStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		    titleStyle.setBorderTop(BorderStyle.MEDIUM);
		    titleStyle.setBorderBottom(BorderStyle.MEDIUM);
		    titleStyle.setBorderLeft(BorderStyle.MEDIUM);
		    titleStyle.setBorderRight(BorderStyle.MEDIUM);
		    titleStyle.setFont(titleFontStyle);
		    

		    // 데이터는 가운데 정렬합니다.
		    headStyle.setAlignment(HorizontalAlignment.CENTER);
		    
		    // 데이터용 경계 스타일 테두리만 지정
		    CellStyle bodyStyle = wb.createCellStyle();
		    //세로 중앙정렬
		    bodyStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		    bodyStyle.setBorderTop(BorderStyle.THIN);
		    bodyStyle.setBorderBottom(BorderStyle.THIN);
		    bodyStyle.setBorderLeft(BorderStyle.THIN);
		    bodyStyle.setBorderRight(BorderStyle.THIN);
		    bodyStyle.setWrapText(true);
		    row = sheet.createRow(rowNo++);
		    
		    for (int i=1; i<headerArr.length; i++){
		    	cell = row.createCell(i-1);
		    	cell.setCellValue("소프트웨어 자산 대장");
		    	cell.setCellStyle(titleStyle);
		    }
		    row = sheet.createRow(rowNo++);
		    for (int i=1; i<headerArr.length; i++){
		    	cell = row.createCell(i-1);
		    	cell.setCellValue("소프트웨어 자산 대장");
		    	cell.setCellStyle(titleStyle);
		    }
		    //셀 병합
		    sheet.addMergedRegion(new CellRangeAddress(0, 1, 0, headerArr.length-2));
		    // 헤더 생성
		    row = sheet.createRow(rowNo++);
		    
		    for (int i=1; i<headerArr.length; i++){
		    	cell = row.createCell(i-1);
			    cell.setCellStyle(headStyle);
			    cell.setCellValue(headerArr[i]);
		    };
		    // 데이터 부분 생성
		    for(int i=0; i<dataList.size(); i++) {
		    	row = sheet.createRow(rowNo++);
		    	for(int j=1; j<columnArr.length; j++){
		    		cell = row.createCell(j-1);
		    		cell.setCellStyle(bodyStyle);
		    		String value = null;
		    		//BigDecimal 에러 발생 이유로 분기 처리
		    		if(dataList.get(i).get(columnArr[j]) instanceof BigDecimal){
		    			value = ((BigDecimal)dataList.get(i).get(columnArr[j])).toString();
		    		}else{
		    			value = (String) dataList.get(i).get(columnArr[j]);
		    		}
		    			cell.setCellValue(value);
		    		}
		    }
		    
		    for(int i=0; i<headerArr.length; i++){
		    	sheet.autoSizeColumn(i);
		    	//sheet.setColumnWidth(i, (sheet.getColumnWidth(i)+(short)1024));
		    }
		    
		    // 컨텐츠 타입과 파일명 지정
		    String fileName = "소프트웨어 자산 대장";
		    response.setContentType("ms-vnd/excel");
		    response.setHeader("Content-Disposition", "attachment;filename="+new String(fileName.getBytes("euc-kr"),"8859_1")+".xls");
		   
		    // 엑셀 출력
		    wb.write(response.getOutputStream());
		    wb.close();
			
			
		}
		
		
		public static List<Map<String, String>> salaryRead(HttpServletRequest request, MultipartFile file){
			//변환시키기 위하여 excel 폴더에 업로드하기 위한 파일업로드 객체 생성
			FileUploadUtil upload = new FileUploadUtil();
			//업로드 한후 업로드 위치를 리턴 받아 String 변수에 담음
			String location = upload.fileUploadRealPath(request, file, "excel");
			ExcelReadOption excelFile = new ExcelReadOption();
			
			excelFile.setFilePath(location);
			
			List<Map<String, String>> list = ExcelRead.salaryRead(excelFile);
			File deleteFile = new File(excelFile.getFilePath());
			if(deleteFile.exists()){
				deleteFile.delete();
			}
			return list;
		}
		public static List<Map<String, String>> earnSalaryRead(HttpServletRequest request, MultipartFile file){
			//변환시키기 위하여 excel 폴더에 업로드하기 위한 파일업로드 객체 생성
			FileUploadUtil upload = new FileUploadUtil();
			//업로드 한후 업로드 위치를 리턴 받아 String 변수에 담음
			String location = upload.fileUploadRealPath(request, file, "excel");
			ExcelReadOption excelFile = new ExcelReadOption();
			
			excelFile.setFilePath(location);
			
			List<Map<String, String>> list = ExcelRead.salaryRead(excelFile);
			File deleteFile = new File(excelFile.getFilePath());
			if(deleteFile.exists()){
				deleteFile.delete();
			}
			return list;
		}
		
		
		public static void ExceldownSalery(HttpServletRequest request, HttpServletResponse response, List<Map<String, Object>> dataList1, List<Map<String, Object>> dataList2, List<Map<String, Object>> dataList3) throws IOException{
			//컬럼명 추출을 위한 컬럼명배열 생성
			String sheet1cols = request.getParameter("sheet1Cols");
			String[] column1Arr = sheet1cols.split(",");
			String sheet2cols = request.getParameter("sheet2Cols");
			String[] column2Arr = sheet2cols.split(",");
			String sheet3cols = request.getParameter("sheet3Cols");
			String[] column3Arr = sheet3cols.split(",");
			
			//엑셀상단 제목을 위한 헤더배열 생성
			String sheet1colsNm = request.getParameter("sheet1ColsNm");
			String[] header1Arr = sheet1colsNm.split(",");
			String sheet2colsNm = request.getParameter("sheet2ColsNm");
			String[] header2Arr = sheet2colsNm.split(",");
			String sheet3colsNm = request.getParameter("sheet3ColsNm");
			String[] header3Arr = sheet3colsNm.split(",");
			
			// 워크북 생성
		    Workbook wb = new HSSFWorkbook();
		    
		    
		    Row row = null;
		    Cell cell = null;
		    int rowNo1 = 0;
		    int rowNo2 = 0;
		    int rowNo3 = 0;
		    
		    // 테이블 헤더용 스타일
		    CellStyle headStyle = wb.createCellStyle();
		    
		    Font Headfont = wb.createFont();
		    Headfont.setBold(true);
		    
		    
		    // 가는 경계선을 가집니다.
		    headStyle.setBorderTop(BorderStyle.THIN);
		    headStyle.setBorderBottom(BorderStyle.THIN);
		    headStyle.setBorderLeft(BorderStyle.THIN);
		    headStyle.setBorderRight(BorderStyle.THIN);
		    headStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		    
		    
		    
		    // 배경색은 노란색입니다.
		    headStyle.setFillForegroundColor(HSSFColorPredefined.GREY_25_PERCENT.getIndex());
		    headStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		    headStyle.setFont(Headfont);
		    
		    
		    // 데이터는 가운데 정렬합니다.
		    headStyle.setAlignment(HorizontalAlignment.CENTER);
		    
		    
		    
		    // 데이터용 경계 스타일 테두리만 지정
		    CellStyle bodyStyle = wb.createCellStyle();
		    bodyStyle.setBorderTop(BorderStyle.THIN);
		    bodyStyle.setBorderBottom(BorderStyle.THIN);
		    bodyStyle.setBorderLeft(BorderStyle.THIN);
		    bodyStyle.setBorderRight(BorderStyle.THIN);
		    
		    
		    if(dataList1.size() != 0){
		    	Sheet sheet1 = wb.createSheet("근로소득자");
		    	//근로소득자
			    // 헤더 생성
			    row = sheet1.createRow(rowNo1++);
			    for (int i=1; i<header1Arr.length; i++){
			    	cell = row.createCell(i-1);
				    cell.setCellStyle(headStyle);
				    cell.setCellValue(header1Arr[i]);
			    };
			    
			    
			    // 데이터 부분 생성
			    for(int i=0; i<dataList1.size(); i++) {
			    	row = sheet1.createRow(rowNo1++);
			    	for(int j=1; j<column1Arr.length; j++){
			    		cell = row.createCell(j-1);
			    		cell.setCellStyle(bodyStyle);
			    		String value = null;
			    		//BigDecimal 에러 발생 이유로 분기 처리
			    		if(dataList1.get(i).get(column1Arr[j]) instanceof BigDecimal){
			    			value = ((BigDecimal)dataList1.get(i).get(column1Arr[j])).toString();
			    		}else{
			    			value = (String) dataList1.get(i).get(column1Arr[j]);
			    		}
			    			cell.setCellValue(value);
			    		}
			    		
			    		
			    }
			    
			    for(int i=0; i<header1Arr.length; i++){
			    	sheet1.autoSizeColumn(i);
			    	sheet1.setColumnWidth(i, (sheet1.getColumnWidth(i))+2048 ); 
			    }
		    
		    }
		    if(dataList2.size() != 0){
		    	
		    	Sheet sheet2 = wb.createSheet("사업소득자");
		    	//사업소득자
			    // 헤더 생성
			    row = sheet2.createRow(rowNo2++);
			    for (int i=1; i<header2Arr.length; i++){
			    	cell = row.createCell(i-1);
			    	cell.setCellStyle(headStyle);
			    	cell.setCellValue(header2Arr[i]);
			    	if(i ==10){
			    		cell.setCellValue("공제내역");
			    	}
			    }
			    row = sheet2.createRow(rowNo2++);
			    for (int i=1; i<header2Arr.length; i++){
			    	cell = row.createCell(i-1);
			    	cell.setCellStyle(headStyle);
			    	cell.setCellValue(header2Arr[i]);
			    };
			    for (int i=0; i<9; i++){
			    	//셀 병합
				    sheet2.addMergedRegion(new CellRangeAddress(rowNo2-2, rowNo2-1, i, i));
			    };
			    for (int i=11; i<header2Arr.length; i++){
			    	//셀 병합
			    	sheet2.addMergedRegion(new CellRangeAddress(rowNo2-2, rowNo2-1, i, i));
			    };
			    sheet2.addMergedRegion(new CellRangeAddress(rowNo2-2, rowNo2-2, 9, 10));
			    
			    // 데이터 부분 생성
			    for(int i=0; i<dataList2.size(); i++) {
			    	row = sheet2.createRow(rowNo2++);
			    	for(int j=1; j<column2Arr.length; j++){
			    		cell = row.createCell(j-1);
			    		cell.setCellStyle(bodyStyle);
			    		String value = null;
			    		//BigDecimal 에러 발생 이유로 분기 처리
			    		if(dataList2.get(i).get(column2Arr[j]) instanceof BigDecimal){
			    			value = ((BigDecimal)dataList2.get(i).get(column2Arr[j])).toString();
			    		}else{
			    			value = (String) dataList2.get(i).get(column2Arr[j]);
			    		}
			    		cell.setCellValue(value);
			    	}
			    	
			    	
			    }
			    
			    for(int i=0; i<header2Arr.length; i++){
			    	sheet2.autoSizeColumn(i);
			    	sheet2.setColumnWidth(i, (sheet2.getColumnWidth(i))+2048 );
			    }
		    
		    
		    }
		    if(dataList3.size() != 0){
		    	
		    	Sheet sheet3 = wb.createSheet("기타소득자");
		    	
		    	// 기타소득자
			    // 헤더 생성
			    row = sheet3.createRow(rowNo3++);
			    for (int i=1; i<header3Arr.length; i++){
			    	cell = row.createCell(i-1);
			    	cell.setCellStyle(headStyle);
			    	cell.setCellValue(header3Arr[i]);
			    	if(i == 7){
			    		cell.setCellValue("공제내역(3.3%)");
			    	}
			    }
			    row = sheet3.createRow(rowNo3++);
			    for (int i=1; i<header3Arr.length; i++){
			    	cell = row.createCell(i-1);
			    	cell.setCellStyle(headStyle);
			    	cell.setCellValue(header3Arr[i]);
			    };
			    for (int i=0; i<6; i++){
			    	//셀 병합
				    sheet3.addMergedRegion(new CellRangeAddress(rowNo3-2, rowNo3-1, i, i));
			    };
			    for (int i=9; i<header3Arr.length; i++){
			    	//셀 병합
			    	sheet3.addMergedRegion(new CellRangeAddress(rowNo3-2, rowNo3-1, i, i));
			    };
			    sheet3.addMergedRegion(new CellRangeAddress(rowNo3-2, rowNo3-2, 6, 8));
			    
			    // 데이터 부분 생성
			    for(int i=0; i<dataList3.size(); i++) {
			    	row = sheet3.createRow(rowNo3++);
			    	for(int j=1; j<column3Arr.length; j++){
			    		cell = row.createCell(j-1);
			    		cell.setCellStyle(bodyStyle);
			    		String value = null;
			    		//BigDecimal 에러 발생 이유로 분기 처리
			    		if(dataList3.get(i).get(column3Arr[j]) instanceof BigDecimal){
			    			value = ((BigDecimal)dataList3.get(i).get(column3Arr[j])).toString();
			    		}else{
			    			value = (String) dataList3.get(i).get(column3Arr[j]);
			    		}
			    		cell.setCellValue(value);
			    	}
			    	
			    	
			    }
			    
			    for(int i=0; i<header3Arr.length; i++){
			    	sheet3.autoSizeColumn(i);
			    	sheet3.setColumnWidth(i, (sheet3.getColumnWidth(i))+2048 );
			    }
		    	
		    }
		   
		    // 컨텐츠 타입과 파일명 지정
		    String fileName = "급여엑셀다운로드";
		    response.setContentType("ms-vnd/excel");
		    response.setHeader("Content-Disposition", "attachment;filename="+new String(fileName.getBytes("euc-kr"),"8859_1")+".xls");
		   
		    // 엑셀 출력
		    wb.write(response.getOutputStream());
		    wb.close();
		    

		}
		public static void ExceldownBank(HttpServletRequest request, HttpServletResponse response, List<Map<String, Object>> dataList) throws IOException{
			//컬럼명 추출을 위한 컬럼명배열 생성
			String cols = request.getParameter("excelCols");
			String[] columnArr = cols.split(",");
			
			//엑셀상단 제목을 위한 헤더배열 생성
			String colsNm = request.getParameter("excelColsNm");
			String[] headerArr = colsNm.split(",");
			
			// 워크북 생성
		    Workbook wb = new HSSFWorkbook();
		    Sheet sheet = wb.createSheet("은행총괄표");
		    Row row = null;
		    Cell cell = null;
		    int rowNo = 0;


		    // 테이블 헤더용 스타일
		    CellStyle headStyle = wb.createCellStyle();

		    // 가는 경계선을 가집니다.
		    headStyle.setBorderTop(BorderStyle.THIN);
		    headStyle.setBorderBottom(BorderStyle.THIN);
		    headStyle.setBorderLeft(BorderStyle.THIN);
		    headStyle.setBorderRight(BorderStyle.THIN);



		    // 배경색은 노란색입니다.
		    headStyle.setFillForegroundColor(HSSFColorPredefined.YELLOW.getIndex());
		    headStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);



		    // 데이터는 가운데 정렬합니다.
		    headStyle.setAlignment(HorizontalAlignment.CENTER);



		    // 데이터용 경계 스타일 테두리만 지정
		    CellStyle bodyStyle = wb.createCellStyle();
		    bodyStyle.setBorderTop(BorderStyle.THIN);
		    bodyStyle.setBorderBottom(BorderStyle.THIN);
		    bodyStyle.setBorderLeft(BorderStyle.THIN);
		    bodyStyle.setBorderRight(BorderStyle.THIN);
		    // 헤더 생성
		    row = sheet.createRow(rowNo++);
		    for (int i=1; i<headerArr.length; i++){
		    	cell = row.createCell(i-1);
			    cell.setCellStyle(headStyle);
			    cell.setCellValue(headerArr[i]);
		    };
		    // 데이터 부분 생성
		    for(int i=0; i<dataList.size(); i++) {
		    	row = sheet.createRow(rowNo++);
		    	for(int j=1; j<columnArr.length; j++){
		    		cell = row.createCell(j-1);
		    		cell.setCellStyle(bodyStyle);
		    		String value = null;
		    		//BigDecimal 에러 발생 이유로 분기 처리
		    		if(dataList.get(i).get(columnArr[j]) instanceof BigDecimal){
		    			value = ((BigDecimal)dataList.get(i).get(columnArr[j])).toString();
		    		}else{
		    			value = (String) dataList.get(i).get(columnArr[j]);
		    		}
		    			cell.setCellValue(value);
		    		}
		    		
		    		
		    	}
		    // 컨텐츠 타입과 파일명 지정
		    String fileName = "은행이체 총괄표";
		    response.setContentType("ms-vnd/excel");
		    response.setHeader("Content-Disposition", "attachment;filename="+new String(fileName.getBytes("euc-kr"),"8859_1")+".xls");
		   
		    // 엑셀 출력
		    wb.write(response.getOutputStream());
		    wb.close();
		    

		}
		
}
