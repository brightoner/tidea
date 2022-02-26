package tidea.utils.MailUtil;

import java.io.File;
import java.util.Date;
import java.util.Properties;
import java.util.regex.Pattern;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import egovframework.cmmn.service.EgovProperties;

public class MailUtil {
	Properties prop;
	Session session;

	EgovProperties egovProperties = new EgovProperties();
	
	public MailUtil()
	 {
	  prop = new Properties();
	  
	  prop.put("mail.transport.protocol", "smtp");

	  // 물론 알아서 하겠지만 메일을 보내주는 메일서버 정보
	  prop.put("mail.smtp.host", "smtp.daum.net");
//	  prop.put("mail.smtp.port", "587");
	  prop.put("mail.smtp.port", "465");
	  prop.put("mail.smtp.ssl.enable", "true");
	  
	  prop.put("mail.user" , "경영지원실");
	  prop.put("mail.from" , "경영지원실");
	  prop.put("mail.debug", "false");


	//  SMTP 서버 인증정보
	  prop.put("mail.smtp.auth", "true");
	  
	  String mailID = egovProperties.getProperty("mailID");
	  String mailPW = egovProperties.getProperty("mailPW");
	  
	  MyAuthenticator auth = new MyAuthenticator(mailID, mailPW);

	  session = Session.getInstance(prop, auth);
	 }

	/**
	 * SMTP Authenticator
	 */
	public final class MyAuthenticator extends javax.mail.Authenticator {

		private String id;
		private String pw;

		public MyAuthenticator(String id, String pw) {
			this.id = id;
			this.pw = pw;
		}

		protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
			return new javax.mail.PasswordAuthentication(id, pw);
		}

	}

	public  void send(String from, String messageTo, String messageCCTo, String subject, String content, File pdfFile, String attachment) 
	  throws Exception
	 {
		
		  String mailID = egovProperties.getProperty("mailID");
		  String mailPW = egovProperties.getProperty("mailPW");
		
		MimeMessage message = new MimeMessage(session);
        boolean parseStrict = false;
        InternetAddress address = InternetAddress.parse(mailID + "@daum.net", parseStrict)[0];
        address.setPersonal(from, "UTF-8");
        
        message.setFrom(address);
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(messageTo, parseStrict));
        message.setRecipients(Message.RecipientType.CC, InternetAddress.parse(messageCCTo, parseStrict));
        message.setSubject(subject);

        message.setHeader("X-Mailer", "sendMessage");
        message.setSentDate(new Date());

        FileDataSource dataSource = new FileDataSource(pdfFile);
        
        MimeBodyPart attachPart = new MimeBodyPart();
        attachPart.setDataHandler(new DataHandler(dataSource));
        attachPart.setFileName(attachment); // 파일명
//        attachPart.setDataHandler(new DataHandler(new FileDataSource(new File("somefile.xml"))));
        
        
        MimeBodyPart bodypart = new MimeBodyPart();
        bodypart.setContent(content, "text/html;charset=UTF-8");
        
        Multipart multipart = new MimeMultipart();
        multipart.addBodyPart(bodypart);
        multipart.addBodyPart(attachPart);
        
        message.setContent(multipart);
        Transport.send(message);
        pdfFile.delete();


	 }

	 public static boolean isEmail(String email) {
	 	if (email == null)
	 		return false;
	 	boolean b = Pattern.matches("[\\w\\~\\-\\.]+@[\\w\\~\\-]+(\\.[\\w\\~\\-]+)+", email.trim());
	 	return b;
	 }
}
