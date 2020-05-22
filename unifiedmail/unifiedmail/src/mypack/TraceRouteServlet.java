package mypack;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class TraceRouteServlet extends HttpServlet {

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
		String ip=request.getParameter("ip");
		String hops=request.getParameter("cnt");
		//String icmp=request.getParameter("icmp");
		//out.println("ip="+ip+"     hops="+hops);
		Process p=null;
		
	/*	if(icmp.equalsIgnoreCase("yes"))
		{
			p = Runtime.getRuntime().exec("traceroute -I -n -m "+hops+" "+ip); 	
		}
		else if(icmp.equalsIgnoreCase("no"))
		{
		*/
			p = Runtime.getRuntime().exec("traceroute -n -m "+hops+" "+ip); 
	//	}
		

		
		BufferedReader stdInput = new BufferedReader(new InputStreamReader(p.getInputStream()));
		
		String s="";
	out.print("<table>");
		while ((s = stdInput.readLine()) != null) 
		{
			out.print("<tr><td>"+s+"</td></tr>");	
			
		}
		out.print("</table>");
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
