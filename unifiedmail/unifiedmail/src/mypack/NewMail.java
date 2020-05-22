package mypack;


	

	import javax.mail.*;
	import javax.mail.internet.*;

import java.util.*; 
	public class NewMail {

		public static void send(String id,String sub,String mesg)throws MessagingException {
			// TODO Auto-generated method stub
			// Recipient's email ID needs to be mentioned.
				String sender_email = "unifiedmail.sil@gmail.com",//bsipldc@gmail.com",//enter sender mail id(should be in gmail)
				sender_password = "sil@2014",//bsipldc03",			//	passwor of email id		
				sender_host = "smtp.gmail.com",
				sender_port = "465",
				reciever_id = id,//"pandeyji.89@gmail.com",
				subject_to_be_given = sub,// "hiiiiiiii",
				message_mi = mesg;//"Welccome to .";

				Properties props = new Properties();
				
				//props.put("mail.smtp.from", "Nirbhay");
				 props.put("mail.smtp.user", sender_email);
				 props.put("mail.smtp.host", sender_host);
				 props.put("mail.smtp.port", sender_port);
				 props.put("mail.smtp.starttls.enable","true");
				 props.put("mail.smtp.auth", "true");
				 //props.put("mail.smtp.debug", "true");
				 props.put("mail.smtp.socketFactory.port",sender_port);
				 props.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");
				 props.put("mail.smtp.socketFactory.fallb","false");

				 SecurityManager security = System.getSecurityManager();

				 try
				 {
				 Authenticator auth = new SMTPAuthenticator(sender_email,sender_password);
				 Session session = Session.getInstance(props, auth);
				 //session.setDebug(true);

				 MimeMessage msg = new MimeMessage(session);
				//msg.setFrom(new InternetAddress("Nirbhay"));
				 msg.setContent(message_mi,"text/html" );
				// msg.setText(message_mi);
				 msg.setSubject(subject_to_be_given);
				 msg.setFrom(new InternetAddress(sender_email,"Unified Mail Support"));
				// msg.setFrom(new InternetAddress("mail@companyxyz.com", "Company XYZ"));
				 msg.addRecipient(Message.RecipientType.TO,new InternetAddress(reciever_id));
				// msg.setRecipient(Message.RecipientType.CC, new InternetAddress("nirbhaysingh1074@gmail.com"));
				 Transport.send(msg);
				 }
				 catch (Exception mex)
				 {
					 mex.printStackTrace();
				 } 

		}

	}
	class SMTPAuthenticator extends javax.mail.Authenticator
	{
		
		String sender_email = null;
				String sender_password =null;
				SMTPAuthenticator(String a,String b)
				{
					sender_email=a;
					sender_password=b;
				//sender_host = "smtp.gmail.com",
				//sender_port = "465",
				//ciever_id = "suryap085@gmail.com",
				//subject_to_be_given = "hiiiiiii",
				//message_mi = "Welcome to surya.";
		}
		public PasswordAuthentication getPasswordAuthentication()
		{
				return new PasswordAuthentication(sender_email, sender_password);
		}
	}

	
	
	
	
	
	

