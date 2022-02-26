package tidea.review.receipt.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import tidea.review.apply.vo.AttachFileVo;
import tidea.review.receipt.vo.ReceiptVo;

public interface ReceiptService {

	
	/**
	 * 우선신청접수 리스트
	 * @param request
	 * @param model
	 * @param applyVo
	 * @throws Exception
	 */
	public void receiptInfoList(HttpServletRequest request, Model model, ReceiptVo receiptVo) throws Exception;
	
	/**
	 * 우선신청접수 상세페이지 불러오기
	 * @param applyVo
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectReceiptDetail(ReceiptVo receiptVo) throws Exception;
	
	
	/**
	 * 우선신청접수 insert or update
	 * @param applyVo
	 * @return
	 * @throws Exception
	 */
//	public int saveChoice(ReceiptVo receiptVo) throws Exception;
	
	/**
	 * 우선신청접수 입력 -관리자
	 * @param applyVo
	 * @throws Exception
	 */
	public void insertReceipt(ReceiptVo receiptVo) throws Exception;
	
	/**
	 * 우선신청접수 수정 - 관리자
	 * @param applyVo
	 * @throws Exception
	 */
	public void updateReceipt(ReceiptVo receiptVo) throws Exception;
	
	
	/**
	 * 우선신청접수 삭제 -이용자
	 * @param applyVo
	 * @throws Exception
	 */
	public void deleteReceipt(ReceiptVo receiptVo) throws Exception;
	
	/**
	 * 우선신청접수 중복체크 (공고번호가 PK)
	 * @param applyVo
	 * @return
	 * @throws Exception
	 */
	public int duplCheck(ReceiptVo receiptVo) throws Exception;
	
	
// 첨부파일 관련	

	/**
	 * 우선신청접수 시 첨부파일 불러오기 - 이용자
	 * @param applyVo
	 * @return
	 * @throws Exception
	 */
	
	public List<Map<String, Object>> selectReceiptFileDetail(AttachFileVo attachFileVo) throws Exception;
	/**
	 * 우선신청접수 시 첨부파일 불러오기 - 관리자
	 * @param applyVo
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectReceiptFileDetail_2(AttachFileVo attachFileVo) throws Exception;
	
	/**
	 * 우선신청접수 시 첨부파일 입력 - 관리자
	 * @param applyVo
	 * @throws Exception
	 */
	public void insertReceiptFile_2(AttachFileVo attachFileVo) throws Exception;
	
	/**
	 * 우선신청접수 시 첨부파일 수정 - 이용자
	 * @param applyVo
	 * @throws Exception
	 */
	public void updateReceiptFile_2(AttachFileVo attachFileVo) throws Exception; 
	
	/**
	 * 우선신청접수 시 첨부파일 삭제 - 관리자
	 * @param applyVo
	 * @throws Exception
	 */
//	public void deleteReceiptFile-2(AttachFileVo attachFileVo) throws Exception;
	
	
	/**
	 * 우선신청접수 시 첨부파일 삭제 - 관리자
	 * @param ReceiptVo
	 * @throws Exception
	 */
	public void delReceiptFile_2(AttachFileVo attachFileVo) throws Exception;
	
}
