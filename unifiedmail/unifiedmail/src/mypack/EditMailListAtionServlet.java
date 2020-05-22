package mypack;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbutil.Crudoperation;

public class EditMailListAtionServlet extends HttpServlet {

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
		String action=request.getParameter("action");
		String dm="";
		String mail[] = request.getParameterValues("CheckboxGroup1");
		   if (mail != null) 
		   {
		      for (int i = 0; i < mail.length; i++) 
		      {
		    	  HttpSession hs=request.getSession();
		    	 String dn[]=mail[i].split("@");
		    	 dm=dn[1];
		    	  ModifyAtt.modyfyAtt(hs, mail[i], dm, "Groups", "accountStatus", action);
		    	  
		    	  
		    	  
		    	  
		    	  String ip= (String)hs.getAttribute("ip");
			       String utype= (String)hs.getAttribute("user_name");
			       String adm="";
			       if(utype.equals("Admin"))
			       {
			       	adm="Global Admin";
			       }
			       else
			       {
			       	adm="mail-admin@"+dm;
			       }
			       String sql="insert into log (ip,name,domain,msg) values(?,?,?,?)";
			       String data=ip+","+adm+","+dm+",Edit List Profile : "+mail[i];
			       int mg=Crudoperation.insertlog(sql, data);
		    	  
		      }
		   }
		   
		   
		 
		   if(action.equalsIgnoreCase("active"))
		   {
			   response.sendRedirect("/unifiedmail/global/maillistslist.jsp?msg=Enabled&dm="+dm);
		   }
		   else if(action.equalsIgnoreCase("disabled"))
		   {
			   response.sendRedirect("/unifiedmail/global/maillistslist.jsp?msg=Disabled&dm="+dm);
		   }
		   else
		   {
			   response.sendRedirect("/unifiedmail/global/maillistslist.jsp?dm="+dm);
		   }
		
		out.flush();
		out.close();
	}

}
