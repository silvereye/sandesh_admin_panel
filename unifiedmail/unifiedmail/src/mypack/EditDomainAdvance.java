package mypack;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbutil.Crudoperation;

public class EditDomainAdvance extends HttpServlet {

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
		String dn=request.getParameter("hid_dn");
		String minp=request.getParameter("minp");
		String maxp=request.getParameter("maxp");
		String dqt=request.getParameter("dqt");
		String ftp=request.getParameter("ftp");
		String plang=request.getParameter("plang");
		//String basedir=request.getParameter("dir");
		
		
		//ModifyDomainAtt.modyfyAtt(hs, dn, "domainBaseStorage", basedir);
		
			if(utype!=null && utype.equalsIgnoreCase("Admin"))
			 {
				String ftpdom=request.getParameter("ftpdom");
				String mqt=request.getParameter("mqt");
				String musr=request.getParameter("musr");
				String mlist=request.getParameter("mlist");
				String malias=request.getParameter("malias");
				long qt=(Long.parseLong(mqt))*1024;
		ModifyDomainAtt.modyfyAtt(hs, dn, "domainMaxAliasNumber", malias );
		ModifyDomainAtt.modyfyAtt(hs, dn, "domainMaxListNumber", mlist);
		ModifyDomainAtt.modyfyAtt(hs, dn, "domainMaxUserNumber", musr);
		ModifyDomainAtt.modyfyAtt(hs, dn, "domainMaxQuotaSize", ""+qt );
		if(ftpdom!=null && ftpdom.equalsIgnoreCase("TRUE"))
        {
			ModifyDomainAtt.modyfyAtt(hs, dn,  "domainFTPStatus", "TRUE" );
        }
		else
		{
			ModifyDomainAtt.modyfyAtt(hs, dn,  "domainFTPStatus", "FALSE" );
		}
			 }
		
		ModifyDomainAtt.modyfyAtt(hs, dn, "domainDefaultUserQuota",dqt );
		ModifyDomainAtt.modyfyAtt(hs, dn, "domainDefaultFtpQuota",ftp );
		//ModifyDomainAtt.modyfyAtt(hs, dn, "accountSetting","minPasswordLength:"+minp.trim() );
	//	ModifyDomainAddAtt.modyfyAddAtt(hs, dn, "accountSetting","maxPasswordLength:"+maxp.trim() );
		ModifyDomainAtt.modyfyAtt(hs, dn, "preferredLanguage", plang);
		
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
		String data=ip+","+adm+","+dn+",Edit Domain Profile -Advance : "+dn;
		int mg=Crudoperation.insertlog(sql, data);
		
		
		 response.sendRedirect("/unifiedmail/global/advancedomain.jsp?dn="+dn+"&status=succ");
		out.flush();
		out.close();
	}

}
