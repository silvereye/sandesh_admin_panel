package mypack;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbutil.Crudoperation;

public class AddMailListModeratorsServlet extends HttpServlet {

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
		
		String dn=request.getParameter("hid_dn");
		String ml=request.getParameter("hid_ml");
		String arr1[]=request.getParameterValues("loc_mail");
		String arr2[]=request.getParameterValues("ex_mail");
		HttpSession hs=request.getSession();
		 String username= (String)hs.getAttribute("id");
	        String password= (String)hs.getAttribute("password");
	        String url= (String)hs.getAttribute("url");
	        String mbase= (String)hs.getAttribute("base");
	    
		System.out.println("dn="+dn+"     mail="+ml);
		int flg=0;
		if(arr1!=null)
		{
		for(int i=0;i<arr1.length; i++)
		{
			System.out.println("<br>arr="+arr1[i]);
			
			if(arr1[i]!=null && !(arr1[i].equals("")))
			{
				if(flg==0)
				{
					ModifyAtt.modyfyAtt(hs, ml, dn, "Groups", "listAllowedUser", arr1[i]);
					flg=1;
				}
				else
				{
					ModifyAddAtt.modyfyAddAtt(hs, ml, dn, "Groups", "listAllowedUser", arr1[i]);
				}
				
			}
		}
		}
		else
		{
			ModifyRemAtt.modyfyRemAtt(hs, dn, "Groups", ml, "listAllowedUser");
		}
		
		
		
		
		if(arr2!=null)
		{
		for(int i=0,f=0;i<arr2.length; i++)
		{
			System.out.println("<br>arr="+arr2[i]);
			
			if(arr2[i]!=null && !(arr2[i].equals("")))
			{
				if(flg==0)
				{
					ModifyAtt.modyfyAtt(hs, ml, dn, "Groups", "listAllowedUser", arr2[i]);
					flg=1;
				}
				else
				{
					ModifyAddAtt.modyfyAddAtt(hs, ml, dn, "Groups", "listAllowedUser", arr2[i]);
				}
				
				
			}
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
	       String data=ip+","+adm+","+dn+",Edit List Profile -Moderators : "+ml;
	       int mg=Crudoperation.insertlog(sql, data);
		
		 response.sendRedirect("/unifiedmail/global/addmaillistmoderators.jsp?ml="+ml+"&status=succ");
		
		
		out.flush();
		out.close();
	}

}
