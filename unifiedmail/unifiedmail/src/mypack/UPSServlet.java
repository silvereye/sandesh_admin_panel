package mypack;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UPSServlet extends HttpServlet {

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
		String data="";
		if(true)
		{
		Process p = Runtime.getRuntime().exec("sudo mpstat");  	
		BufferedReader stdInput = new BufferedReader(new InputStreamReader(p.getInputStream()));
		String s="";
		while ((s = stdInput.readLine()) != null) 
		{
		    //  out.println("<br>"+s);
		   if(s.indexOf("all")>=0)
		       {
		       break;
		       }		        
		}
  s=s.trim();
  String arr[]=s.split(" ");
  String cpu=arr[arr.length-1];
  data=cpu;
		}
		
		
		if(true)
		{
			
			 Process	p = Runtime.getRuntime().exec("cat /proc/meminfo"); 	
				BufferedReader stdInput = new BufferedReader(new InputStreamReader(p.getInputStream()));
				//String s="User quota STORAGE 0 4194304 0";
				String s="";
			String tmem="";
			String fmem="";
			
				while ((s = stdInput.readLine()) != null) 
				{
				//out.print("<br>"+s);
				if(s.indexOf("MemTotal")>-1)
				{
				String arr[]=s.split(":");
				arr[1]=arr[1].trim();
				String arr1[]=arr[1].split(" ");
				tmem=arr1[0].trim();
				}
				if(s.indexOf("MemFree")>-1)
				{
				String arr[]=s.split(":");
				arr[1]=arr[1].trim();
				String arr1[]=arr[1].split(" ");
				fmem=arr1[0].trim();
				}
				
				}
			int t=Integer.parseInt(tmem);
			int f=Integer.parseInt(fmem);	
			int u=t-f;
			
			double per=(u*100.0)/t;
			data=data+"-"+per;
		}
		
		
		if(true)
		{
			
			 Process	p = Runtime.getRuntime().exec("cat /proc/meminfo"); 	
				BufferedReader stdInput = new BufferedReader(new InputStreamReader(p.getInputStream()));
				//String s="User quota STORAGE 0 4194304 0";
				String s="";
			String tswp="";
			String fswp="";
				while ((s = stdInput.readLine()) != null) 
				{
				//out.print("<br>"+s);
				if(s.indexOf("SwapTotal")>-1)
				{
				String arr[]=s.split(":");
				arr[1]=arr[1].trim();
				String arr1[]=arr[1].split(" ");
				tswp=arr1[0].trim();
				}
				if(s.indexOf("SwapFree")>-1)
				{
				String arr[]=s.split(":");
				arr[1]=arr[1].trim();
				String arr1[]=arr[1].split(" ");
				fswp=arr1[0].trim();
				}
				
				}
			int t=Integer.parseInt(tswp);
			int f=Integer.parseInt(fswp);	
			int u=t-f;
			double per=(u*100.0)/t;
			data=data+"-"+per;
		}
		out.print(data);
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
		out
				.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<HTML>");
		out.println("  <HEAD><TITLE>A Servlet</TITLE></HEAD>");
		out.println("  <BODY>");
		out.print("    This is ");
		out.print(this.getClass());
		out.println(", using the POST method");
		out.println("  </BODY>");
		out.println("</HTML>");
		out.flush();
		out.close();
	}

}
