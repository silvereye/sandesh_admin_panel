package mypack;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbutil.Crudoperation;

public class AddMailListMembersServlet extends HttpServlet {

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
		String nwml="";
		if(arr1!=null)
		{
		for(int i=0;i<arr1.length; i++)
		{
			System.out.println("<br>arr="+arr1[i]);
			nwml=nwml+","+arr1[i];
			if(arr1[i]!=null && !(arr1[i].equals("")))
			{
				ModifyAddAtt.modyfyAddAtt(hs, arr1[i], dn, "memberOfGroup", ml);
			}
		}
		}
		
		ModifyListMember.modyfyAddMemInList(hs, dn, nwml, ml);
		
		String old_lst=request.getParameter("hid_old_list");
		System.out.println("<br>new="+nwml);
		System.out.println("<br>old="+old_lst);
		String oldarr[]=old_lst.split(",");
		for(int i=1;i< oldarr.length;i++)
		{
			if(nwml.indexOf(oldarr[i])<0)
			{
				System.out.print("<br>delete mail="+oldarr[i]);
				String chk=GetUsersList.getUsersListMem(url,username,password,mbase,dn,"mail",oldarr[i],ml);
				System.out.print("<br>delete all list ="+chk);
				String delarr[]=chk.split(",");
				int f=0;
				for(int j=1;j<delarr.length ;j++)
				{
				if(ml.equalsIgnoreCase(delarr[j]))
					{
					continue;
					}
				f++;
				if(f==1)
					{
					ModifyAtt.modyfyAtt(hs, oldarr[i], dn, "memberOfGroup", delarr[j]);
					}
				else
				{
					ModifyAddAtt.modyfyAddAtt(hs, oldarr[i], dn, "memberOfGroup", delarr[j]);
				}
					
				}
				if(f==0)
				{
					ModifyRemAtt.modyfyRemAtt(hs, dn, oldarr[i], "memberOfGroup");
				}
			}
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
				ModifyAtt.modyfyAtt(hs, "memberOfGroup", ml, dn, "Externals", "mail", arr2[i])	;
				}
				else
				{
				ModifyAddAtt.modyfyAddAtt(hs, "memberOfGroup", ml, dn, "Externals", "mail", arr2[i]);
				}
				
			}
		}
		}
		else
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
	       String data=ip+","+adm+","+dn+",Edit List Profile -Members : "+ml;
	       int mg=Crudoperation.insertlog(sql, data);
		
		
		 response.sendRedirect("/unifiedmail/global/addmaillistmembers.jsp?ml="+ml+"&status=succ");
		out.flush();
		out.close();
	}

}
