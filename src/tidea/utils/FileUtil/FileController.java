package tidea.utils.FileUtil;

import java.io.File;
import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.ModelAndView;

import tidea.review.common.service.CommonShService;
import tidea.review.common.vo.CommonVo;

@Controller
public class FileController implements ApplicationContextAware{
	
	@Resource(name = "commonShService")
	private CommonShService commonShService;
 
    private WebApplicationContext context = null;
     
    /**
	 * <pre>
	 * @Method Name  : download
	 * @Method 설명 : 파일 다운로드
	 * 파일 경로와 파일이름을 이용하여 파일을 다운로드 한다.
	 * </pre>
	 * @작성일   : 2019. 02. 10.
	 * @작성자   : PJB
	 * @변경이력  :
	 */
    
    @RequestMapping("download.do")
    public ModelAndView download(@RequestParam("path")String path,
                                  @RequestParam("fileName")String fileName, HttpServletRequest request){
    	String savePath = request.getSession().getServletContext().getRealPath("/");
        //파일 객체 생성
        File file = new File(savePath + path + File.separator + fileName);
        
        return new ModelAndView("download", "downloadFile", file);
    }
    
    /**
   	 * <pre>
   	 * @Method Name  : fileDelete
   	 * @Method 설명 : 파일 삭제
   	 * 파일 경로를 이용하여 파일객체를 만든 다음 해당 파일을 삭제한다.
   	 * </pre>
   	 * @작성일   : 2019. 02. 12.
   	 * @작성자   : PJB
   	 * @변경이력  :
   	 */
       
    
    @ResponseBody
    @RequestMapping("fileDelete.do")
    public HashMap<String, String> fileDelete(HttpServletRequest request){
    	
    	//404 에러 방지를 위한 값 전달
    	commonShService.fileDelete(request);
    	HashMap<String, String> map = new HashMap<String, String>();

    	map.put("code","1");
        map.put("msg", "404에러방지 값입니다.");
        
        return map;


    	
    }
    
    /**
   	 * <pre>
   	 * @Method Name  : fileDelete
   	 * @Method 설명 : 파일 삭제
   	 * 파일 경로를 이용하여 파일객체를 만든 다음 해당 파일을 삭제한다.
   	 * </pre>
   	 * @작성일   : 2019. 02. 12.
   	 * @작성자   : PJB
   	 * @변경이력  :
   	 */
       
    
    @ResponseBody
    @RequestMapping("fileDeleteBF.do")
    public HashMap<String, String> fileDeleteBF(HttpServletRequest request){
    	
    	//404 에러 방지를 위한 값 전달
    	commonShService.fileDeleteBF(request);
    	HashMap<String, String> map = new HashMap<String, String>();

    	map.put("code","1");
        map.put("msg", "404에러방지 값입니다.");
        
        return map;


    	
    }
    
    /**
   	 * <pre>
   	 * @Method Name  : fileDelete
   	 * @Method 설명 : 파일 삭제
   	 * 파일 경로를 이용하여 파일객체를 만든 다음 해당 파일을 삭제한다.
   	 * </pre>
   	 * @작성일   : 2019. 02. 12.
   	 * @작성자   : PJB
   	 * @변경이력  :
   	 */
       
    
    @ResponseBody
    @RequestMapping("fileDeleteAF.do")
    public HashMap<String, String> fileDeleteAF(HttpServletRequest request){
    	
    	//404 에러 방지를 위한 값 전달
    	commonShService.fileDeleteAF(request);
    	HashMap<String, String> map = new HashMap<String, String>();

    	map.put("code","1");
        map.put("msg", "404에러방지 값입니다.");
        
        return map;


    	
    }
 
    /**
   	 * <pre>
   	 * @Method Name  : fileDelete
   	 * @Method 설명 : 파일 삭제
   	 * 파일 경로를 이용하여 파일객체를 만든 다음 해당 파일을 삭제한다.
   	 * </pre>
   	 * @작성일   : 2019. 02. 12.
   	 * @작성자   : PJB
   	 * @변경이력  :
   	 */
       
    
    @ResponseBody
    @RequestMapping("fileDeleteDGRI.do")
    public HashMap<String, String> fileDeleteDGRI(HttpServletRequest request){
    	
    	//404 에러 방지를 위한 값 전달
    	commonShService.fileDeleteDGRI(request);
    	HashMap<String, String> map = new HashMap<String, String>();

    	map.put("code","1");
        map.put("msg", "404에러방지 값입니다.");
        
        return map;


    	
    }
    @Override
    public void setApplicationContext(ApplicationContext arg0)
            throws BeansException {
        // TODO Auto-generated method stub
         
        this.context = (WebApplicationContext)arg0;
         
    }
     
}