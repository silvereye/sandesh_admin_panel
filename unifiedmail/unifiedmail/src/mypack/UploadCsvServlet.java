package mypack;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

public class UploadCsvServlet extends HttpServlet {

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
		try
		{

		String fname=null;
		String mptoken=null;
		File fobj=null;
		int an=0;
	    String path=getServletContext().getRealPath("/");       //path of the folder where ur folder will be create
		
		String ui= "CsvFile";    //accessing userid from the session....otherwise u can store an appropriate name in ui variable  
		System.out.println(ui);
		String nwpath=path+ui;
		System.out.println(nwpath);
	
		File f=new File(nwpath);
		if(!f.exists())
		{
			f.mkdir();        //if folder is not exist then it will create folder name as user id this folder will store the image
		}
		MultipartRequest mpt=new MultipartRequest(request,nwpath,1024*1024*1000);
		Enumeration e=mpt.getFileNames();
		while(e.hasMoreElements())
		{
			mptoken=(String)e.nextElement();
			fobj=mpt.getFile(mptoken);
			fname=fobj.getName();                   //this variable will store name of the image
			System.out.println("filename is"+fname);
			System.out.println("hiii");
			
			
				}	
		String dm=mpt.getParameter("domain");
		
		
		
		
			
			
			System.out.print("\npath----"+nwpath+"/"+fname);
			response.sendRedirect("/unifiedmail/global/bulkuseruploadshow.jsp?file="+fname+"&dm="+dm);
	
		}
		catch (java.lang.IllegalStateException se) {
			System.out.println(se);
			response.sendRedirect("/unifiedmail/global/bulkuserupload.jsp");
			// TODO: handle exception
		}
	
		
		out.flush();
		out.close();
	}

}
