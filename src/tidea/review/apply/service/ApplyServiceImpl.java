package tidea.review.apply.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import tidea.review.apply.dao.ApplyDao;
import tidea.review.apply.vo.ApplyVo;
import tidea.review.apply.vo.AttachFileVo;
import tidea.utils.ComponentUtil;
import tidea.utils.PagingUtil;

@Service("applyService")
public class ApplyServiceImpl implements ApplyService{

	
	@Resource
	private ApplyDao applyDao;
	
	
	/**
	 * 우선심사신청 리스트, 카운트 갯수 불러오기
	 */
	@Override
	public void applyInfoList(HttpServletRequest request, Model model, ApplyVo applyVo) throws Exception {
		
		int curPage = 1;
		
		//현재페이지 유지
		String tempPage = request.getParameter("curPage");
		
		if(!(tempPage == null || tempPage == "")){
			curPage = Integer.parseInt(tempPage);
		}
		
		List<Map<String, Object>> gridList = new ArrayList<Map<String, Object>>();
		int totalCnt = 0;
		PagingUtil pageUtil = new PagingUtil(totalCnt, curPage);
		
		if(StringUtils.equals("Y", request.getParameter("searchYn"))) {
			
			//목록 총 갯수
			totalCnt = applyDao.selectApplyListCount(applyVo);
			pageUtil = new PagingUtil(totalCnt, curPage);
			applyVo.setPageBegin(pageUtil.getPageBegin());
			applyVo.setPageEnd(pageUtil.getPageEnd());
			
			//목록 호출 요청
			gridList = applyDao.selectApplyList(applyVo);
		}
		
		model.addAttribute("gridList", ComponentUtil.dataGridSetting(gridList, request));
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("paging", pageUtil);
		model.addAttribute("applyVo", applyVo);
	}


	/**
	 * 우선심사신청 입력 -이용자
	 * @param applyVo
	 * @throws Exception
	 */
	@Override
	public void insertApply(ApplyVo applyVo) throws Exception {
		applyDao.insertApply(applyVo);
	}



	/**
	 * 우선심사신청 상세페이지 불러오기
	 * @param applyVo
	 * @return
	 * @throws Exception
	 */
	@Override
	public Map<String, Object> selectApplyDetail(ApplyVo applyVo) throws Exception {
		Map<String, Object> detailMap = applyDao.selectApplyDetail(applyVo);
		return detailMap;
	}


	/**
	 * 우선심사신청 insert or update
	 * @param applyVo
	 * @return
	 * @throws Exception
	 */
//	@Override
//	public int saveChoice(ApplyVo applyVo) throws Exception {
//		return applyDao.saveChoice(applyVo);
//	}


	/**
	 * 우선심사신청 수정 - 이용자
	 * @param applyVo
	 * @throws Exception
	 */
	@Override
	public void updateApply(ApplyVo applyVo) throws Exception {
		applyDao.updateApply(applyVo);
	}
	
	
	/**
	 * 보완 파일클릭 시 다운로드 시간 등록 - 이용자
	 * @param applyVo
	 * @throws Exception
	 */
	@Override
	public void updateDownDt(ApplyVo applyVo) throws Exception {
		applyDao.updateDownDt(applyVo);
	}


	/**
	 * 우선심사신청 삭제 -이용자
	 * @param applyVo
	 * @throws Exception
	 */
	@Override
	public void deleteApply(ApplyVo applyVo) throws Exception {
		applyDao.deleteApply(applyVo);
	}

	/**
	 * 우선심사 신청 시 결제
	 * @param applyVo
	 * @throws Exception
	 */
	@Override
	public void insertPayment(ApplyVo applyVo) throws Exception {
		applyDao.insertPayment(applyVo);
	}


	/**
	 * 결제완료시 심사상태 변경 (2:결제완료)
	 * @param applyVo
	 * @throws Exception
	 */
	@Override
	public void updateStatus(ApplyVo applyVo) throws Exception {
		applyDao.updateStatus(applyVo);
	}
	
	/**
	 * 우선심사신청 삭제시 결제 정보도 삭제 
	 * @param applyVo
	 * @throws Exception
	 */
	@Override
	public void deletePayment(ApplyVo applyVo) throws Exception {
		applyDao.deletePayment(applyVo);
	}

// 첨부파일관련
	@Override
	public List<Map<String, Object>> selectApplyFileDetail(AttachFileVo attachFileVo) throws Exception {
		List<Map<String, Object>> detailMap_2 = applyDao.selectApplyFileDetail(attachFileVo);
		return detailMap_2;
	}
	
	@Override
	public List<Map<String, Object>> selectApplyFileDetail_2(AttachFileVo attachFileVo) throws Exception {
		List<Map<String, Object>> detailMap_2 = applyDao.selectApplyFileDetail_2(attachFileVo);
		return detailMap_2;
	}


	@Override
	public void insertApplyFile(AttachFileVo attachFileVo) throws Exception {
		applyDao.insertApplyFile(attachFileVo);
	}


	@Override
	public void updateApplyFile(AttachFileVo attachFileVo) throws Exception {
		applyDao.updateApplyFile(attachFileVo);
	}


	@Override
	public void deleteApplyFile(AttachFileVo attachFileVo) throws Exception {
		applyDao.deleteApplyFile(attachFileVo);
	}


	@Override
	public void delApplyFile(AttachFileVo attachFileVo) throws Exception {
		applyDao.delApplyFile(attachFileVo);
	}


//	@Override
//	public int saveChoice(ApplyVo applyVo) throws Exception {
//		// TODO Auto-generated method stub
//		return 0;
//	}


	@Override
	public int duplCheck(ApplyVo applyVo) throws Exception {
		return applyDao.duplCheck(applyVo);
	}




	
	
	
	
	
	
}
