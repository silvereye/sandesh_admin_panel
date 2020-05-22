package mypack;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbutil.Crudoperation;

public class UploadDesclaimerServlet extends HttpServlet {

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
		String dm=request.getParameter("hid_dn");
		String con_h=request.getParameter("dis_h");
		String con_t=request.getParameter("dis_t");
		con_t=con_t;
		//String path="";
		
		
		    
		 File  file = new File("/maildir/domains/disclaimer/"+dm+".html");
		    if (!file.exists()) {
		    boolean successful=    file.createNewFile();
		  
		    if (successful)
		    {
		      // creating the directory succeeded
		      out.println("directory was created successfully");
		    }
		    else
		    {
		      // creating the directory failed
		    out.println("failed trying to create the directory");
		    }
		    }
		    
		    try
			{
			FileWriter fstream = new FileWriter("/maildir/domains/disclaimer/"+dm+".html");
		    BufferedWriter out1 = new BufferedWriter(fstream);
		    out1.write(con_h);
		    out1.close();
		      }catch (Exception e){//Catch exception if any
		  System.err.println("Error: " + e.getMessage());
		   }
		      
		      
		      
		      File  file1 = new File("/maildir/domains/disclaimer/"+dm+".txt");
			    if (!file1.exists()) {
			    boolean successful=    file1.createNewFile();
			  
			    if (successful)
			    {
			      // creating the directory succeeded
			      out.println("directory was created successfully");
			    }
			    else
			    {
			      // creating the directory failed
			    out.println("failed trying to create the directory");
			    }
			    }
			    
			    try
				{
				FileWriter fstream = new FileWriter("/maildir/domains/disclaimer/"+dm+".txt");
			    BufferedWriter out1 = new BufferedWriter(fstream);
			    out1.write("\n");
			    out1.write(con_t);
			    out1.write("\n");
			    out1.close();
			      }catch (Exception e){//Catch exception if any
			  System.err.println("Error: " + e.getMessage());
			   }  
			      
			      
			      HttpSession hs=request.getSession();
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
					String data=ip+","+adm+","+dm+",Edit Domain Profile - Disclaimer: "+dm;
					int mg=Crudoperation.insertlog(sql, data);
			      
			      
			      
			      response.sendRedirect("/unifiedmail/global/disclaimerdomain.jsp?dn="+dm+"&status=succ");
		out.flush();
		out.close();
	}

}
