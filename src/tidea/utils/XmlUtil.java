package tidea.utils;

import java.util.List;
import java.util.Map;

import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;

/**
 * <pre>
 * FileName: XmlUtil.java
 * Package : kr.co.rastech.commons.utils
 *
 * XML 변환 관련 유틸리티 객체.
 *
 * </pre>
 * @author : rastech
 * @date   : 2015. 3. 9.
 */
public class XmlUtil {

    /**
     *
     * <pre>
     * 리스트를 XML로 변환한다.
     * 리스트 객체는 <items>로 DTO는 <item>으로 변환 한다.
     * XStream을 사용하고 있다.
     *
     * </pre>
     * @author : rastech
     * @date   : 2015. 3. 9.
     * @param list
     * @return
     */
    @SuppressWarnings("rawtypes")
    public static String listToXml(List list) {
        if (list == null) return "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n<items/>";

        String xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n";
        XStream xStream = new XStream(new DomDriver("UTF-8"));
        xStream.alias("items", List.class);

        if (!list.isEmpty()) {
            xStream.alias("item", list.get(0).getClass());
            xStream.processAnnotations(list.get(0).getClass());
        }

        xml += xStream.toXML(list);

        xml = xml.replaceAll("__", "_");
        
        return xml;
    }
    
    public static String listMapToXml(List<Map<String, Object>> list) {
    	StringBuffer xml = new StringBuffer();
		if (list == null){
			xml.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n<items/>");
		}else{
			
			xml.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n");
			xml.append("<items>\n");
			
			for (Map<String, Object> map : list) {
				xml.append("<item>\n");
				for (String colName : map.keySet()) {
					xml.append("	<"+colName+">").append(map.get(colName)).append("</"+colName+">\n");
				} 
				xml.append("</item>\n");				
			}
			xml.append("</items>\n");
		}
    	
    	return xml.toString();
    }

    /**
     *
     * <pre>
     * 리스트를 한줄짜리 XML로 변환한다.
     * 작은따움표(')는 \' 로 변환한다.
     * 리스트 객체는 <items>로 DTO는 <item>으로 변환 한다.
     * XStream을 사용하고 있다.
     *
     * </pre>
     * @author : rastech
     * @date   : 2015. 3. 9.
     * @param list
     * @return
     */
    @SuppressWarnings("rawtypes")
    public static String listToXmlLine(List list) {
        String xml = listToXml(list);
        return xml.replaceAll("\r\n", " ").replaceAll("\r", " ").replaceAll("\n", " " ).replaceAll("\\'", "\\\\'");
    }

    /**
     *
     * <pre>
     * 객체를 XML로 변환.
     *
     * </pre>
     * @author : rastech
     * @date   : 2015. 3. 9.
     * @param obj
     * @return
     */
    public static String objToXml(Object obj) {
        String xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n";
        XStream xStream = new XStream(new DomDriver("UTF-8"));
        xStream.alias("item", obj.getClass());
        xStream.processAnnotations(obj.getClass());
        xml += xStream.toXML(obj);

        return xml;
    }

    /**
     *
     * <pre>
     * Map을 XML로 변환
     *
     * </pre>
     * @author : rastech
     * @date   : 2015. 9. 14.
     * @param map
     * @return
     */
    public static String mapToXml(Map map) {
    	StringBuffer xml = new StringBuffer();
    	xml.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n");
    	xml.append("<item>");
    	for (Object key: map.keySet()) {
    		xml.append("<");
    		xml.append(key);
    		xml.append(">");
    		xml.append(map.get(key).toString());
    		xml.append("</");
    		xml.append(key);
    		xml.append(">\r\n");
    	}
    	xml.append("</item>");

    	return xml.toString();
    }
}
