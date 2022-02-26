package tidea.review.email.service;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import tidea.review.email.dao.EmailDao;
import tidea.review.email.vo.EmailVo;

@Service("emailService")
public class EmailServiceImpl implements EmailService{

	@Resource
	private EmailDao emailDao;
	
	/**
	 * 티디아기관메일 정보 - 메일 발송을 위해
	 * @param authVo
	 * @return
	 * @throws Exception
	 */
	@Override
	public Map<String, Object> getTideaEmail(EmailVo emailVo) throws Exception {
		Map<String, Object> detailMap = emailDao.getTideaEmail(emailVo);
		return detailMap;
	}
	
	/**
	 * 티디아기관메일 정보 수정
	 * @param emailVo
	 * @throws Exception
	 */
	@Override
	public void updateTideaEmail(EmailVo emailVo) throws Exception {
		emailDao.updateTideaEmail(emailVo);
	}

	
}
