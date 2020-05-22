package mypack;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbutil.Crudoperation;

public class AdvanceUserServlet extends HttpServlet {

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
		HttpSession hs=request.getSession();
		String utype=(String)hs.getAttribute("user_name");
		String mail=request.getParameter("hid_mail");
		String arr1[]=request.getParameterValues("acc");
		String frd="";
		if(arr1!=null && arr1.length>0)
			frd="yes";
		else
			frd="no";
		String dn=request.getParameter("hid_dn");
		if(utype!=null && utype.equalsIgnoreCase("Admin"))
		{
			String ftpub=request.getParameter("ftpub");
			String ftpdb=request.getParameter("ftpdb");
			String ftpur=request.getParameter("ftpur");
			String ftpdr=request.getParameter("ftpdr");
			
			if(ftpub.equalsIgnoreCase("") || ftpub==null)
			{
			ModifyRemAtt.modyfyRemAtt(hs, dn, mail, "FTPUploadBandwidth")	;		
			}
			else
			{
				ModifyAtt.modyfyAtt(hs, mail, dn, "FTPUploadBandwidth", ftpub);	
			}
			
			
			if(ftpdb.equalsIgnoreCase("") || ftpdb==null)
			{
			ModifyRemAtt.modyfyRemAtt(hs, dn, mail, "FTPDownloadBandwidth")	;		
			}
			else
			{
				ModifyAtt.modyfyAtt(hs, mail, dn, "FTPDownloadBandwidth", ftpdb);	
			}
			
			if(ftpur.equalsIgnoreCase("") || ftpur==null)
			{
			ModifyRemAtt.modyfyRemAtt(hs, dn, mail, "FTPUploadRatio")	;		
			}
			else
			{
				ModifyAtt.modyfyAtt(hs, mail, dn, "FTPUploadRatio", ftpur);	
			}
			
			
			if(ftpdr.equalsIgnoreCase("") || ftpdr==null)
			{
			ModifyRemAtt.modyfyRemAtt(hs, dn, mail, "FTPDownloadRatio")	;		
			}
			else
			{
				ModifyAtt.modyfyAtt(hs, mail, dn, "FTPDownloadRatio", ftpdr);	
			}
			
			
		}
		
		String serv=request.getParameter("hid_serv");
		String senbcc=request.getParameter("senbcc");
		String recbcc=request.getParameter("recbcc");
		//String mta=request.getParameter("mta");
		String qftp=request.getParameter("qftp");
		System.out.println("qftp="+qftp);
		/*
		if(qftp.equalsIgnoreCase("") || qftp==null)
		{
		ModifyRemAtt.modyfyRemAtt(hs, dn, mail, "FTPQuotaMBytes")	;		
		}
		else
		{
			ModifyAtt.modyfyAtt(hs, mail, dn, "FTPQuotaMBytes", qftp);	
		}
		
		*/
		
		if(frd.equalsIgnoreCase("no") && serv.indexOf("shadowaddress")<0)
		{
			
		}
		else if(serv.indexOf("shadowaddress")<0)
		{
			ModifyAtt.modyfyAtt(hs, mail, dn, "enabledService", "shadowaddress");		
			String ser_arr[]=serv.split(",");
			for(int i=0;i<ser_arr.length;i++)
			{
				ModifyAddAtt.modyfyAddAtt(hs, mail, dn, "enabledService", ser_arr[i]);
			}
		}
		else if(frd.equalsIgnoreCase("no"))
		{
			String ser_arr[]=serv.split(",");
			for(int i=0,j=0;i<ser_arr.length;i++)
			{
				if(ser_arr[i].equalsIgnoreCase("shadowaddress"))
				{
					continue;
				}
				j++;
				if(j==1)
				{
					ModifyAtt.modyfyAtt(hs, mail, dn, "enabledService",ser_arr[i]);
				}
				else
				{
				ModifyAddAtt.modyfyAddAtt(hs, mail, dn, "enabledService", ser_arr[i]);
				}
			}

		}
		else
		{
			
		}
		
		
		
		
		if(recbcc.equalsIgnoreCase("") || recbcc==null)
		{
		ModifyRemAtt.modyfyRemAtt(hs, dn, mail, "userRecipientBccAddress")	;		
		}
		else
		{
			ModifyAtt.modyfyAtt(hs, mail, dn, "userRecipientBccAddress", recbcc);	
		}
		
		
		if(senbcc.equalsIgnoreCase("") || senbcc==null)
		{
		ModifyRemAtt.modyfyRemAtt(hs, dn, mail, "userSenderBccAddress")	;		
		}
		else
		{
			ModifyAtt.modyfyAtt(hs, mail, dn, "userSenderBccAddress", senbcc);	
		}
		
		
		
		
		
		
		String relay=request.getParameter("relay");
		if(relay.equalsIgnoreCase("") || relay==null)
		{
			ModifyRemAtt.modyfyRemAtt(hs, dn, mail, "mtaTransport");
		}
		else
		{
		if(relay.equalsIgnoreCase("other"))
		{
			relay="smtp:["+request.getParameter("otr")+"]:25";
		}
		if(relay.equalsIgnoreCase("lmtp:127.0.0.1:7025"))
		{
			ModifyRemAtt.modyfyRemAtt(hs, dn, mail, "mtaTransport");
		}
		else
		{
			ModifyAtt.modyfyAtt(hs, mail, dn, "mtaTransport", relay);
		}
		}
		/*
		if(mta.equalsIgnoreCase("") || mta==null)
		{
		ModifyRemAtt.modyfyRemAtt(hs, dn, mail, "mtaTransport")	;		
		}
		else
		{
			ModifyAtt.modyfyAtt(hs, mail, dn, "mtaTransport", mta);	
		}
		*/
		
		
		


		String ip= (String)hs.getAttribute("ip");
		//String utype= (String)hs.getAttribute("user_name");
		String adm="";
		if(utype.equals("Admin"))
		{
			adm="Global Admin";
		}
		else
		{
			adm="mail-admin@"+dn;
		}
		String sql="insert into log (ip,name,domain,msg) values(?,?,?,?)";
		String data=ip+","+adm+","+dn+",Edit User Profile -Aliases : "+mail;
		int mg=Crudoperation.insertlog(sql, data);

		
		response.sendRedirect("/unifiedmail/global/advanceuser.jsp?ml="+mail+"&status=succ");
		out.flush();
		out.close();
	}

}
