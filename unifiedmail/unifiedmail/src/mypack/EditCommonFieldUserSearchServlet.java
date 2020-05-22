package mypack;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbutil.Crudoperation;

public class EditCommonFieldUserSearchServlet extends HttpServlet {

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
		String mls=request.getParameter("hid_mls");
		String acc_arr[]=request.getParameterValues("acc");
		String acc="disabled";
		if(acc_arr!=null && acc_arr.length>0)
			acc="active";
		else
			acc="disabled";
		
		String ftp_arr[]=request.getParameterValues("ftp");
		String ftp="disabled";
		if(ftp_arr!=null && ftp_arr.length>0)
			ftp="enabled";
		else
			ftp="disabled";
		
		String prelang=request.getParameter("prelang");
		String fpc=request.getParameter("fpc");
		String cprofile=request.getParameter("cprofile");
		String edt=request.getParameter("edt");
		
		
		String mail[] = mls.split(",");
		String dm="";
		try
		{
		String pwd=request.getParameter("np");
		String ps=request.getParameter("np");
		ps=ps.trim();
		if(ps!=null && !(ps.equals("")))
		{
		try
		{
		//pass=SHA256.encode(pass);
			pwd=Encryption.puttySSHA512(pwd);
		}
		catch (Exception e) {
			System.out.println(e);
		}
		}
		System.out.println("pas "+ps);
		HttpSession hs=request.getSession();
		   if (mail != null) 
		   {
		      for (int i = 0; i < mail.length; i++) 
		      {
		    	  String mlarrr[]=mail[i].split("@");
		    	  dm=mlarrr[1];
		    	  System.out.println("in loop= "+mail[i]);
		    	  try
		    	  {
		    	  if(ps!=null && !(ps.equals("")))
		  		{
		    		  System.out.println("hiiiiiiiiiiiii");
		    	  ModifyAtt.modyfyAtt(hs, mail[i], dm, "userPassword",pwd );
		  		}
		    	  
		    	  if(edt!=null && !(edt.equals("")))
				    {
				    String dateoj[]=edt.split("-");
				    String edt1=""+dateoj[0]+dateoj[1]+dateoj[2]+"0000Z";
				    ModifyAtt.modyfyAtt(hs, mail[i], dm, "expiredDate", edt1);
				    }
		    	  
		    	  
		    	  if(fpc!=null && !(fpc.equals("")) && !(fpc.equalsIgnoreCase("index")))
			  		{
			    		 // System.out.println("hiiiiiiiiiiiii");
			    	  ModifyAtt.modyfyAtt(hs, mail[i], dm, "forcePasswordChange",fpc );
			  		}
			  		
			  		 if(cprofile!=null && !(cprofile.equals("")) && !(cprofile.equalsIgnoreCase("index")))
				  		{
				    		 // System.out.println("hiiiiiiiiiiiii");
				    	  ModifyAtt.modyfyAtt(hs, mail[i], dm, "createprofile",cprofile );
				  		}
		    	  ModifyAtt.modyfyAtt(hs, mail[i], dm, "accountStatus", acc );
		    	  ModifyAtt.modyfyAtt(hs, mail[i], dm, "FTPStatus", ftp );
		    	  ModifyAtt.modyfyAtt(hs, mail[i], dm, "preferredLanguage", prelang);
		    	  
		    	  
		    	 /* try
		    	  {
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
		    	  String data=ip+","+adm+","+dm+",Edit User Profile -Common fields : "+mail;
		    	  int mg=Crudoperation.insertlog(sql, data);
		    	  }
		    	  catch(Exception e)
		    	  {
		    		  e.printStackTrace();
		    	  }
*/
		    	  }
		    	  catch(Exception e)
		    	  {
		    		  e.printStackTrace();
		    	  }
		      }
		   }
		   
		   response.sendRedirect("/unifiedmail/global/userslist.jsp?msg=Updated successfully&dm="+dm);
		   System.out.println("page last");
		   
		   
	}
	  catch(Exception e)
	  {
		  e.printStackTrace();
	  }
		   
		   
		//response.sendRedirect("/unifiedmail/global/userslist.jsp?msg=Updated successfully&dm="+dm);  
		   
		out.flush();
		out.close();
	}

}
