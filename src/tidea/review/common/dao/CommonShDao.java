package tidea.review.common.dao;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import tidea.review.auth.vo.AuthVo;
import tidea.review.common.vo.CommonVo;

@Mapper("commonShDao")
public interface CommonShDao {
	
	public List<Map<String, Object>> selectCotCdOrgList(String code) throws Exception;
	
	public List<Map<String, Object>> selectYearCombobox() throws Exception;
	
	public List<Map<String, Object>> selectAllItemNmList() throws Exception;
	
	public void updateApprovalOrCancelProcess(CommonVo commonVo) throws Exception;
	
	public List<Map<String, Object>> selectCmmnCdList(String codeSe) throws Exception;
	
	public int searchPopupListCount(AuthVo authVo) throws Exception;
	
	public List<AuthVo> searchPopupList(AuthVo authVo) throws Exception;
	
	public String cnfirmAtCheck(CommonVo commonVo) throws Exception;
	
	
	
	
	
	public void insertAllCpvStudMstList(List<Map<String, Object>> pList) throws Exception;
	
	public void deleteAllCpvStudMstList() throws Exception;

	public void fileDelete(CommonVo paramVo);
	
	public void fileDeleteBF(CommonVo paramVo);
	
	public void fileDeleteAF(CommonVo paramVo);

	public void fileDeleteDGRI(CommonVo paramVo);
	
	
	

}
