package mypack;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbutil.Crudoperation;

public class EditCatchAllDomainServlet extends HttpServlet {

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
		String dn=request.getParameter("hid_dn");
		//ModifyAtt.modyfyAtt(hs, "@"+dn,dn, "disclaimer", dis);
		String acc[] = request.getParameterValues("acc");
		   if (acc != null && acc.length>0) 
		   {
			   ModifyAtt.modyfyAtt(hs, "@"+dn,dn, "accountStatus", "active");
		   }
		   else
		   {
			   ModifyAtt.modyfyAtt(hs, "@"+dn,dn, "accountStatus", "disabled");
			   
		   }
		String no=request.getParameter("hid_cadd");
		for(int i=1,j=0;i<=Integer.parseInt(no);i++)
		{
		String fd=request.getParameter("cadd"+i);
		if(fd.equals("") || fd==null)
		{
			continue;
		}
		j++;
		if(j==1)
		{
			ModifyAtt.modyfyAtt(hs, "@"+dn,dn, "mailForwardingAddress", fd);	
		}
		else
		{
			ModifyAddAtt.modyfyAddAtt(hs, "@"+dn,dn, "mailForwardingAddress", fd);	
		}
		}
		
		
		String ip= (String)hs.getAttribute("ip");
		String utype= (String)hs.getAttribute("user_name");
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
		String data=ip+","+adm+","+dn+",Edit Domain Profile -CatchAll : "+dn;
		int mg=Crudoperation.insertlog(sql, data);
		
		
		   response.sendRedirect("/unifiedmail/global/catchalldomain.jsp?dn="+dn+"&status=succ");
		out.flush();
		out.close();
	}

}
