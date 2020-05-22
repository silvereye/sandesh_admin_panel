package mypack;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbutil.Crudoperation;
import dbutil.Crudoperation_Policy;

public class EditThrottlingDomainServlet extends HttpServlet {

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
		
		int outpid=Integer.parseInt( request.getParameter("hid_outpid"));
		int outqid=Integer.parseInt( request.getParameter("hid_outqid"));
		int outqidlmt=Integer.parseInt( request.getParameter("hid_outqidlmt"));
		
		String arr1[]=request.getParameterValues("out_acc");
		int out_dis=0;
		if(arr1!=null && arr1.length>0)
			 out_dis=0;
		else
			 out_dis=1;
		
		int out_max=Integer.parseInt( request.getParameter("out_max"));
		
		String arr2[]=request.getParameterValues("out_time");
		int out_time=0;
		if(arr2!=null && arr2.length>0)
			out_time=Integer.parseInt(arr2[0]);
		if(out_time==0)
			out_time=Integer.parseInt(request.getParameter("out_time_val"));
		out.print("<br> dn="+dn);
		out.print("<br> outpid="+outpid);
		out.print("<br> outqid="+outqid);
		out.print("<br> outqidlmt="+outqidlmt);
		out.print("<br> out_dis="+out_dis);
		out.print("<br> out_time="+out_time);
		out.print("<br> out_max="+out_max);
	
		
		String sql_p1="update policies set Disabled=? where id=?";	
		Crudoperation_Policy.updateData(sql_p1, out_dis, outpid);
		
		
		
		if(outqid==0)
		{
		String sql ="insert into quotas(PolicyID,Name,Track,Period,Verdict,Disabled) values(?,?,?,?,?,?)";	
		Connection con=Crudoperation_Policy.createPolicyConnection();
		try
		{
		PreparedStatement ps=con.prepareStatement(sql);
		ps.setInt(1, outpid);
		ps.setString(2, "Sender Quotas for "+dn);
		ps.setString(3, "Sender:@domain");
		ps.setInt(4,out_time);
		ps.setString(5, "REJECT");
		ps.setInt(6, out_dis);
		ps.executeUpdate();
		
		
		
		outqid=Crudoperation_Policy.getQtID(outpid,"Sender:@domain");
		
		sql="insert into quotas_limits(QuotasID,type,CounterLimit,Comment,Disabled) values(?,?,?,?,?)";
		ps=con.prepareStatement(sql);
		ps.setInt(1, outqid);
		ps.setString(2, "MessageCount");
		ps.setInt(3,out_max);
		ps.setString(4, "limit to send outgoing mail for "+dn);
		ps.setInt(5, out_dis);
		ps.executeUpdate();
		}
		catch (Exception e) {
			// TODO: handle exception
		}
		}
		else
		{
		String sql="update quotas set Period=?  where id=?";	
		Crudoperation_Policy.updateData(sql, out_time, outqid);
		
		
		sql="update quotas_limits set CounterLimit=? where id=?";	
		Crudoperation_Policy.updateData(sql, out_max, outqidlmt);
		
		}
		
		
		
		
		/********************* in coming ***************************/
		
		int inpid=Integer.parseInt( request.getParameter("hid_inpid"));
		int inqid=Integer.parseInt( request.getParameter("hid_inqid"));
		int inqidlmt=Integer.parseInt( request.getParameter("hid_inqidlmt"));
		
		String arr3[]=request.getParameterValues("in_acc");
		int in_dis=0;
		if(arr3!=null && arr3.length>0)
			 in_dis=0;
		else
			 in_dis=1;
		
		int in_max=Integer.parseInt( request.getParameter("in_max"));
		
		String arr4[]=request.getParameterValues("in_time");
		int in_time=0;
		if(arr4!=null && arr4.length>0)
			in_time=Integer.parseInt(arr4[0]);
		if(in_time==0)
			in_time=Integer.parseInt(request.getParameter("in_time_val"));
		
		out.print("<br> dn="+dn);
		out.print("<br> inpid="+inpid);
		out.print("<br> inqid="+inqid);
		out.print("<br> inqidlmt="+inqidlmt);
		out.print("<br> in_dis="+in_dis);
		out.print("<br> in_time="+in_time);
		out.print("<br> in_max="+in_max);
	
		
		String sql_p2="update policies set Disabled=? where id=?";	
		Crudoperation_Policy.updateData(sql_p2, in_dis, inpid);
		
		
		if(inqid==0)
		{
		String sql ="insert into quotas(PolicyID,Name,Track,Period,Verdict,Disabled) values(?,?,?,?,?,?)";	
		Connection con=Crudoperation_Policy.createPolicyConnection();
		try
		{
		PreparedStatement ps=con.prepareStatement(sql);
		ps.setInt(1, inpid);
		ps.setString(2, "Recipient Quotas for "+dn);
		ps.setString(3, "Recipient:@domain");
		ps.setInt(4,in_time);
		ps.setString(5, "REJECT");
		ps.setInt(6, in_dis);
		ps.executeUpdate();
		
		
		
		inqid=Crudoperation_Policy.getQtID(inpid,"Recipient:@domain");
		
		sql="insert into quotas_limits(QuotasID,type,CounterLimit,Comment,Disabled) values(?,?,?,?,?)";
		ps=con.prepareStatement(sql);
		ps.setInt(1, inqid);
		ps.setString(2, "MessageCount");
		ps.setInt(3,in_max);
		ps.setString(4, "limit to reciept incoming mail for "+dn);
		ps.setInt(5, in_dis);
		ps.executeUpdate();
		}
		catch (Exception e) {
			// TODO: handle exception
		}
		}
		else
		{
		String sql="update quotas set Period=? where id=?";	
		Crudoperation_Policy.updateData(sql, in_time, inqid);
		
		
		sql="update quotas_limits set CounterLimit=? where id=?";	
		Crudoperation_Policy.updateData(sql, in_max, inqidlmt);
		
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
			adm="mail-admin@"+dn;
		}
		String sql="insert into log (ip,name,domain,msg) values(?,?,?,?)";
		String data=ip+","+adm+","+dn+",Edit Domain Profile -Throttling: "+dn;
		int mg=Crudoperation.insertlog(sql, data);
		
		
		
		
		 response.sendRedirect("/unifiedmail/global/throttlingdomain.jsp?dn="+dn+"&status=succ");
		out.flush();
		out.close();
	}

}
