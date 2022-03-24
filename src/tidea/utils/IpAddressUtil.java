package tidea.utils;

import java.net.Inet4Address;

import javax.servlet.http.HttpServletRequest;

public class IpAddressUtil {

	public static String getIpAddress(HttpServletRequest request) throws Exception{ 
		String ip = request.getRemoteAddr();
//		String ip2 = request.getRemoteHost();
		
		String ip4_ip = "";
		if("0:0:0:0:0:0:0:1".equals(ip) || ip == "0:0:0:0:0:0:0:1") {	// localhost ip 가 찍힐경우 실제 ip로 변환
			ip4_ip = Inet4Address.getLocalHost().getHostAddress();
		}else {															// 외부 ip 일 경우 외부 ip 
			ip4_ip = ip;
		}
		return ip4_ip;
	}
}
