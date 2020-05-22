package mypack;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class WelcomeMail {
	
	public static void send(String sender,String id,String sub,String mesg)throws MessagingException {
	

		//String sender="mail-noreply@speedymx.com";
	      
	       
	       
	       	 mesg=mesg;
	       		       
	       	String sender_email = sender,
			sender_host = "127.0.0.1",
			sender_port = "25",
			reciever_id = id,
			subject_to_be_given = sub,
			message_mi = mesg;
	         Properties props = new Properties();
			 props.put("mail.smtp.user", sender_email);
			 props.put("mail.smtp.host", sender_host);
			 props.put("mail.smtp.port", sender_port);
			 props.put("mail.smtp.starttls.enable","true");
			// props.put("mail.smtp.auth", "true");
			 //props.put("mail.smtp.debug", "true");
			 props.put("mail.smtp.socketFactory.port",sender_port);
			// props.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");
			 props.put("mail.smtp.socketFactory.fallb","false");

			 SecurityManager security = System.getSecurityManager();

			 try
			 {
	       
				// Authenticator auth = new SMTPAuthenticator(sender_email,sender_password);
				 Session session = Session.getInstance(props);
				 //session.setDebug(true);

				 MimeMessage msg = new MimeMessage(session);
				// msg.setText(message_mi);
				 msg.setContent(message_mi,"text/html" );
				 msg.setSubject(subject_to_be_given);
				 msg.setFrom(new InternetAddress(sender_email,"Web Mail Admin"));
				 msg.addRecipient(Message.RecipientType.TO,new InternetAddress(reciever_id));
				// msg.setRecipient(Message.RecipientType.CC, new InternetAddress("nirbhay@silvereye.co"));
				 Transport.send(msg);
				 }
				 catch (Exception mex)
				 {
					 mex.printStackTrace();
				 } 
 	
}

}