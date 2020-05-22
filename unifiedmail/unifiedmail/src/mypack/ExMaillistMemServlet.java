package mypack;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbutil.Crudoperation;

public class ExMaillistMemServlet extends HttpServlet {

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
		String ml=request.getParameter("hid_exmaillist");
		String dn="";
		  if( ml!=null && !(ml.equals("")) )
		   {
		   				String arr[]=ml.split("@");
		   				dn=arr[1];
		   }
		                HttpSession hs=request.getSession(false);
				        String username= (String)hs.getAttribute("id");
				        String password= (String)hs.getAttribute("password");
				        String url= (String)hs.getAttribute("url");
				        String mbase= (String)hs.getAttribute("base");
				       

		String mail[] = request.getParameterValues("ex_mail");
		String cr_ml="";
		   if (mail != null) 
		   {
		      for (int i = 0; i < mail.length; i++) 
		      {
		    	  cr_ml=cr_ml+","+mail[i]; 
		      }
		   }
		   
		   
		String ex_mail=GetExternalList.getExternalList(url,username,password,mbase,dn,"memberOfGroup",ml) ;
       	String ex_arr[]=ex_mail.split(",");
       	System.out.println("ex="+ex_mail);
       	int f=0;
       	for(int i=0;i<ex_arr.length;i++)
       	{
       	if(ex_arr[i]!= null && !(ex_arr[i].equals("")))
       	{
       		if(cr_ml.indexOf(ex_arr[i])>=0)
       		{
       			continue;
       		}
       		else
       		{
       			f++;
       			if(f==1)
       			{
       			ModifyAtt.modyfyAtt(hs, "memberOfGroup", ml, dn, "Externals", "mail", ex_arr[i])	;
       			}
       			else
       			{
       			ModifyAddAtt.modyfyAddAtt(hs, "memberOfGroup", ml, dn, "Externals", "mail", ex_arr[i]);	
       			}
       		}
       		
       		
       	}
       	}
       	if(f==0)
       	{
       		ModifyRemAtt.modyfyRemAtt(hs, dn, "Externals", "memberOfGroup", ml, "mail");
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
	       String data=ip+","+adm+","+dn+",Edit List Profile -Externals Members : "+ml;
	       int mg=Crudoperation.insertlog(sql, data);
		
       
       	response.sendRedirect("/unifiedmail/global/maillistmembers.jsp?ml="+ml+"&status=succ");
		out.flush();
		out.close();
	}

}
