package tidea.utils;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

public class FileUploadUtil {
		
	
		String path = "";
		String fileName = "";
	    
	//  프로젝트 내 지정된 경로에 파일을 저장하는 메소드
	//  DB에는 업로드된 전체 경로명으로만 지정되기 때문에(업로드한 파일 자체는 경로에 저장됨)
	//  fileUpload() 메소드에서 전체 경로를 리턴받아 DB에 경로 그대로 저장   
	    public String fileUpload(HttpServletRequest request, List<MultipartFile> uploadFile, String type) {
	        
	        OutputStream out = null;
	        PrintWriter printWriter = null;
	        
	        for(MultipartFile files : uploadFile) {
	        	
	        	try {
		            fileName = files.getOriginalFilename();
		            byte[] bytes = files.getBytes();
		            path = getSaveLocation(request, type);
		            File file = new File(path);
		            
	//	          파일명이 중복으로 존재할 경우
		            if (fileName != null && !fileName.equals("")) {
		                if (file.exists()) {
		                	
		             //파일명 앞에 yyyyMMdd_HHmmss 형식으로 붙여 파일명 중복을 방지
		                	Date dt = new Date();
		                	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
		            		String yyyyMMddHHmm = sdf.format(dt);
		            		String yyyyMMdd = yyyyMMddHHmm.substring(0,8);
		            		String HHmm = yyyyMMddHHmm.substring(8,12);
	
		            		fileName = yyyyMMdd + "_" + HHmm + "_" + fileName;
		            		
		            		file = new File(path + fileName);
		                }
		            }
		            
		            out = new FileOutputStream(file);
		            out.write(bytes);
		            
		        } catch (Exception e) {
		            e.printStackTrace();
		        } finally {
		            try {
		                if (out != null) {
		                    out.close();
		                }
		                if (printWriter != null) {
		                    printWriter.close();
		                }
		            } catch (IOException e) {
		                e.printStackTrace();
		            }
		        }
	        	
	        	System.out.println();
	        	
	        }// for문
	        
	        return path;
	    }
	    
	    	
	    public String fileUploadRealPath(HttpServletRequest request, List<MultipartFile> uploadFile, String type) {
	        
	        
	        OutputStream out = null;
	        PrintWriter printWriter = null;
	        
	        for(MultipartFile files : uploadFile) {
	       
	        	try {
		            fileName = files.getOriginalFilename();
		            byte[] bytes = files.getBytes();
		            path = getSaveRealLocation(request, type);
		            File file = new File(path);
		            
	//	          파일명이 중복으로 존재할 경우
		            if (fileName != null && !fileName.equals("")) {
		                if (file.exists()) {
		                //파일명 앞에 yyyyMMdd_HHmmss 형식으로 붙여 파일명 중복을 방지  
		                	Date dt = new Date();
		                	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		            		String yyyyMMddHHmmss = sdf.format(dt);
		            		String yyyyMMdd = yyyyMMddHHmmss.substring(0,8);
		            		String HHmmss = yyyyMMddHHmmss.substring(8,14);
	
		            		fileName = yyyyMMdd + "_" + HHmmss + "_" + fileName;
		                    
		                    file = new File(path + fileName);
		                	
		                }
		            }
		            out = new FileOutputStream(file);
		            out.write(bytes);
	            
		        } catch (Exception e) {
		            e.printStackTrace();
		        } finally {
		            try {
		                if (out != null) {
		                    out.close();
		                }
		                if (printWriter != null) {
		                    printWriter.close();
		                }
		            } catch (IOException e) {
		                e.printStackTrace();
		            }
		        }
	        }// for문
	        
	        return path;
	    }
	    
	    

	//  업로드 파일 저장 경로 얻는 메소드
	//  업로드한 파일의 경로가 도메인 별로 달라야 했기 때문에 도메인의 형을 비교하여 파일 저장 정로를 다르게 지정함
	    public String getSaveLocation(HttpServletRequest request, String type) {
	        
	    	String uploadPath = "D:\\workspace_tidea_system_dev\\tidea\\WebContent\\files\\";		// 로컬 경로
//	    	String uploadPath = "/home/tomcat7_system/webapps/tidea_system/files/";				// 운영 경로
	     
	    	return uploadPath;
	    }
	    
	//  업로드 파일 저장 경로 얻는 메소드
	//  업로드한 파일의 경로가 도메인 별로 달라야 했기 때문에 도메인의 형을 비교하여 파일 저장 정로를 다르게 지정함
	    public String getSaveRealLocation(HttpServletRequest request, String type) {
	        
	    	// 로컬 경로
	    	String uploadPath = "D:\\workspace_tidea_system_dev\\tidea\\WebContent\\files\\";		// 로컬 경로
//	    	String uploadPath = "/home/tomcat7_system/webapps/tidea_system/files/";				// 운영 경로
	        
	        return uploadPath;
	    }
	    
	    public String getLocation(){
	    	HashMap<String, String> locationMap = new HashMap<String, String>();
	    	String location = path + fileName;
	    	return location;
	    }
	    
	    
	    
	    
	    
//*********************************************************************************************************************************
public String fileUpload1(HttpServletRequest request, List<MultipartFile> uploadFile, String type) {
	        
	        OutputStream out = null;
	        PrintWriter printWriter = null;
	        
	        for(MultipartFile files : uploadFile) {
	        	
	        	try {
		            fileName = files.getOriginalFilename();
		            byte[] bytes = files.getBytes();
		            path = getSaveLocation1(request, type);
		            File file = new File(path);
		            
	//	          파일명이 중복으로 존재할 경우
		            if (fileName != null && !fileName.equals("")) {
		                if (file.exists()) {
		                	
		             //파일명 앞에 yyyyMMdd_HHmmss 형식으로 붙여 파일명 중복을 방지
		                	Date dt = new Date();
		                	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
		            		String yyyyMMddHHmm = sdf.format(dt);
		            		String yyyyMMdd = yyyyMMddHHmm.substring(0,8);
		            		String HHmm = yyyyMMddHHmm.substring(8,12);
	
		            		fileName = yyyyMMdd + "_" + HHmm + "_" + fileName;
		            		
		            		file = new File(path + fileName);
		                }
		            }
		            
		            out = new FileOutputStream(file);
		            out.write(bytes);
		            
		        } catch (Exception e) {
		            e.printStackTrace();
		        } finally {
		            try {
		                if (out != null) {
		                    out.close();
		                }
		                if (printWriter != null) {
		                    printWriter.close();
		                }
		            } catch (IOException e) {
		                e.printStackTrace();
		            }
		        }
	        	
	        	System.out.println();
	        	
	        }// for문
	        
	        return path;
	    }
	    
	    
//  업로드 파일 저장 경로 얻는 메소드
//  업로드한 파일의 경로가 도메인 별로 달라야 했기 때문에 도메인의 형을 비교하여 파일 저장 정로를 다르게 지정함
    public String getSaveLocation1(HttpServletRequest request, String type) {
        
    	String uploadPath = "D:\\workspace_tidea_system_dev\\tidea\\WebContent\\files\\biz_no\\";		// 로컬 경로
//    	String uploadPath = "/home/tomcat7_system/webapps/tidea_system/biz_no/";				// 운영 경로
     
    	return uploadPath;
    }
	    
	    
	    
	    

}
