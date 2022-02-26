package tidea.review.sample.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import tidea.review.common.service.CommonShService;
import tidea.review.sample.dao.SampleDao;
import tidea.review.sample.vo.SampleVo;
import tidea.utils.ComponentUtil;
import tidea.utils.PagingUtil;

@Service("sampleService")
public class SampleServiceImpl implements SampleService {

	@Resource
	private  SampleDao sampleDao;
	
	@Resource(name = "commonShService")
	private CommonShService commonShService;
	
	
	public void sampleScreen2(HttpServletRequest request, Model model, SampleVo sampleVo) throws Exception {
		
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
			totalCnt = sampleDao.selectSampleListCount(sampleVo);
			pageUtil = new PagingUtil(totalCnt, curPage);
			sampleVo.setPageBegin(pageUtil.getPageBegin());
			sampleVo.setPageEnd(pageUtil.getPageEnd());
			
			// 목록 호출 요청
			gridList = sampleDao.selectSampleList(sampleVo);
			
		}
		
		model.addAttribute("gridList", ComponentUtil.dataGridSetting(gridList, request));
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("paging", pageUtil);
		model.addAttribute("vo", sampleVo);
		
	}
	
	public Map<String, Object> sampleDetail(SampleVo sampleVo) throws Exception {
		
		Map<String, Object> detailMap = sampleDao.selectSampleDetail(sampleVo);
		
		return detailMap;
	}
	
}
