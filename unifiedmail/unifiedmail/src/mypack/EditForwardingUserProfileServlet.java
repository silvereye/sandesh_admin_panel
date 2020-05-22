package mypack;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbutil.Crudoperation;

public class EditForwardingUserProfileServlet extends HttpServlet {

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
		String mail=request.getParameter("hid_mail");
		String arr2[]=request.getParameterValues("inbox");
		String arr1[]=request.getParameterValues("acc");
		String frd="";
		if(arr1!=null && arr1.length>0)
			frd="yes";
		else
			frd="no";
		String dn=request.getParameter("hid_dn");
		
		String serv=request.getParameter("hid_serv");

		
		String no=request.getParameter("hid_cadd");
		int fj=0;
		for(int i=1;i<=Integer.parseInt(no);i++)
		{
		String fd=request.getParameter("cadd"+i);
		if(fd.equals("") || fd==null)
		{
			continue;
		}
		fj++;
		if(fj==1)
		{
			ModifyAtt.modyfyAtt(hs, mail,dn, "mailForwardingAddress", fd);	
		}
		else
		{
			ModifyAddAtt.modyfyAddAtt(hs, mail,dn, "mailForwardingAddress", fd);	
		}
		}
		if(fj==0)
		{
		ModifyRemAtt.modyfyRemAtt(hs, dn, mail, "mailForwardingAddress");
		}
		
		
		
		
		if(arr2!=null && arr2.length>0)
		{
			ModifyAddAtt.modyfyAddAtt(hs, mail,dn, "mailForwardingAddress", mail);	
		}
		
		
		
		
		if(frd.equalsIgnoreCase("no") && serv.indexOf("forward")<0)
		{
			
		}
		else if(serv.indexOf("forward")<0)
		{
			ModifyAtt.modyfyAtt(hs, mail, dn, "enabledService", "forward");		
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
				if(ser_arr[i].equalsIgnoreCase("forward"))
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
		String data=ip+","+adm+","+dn+",Edit User Profile -Mail forwarding : "+mail;
		int mg=Crudoperation.insertlog(sql, data);

		
		response.sendRedirect("/unifiedmail/global/forwardinguser.jsp?ml="+mail+"&status=succ");

		out.flush();
		out.close();
	}

}
