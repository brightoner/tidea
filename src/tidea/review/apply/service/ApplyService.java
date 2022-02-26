package tidea.review.apply.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import tidea.review.apply.vo.ApplyVo;
import tidea.review.apply.vo.AttachFileVo;

public interface ApplyService {

	
	/**
	 * 우선심사신청 리스트
	 * @param request
	 * @param model
	 * @param applyVo
	 * @throws Exception
	 */
	public void applyInfoList(HttpServletRequest request, Model model, ApplyVo applyVo) throws Exception;
	
	/**
	 * 우선심사신청 상세페이지 불러오기
	 * @param applyVo
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectApplyDetail(ApplyVo applyVo) throws Exception;
	
	
	/**
	 * 우선심사신청 insert or update
	 * @param applyVo
	 * @return
	 * @throws Exception
	 */
//	public int saveChoice(ApplyVo applyVo) throws Exception;
	
	/**
	 * 우선심사신청 입력 -이용자
	 * @param applyVo
	 * @throws Exception
	 */
	public void insertApply(ApplyVo applyVo) throws Exception;
	
	/**
	 * 우선심사신청 수정 - 이용자
	 * @param applyVo
	 * @throws Exception
	 */
	public void updateApply(ApplyVo applyVo) throws Exception;
	
	
	/**
	 * 우선심사신청 삭제 -이용자
	 * @param applyVo
	 * @throws Exception
	 */
	public void deleteApply(ApplyVo applyVo) throws Exception;
	
	/**
	 * 우선심사신청 중복체크 (공고번호가 PK)
	 * @param applyVo
	 * @return
	 * @throws Exception
	 */
	public int duplCheck(ApplyVo applyVo) throws Exception;
	
	
	/**
	 * 우선심사 신청 시 결제
	 * @param applyVo
	 * @throws Exception
	 */
	public void insertPayment(ApplyVo applyVo) throws Exception;
	
	/**
	 * 결제완료시 심사상태 변경 (2:결제완료)
	 * @param applyVo
	 * @throws Exception
	 */
	public void updateStatus(ApplyVo applyVo) throws Exception;
	
	/**
	 * 우선심사신청 삭제시 결제 정보도 삭제 
	 * @param applyVo
	 * @throws Exception
	 */
	public void deletePayment(ApplyVo applyVo) throws Exception;
	
// 첨부파일 관련	

	/**
	 * 우선심사신청 시 첨부파일 불러오기 - 이용자
	 * @param applyVo
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectApplyFileDetail(AttachFileVo attachFileVo) throws Exception;
	
	/**
	 * 우선심사신청 시 첨부파일 불러오기 - 관리자
	 * @param applyVo
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectApplyFileDetail_2(AttachFileVo attachFileVo) throws Exception;
	
	/**
	 * 우선심사신청 시 첨부파일 입력 - 이용자
	 * @param applyVo
	 * @throws Exception
	 */
	public void insertApplyFile(AttachFileVo attachFileVo) throws Exception;
	
	/**
	 * 우선심사신청 시 첨부파일 수정 - 이용자
	 * @param applyVo
	 * @throws Exception
	 */
	public void updateApplyFile(AttachFileVo attachFileVo) throws Exception; 
	
	/**
	 * 우선심사삭제 시 첨부파일 삭제 - 이용자
	 * @param applyVo
	 * @throws Exception
	 */
	public void deleteApplyFile(AttachFileVo attachFileVo) throws Exception;
	
	
	/**
	 * 우선심사수정 시 첨부파일 삭제 - 이용자
	 * @param ReceiptVo
	 * @throws Exception
	 */
	public void delApplyFile(AttachFileVo attachFileVo) throws Exception;
	
	
	
	
}
