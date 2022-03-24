package tidea.review.auth.controller;


import java.io.Writer;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import tidea.review.auth.service.AuthService;
import tidea.review.auth.vo.AuthVo;
import tidea.review.login.service.LoginService;
import tidea.utils.EncryptUtil;
import tidea.utils.XmlUtil;

@Controller
public class AuthController {
	
	@Resource(name = "authService")
	private AuthService authService;
	
	@Resource(name = "loginService")
	private LoginService loginService;
	/**
	 * <pre>
	 * @Method Name  : menuMng
	 * @Method 설명 : 메뉴관리 화면 오픈
	 * </pre>
	 * @작성일   : 2018. 11. 26.
	 * @작성자   : YTK
	 * @변경이력  :
	 */
	@RequestMapping(value="/auth/menuMng.do")
	public String menuMng(String sel_menu_id, HttpServletRequest request, Model model) throws Exception {
		
		model.addAttribute("sel_menu_id", sel_menu_id);
		
		return "/auth/menuMng.tiles";
	}
	
	/**
	 * <pre>
	 * @Method Name  : readMenuList
	 * @Method 설명 : 메뉴 목록을 불러온다.
	 * </pre>
	 * @작성일   : 2018. 11. 26.
	 * @작성자   : YTK
	 * @변경이력  :
	 */
	@RequestMapping("/auth/readMenuList.do")
	public void readMenuList(HttpServletResponse resp, Writer out, AuthVo authVo) throws Exception {
		
		String xml="";
		List<AuthVo> menuList = authService.readMenuList(authVo);
		
		if(menuList.size() > 0){
			xml = XmlUtil.listToXml(menuList);
		}
    	
 	    resp.setContentType("text/xml");
 	    resp.setCharacterEncoding("UTF-8");
 	    resp.setHeader("Cache-Control", "no-cache");
 	    resp.setHeader("Pragma", "no-cache");
 	    resp.setDateHeader("Expires", -1);

 	    out.write(xml);
 	    
 	    out.flush();
	}
	
	/**
	 * <pre>
	 * @Method Name  : saveMenu
	 * @Method 설명 : 메뉴 등록
	 * </pre>
	 * @작성일   : 2018. 11. 26.
	 * @작성자   : YTK
	 * @변경이력  :
	 */
	@RequestMapping(value="/auth/saveMenu.do")
	public String saveMenu(AuthVo authVo, Model model, HttpServletRequest request) throws Exception {
		
		authService.saveMenu(authVo, model, request);
		
		return "redirect:menuMng.do?sel_menu_id=" + authVo.getMenu_id();
	}
	
	/**
	 * <pre>
	 * @Method Name  : delMenu
	 * @Method 설명 : 메뉴 삭제
	 * </pre>
	 * @작성일   : 2018. 11. 26.
	 * @작성자   : YTK
	 * @변경이력  :
	 */
	@RequestMapping(value="/auth/deleteMenu.do")
	public String deleteMenu(AuthVo authVo, Model model, HttpServletRequest request) throws Exception {
		
		// 상위메뉴코드와 메뉴코드 전부 비어있으면 오류 처리
		if(StringUtils.isBlank(authVo.getMenu_id()) && StringUtils.isBlank(authVo.getMenu_prts_id())){
			throw new Exception("삭제 메뉴정보가 없습니다.");
		}
		
		authService.deleteMenu(authVo);
		
		return "redirect:menuMng.do";
	}
	
	/**
	 * <pre>
	 * @Method Name  : duplChkMenuList
	 * @Method 설명 : 메뉴 ID 중복체크
	 * </pre>
	 * @작성일   : 2018. 11. 26.
	 * @작성자   : YTK
	 * @변경이력  :
	 */
	@RequestMapping("/auth/duplChkMenuList.do")
	public void duplChkMenuList(HttpServletResponse resp, Writer out, AuthVo authVo) throws Exception {
		
		String xml="";
		List<AuthVo> menuListChk  = authService.readMenuList(authVo);
		
		if(menuListChk.size() > 0){
			xml = XmlUtil.listToXml(menuListChk);
		}
    	
 	    resp.setContentType("text/xml");
 	    resp.setCharacterEncoding("UTF-8");
 	    resp.setHeader("Cache-Control", "no-cache");
 	    resp.setHeader("Pragma", "no-cache");
 	    resp.setDateHeader("Expires", -1);

 	    out.write(xml);
 	    
 	    out.flush();
	}
	
	
	/**
	 * <pre>
	 * @Method Name  : authCdMng
	 * @Method 설명 : 권한코드 관리화면
	 * </pre>
	 * @작성일   : 2019. 02. 01.
	 * @작성자   : CMK
	 * @변경이력  :
	 */
	@RequestMapping(value="/auth/authCdMng.do")
	public String authCdMng(HttpServletRequest request, Model model, AuthVo vo) throws Exception {
		
		authService.authCdMng(request, model, vo);
		
		return "/auth/authCdMng.tiles";
	}
	
	/**
	 * <pre>
	 * @Method Name  : authCdMngDetail
	 * @Method 설명 : 권한코드 관리화면 상세
	 * </pre>
	 * @작성일   : 2019. 02. 01.
	 * @작성자   : CMK
	 * @변경이력  :
	 */
	@RequestMapping(value="/auth/authCdMngDetail.do")
	public String authCdMngDetail(HttpServletRequest request, Model model, AuthVo vo) throws Exception {
		
		Map<String, Object> detailMap = authService.authCdMngDetail(vo);
		
		model.addAttribute("detailMap", detailMap);
		
		return "jsonView";
		
	}
	
	/**
	 * <pre>
	 * @Method Name  : saveAuthCdMng
	 * @Method 설명 : 권한코드 관리화면 저장(신규, 수정)
	 * </pre>
	 * @작성일   : 2019. 02. 01.
	 * @작성자   : CMK
	 * @변경이력  :
	 */
	@RequestMapping(value="/auth/saveAuthCdMng.do")
	public String saveAuthCdMng(HttpServletRequest request, Model model, AuthVo vo) throws Exception {
		
		authService.saveAuthCdMng(request, model, vo);
		
		String paramUrl = "?searchYn=Y";
		paramUrl += "&curPage=" + request.getParameter("curPage");
		paramUrl += "&cols=" + request.getParameter("cols");
		paramUrl += "&keys=" + request.getParameter("keys");
		// 조회조건유지 항목만 셋팅 해줄것! 
		paramUrl += "&SEARCH_AUTH_NM=" + URLEncoder.encode(vo.getSEARCH_AUTH_NM(), "UTF-8");
		
		return "redirect:/auth/authCdMng.do" + paramUrl;
	}
	
	/**
	 * <pre>
	 * @Method Name  : deleteAuthCdMng
	 * @Method 설명 : 권한코드 관리화면 삭제
	 * </pre>
	 * @작성일   : 2019. 02. 01.
	 * @작성자   : YTK
	 * @변경이력  :
	 */
	@RequestMapping(value="/auth/deleteAuthCdMng.do")
	public String deleteAuthCdMng(HttpServletRequest request, Model model, AuthVo vo) throws Exception {
		
		authService.deleteAuthCdMng(request, model, vo);
		
		String paramUrl = "?searchYn=Y";
		paramUrl += "&curPage=" + request.getParameter("curPage");
		paramUrl += "&cols=" + request.getParameter("cols");
		paramUrl += "&keys=" + request.getParameter("keys");
		// 조회조건유지 항목만 셋팅 해줄것! 
		paramUrl += "&SEARCH_AUTH_NM=" + URLEncoder.encode(vo.getSEARCH_AUTH_NM(), "UTF-8");
		
		return "redirect:/auth/authCdMng.do" + paramUrl;
	}
	
	
	/**
	 * <pre>
	 * @Method Name  : cmmnCdMng
	 * @Method 설명 : 공통코드 관리화면
	 * </pre>
	 * @작성일   : 2019. 01. 09.
	 * @작성자   : YTK
	 * @변경이력  :
	 */
	@RequestMapping(value="/auth/cmmnCdMng.do")
	public String cmmnCdMng(HttpServletRequest request, Model model, AuthVo vo) throws Exception {
		
		authService.cmmnCdMng(request, model, vo);
		
		return "/auth/cmmnCdMng.tiles";
	}
	
	/**
	 * <pre>
	 * @Method Name  : cmmnCdMngDetail
	 * @Method 설명 : 공통코드 관리화면 상세
	 * </pre>
	 * @작성일   : 2019. 01. 09.
	 * @작성자   : YTK
	 * @변경이력  :
	 */
	@RequestMapping("/auth/cmmnCdMngDetail.do")
	public String cmmnCdMngDetail(HttpServletRequest request, Model model, AuthVo vo) throws Exception {
		
		Map<String, Object> detailMap = authService.cmmnCdMngDetail(vo);
		
		model.addAttribute("detailMap", detailMap);
		
		return "jsonView";
	}
	
	/**
	 * <pre>
	 * @Method Name  : saveCmmnCdMng
	 * @Method 설명 : 공통코드 관리화면 저장(신규, 수정)
	 * </pre>
	 * @작성일   : 2019. 01. 09.
	 * @작성자   : YTK
	 * @변경이력  :
	 */
	@RequestMapping(value="/auth/saveCmmnCdMng.do")
	public String saveCmmnCdMng(HttpServletRequest request, Model model, AuthVo vo) throws Exception {
		
		authService.saveCmmnCdMng(request, model, vo);
		
		String paramUrl = "?searchYn=Y";
		paramUrl += "&curPage=" + request.getParameter("curPage");
		paramUrl += "&cols=" + request.getParameter("cols");
		paramUrl += "&keys=" + request.getParameter("keys");
		// 조회조건유지 항목만 셋팅 해줄것! 
		paramUrl += "&SEARCH_CODE_NM=" + URLEncoder.encode(vo.getSEARCH_CODE_NM(), "UTF-8");
		
		return "redirect:/auth/cmmnCdMng.do" + paramUrl;
	}
	
	/**
	 * <pre>
	 * @Method Name  : deleteCmmnCdMng
	 * @Method 설명 : 공통코드 관리화면 삭제
	 * </pre>
	 * @작성일   : 2019. 01. 09.
	 * @작성자   : YTK
	 * @변경이력  :
	 */
	@RequestMapping(value="/auth/deleteCmmnCdMng.do")
	public String deleteCmmnCdMng(HttpServletRequest request, Model model, AuthVo vo) throws Exception {
		
		authService.deleteCmmnCdMng(request, model, vo);
		
		String paramUrl = "?searchYn=Y";
		paramUrl += "&curPage=" + request.getParameter("curPage");
		paramUrl += "&cols=" + request.getParameter("cols");
		paramUrl += "&keys=" + request.getParameter("keys");
		// 조회조건유지 항목만 셋팅 해줄것! 
		paramUrl += "&SEARCH_CODE_NM=" + URLEncoder.encode(vo.getSEARCH_CODE_NM(), "UTF-8");
		
		return "redirect:/auth/cmmnCdMng.do" + paramUrl;
	}
	
	
	/**
	 * <pre>
	 * @Method Name  : cmmnDtlCdMng
	 * @Method 설명 : 공통상세코드 관리화면
	 * </pre>
	 * @작성일   : 2019. 01. 09.
	 * @작성자   : YTK
	 * @변경이력  :
	 */
	@RequestMapping(value="/auth/cmmnDtlCdMng.do")
	public String cmmnDtlCdMng(HttpServletRequest request, Model model, AuthVo vo) throws Exception {
		
		authService.cmmnCdMng(request, model, vo);
		
		return "/auth/cmmnDtlCdMng.tiles";
	}
	
	/**
	 * <pre>
	 * @Method Name  : cmmnCdMngDetail
	 * @Method 설명 : 공통코드 관리화면 상세
	 * </pre>
	 * @작성일   : 2019. 01. 09.
	 * @작성자   : YTK
	 * @변경이력  :
	 */
	@RequestMapping("/auth/cmmnDtlCdMngDetail.do")
	public String cmmnDtlCdMngDetail(HttpServletRequest request, Model model, AuthVo vo) throws Exception {
		
		List<Map<String, Object>> detailMapList = authService.cmmnDtlCdMngDetail(vo);
		
		model.addAttribute("detailMapList", detailMapList);
		
		return "jsonView";
	}
	
	/**
	 * <pre>
	 * @Method Name  : saveCmmnDtlCdMng
	 * @Method 설명 : 공통코드 관리화면 저장
	 * </pre>
	 * @작성일   : 2019. 01. 09.
	 * @작성자   : YTK
	 * @변경이력  :
	 */
	@RequestMapping("/auth/saveCmmnDtlCdMng.do")
	public String saveCmmnDtlCdMng(HttpServletRequest request, Model model,
										@RequestParam(value="codeSe") String codeSe,
										@RequestParam(value="codeSeArr[]") List<String> codeSeArr,
										@RequestParam(value="dtlcodeArr[]") List<String> dtlcodeArr,
										@RequestParam(value="dtlcodeNmArr[]") List<String> dtlcodeNmArr,
										@RequestParam(value="dtlcodeEngNmArr[]") List<String> dtlcodeEngNmArr,
										@RequestParam(value="dtlcodeDcArr[]") List<String> dtlcodeDcArr,
										@RequestParam(value="ordrArr[]") List<String> ordrArr,
										@RequestParam(value="useAtArr[]") List<String> useAtArr) throws Exception {
		
		List<AuthVo> paramVoList = new ArrayList<AuthVo>();
		if(codeSeArr.size() != 0){
			for(int i = 0; i < codeSeArr.size(); i++){
				AuthVo tmpVo = new AuthVo();
				tmpVo.setCODE_SE(StringUtils.equals(" ", codeSeArr.get(i)) ? "" : codeSeArr.get(i));
				tmpVo.setDTLCODE(StringUtils.equals(" ", dtlcodeArr.get(i)) ? "" : dtlcodeArr.get(i));
				tmpVo.setDTLCODE_NM(StringUtils.equals(" ", dtlcodeNmArr.get(i)) ? "" : dtlcodeNmArr.get(i));
				tmpVo.setDTLCODE_ENG_NM(StringUtils.equals(" ", dtlcodeEngNmArr.get(i)) ? "" : dtlcodeEngNmArr.get(i));
				tmpVo.setDTLCODE_DC(StringUtils.equals(" ", dtlcodeDcArr.get(i)) ? "" : dtlcodeDcArr.get(i));
				tmpVo.setORDR(StringUtils.equals(" ", ordrArr.get(i)) ? "" : ordrArr.get(i));
				tmpVo.setUSE_AT(StringUtils.equals(" ", useAtArr.get(i)) ? "" : useAtArr.get(i));
				paramVoList.add(tmpVo);
			}
		}

		authService.saveCmmnDtlCdMng(codeSe, paramVoList);
		
		return "jsonView";
	}
	
	
	/**
	 * <pre>
	 * @Method Name  : usrMng
	 * @Method 설명 : 사용자 관리
	 * </pre>
	 * @작성일   : 2019. 02. 19.
	 * @작성자   : LJY
	 * @변경이력  :
	 */
	@RequestMapping(value="/auth/usrMng.do")
	public String usrMng(HttpServletRequest request, Model model, AuthVo vo) throws Exception {
		authService.usrMng(request, model, vo);
		
		return "/auth/usrMng.tiles";
	}
	/**
	 * <pre>
	 * @Method Name  : usrMngDetail
	 * @Method 설명 : 사용자 관리화면 상세
	 * </pre>
	 * @작성일   : 2019. 02. 11.
	 * @작성자   : LJY
	 * @변경이력  :
	 */
	@RequestMapping("/auth/usrMngDetail.do")
	public String usrMngDetail(HttpServletRequest request, Model model, AuthVo vo) throws Exception {
		Map<String, Object> detailMap = authService.usrMngDetail(vo);
		
		model.addAttribute("detailMap", detailMap);
		return "jsonView";
	}
	
	
	/**
	 * 신규 사용자 등록시 아이디 중복 체크
	 * @param request
	 * @param model
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/auth/duplIdCheck.do")
	public String duplIdCheck(HttpServletRequest request, Model model, AuthVo vo) throws Exception{
		String user_id = request.getParameter("INSERT_USER_ID");
		vo.setUSER_ID(user_id);
		
		int result = authService.duplIdCheck(vo);
		
		if(result == 0){
			model.addAttribute("duplIdCheck", "OK");
			return "jsonView";
		}else {
			model.addAttribute("duplIdCheck", "Error");
			return "jsonView";
		}
		
	}
	
	
	/**
	 * <pre>
	 * @Method Name  : saveUsrMng
	 * @Method 설명 : 사용자 관리화면 저장(신규, 수정)
	 * </pre>
	 * @작성일   : 2019. 02. 11.
	 * @작성자   : LJY
	 * @변경이력  :
	 */
	@RequestMapping(value="/auth/saveUsrMng.do")
	public String saveUsrMng(HttpServletRequest request, Model model, AuthVo vo) throws Exception {
		String USER_ID = request.getParameter("INSERT_USER_ID");
		vo.setUSER_ID(USER_ID);
		
		String password = request.getParameter("USER_PWD");

		if(password == null || password == "" || password.equals("")) {
			vo.setUSER_PWD("");
		}else {
			String Encrypt = EncryptUtil.sha256(password);
			vo.setUSER_PWD(Encrypt);
		}
		
		String USER_NM = request.getParameter("USER_NM");
		vo.setUSER_NM(USER_NM);
		
		String EMAIL = request.getParameter("INSER_USER_EMAIL");
		vo.setEMAIL(EMAIL);
		
		String MOBILE = request.getParameter("MOBILE");
		vo.setMOBILE(MOBILE);
		
		String AUTH_CD = request.getParameter("AUTH_CD");
		vo.setAUTH_CD(AUTH_CD);
		
//		String USE_AT = request.getParameter("USE_AT");
//		vo.setUSE_AT(USE_AT);
		
		String OFFICE_REG_NO = request.getParameter("OFFICE_REG_NO");
		vo.setOFFICE_REG_NO(OFFICE_REG_NO);
		
		String ANNUAL_USER = request.getParameter("ANNUAL_USER");
		vo.setANNUAL_USER(ANNUAL_USER);
		
		String ANNUAL_USER_START_DT = request.getParameter("ANNUAL_USER_START_DT");
		vo.setANNUAL_USER_START_DT(ANNUAL_USER_START_DT);
		
		authService.saveUsrMng(request, model, vo);
		
		String paramUrl = "?searchYn=Y";
		paramUrl += "&curPage=" + request.getParameter("curPage");
		paramUrl += "&cols=" + request.getParameter("cols");
		paramUrl += "&keys=" + request.getParameter("keys");
		// 조회조건유지 항목만 셋팅 해줄것! 
		paramUrl += "&SEARCH_USR_NM=" + URLEncoder.encode(request.getParameter("SEARCH_USR_NM"), "UTF-8");
		
		return "redirect:/auth/usrMng.do" +  paramUrl;
	}
	
	
	
	/**
	 * <pre>
	 * @Method Name  : deleteUsrMng
	 * @Method 설명 : 사용자 관리화면 삭제
	 * </pre>
	 * @작성일   : 2019. 02. 19.
	 * @작성자   : LJY
	 * @변경이력  :
	 */
	@RequestMapping(value="/auth/deleteUsrMng.do")
	public String deleteUsrMng(HttpServletRequest request, Model model, AuthVo vo) throws Exception {
		
		
		
		authService.deleteUsrMng(request, model, vo);
		
		String paramUrl = "?searchYn=Y";
		paramUrl += "&curPage=" + request.getParameter("curPage");
		paramUrl += "&cols=" + request.getParameter("cols");
		paramUrl += "&keys=" + request.getParameter("keys");
		// 조회조건유지 항목만 셋팅 해줄것! 
		paramUrl += "&SEARCH_USR_NM=" + URLEncoder.encode(request.getParameter("SEARCH_USR_NM"), "UTF-8");
		
		return "redirect:/auth/usrMng.do";
	}
	
	
	
	/**
	 * <pre>
	 * @Method Name  : chkPwdUsrMng
	 * @Method 설명 : 사용자 관리화면 패스워드 검사
	 * </pre>
	 * @작성일   : 2019. 02. 19.
	 * @작성자   : LJY
	 * @변경이력  :
	 */
	@RequestMapping(value="/auth/chkPwdUsrMng.do")
	public String chkPwdUsrMng(HttpServletRequest request, Model model, AuthVo vo) throws Exception {
		int  result = authService.chkPwdUsrMng(vo, request, model);
		
		if(result == 0){
			model.addAttribute("pwdChk", "OK");
			return "jsonView";
		}else {
			model.addAttribute("pwdChk", "Error");
			return "jsonView";
		}
	}

	
	/**
	 * <pre>
	 * @Method Name  : menuAuthMng
	 * @Method 설명 : 메뉴권한관리 화면 오픈
	 * </pre>
	 * @작성일   : 2018. 02. 12.
	 * @작성자   : HBJ
	 * @변경이력  :
	 */
	@RequestMapping(value="/auth/menuAuthMng.do")
	public String menuAuthMng(HttpServletRequest request, Model model) throws Exception {
		
		return "/auth/menuAuthMng.tiles";
	}
	
	/**
	 * <pre>
	 * @Method Name  : menuAuthCdMng
	 * @Method 설명 : 권한코드 관리화면
	 * </pre>
	 * @작성일   : 2019. 02. 01.
	 * @작성자   : CMK
	 * @변경이력  :
	 */
	@RequestMapping(value="/auth/menuAuthCdMng.do")
	public String menuAuthCdMng(HttpServletRequest request, Model model, AuthVo vo) throws Exception {
		
		authService.authCdMng(request, model, vo);
		
		return "/auth/menuAuthMng.tiles";
	}
	
	/**
	 * <pre>
	 * @Method Name  : menuAuthMngDetail
	 * @Method 설명 : 메뉴권한 관리화면 상세
	 * </pre>
	 * @작성일   : 2019. 02. 13.
	 * @작성자   : HBJ
	 * @변경이력  :
	 */
	@RequestMapping("/auth/menuAuthMngDetail.do")
	public String menuAuthMngDetail(HttpServletRequest request, Model model, AuthVo vo) throws Exception {
		
		List<AuthVo> authMenuList = authService.readAuthMenuList(vo);
		
		model.addAttribute("authMenuList", authMenuList);
		
		return "jsonView";
	}
	
	
	/**
	 * <pre>
	 * @Method Name  : saveMenuAuthDtlMng
	 * @Method 설명 : 메뉴권한 관리화면 저장
	 * </pre>
	 * @작성일   : 2019. 02. 13.
	 * @작성자   : HBJ
	 * @변경이력  :
	 */
	@RequestMapping("/auth/saveMenuAuthDtlMng.do")
	public String saveAuthDtlMng(HttpServletRequest request, Model model,
										@RequestParam(value="authCd") String authCd,
										@RequestParam(value="authArr[]") List<String> authArr,
										@RequestParam(value="menuIdArr[]") List<String> menuIdArr) throws Exception {
		
		List<AuthVo> paramVoList = new ArrayList<AuthVo>();
		if(authArr.size() != 0){
			for(int i = 0; i < authArr.size(); i++){
					AuthVo tmpVo = new AuthVo();
					tmpVo.setMenu_use_authChk(StringUtils.equals(" ", authArr.get(i)) ? "" : authArr.get(i));
					tmpVo.setMenu_id(StringUtils.equals(" ", menuIdArr.get(i)) ? "" : menuIdArr.get(i));
					paramVoList.add(tmpVo);
			}
		}

		authService.saveAuthDtlMng(authCd,paramVoList);
		
		return "jsonView";
	}
	
	
	
	
	// ************* 기관코드 및 기관상세코드 **********************
	
	
	@RequestMapping(value="/auth/prOrgCdMng.do")
	public String prOrgCdMng(HttpServletRequest request, Model model, AuthVo vo) throws Exception {
		
		authService.prOrgCdMng(request, model, vo);
		
		return "/auth/prOrgCdMng.tiles";
	}
	
	
	@RequestMapping("/auth/prOrgMngDetail.do")
	public String prOrgMngDetail(HttpServletRequest request, Model model, AuthVo vo) throws Exception {
		
		Map<String, Object> detailMap = authService.prOrgMngDetail(vo);
		
		model.addAttribute("detailMap", detailMap);
		
		return "jsonView";
	}
	
	
	@RequestMapping(value="/auth/savePrOrgCdMng.do")
	public String savePrOgrMng(HttpServletRequest request, Model model, AuthVo vo) throws Exception {
		
		authService.savePrOgrMng(request, model, vo);
		String paramUrl = "?searchYn=Y";
		paramUrl += "&curPage=" + request.getParameter("curPage");
		paramUrl += "&cols=" + request.getParameter("cols");
		paramUrl += "&keys=" + request.getParameter("keys");
		// 조회조건유지 항목만 셋팅 해줄것! 
		paramUrl += "&SEARCH_CODE_NM=" + URLEncoder.encode(vo.getSEARCH_CODE_NM(), "UTF-8");
		
		return "redirect:/auth/prOrgCdMng.do" + paramUrl;
	}
	
	
	@RequestMapping(value="/auth/deletePrOrgCdMng.do")
	public String deletePrOrgCdMng(HttpServletRequest request, Model model, AuthVo vo) throws Exception {
		
		authService.deletePrOrgCdMng(request, model, vo);
		
		String paramUrl = "?searchYn=Y";
		paramUrl += "&curPage=" + request.getParameter("curPage");
		paramUrl += "&cols=" + request.getParameter("cols");
		paramUrl += "&keys=" + request.getParameter("keys");
		// 조회조건유지 항목만 셋팅 해줄것! 
		paramUrl += "&SEARCH_CODE_NM=" + URLEncoder.encode(vo.getSEARCH_CODE_NM(), "UTF-8");
		
		return "redirect:/auth/prOrgCdMng.do" + paramUrl;
	}
	
	
	@RequestMapping("/auth/prOrgDtlMngDetail.do")
	public String prOrgDtlMngDetail(HttpServletRequest request, Model model, AuthVo vo) throws Exception {
		
		List<Map<String, Object>> detailMapList = authService.prOrgDtlMngDetail(vo);
		
		model.addAttribute("detailMapList", detailMapList);
		
		return "jsonView";
	}
	
	
	@RequestMapping("/auth/savePrOrgDtlCdMng.do")
	public String savePrOrgDtlCdMng(HttpServletRequest request, Model model,
										@RequestParam(value="codeSe") String codeSe,
										@RequestParam(value="codeSeArr[]") List<String> codeSeArr,
										@RequestParam(value="dtlcodeArr[]") List<String> dtlcodeArr,
										@RequestParam(value="dtlcodeNmArr[]") List<String> dtlcodeNmArr,
										@RequestParam(value="addressArr[]") List<String> addressArr,
										@RequestParam(value="saupjaNoArr[]") List<String> saupjaNoArr,
										@RequestParam(value="useAtArr[]") List<String> useAtArr) throws Exception {
		
		List<AuthVo> paramVoList = new ArrayList<AuthVo>();
		if(codeSeArr.size() != 0){
			for(int i = 0; i < codeSeArr.size(); i++){
				AuthVo tmpVo = new AuthVo();
				tmpVo.setCODE_SE(StringUtils.equals(" ", codeSeArr.get(i)) ? "" : codeSeArr.get(i));
				tmpVo.setDTLCODE(StringUtils.equals(" ", dtlcodeArr.get(i)) ? "" : dtlcodeArr.get(i));
				tmpVo.setDTLCODE_NM(StringUtils.equals(" ", dtlcodeNmArr.get(i)) ? "" : dtlcodeNmArr.get(i));
				tmpVo.setADDRESS(StringUtils.equals(" ", addressArr.get(i)) ? "" : addressArr.get(i));
				tmpVo.setSAUPJA_NO(StringUtils.equals(" ", saupjaNoArr.get(i)) ? "" : saupjaNoArr.get(i));
				tmpVo.setUSE_AT(StringUtils.equals(" ", useAtArr.get(i)) ? "" : useAtArr.get(i));
				paramVoList.add(tmpVo);
			}
		}

		authService.savePrOrgDtlCdMng(codeSe, paramVoList);
		
		return "jsonView";
	}
	
	@RequestMapping(value="/auth/prOrgCdDtlMng.do")
	public String prOrgDtlCdMng(HttpServletRequest request, Model model, AuthVo vo) throws Exception {
		
		authService.prOrgCdMng(request, model, vo);
		
		return "/auth/prOrgCdDtlMng.tiles";
	}
	
	
	
}
