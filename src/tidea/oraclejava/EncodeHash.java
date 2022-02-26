package tidea.oraclejava;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import sun.misc.BASE64Encoder;

public class EncodeHash {

	public static String sha256(String text) throws NoSuchAlgorithmException, UnsupportedEncodingException{
		
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		md.update(text.getBytes("UTF-8"));
		byte raw[] = md.digest();	//step 4
		String hash = (new BASE64Encoder()).encode(raw);	//step 5
		
		return hash;
	}
	
	
}
