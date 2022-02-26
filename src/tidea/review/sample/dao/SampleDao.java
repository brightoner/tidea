package tidea.review.sample.dao;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import tidea.review.sample.vo.SampleVo;

@Mapper("sampleDao")
public interface SampleDao {
	
	public int selectSampleListCount(SampleVo sampleVo) throws Exception;
	
	public List<Map<String, Object>> selectSampleList(SampleVo sampleVo) throws Exception;
	
	public Map<String, Object> selectSampleDetail(SampleVo sampleVo) throws Exception;

}
