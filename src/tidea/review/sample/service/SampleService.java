package tidea.review.sample.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import tidea.review.sample.vo.SampleVo;

public interface SampleService {
	
	public void sampleScreen2(HttpServletRequest request, Model model, SampleVo sampleVo) throws Exception;
	
	public Map<String, Object> sampleDetail(SampleVo sampleVo) throws Exception;

}
