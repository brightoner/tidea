package tidea.review.email.dao;

import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import tidea.review.email.vo.EmailVo;

@Mapper("emailDao")
public interface EmailDao {

	/**
	 * 티디아기관메일 정보 - 메일 발송을 위해
	 * @param authVo
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getTideaEmail(EmailVo emailVo) throws Exception;
	
	/**
	 * 티디아기관메일 정보 수정
	 * @param emailVo
	 * @throws Exception
	 */
	public void updateTideaEmail(EmailVo emailVo) throws Exception;
	
	
}
