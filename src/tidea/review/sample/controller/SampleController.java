package tidea.review.sample.controller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import tidea.review.common.service.CommonShService;
import tidea.review.sample.service.SampleService;
import tidea.review.sample.vo.SampleVo;

@Controller
public class SampleController {

	@Resource(name = "sampleService")
	private SampleService sampleService;
	
	@Resource(name = "commonShService")
	private CommonShService commonShService;
	
	
	/**
	 * <pre>
	 * @Method Name  : sampleScreen2
	 * @Method 설명 : 샘플화면(공통)들을 구현2
	 * </pre>
	 * @작성일   : 2018. 11. 26.
	 * @작성자   : YTK
	 * @변경이력  :
	 */
	@RequestMapping(value="/sample/sampleScreen2.do")
	public String sampleScreen2(HttpServletRequest request, Model model, SampleVo sampleVo) throws Exception {
		
		sampleService.sampleScreen2(request, model, sampleVo);
		
		return "/sample/sampleScreen2.test";
	}
	
	/**
	 * <pre>
	 * @Method Name  : sampleDetail
	 * @Method 설명 : 
	 * </pre>
	 * @작성일   : 2018. 11. 26.
	 * @작성자   : YTK
	 * @변경이력  :
	 */
	@RequestMapping("/sample/sampleDetail.do")
	public String sampleDetail(HttpServletRequest request, Model model, SampleVo sampleVo) throws Exception {
		
		Map<String, Object> detailMap = sampleService.sampleDetail(sampleVo);
		
		model.addAttribute("detailMap", detailMap);
		
		return "jsonView";
	}
	
	
	/**
	 * <pre>
	 * @Method Name  : sampleMain
	 * @Method 설명 : 샘플화면(공통)들을 구현2
	 * </pre>
	 * @작성일   : 2018. 11. 26.
	 * @작성자   : YTK
	 * @변경이력  :
	 */
	@RequestMapping(value="/sample/samplemain.do")
	public String sampleMain(HttpServletRequest request, Model model, SampleVo sampleVo) throws Exception {
		
		sampleService.sampleScreen2(request, model, sampleVo);
		
		return "/sample/samplemain";
	}
}
