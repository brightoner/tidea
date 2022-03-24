package tidea.review.auth.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import tidea.review.auth.dao.AuthDao;
import tidea.review.auth.vo.AuthVo;
import tidea.review.auth.vo.BiznofileVo;
import tidea.utils.ComponentUtil;
import tidea.utils.PagingUtil;

@Service("authService")
public class AuthServiceImpl implements AuthService {
	
	@Resource
	private AuthDao authDao;
	
	public List<AuthVo> readMenuList(AuthVo authVo)  throws Exception{
		return authDao.selectMenuList(authVo);
	}
	
	public void saveMenu(AuthVo authVo, Model model, HttpServletRequest request) throws Exception {
		
		if(StringUtils.equals(authVo.getSave_type(), "I")){
			authDao.insertMenu(authVo);
		}else{
			authDao.updateMenu(authVo);
			if(authVo.getMenu_levl() == 0){
				//상위메뉴가 변경시 하위메뉴의 사용유무를 변경
				authDao.updateMenuDtl(authVo);
			}
		}
	}
	
	public void deleteMenu(AuthVo authVo) throws Exception {
		//하위메뉴삭제여부
		if(!StringUtils.isBlank(authVo.getMenu_id()) && StringUtils.isBlank(authVo.getMenu_prts_id()) ){
			authVo.setDel_yn("Y");
		}else{
			authVo.setDel_yn("N");
		}
		authDao.deleteMenu(authVo);
	}
	
	public void authCdMng(HttpServletRequest request, Model model, AuthVo vo) throws Exception {
		
		int curPage = 1;
		
		// 현재페이지 유지
		String tempPage = request.getParameter("curPage");
		if(!(tempPage == null || tempPage == "")){
			curPage = Integer.parseInt(tempPage);
		}
		
		List<Map<String, Object>> gridList = new ArrayList<Map<String,Object>>();
		int totalCnt = 0;
		PagingUtil pageUtil = new PagingUtil(totalCnt, curPage);
		
		if(StringUtils.equals("Y", request.getParameter("searchYn"))){
			
			// 목록 총 갯수
			totalCnt = authDao.selectAuthCdMngListCount(vo);
			pageUtil = new PagingUtil(totalCnt, curPage);
			vo.setPageBegin(pageUtil.getPageBegin());
			vo.setPageEnd(pageUtil.getPageEnd());
			
			// 목록 호출 요청
			gridList = authDao.selectAuthCdMngList(vo);
			
		}
		
		model.addAttribute("gridList", ComponentUtil.dataGridSetting(gridList, request));
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("paging", pageUtil);
		model.addAttribute("vo", vo);
	}
	
	public Map<String, Object> authCdMngDetail(AuthVo authVo) throws Exception {
		
		Map<String, Object> detailMap = authDao.selectAuthCdMngDetail(authVo);
		
		return detailMap;
	}
	
	
	public void saveAuthCdMng(HttpServletRequest request, Model model, AuthVo vo) throws Exception {
		
		String updateYn = request.getParameter("updateYn");
		if(StringUtils.equals("Y", updateYn)){
			authDao.updateAuthCdMng(vo);
		}else{
			authDao.insertAuthCdMng(vo);
		}
	}
	
	public void deleteAuthCdMng(HttpServletRequest request, Model model, AuthVo vo) throws Exception {
		
		// 권한코드 삭제
		authDao.deleteAuthCdMng(vo);
		
		// 권한상세코드 삭제
		
	}
	
	public List<Map<String, Object>> selectTopLeftmenuList(Map<String, Object> paramMap) throws Exception {
		return authDao.selectTopLeftmenuList(paramMap);
	}
	
	public List<AuthVo> selectMenuList(AuthVo authVo) throws Exception {
		return authDao.selectMenuList(authVo);
	}
	
	public void cmmnCdMng(HttpServletRequest request, Model model, AuthVo vo) throws Exception {
		
		int curPage = 1;
		
		// 현재페이지 유지
		String tempPage = request.getParameter("curPage");
		if(!(tempPage == null || tempPage == "")){
			curPage = Integer.parseInt(tempPage);
		}
		
		List<Map<String, Object>> gridList = new ArrayList<Map<String,Object>>();
		int totalCnt = 0;
		PagingUtil pageUtil = new PagingUtil(totalCnt, curPage);
		
		if(StringUtils.equals("Y", request.getParameter("searchYn"))){
			
			// 목록 총 갯수
			totalCnt = authDao.selectCmmnCdMngListCount(vo);
			pageUtil = new PagingUtil(totalCnt, curPage);
			vo.setPageBegin(pageUtil.getPageBegin());
			vo.setPageEnd(pageUtil.getPageEnd());
			
			// 목록 호출 요청
			gridList = authDao.selectCmmnCdMngList(vo);
			
		}
		
		model.addAttribute("gridList", ComponentUtil.dataGridSetting(gridList, request));
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("paging", pageUtil);
		model.addAttribute("vo", vo);
	}
	
	public Map<String, Object> cmmnCdMngDetail(AuthVo vo) throws Exception {
		
		Map<String, Object> detailMap = authDao.selectCmmnCdMngDetail(vo);
		
		return detailMap;
	}
	
	public void saveCmmnCdMng(HttpServletRequest request, Model model, AuthVo vo) throws Exception {
		
		String updateYn = request.getParameter("updateYn");
		if(StringUtils.equals("Y", updateYn)){
			authDao.updateCmmnCdMng(vo);
		}else{
			authDao.insertCmmnCdMng(vo);
		}
	}
	
	public void deleteCmmnCdMng(HttpServletRequest request, Model model, AuthVo vo) throws Exception {
		
		// 공통코드 삭제
		authDao.deleteCmmnCdMng(vo);
		
		// 공통상세코드 삭제
		authDao.deleteCmmnDtlCdMng(vo.getCODE_SE());
	}
	
	public List<Map<String, Object>> cmmnDtlCdMngDetail(AuthVo vo) throws Exception {
		
		List<Map<String, Object>> detailMapList = authDao.selectCmmnDtlCdMngDetailList(vo);
		
		return detailMapList;
	}
	
	public void saveCmmnDtlCdMng(String codeSe, List<AuthVo> voList) throws Exception {
		
		// 공통상세관리 삭제
		authDao.deleteCmmnDtlCdMng(codeSe);
		
		if(voList.size() > 0){
			// 공통상세관리 저장
			for(int i = 0; i < voList.size(); i++){
				AuthVo paramVo = new AuthVo();
				paramVo = voList.get(i);
				authDao.insertCmmnDtlCdMng(paramVo);
			}
		}
	}

	
	/**
	 * 사용자 관리
	 */
	public void usrMng(HttpServletRequest request, Model model, AuthVo vo) throws Exception {
		
		int curPage = 1;
		
		// 현재페이지 유지
		String tempPage = request.getParameter("curPage");
		if(!(tempPage == null || tempPage == "")){
			curPage = Integer.parseInt(tempPage);
		}
		
		List<Map<String, Object>> gridList = new ArrayList<Map<String,Object>>();
		int totalCnt = 0;
		PagingUtil pageUtil = new PagingUtil(totalCnt, curPage);
		
		if(StringUtils.equals("Y", request.getParameter("searchYn"))){
			
			// 목록 총 갯수
			totalCnt = authDao.selectUsrMngListCount(vo);
			pageUtil = new PagingUtil(totalCnt, curPage);
			vo.setPageBegin(pageUtil.getPageBegin());
			vo.setPageEnd(pageUtil.getPageEnd());
			
			// 목록 호출 요청
			gridList = authDao.selectUsrMngList(vo);
			
		}
		
		model.addAttribute("gridList", ComponentUtil.dataGridSetting(gridList, request));
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("paging", pageUtil);
		model.addAttribute("vo", vo);
	}
	
	public Map<String, Object> usrMngDetail(AuthVo vo) throws Exception {
		Map<String, Object> detailMap = authDao.selectUsrMngDetail(vo);
		
		return detailMap;
	}
	
	
	/**
	 * 사용자 신규입력시 아이디 중복체크
	 * @param vo
	 * @throws Exception
	 */
	@Override
	public int duplIdCheck(AuthVo vo) throws Exception {
		return authDao.duplIdCheck(vo);
	}
	
	
	/**
	 * 관리자가 사용자의 사용여부, 권한 수정
	 * @param vo
	 * @throws Exception
	 */
	public void saveUsrMng(HttpServletRequest request, Model model, AuthVo vo) throws Exception {
		String updateYn = request.getParameter("updateYn");
		if(StringUtils.equals("Y", updateYn)) {
			authDao.updateUsrMng(vo);
		}else {
			authDao.insertUsrMng(vo);
		}
	}
	
	/**
	 * 사용자가 자신의 회원 정보 수정
	 * @param vo
	 * @throws Exception
	 */
	@Override
	public void updateUserInfo(AuthVo vo) throws Exception {
		authDao.updateUserInfo(vo);
	}
	
	
	/**
	 * 사용자가 회원정보 수정 시 비밀번호 수정 - 이용자
	 * @param vo
	 * @throws Exception
	 */
	public void updatePw(AuthVo vo) throws Exception{
		authDao.updatePw(vo);
	}
	
	
	/**
	 * 사용자가 회원정보 삭제 - 탈퇴
	 * @param authVo
	 * @throws Exception
	 */
	@Override
	public void deleteUserInfo(AuthVo authVo) throws Exception {
		authDao.deleteUserInfo(authVo);
	}
	
	
	/**
	 * 이용자 회원정보 수정화면 불러오기
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	@Override
	public Map<String, Object> selectUserInfoDetail(AuthVo vo) throws Exception {
		Map<String, Object> detailMap = authDao.selectUserInfoDetail(vo);
		return detailMap;
	}
	
	
	
	public void deleteUsrMng(HttpServletRequest request, Model model, AuthVo vo) throws Exception {
		
		// 공통코드 삭제
		authDao.deleteUsrMng(vo);
		
	}
	
	
	public List<AuthVo> readAuthMenuList(AuthVo vo) throws Exception {
		return authDao.selectAuthMenuList(vo);
	}
	
	public void saveAuthDtlMng(String authCd,List<AuthVo> voList) throws Exception {
			
			AuthVo vo = new AuthVo();
			List<AuthVo> authMenuList = authDao.selectAuthMenuList(vo);
			
			if(voList.size() > 0){
					// 메뉴권한 저장
					for(int i = 0; i < voList.size(); i++){
						AuthVo paramVo = new AuthVo();
						paramVo = voList.get(i);
						String auth = authCd;
						String authMenu ="";
						String menuAuth = authMenuList.get(i).getMenu_use_auth();
						String authArrStr = paramVo.getMenu_use_authChk();
						String[] menuAuthArr = null;
						if(authArrStr.equals("Y")){
							if(null != authMenuList.get(i).getMenu_use_auth()){
								if(!"".equals(menuAuth)){
									menuAuthArr = menuAuth.split(",");
									for (int j = 0; j < menuAuthArr.length; j++) {
											if(menuAuth.contains(auth)){
												authMenu = menuAuth;
												break;
											}else{
												authMenu = menuAuth+","+auth;
											}
									
									}
									paramVo.setMenu_use_auth(authMenu);
								}else{
									paramVo.setMenu_use_auth(auth);
								}
							}else{
								paramVo.setMenu_use_auth(auth);
							}
								authDao.insertAuthDtlMng(paramVo);
								
						}else{
							authMenu = "";
							//메뉴권한 삭제(여긴 맞는거같은데 내일은 위에를 한번 보자)
							if(null != authMenuList.get(i).getMenu_use_auth()){
									if(!"".equals(menuAuth)){
										menuAuthArr = menuAuth.split(",");
										if(menuAuth.contains(auth)){//n일때 포함되어있으면 해당 auth 빼야함
										for (int j = 0; j < menuAuthArr.length; j++) {
												if(auth.equals(menuAuthArr[j])){
													continue;
												}else{
													if("".equals(authMenu)){
														authMenu = menuAuthArr[j];
													}else{
														authMenu += ","+menuAuthArr[j];
													}
												}
											}
											paramVo.setMenu_use_auth(authMenu);
										}else{
											paramVo.setMenu_use_auth(menuAuth);
										}
									}
								}
								authDao.insertAuthDtlMng(paramVo);
						}
					}
				}
			
			}

	
	@Override
	public List<Map<String, Object>> selectMainmenuList(Map<String, Object> paramMap) throws Exception {
		return authDao.selectMainmenuList(paramMap);
	}
	
	public List<Map<String, Object>> selectAllMenuList(Map<String, Object> paramMap) throws Exception {
		List<Map<String, Object>> listMap = new ArrayList<Map<String,Object>>();
		listMap = authDao.selectAllMenuList(paramMap);
		return listMap;
	}

	public List<Map<String, Object>> selectMenuByAuth(
			Map<String, Object> paramMap) {
		List<Map<String, Object>> listMap = new ArrayList<Map<String,Object>>();
		listMap = authDao.selectMenuByAuth(paramMap);
		return listMap;
	}

	@Override
	public List<Map<String, Object>> selectTopmenuList(Map<String, Object> paramMap) {
		List<Map<String, Object>> listMap = new ArrayList<Map<String,Object>>();
		listMap = authDao.selectTopmenuList(paramMap);
		return listMap;
	}


	@Override
	public int chkPwdUsrMng(AuthVo vo, HttpServletRequest request, Model model) throws Exception {
		int result = authDao.chkPwdUsrMng(vo);
		return result;
	}

	
	
	
	// ************* 기관코드 및 기관상세코드 **********************
	
	public void prOrgCdMng(HttpServletRequest request, Model model, AuthVo vo) throws Exception {
			
			int curPage = 1;
			
			// 현재페이지 유지
			String tempPage = request.getParameter("curPage");
			if(!(tempPage == null || tempPage == "")){
				curPage = Integer.parseInt(tempPage);
			}
			
			List<Map<String, Object>> gridList = new ArrayList<Map<String,Object>>();
			int totalCnt = 0;
			PagingUtil pageUtil = new PagingUtil(totalCnt, curPage);
			
			if(StringUtils.equals("Y", request.getParameter("searchYn"))){
				
				// 목록 총 갯수
				totalCnt = authDao.selectPrOrgMngListCount(vo);
				pageUtil = new PagingUtil(totalCnt, curPage);
				vo.setPageBegin(pageUtil.getPageBegin());
				vo.setPageEnd(pageUtil.getPageEnd());
				
				// 목록 호출 요청
				gridList = authDao.selectPrOrgMngList(vo);
				
			}
			
			model.addAttribute("gridList", ComponentUtil.dataGridSetting(gridList, request));
			model.addAttribute("totalCnt", totalCnt);
			model.addAttribute("paging", pageUtil);
			model.addAttribute("vo", vo);
	}
	
	
	public Map<String, Object> prOrgMngDetail(AuthVo vo) throws Exception {
		
		Map<String, Object> detailMap = authDao.selectPrOrgMngDetail(vo);
		
		return detailMap;
	}
	
	
	public void savePrOgrMng(HttpServletRequest request, Model model, AuthVo vo) throws Exception {
		
		String updateYn = request.getParameter("updateYn");
		
		if(StringUtils.equals("Y", updateYn)){
			authDao.updatePrOrgMng(vo);
		}else{
			authDao.insertPrOrgMng(vo);
		}
	}
	
	
	public void deletePrOrgCdMng(HttpServletRequest request, Model model, AuthVo vo) throws Exception {
		
		// 기관코드 삭제
		authDao.deletePrOrgCdMng(vo);
		
		// 기관상세코드 삭제
		authDao.deletePrOrgDtlCdMng(vo.getCODE_SE());
	}
	
	
	public List<Map<String, Object>> prOrgDtlMngDetail(AuthVo vo) throws Exception {
		
		List<Map<String, Object>> detailMapList = authDao.selectPrOrgMngDetailList(vo);
		
		return detailMapList;
	}
	
	
	public void savePrOrgDtlCdMng(String codeSe, List<AuthVo> voList) throws Exception {
		
		// 공통상세관리 삭제
		authDao.deletePrOrgDtlCdMng(codeSe);
		
		if(voList.size() > 0){
			// 공통상세관리 저장
			for(int i = 0; i < voList.size(); i++){
				AuthVo paramVo = new AuthVo();
				paramVo = voList.get(i);
				authDao.insertPrOrgDtlCdMng(paramVo);
			}
		}
	}

	
	/**
	 * 사용자 입력(회원가입)
	 * @param vo
	 * @throws Exception
	 */
	@Override
	public void insertUsrMng(AuthVo vo) throws Exception {
		authDao.insertUsrMng(vo);
	}

	/**
	 * 아이디찾기
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	@Override
	public String findUser_Id(AuthVo vo) throws Exception {
		return authDao.findUser_Id(vo);
	}
	
	/**
	 * 아이디찾기 카운트
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	@Override
	public int findUser_Id_count(AuthVo vo) throws Exception {
		return authDao.findUser_Id_count(vo);
	}
	
	/**
	 * 비밀번호찾기 카운트
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	@Override
	public int findUser_Pw_count(AuthVo vo) throws Exception {
		return authDao.findUser_Pw_count(vo);
	}

	/**
	 * 임시비밀번호 update 
	 * @param vo
	 * @throws Exception
	 */
	@Override
	public void updateTempPw(AuthVo vo) throws Exception {
		authDao.updateTempPw(vo);
	}
	
	/**
	 * 로그인시 미자막 로그인 날짜를 입력
	 * @param authVo
	 * @throws Exception
	 */
	@Override
	public void updateLastLoginDt(AuthVo authVo) throws Exception {
		authDao.updateLastLoginDt(authVo);
	}

	/**
	 * 비밀번호 변경날짜 확인 
	 * @param authVo
	 * @return
	 * @throws Exception
	 */
	@Override
	public String chkPwChangeDt(AuthVo authVo) throws Exception {
		return authDao.chkPwChangeDt(authVo);
	}

	
	
	/**
	 * 논문 접수 후 보완자료 첨부 시 이용자 메일주소 가져오기 - 보완완료 메일전송시 사용
	 * @param authVo
	 * @return
	 * @throws Exception
	 */
	@Override
	public String getEmail(AuthVo authVo) throws Exception {
		return authDao.getEmail(authVo);
	}
	
	
	/**
	 * 논문 접수 후 보완자료 첨부시 접수자 이메일주소 가져오기 - 보완완료 메일전송시 사용(접수자도 접수된 사실을 알아야하기때문)
	 * @param authVo
	 * @return
	 * @throws Exception
	 */
	@Override
	public String getRectEmail(AuthVo authVo) throws Exception {
		return authDao.getRectEmail(authVo);
	}
	

	/**
	 * 이용자 우선심사신청시  이용자 이름  불러오기 - 신청메일 메일전송시 사용
	 * @param authVo
	 * @return
	 * @throws Exception
	 */
	@Override
	public String getName(AuthVo authVo) throws Exception {
		return authDao.getName(authVo);
	}

	
	
	
// ************* 사업자등록증파일 관련*******************************************************	
	/**
	 * 회원정보에서 사업자등록증파일 select
	 * @param biznofileVo
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<Map<String, Object>> selectBizNoFile(BiznofileVo biznofileVo) throws Exception {
		List<Map<String, Object>> detailMap_2 = authDao.selectBizNoFile(biznofileVo);
		return detailMap_2;
	}

	/**
	 * 회원가입시 사업자등록증파일 insert
	 * @param biznofileVo
	 * @throws Exception
	 */
	@Override
	public void insertBizNoFile(BiznofileVo biznofileVo) throws Exception {
		authDao.insertBizNoFile(biznofileVo);
	}

	/**
	 * 회원정보에서  사업자등록증파일 수정 
	 * @param biznofileVo
	 * @throws Exception
	 */
	@Override
	public void updateBizNoFile(BiznofileVo biznofileVo) throws Exception {
		authDao.updateBizNoFile(biznofileVo);
	}

	/**
	 * 회원정보 등록 시 사업자등록증파일 삭제
	 * @param biznofileVo
	 * @throws Exception
	 */
	@Override
	public void deleteBizNoFile(BiznofileVo biznofileVo) throws Exception {
		authDao.deleteBizNoFile(biznofileVo);
	}

	/**
	 * 회원정보  수정 시 사업자등록증파일 삭제
	 * @param biznofileVo
	 * @throws Exception
	 */
	@Override
	public void delBizNoFile(BiznofileVo biznofileVo) throws Exception {
		authDao.delBizNoFile(biznofileVo);
	}

	

//*********************************************************************************
	
	

	
	
	
}
