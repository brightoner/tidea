package tidea.review.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Pattern;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import tidea.review.auth.service.AuthService;
import tidea.review.auth.vo.AuthVo;
import tidea.review.common.service.CommonShService;

@Component
public class Interceptor extends HandlerInterceptorAdapter {

	protected Log log = LogFactory.getLog(this.getClass());
	
	@Resource(name = "commonShService")
	private CommonShService commonShService;
	
	@Resource(name = "authService")
	private AuthService authService;
	
	private String requestURI;
	
	private Set<String> permittedURL;
	public void setPermittedURL(Set<String> permittedURL) {
		this.permittedURL = permittedURL;
	}
	
	// AJAX로 생성한 콤포넌트 URL
	private Set<String> ajaxCompoURL;
	public void setAjaxCompoURL(Set<String> ajaxCompoURL) {
		this.ajaxCompoURL = ajaxCompoURL;
	}
	
	/** 전처리 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		requestURI = request.getRequestURI(); // 요청 URI
		
		// 사용자 세션 정보
		@SuppressWarnings("unchecked")
		Map<String, Object> ssLoginInfo = (Map<String, Object>) request.getSession().getAttribute("SS_LOGIN_INFO");
		
		// 로그인폼으로 이동 or 로그아웃을 할 경우 인터셉터를 거치지 않음
		for(Iterator<String> it = this.permittedURL.iterator(); it.hasNext();){
			String urlPattern = request.getContextPath() + (String) it.next();
			if(Pattern.matches(urlPattern, requestURI)){
				// 사용자 세션이 남아있는데 로그인페이지로 이동을 하려고 하는 경우
				
				if(null != ssLoginInfo && StringUtils.equals("/login/login.do", requestURI)){
					response.sendRedirect("/sample/samplemain.do");
					return false;
				}else{
					return true;
				}
				
			}
		}
		// 사용자 세션 정보가 없는 경우 로그인 페이지로 이동
		if(null == ssLoginInfo){
			response.sendRedirect("/login/login.do?loginErrorCode=SS_ERROR");
			return false;
		}
		
		// AJAX로 생성한 콤포넌트 URL인 경우 세션처리 생략
		for(Iterator<String> it = this.ajaxCompoURL.iterator(); it.hasNext();){
			String urlPattern = request.getContextPath() + (String) it.next();
			if(Pattern.matches(urlPattern, requestURI)){ 
				return true;
			}
		}
		
		
		//log.debug("■■■■■■■■■■■■■■■■■  전   처   리       ■■■■■■■■■■■■■■■■■■■" + request.getRequestURI());
		
		// 메뉴 불러오기(세션)
		List<Map<String, Object>> ssTopMenuList = new ArrayList<Map<String,Object>>();
		Map<String, Object> paramMap = new HashMap<String, Object>();
		Map<String, Object> userMap = (Map<String, Object>) request.getSession().getAttribute("SS_LOGIN_INFO");

		
		
		//************ 202107 이재규 **********************************
		//		paramMap.put("MENU_USE_AUTH", userMap.get("AUTH"));
		paramMap.put("MENU_USE_AUTH", userMap.get("AUTH_CD"));
		//************ 202107 이재규 **********************************
		
		
		paramMap.put("MENU_LEVL", "0");
				
		ssTopMenuList = authService.selectTopLeftmenuList(paramMap);
		request.getSession().setAttribute("SS_TOP_MENU", ssTopMenuList);
		ssTopMenuList = new ArrayList<Map<String,Object>>();
		//paramMap.clear();
		
		ssTopMenuList = authService.selectTopmenuList(paramMap);
		request.getSession().setAttribute("SS_ALL_MENU", ssTopMenuList);
		ssTopMenuList = new ArrayList<Map<String,Object>>();
		List<String> ssMainMenuList = new ArrayList<String>();
		//paramMap.clear();
		paramMap.put("MENU_LEVL", "0");

		ssTopMenuList = authService.selectTopLeftmenuList(paramMap);
		for (int i = 0; i < ssTopMenuList.size(); i++) {
			ssMainMenuList.add(String.valueOf(ssTopMenuList.get(i).get("MENU_ID")));
		}
		paramMap.put("topMenuList", ssMainMenuList);
		ssTopMenuList = authService.selectMainmenuList(paramMap);
		request.getSession().setAttribute("SS_MAIN_MENU", ssTopMenuList);
		
		
		// 선택된 메뉴(세션)
		String activeTopMenu = request.getParameter("ACTIVE_TOP_MENU") == null ? (String)request.getSession().getAttribute("SS_ACTIVE_TOP_MENU") : request.getParameter("ACTIVE_TOP_MENU");
		String activeSubMenu = request.getParameter("ACTIVE_SUB_MENU") == null ? (String)request.getSession().getAttribute("SS_ACTIVE_SUB_MENU") : request.getParameter("ACTIVE_SUB_MENU");
		
		request.getSession().setAttribute("SS_ACTIVE_TOP_MENU", activeTopMenu);
		request.getSession().setAttribute("SS_ACTIVE_SUB_MENU", activeSubMenu);
		if(!StringUtils.equals("", activeSubMenu)){
			ssTopMenuList = new ArrayList<Map<String,Object>>();
			paramMap.clear();
			paramMap.put("MENU_PRTS_ID", activeTopMenu);
		
			ssTopMenuList = authService.selectTopLeftmenuList(paramMap);
			request.getSession().setAttribute("SS_LEFT_MENU", ssTopMenuList);
		}
		
		// 선택된 TOP메뉴명 가져오기(세션)
		AuthVo paramAuthVo = new AuthVo();
		paramAuthVo.setMenu_id(activeTopMenu);
		List<AuthVo> tmpMenuList = authService.selectMenuList(paramAuthVo);
		if(tmpMenuList.size() > 0){
			request.getSession().setAttribute("SS_ACTIVE_TOP_MENU_NM", tmpMenuList.get(0).getMenu_nm());
		}
		// 선택된 SUB메뉴명 가져오기(세션)
		paramAuthVo.setMenu_id(activeSubMenu);
		tmpMenuList = new ArrayList<AuthVo>();
		tmpMenuList = authService.selectMenuList(paramAuthVo);
		if(tmpMenuList.size() > 0){
			request.getSession().setAttribute("SS_ACTIVE_SUB_MENU_NM", tmpMenuList.get(0).getMenu_nm());
		}
		
		
		/* 성일주석 19.04.01
		// 항목명 리스트(세션)
		List<Map<String, Object>> allItemNmList = new ArrayList<Map<String,Object>>();
		allItemNmList = commonShService.selectAllItemNmList();
		for(int i = 0; i < allItemNmList.size(); i++){
			// 항목번호
			String itemSn = String.valueOf(allItemNmList.get(i).get("ITEM_SN"));
			// 항목명
			String itemNm = String.valueOf(allItemNmList.get(i).get("ITEM_NM"));
			// 주석
			String cmt = allItemNmList.get(i).get("CM") == null ? "" : "■ " + itemNm + " : " + String.valueOf(allItemNmList.get(i).get("CM"));
			
			// 화면에 표출 될 항목명
			request.getSession().setAttribute("ss" + itemSn, itemNm);
			// 화면에 표출 될 주석
			request.getSession().setAttribute("ssCMT_" + itemSn, cmt);
		}
		
		*/
		
		
		/*******************************************************************
		 * 권한이 없는 메뉴에 접근한 경우 메인화면으로 이동
		 *******************************************************************/
		//paramMap.clear();
		Boolean menuAuthCheck = false;
		// 전체 메뉴 목록
		paramMap.put("MENU_USE_YN", "Y");
		List<Map<String, Object>> allMenuList = authService.selectAllMenuList(paramMap);
		for(int i = 0; i < allMenuList.size(); i++){
			Map<String, Object> tmpMap = allMenuList.get(i);
			String tmpMenuUrl = String.valueOf(tmpMap.get("MENU_URL"));
			
			// 메뉴관리에 있는 URL만 요청이 들어온 경우만 처리
			if(StringUtils.equals(tmpMenuUrl, requestURI)){
				menuAuthCheck = true;
			}
		}
		
		// 메뉴관리에 있는 URL만 요청이 들어온 경우만 처리
		if(menuAuthCheck){
			
			Boolean tmpBool = false;
			
			// 내 권한에 해당하는 메뉴목록
			//paramMap.clear();
			
			
			//************ 202107 이재규 **********************************
//			paramMap.put("MENU_USE_AUTH", userMap.get("AUTH"));
			paramMap.put("MENU_USE_AUTH", userMap.get("AUTH_CD"));
			//************ 202107 이재규 **********************************
			
			
			List<Map<String, Object>> myAuthMenuList = authService.selectMenuByAuth(paramMap);
			
			for(int i = 0; i < myAuthMenuList.size(); i++){
				String myAuthUrl = String.valueOf(myAuthMenuList.get(i).get("MENU_URL"));
				if(StringUtils.equals(myAuthUrl, requestURI)){
					
					tmpBool = true;
				}
			}
			
			// 요청한 URL이 내 권한메뉴 목록에 없는 경우 메인페이지로 이동
			if(!tmpBool){
				response.sendRedirect("/sample/samplemain.do?errorCode=AUTH_ERROR");
				return false;
			}
		}
		
		/*******************************************************************
		 * 권한이 없는 메뉴에 접근한 경우 메인화면으로 이동 END
		 *******************************************************************/
		
		
		
		return true;
	}
	
	/** 후처리 */
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		
		//log.debug("■■■■■■■■■■■■■■■■■  후   처   리       ■■■■■■■■■■■■■■■■■■■");
		
	}
}
