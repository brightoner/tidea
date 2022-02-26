/******************************************************************
 * Copyright RASTECH 2015
 ******************************************************************/
package tidea.utils;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.regex.Pattern;

import com.nhncorp.lucy.security.xss.XssFilter;

/**
 * <pre>
 * FileName: StringUtil.java
 * Package : kr.go.ncmik.commons.utils
 *
 * String 값 변환 utilitiy 객체.
 *
 * </pre>
 * @author : rastech
 * @data   : 2015. 3. 6.
 */
public class StringUtil {

    //날짜 검증
    private static final DateFormat DF =  new SimpleDateFormat("yyyyMMdd");
    /**
     *
     * <pre>
     * \r\n을 <br/>로 변환한다.
     *
     * </pre>
     * @author : rastech
     * @date   : 2015. 3. 6.
     * @param str
     * @return
     */
    public static String convBr(String str) {
        if (str == null) return str;
        return str.replaceAll("\r\n", "<br/>").replaceAll("\r", "<br/>").replaceAll("\n", "<br/>");
    }

    /**
     *
     * <pre>
     * XSS 공격 방어 필터.
     *
     * </pre>
     * @author : rastech
     * @date   : 2015. 9. 21.
     * @param str
     * @return
     */
    public static String filterXss(String str) {
        XssFilter filter = XssFilter.getInstance("lucy-xss.xml", true);
        return filter.doFilter(str);
    }

    /**
     *
     * <pre>
     * String 객체를 deep copy하여 반환한다.
     *
     * </pre>
     * @author : rastech
     * @date   : 2015. 12. 7.
     * @param str
     * @return
     */
    public static String deepCopy(String str) {
    	if (str == null) return null;
    	return String.valueOf(str);
    }

    /**
    *
    * <pre>
   * 데이터 검증
   *
   * </pre>
   * @author : sejin
    * @date   : 2015. 10. 21
    * @param param[0] : 데이터값
    *             , param[1] : 컬럼 타입
    *             , param[2] : 제한길이 0인경우 체크안함
    *    컬럼 타입
    *    0 : 해당사항없이 길이만 체크
    *    1 : 숫자 체크
    *    2 : 영문자만 체크
    *    3 : 한글만 체크
    *    4 : 영어/숫자만 체크
    *    5 : 이메일 체크
    *    6 : 소수점 필수 체크
    *    7 : 소수점 자유
    *    8 : 날짜 검증
    * @return
    * @throws IOException, SQLException , NullPointerException
    */
    public static  boolean isValidate(String val, int gbn, int limit){

          boolean isVlidt =true;

          switch (gbn) {

          case 1://숫자
           isVlidt = Pattern.matches("^[0-9]*$", val);
           break;
          case 2://영문자만
           isVlidt = Pattern.matches("^[a-zA-Z]*$", val);
           break;
          case 3://한글만
           isVlidt = Pattern.matches("^[가-힣]*$", val);
           break;
          case 4://영어/숫자만
           isVlidt = Pattern.matches("^[a-zA-Z0-9]*$", val);
           break;
          case 5://이메일체크
           isVlidt = Pattern.matches("^[_a-z0-9-]+(.[_a-z0-9-]+)*@(?:\\w+\\.)+\\w+$", val);
           break;
          case 6://소수점 필수 param : 제한 소수점
           isVlidt = Pattern.matches("[0-9]*\\.[0-9]*", val);
           break;
          case 7://소수점 자유
           isVlidt = Pattern.matches("[0-9]*\\.?[0-9]*", val);
           break;
          case 8://날짜 타입 검증
           try{
                  DF.setLenient(false);
                  java.util.Date df2 = DF.parse(val);
                  isVlidt = Pattern.matches("[1-2]{1}[0-9]{3}[0-9]{2}[0-9]{2}", val);
              
               } catch (ParseException e) {
            	   isVlidt=false;
               }
           break;
          case 9://한글/영어만
              isVlidt = Pattern.matches("^[가-힣a-zA-Z]*$", val);
              break;
          case 10://정수
              isVlidt = Pattern.matches("^-?[0-9]*$", val);
              break;
          default://정수
              
              break;
          }
          //제한길이가 0이상으로 넘어온 경우 길이 체크
          if(limit > 0){
           if(val.length() > limit ){
            isVlidt = false;
           }
          }
          return isVlidt;
    }
}
