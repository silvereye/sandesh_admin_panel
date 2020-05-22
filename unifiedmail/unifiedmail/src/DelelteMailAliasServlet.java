import java.io.IOException;
import java.io.PrintWriter;

import javax.naming.directory.DirContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbutil.Crudoperation;

import mypack.GetMValueAtt;
import mypack.LDAPConnection;
import mypack.ModifyDomainAtt;


public class DelelteMailAliasServlet extends HttpServlet {

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
		try
		{
        String MY_ENTRY="mail="+ml+",ou=Aliases,domainName="+dm+",o=domains,"+mbase;
        DirContext del_ctx=LDAPConnection.getConnection(url, mbase, username, password);
	    del_ctx.destroySubcontext(MY_ENTRY);
		}
		catch (Exception e) {
			// TODO: handle exception
		}
		
		int cdlst=Integer.parseInt( GetMValueAtt.getDomValueAtt(url, username, password, mbase, dm, "domainCurrentAliasNumber") );	
		String dlst=""+(cdlst-1);
		ModifyDomainAtt.modyfyAtt(hs, dm, "domainCurrentAliasNumber", dlst);
		
		
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
        String data=ip+","+adm+","+dm+",Delete Alias: "+ml;
        int mg=Crudoperation.insertlog(sql, data);
		
		
		 response.sendRedirect("/unifiedmail/global/mailaliaseslist.jsp?dm="+dm+"&msg=Deleted");
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
		
		out.flush();
		out.close();
	}

}
