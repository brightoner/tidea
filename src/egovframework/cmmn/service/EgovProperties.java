package egovframework.cmmn.service;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import org.apache.log4j.Logger;

import egovframework.cmmn.EgovWebUtil;

/**
 *  Class Name : EgovProperties.java
 *  Description : properties값들을 파일로부터 읽어와   Globals클래스의 정적변수로 로드시켜주는 클래스로
 *   문자열 정보 기준으로 사용할 전역변수를 시스템 재시작으로 반영할 수 있도록 한다.
 *  Modification Information
 *
 *     수정일         수정자                   수정내용
 *   -------    --------    ---------------------------
 *   2009.01.19    박지욱          최초 생성
 *	 2011.07.20    서준식 	      Globals파일의 상대경로를 읽은 메서드 추가
 *	 2014.10.13    이기하 	      Globals.properties 값이 null일 경우 오류처리
 *  @author 공통 서비스 개발팀 박지욱
 *  @since 2009. 01. 19
 *  @version 1.0
 *  @see
 *
 */

public class EgovProperties {

	/*public static final String ERR_CODE = " EXCEPTION OCCURRED";
	public static final String ERR_CODE_FNFE = " EXCEPTION(FNFE) OCCURRED";
	public static final String ERR_CODE_IOE = " EXCEPTION(IOE) OCCURRED";*/
	
	public static final String ERR_CODE = "99";
	public static final String GLOBALS_PROPERTIES_PATH_URL = "/egovframework/egovProps/globals.properties";
	
	static final char FILE_SEPARATOR = File.separatorChar;
	
	/**
	 * 인자로 주어진 문자열을 Key값으로 하는 프로퍼티 값을 반환한다.
	 * @param key String
	 * @return String
	 */
	public static String getProperty(String key) { 
		return getProperty(GLOBALS_PROPERTIES_PATH_URL, key);
	}
	public static String getProperty(String pathUrl, String key) {
		String value = ERR_CODE;
		InputStream is = null;
		try {
			is = EgovProperties.class.getResource(EgovWebUtil.filePathBlackList(pathUrl)).openStream();
			Properties props = new Properties();
			props.load(new java.io.BufferedInputStream(is));
			value = props.getProperty(key).trim();
		} catch (IOException ioe) {
			debug(ioe);
		} catch (Exception e) {
			debug(e);
		} finally {
			try {
				if (is != null)
					is.close();
			} catch (Exception ex) {
				Logger.getLogger(EgovProperties.class).debug("IGNORED: " + ex.getMessage());
			}
		}
		return value;
	}
	
	/**
	 * 인자로 주어진 문자열을 Key값으로 하는 상대경로 프로퍼티 값을 절대경로로 반환한다
	 * -> [2016.06.21. 이한찬] 본 메소드는 NAWAS Domain모드에서 사용불가(Virtual File System에 Deploy되기 때문에 절대 경로로 해당 프로퍼티 파일 접근할 수 없음) 
	 * @param key String
	 * @return String
	 */
	public static String getPathProperty(String key) { 
		return ERR_CODE;
	}
	public static String getPathProperty(String pathUrl, String key) {
		return ERR_CODE;
	}
	
	/**
	 * 주어진 프로파일의 내용을 파싱하여 (key-value) 형태의 구조체 배열을 반환한다.
	 * @param property String
	 * @return ArrayList
	 */	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static ArrayList loadPropertyFile(String propertyUrl) {
		ArrayList keyList = new ArrayList();
		InputStream is = null;
		try {
			is = EgovProperties.class.getResource(EgovWebUtil.filePathBlackList(propertyUrl)).openStream();
			Properties props = new Properties();
			props.load(new java.io.BufferedInputStream(is));
			Enumeration plist = props.propertyNames();
			if (plist != null) {
				while (plist.hasMoreElements()) {
					Map map = new HashMap();
					String key = (String) plist.nextElement();
					String value = props.getProperty(key).trim();
					map.put(key, value);
					keyList.add(map);
				}
			}
		} catch (Exception e) {
			debug(e);
		} finally {
			try {
				if (is != null)
					is.close();
			} catch (Exception ex) {
				Logger.getLogger(EgovProperties.class).debug("IGNORED: " + ex.getMessage());
			}
		}
		return keyList;
	}

	private static void debug(Object obj) {
		if (obj instanceof java.lang.Exception) {
			Logger.getLogger(EgovProperties.class).debug(
					"IGNORED: " + ((Exception) obj).getMessage());
		}
	}
}
