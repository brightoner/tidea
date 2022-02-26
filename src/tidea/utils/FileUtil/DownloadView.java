package tidea.utils.FileUtil;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;
 

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 

import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;
 
public class DownloadView extends AbstractView {
 
 
    public void Download(){
         
        setContentType("application/download; utf-8");
         
    }
         
    protected void renderMergedOutputModel(Map<String, Object> model,
            HttpServletRequest request, HttpServletResponse response) throws Exception {
         
        File file = (File)model.get("downloadFile");
        System.out.println("DownloadView --> file.getPath() : " + file.getPath());
        System.out.println("DownloadView --> file.getName() : " + file.getName());
         
        response.setContentType(getContentType());
        response.setContentLength((int)file.length());
         
        String userAgent = request.getHeader("User-Agent");
         
        boolean ie = userAgent.indexOf("MSIE") > -1;
        boolean chrome = userAgent.indexOf("Chrome") > -1;
         
        String fileName = null;
        
        
        //파일 이름이 한글일 경우 깨짐현상 방지
        if(ie){
             
            fileName = URLEncoder.encode(file.getName(), "utf-8");
                         
        }else if(chrome){
        	StringBuffer sb = new StringBuffer();
        	for ( int i = 0; i < file.getName().length(); i++ ) {
    			char c = file.getName().charAt( i );
    			if ( c > '~' ) {
    				sb.append( URLEncoder.encode( "" + c, "UTF-8" ) );
    			}
    			else {
    				sb.append( c );
    			}
    		}
        	fileName = sb.toString();
        }else {
        
             
            fileName = new String(file.getName().getBytes("utf-8"));
             
        }// end if;
        //파일 다운로드시 파일명 앞에 붙은 업로드 시간 제거
        String substrFileName = fileName.substring(fileName.lastIndexOf("-_-")+3);
        response.setHeader("Content-Disposition", "attachment; filename=\"" + substrFileName + "\";");
         
        response.setHeader("Content-Transfer-Encoding", "binary");
         
        OutputStream out = response.getOutputStream();
         
        FileInputStream fis = null;
         
        try {
             
            fis = new FileInputStream(file);
             
            FileCopyUtils.copy(fis, out);
             
             
        } catch(Exception e){
             
            e.printStackTrace();
             
        }finally{
             
            if(fis != null){
                 
                try{
                    fis.close();
                }catch(Exception e){}
            }
             
        }// try end;
         
        out.flush();
         
    }// render() end;
}