package mypack;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SupportServlet extends HttpServlet {

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out
				.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<HTML>");
		out.println("  <HEAD><TITLE>A Servlet</TITLE></HEAD>");
		out.println("  <BODY>");
		out.print("    This is ");
		out.print(this.getClass());
		out.println(", using the GET method");
		out.println("  </BODY>");
		out.println("</HTML>");
		out.flush();
		out.close();
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		String name=request.getParameter("nm");
		String cno=request.getParameter("cno");
		String issue=request.getParameter("issue");
		String compname=request.getParameter("compname");
		String desc=request.getParameter("desc");
		String pri=request.getParameter("pri");
		HttpSession hs=request.getSession(false);
	    String base= (String)hs.getAttribute("base");
	    String utype=(String)hs.getAttribute("user_name");
	    String username= (String)hs.getAttribute("id");
	    String adm_id= (String)hs.getAttribute("adm_id");
	  /*
	    if(utype.equalsIgnoreCase("Admin"))
        {
	    	
	    	
		       	String mesg="Name-("+name+")<br>";
		       	mesg=mesg+"Contact No-("+cno+")<br>";
		       	mesg=mesg+"Company Name-("+compname+")<br>";
		       	mesg=mesg+"Priority-("+pri+")<br><br>";
		       	mesg=mesg+"<b>Description:</b><br>"+desc;	       
		       
				String  reciever_id = "support@silvereye.co";
				String subject_to_be_given = issue;
				String message_mi = mesg;
				try
				{
	    	NewMail.send(reciever_id, subject_to_be_given, mesg);
				}
				catch (Exception e) {
					// TODO: handle exception
				}
	    	
        }
	    else  if(utype.equalsIgnoreCase("LocalAdmin"))
        {
        */
	    	String sender="postmaster@";
		       String arr=base.replace("dc=","");
		       arr=arr.replace(",", ".");
		      // out.print("sender="+sender+base);
		       sender=sender+arr;
		       
		       	String mesg="Name-("+name+")<br>";
		       	mesg=mesg+"Contact No-("+cno+")<br>";
		       	mesg=mesg+"Company Name-("+compname+")<br>";
		       	mesg=mesg+"Priority-("+pri+")<br><br>";
		       	mesg=mesg+"<b>Description:</b><br>"+desc;	       
		       	String sender_email = sender,
				sender_host = "127.0.0.1",
				sender_port = "25",
				reciever_id = "support@silvereye.co",
				subject_to_be_given = issue,
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
					 msg.setFrom(new InternetAddress(sender_email,"Unified Mail Support"));
					 msg.addRecipient(Message.RecipientType.TO,new InternetAddress(reciever_id));
					 Transport.send(msg);
					 }
					 catch (Exception mex)
					 {
						 mex.printStackTrace();
					 } 
	    	
					 response.sendRedirect("/unifiedmail/diagnostics/support.jsp?status=succ");
	    	
        //}
	    
	    	
		out.flush();
		out.close();
	}

}
