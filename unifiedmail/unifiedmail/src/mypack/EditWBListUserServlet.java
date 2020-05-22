package mypack;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbutil.Crudoperation;

public class EditWBListUserServlet extends HttpServlet {

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
		String ml=request.getParameter("hid_mail");
		String arr1[]=request.getParameterValues("ws_mail");
		String arr2[]=request.getParameterValues("bs_mail");
		String arr3[]=request.getParameterValues("wr_mail");
		String arr4[]=request.getParameterValues("br_mail");
		HttpSession hs=request.getSession();
		 String username= (String)hs.getAttribute("id");
	        String password= (String)hs.getAttribute("password");
	        String url= (String)hs.getAttribute("url");
	        String mbase= (String)hs.getAttribute("base");
		
		
	        
	        
	        
	        if(arr1!=null)
			{
			for(int i=0,f=0;i<arr1.length; i++)
			{
				System.out.println("<br>arr="+arr1[i]);
				
				if(arr1[i]!=null && !(arr1[i].equals("")))
				{
					f++;
					if(f==1)
					{
					ModifyAtt.modyfyAtt(hs, ml, dn, "amavisWhitelistSender", arr1[i]);
					}
					else
					{
					ModifyAddAtt.modyfyAddAtt(hs, ml, dn, "amavisWhitelistSender", arr1[i]);
					}
					
				}
			}
			}
	        else
			{
				ModifyRemAtt.modyfyRemAtt(hs,  dn,ml, "amavisWhitelistSender");
			}
	        
	        
	        
	        
	        
		if(arr2!=null)
		{
		for(int i=0,f=0;i<arr2.length; i++)
		{
			System.out.println("<br>arr="+arr2[i]);
			
			if(arr2[i]!=null && !(arr2[i].equals("")))
			{
				f++;
				if(f==1)
				{
				ModifyAtt.modyfyAtt(hs, ml, dn, "amavisBlacklistSender", arr2[i])	;
				}
				else
				{
				ModifyAddAtt.modyfyAddAtt(hs, ml, dn, "amavisBlacklistSender", arr2[i]);
				}
				
			}
		}
		}
		else
		{
			ModifyRemAtt.modyfyRemAtt(hs,  dn,ml, "amavisBlacklistSender");
		}
		
		
		
		
		
		
		

        
        if(arr3!=null)
		{
		for(int i=0,f=0;i<arr3.length; i++)
		{
			System.out.println("<br>arr="+arr3[i]);
			
			if(arr3[i]!=null && !(arr3[i].equals("")))
			{
				f++;
				if(f==1)
				{
				ModifyAtt.modyfyAtt(hs, ml, dn, "mailWhitelistRecipient", arr3[i]);
				}
				else
				{
				ModifyAddAtt.modyfyAddAtt(hs, ml, dn, "mailWhitelistRecipient", arr3[i]);
				}
				
			}
		}
		}
        else
		{
			ModifyRemAtt.modyfyRemAtt(hs,  dn,ml, "mailWhitelistRecipient");
		}
        
		
		
		
		
		
        
        if(arr4!=null)
		{
		for(int i=0,f=0;i<arr4.length; i++)
		{
			System.out.println("<br>arr="+arr4[i]);
			
			if(arr4[i]!=null && !(arr4[i].equals("")))
			{
				f++;
				if(f==1)
				{
				ModifyAtt.modyfyAtt(hs, ml, dn, "mailBlacklistRecipient", arr4[i])	;
				}
				else
				{
				ModifyAddAtt.modyfyAddAtt(hs, ml, dn, "mailBlacklistRecipient", arr4[i]);
				}
				
			}
		}
		}
		else
		{
			ModifyRemAtt.modyfyRemAtt(hs,  dn,ml, "mailBlacklistRecipient");
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
		String data=ip+","+adm+","+dn+",Edit User Profile -Whitelist Blacklist : "+ml;
		int mg=Crudoperation.insertlog(sql, data);
		
		
		 response.sendRedirect("/unifiedmail/global/whiteblistuser.jsp?ml="+ml+"&status=succ");
		out.flush();
		out.close();
	}

}
