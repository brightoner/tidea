package tidea.review.receipt.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import tidea.review.apply.vo.AttachFileVo;
import tidea.review.receipt.dao.ReceiptDao;
import tidea.review.receipt.vo.ReceiptVo;
import tidea.utils.ComponentUtil;
import tidea.utils.PagingUtil;

@Service("receiptService")
public class ReceiptServiceImpl implements ReceiptService{

	@Resource
	private ReceiptDao receiptDao;
	
	
	/**
	 * 우선신청접수 리스트, 카운트 갯수 불러오기
	 */
	@Override
	public void receiptInfoList(HttpServletRequest request, Model model, ReceiptVo receiptVo) throws Exception {
		
		int curPage = 1;
		
		//현재페이지 유지
		String tempPage = request.getParameter("curPage");
		
		System.out.println("************** tempPage : " + tempPage);
		
		if(!(tempPage == null || tempPage == "")){
			curPage = Integer.parseInt(tempPage);
			
			System.out.println("************** curPage : " + curPage);
		}
		
		List<Map<String, Object>> gridList = new ArrayList<Map<String, Object>>();
		int totalCnt = 0;
		PagingUtil pageUtil = new PagingUtil(totalCnt, curPage);
		
		if(StringUtils.equals("Y", request.getParameter("searchYn"))) {
			
			//목록 총 갯수
			totalCnt = receiptDao.selectReceiptListCount(receiptVo);
			pageUtil = new PagingUtil(totalCnt, curPage);
			receiptVo.setPageBegin(pageUtil.getPageBegin());
			receiptVo.setPageEnd(pageUtil.getPageEnd());
			
			//목록 호출 요청
			gridList = receiptDao.selectReceiptList(receiptVo);
		}
		
		model.addAttribute("gridList", ComponentUtil.dataGridSetting(gridList, request));
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("paging", pageUtil);
		model.addAttribute("applyVo", receiptVo);
	}


	/**
	 * 우선신청접수 입력 -관리자
	 * @param applyVo
	 * @throws Exception
	 */
	@Override
	public void insertReceipt(ReceiptVo receiptVo) throws Exception {
		receiptDao.insertReceipt(receiptVo);
	}



	/**
	 * 우선신청접수 상세페이지 불러오기
	 * @param applyVo
	 * @return
	 * @throws Exception
	 */
	@Override
	public Map<String, Object> selectReceiptDetail(ReceiptVo receiptVo) throws Exception {
		Map<String, Object> detailMap = receiptDao.selectReceiptDetail(receiptVo);
		return detailMap;
	}


	/**
	 * 우선신청접수 insert or update
	 * @param applyVo
	 * @return
	 * @throws Exception
	 */
//	@Override
//	public int saveChoice(ReceiptVo receiptVo) throws Exception {
//		return receiptDao.saveChoice(receiptVo);
//	}


	/**
	 * 우선신청접수 수정 - 관리자
	 * @param applyVo
	 * @throws Exception
	 */
	@Override
	public void updateReceipt(ReceiptVo receiptVo) throws Exception {
		receiptDao.updateReceipt(receiptVo);
	}


	/**
	 * 우선신청접수 삭제 - 관리자
	 * @param applyVo
	 * @throws Exception
	 */
	@Override
	public void deleteReceipt(ReceiptVo receiptVo) throws Exception {
		receiptDao.deleteReceipt(receiptVo);
	}

// 첨부파일관련
	//이용자
	@Override
	public List<Map<String, Object>> selectReceiptFileDetail(AttachFileVo attachFileVo) throws Exception {
		List<Map<String, Object>> detailMap_2 = receiptDao.selectReceiptFileDetail(attachFileVo);
		return detailMap_2;
	}
	//관리자
	@Override
	public List<Map<String, Object>> selectReceiptFileDetail_2(AttachFileVo attachFileVo) throws Exception {
		List<Map<String, Object>> detailMap_2 = receiptDao.selectReceiptFileDetail_2(attachFileVo);
		return detailMap_2;
	}


	@Override
	public void insertReceiptFile_2(AttachFileVo attachFileVo) throws Exception {
		receiptDao.insertReceiptFile_2(attachFileVo);
	}


	@Override
	public void updateReceiptFile_2(AttachFileVo attachFileVo) throws Exception {
		receiptDao.updateReceiptFile_2(attachFileVo);
	}


//	@Override
//	public void deleteReceiptFile(AttachFileVo attachFileVo) throws Exception {
//		receiptDao.deleteReceiptFile(attachFileVo);
//	}


	@Override
	public void delReceiptFile_2(AttachFileVo attachFileVo) throws Exception {
		receiptDao.delReceiptFile_2(attachFileVo);
	}


//	@Override
//	public int saveChoice(ApplyVo applyVo) throws Exception {
//		// TODO Auto-generated method stub
//		return 0;
//	}


	@Override
	public int duplCheck(ReceiptVo receiptVo) throws Exception {
		return receiptDao.duplCheck(receiptVo);
	}


	
	
	
}
