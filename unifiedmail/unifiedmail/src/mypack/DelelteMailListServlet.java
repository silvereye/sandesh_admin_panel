package mypack;

import java.io.IOException;
import java.io.PrintWriter;

import javax.naming.directory.DirContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbutil.Crudoperation;

public class DelelteMailListServlet extends HttpServlet {

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
		String ml=request.getParameter("ml");
		String arr[]=ml.split("@");
		String nm=arr[0];
		String dm=arr[1];
		HttpSession hs=request.getSession(false);
        String username=(String)hs.getAttribute("id");
        String password=(String)hs.getAttribute("password");
        String url=(String)hs.getAttribute("url");
        String mbase=(String)hs.getAttribute("base");
        String lst=GetUsersList.getMailListMem(url, username, password, mbase, dm, "memberOfGroup", ml);
        out.print(lst);
		String arrlst[]=lst.split(",");
		for(int i=0;i<arrlst.length;i++)
		{
			String lmem=GetUsersList.getUsersListMem(url, username, password, mbase, dm, "mail", arrlst[i], "");
		out.print("<br>ml=  "+lmem);
		int f=0;
		String arr_lmem[]=lmem.split(",");
		for(int j=0;j<arr_lmem.length;j++)
		{
		if(arr_lmem[j]==null || arr_lmem[j].equals(""))
		{
			continue;
		}
		if(ml.equalsIgnoreCase(arr_lmem[j]))
			{
			continue;
			}
		f++;
		if(f==1)
			{
			ModifyAtt.modyfyAtt(hs, arrlst[i], dm, "memberOfGroup", arr_lmem[j]);
			}
		else
			{
			ModifyAddAtt.modyfyAddAtt(hs, arrlst[i], dm, "memberOfGroup", arr_lmem[j]);
			}
		}
		if(f==0)
		{
			ModifyRemAtt.modyfyRemAtt(hs, dm, arrlst[i], "memberOfGroup");
		}
		}
		
		
		
		int cdlst=Integer.parseInt( GetMValueAtt.getDomValueAtt(url, username, password, mbase, dm, "domainCurrentListNumber") );	
		String dlst=""+(cdlst-1);
		ModifyDomainAtt.modyfyAtt(hs, dm, "domainCurrentListNumber", dlst);
		
		try
		{
        String MY_ENTRY="mail="+ml+",ou=Groups,domainName="+dm+",o=domains,"+mbase;
        DirContext del_ctx=LDAPConnection.getConnection(url, mbase, username, password);
	    del_ctx.destroySubcontext(MY_ENTRY);
		}
		catch (Exception e) {
			// TODO: handle exception
		}
		try
		{
        String MY_ENTRY="memberOfGroup="+ml+",ou=Externals,domainName="+dm+",o=domains,"+mbase;
        DirContext del_ctx=LDAPConnection.getConnection(url, mbase, username, password);
	    del_ctx.destroySubcontext(MY_ENTRY);
		}
		catch (Exception e) {
			// TODO: handle exception
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
	    	adm="mail-admin@"+dm;
	    }

        String sql="insert into log (ip,name,domain,msg) values(?,?,?,?)";
        String data=ip+","+adm+","+dm+",Delete List: "+ml;
        int mg=Crudoperation.insertlog(sql, data);
		response.sendRedirect("/unifiedmail/global/maillistslist.jsp?dm="+dm+"&msg=Deleted");
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
