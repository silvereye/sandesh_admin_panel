package mypack;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Hashtable;

import javax.naming.Context;
import javax.naming.directory.Attribute;
import javax.naming.directory.BasicAttribute;
import javax.naming.directory.DirContext;
import javax.naming.directory.InitialDirContext;
import javax.naming.directory.ModificationItem;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbutil.Crudoperation;

public class EditDomainAdminProfileServlet extends HttpServlet {

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
		String mail=request.getParameter("hid_mail");
		String cn=request.getParameter("cn");
		String ps=request.getParameter("np");
		String acc_arr[]=request.getParameterValues("acc");
		String acc="disabled";
		if(acc_arr!=null && acc_arr.length>0)
			acc="active";
		else
			acc="disabled";
		HttpSession hs=request.getSession();
		 String username= (String)hs.getAttribute("id");
	        String password= (String)hs.getAttribute("password");
	        String url= (String)hs.getAttribute("url");
	        String base= (String)hs.getAttribute("base");
		
		 String INITCTX = "com.sun.jndi.ldap.LdapCtxFactory";

		   String MY_HOST =url;

		   String MGR_DN = username;

		   String MGR_PW = password;

		   String MY_SEARCHBASE = base;

		   String MY_ENTRY = "mail="+mail+",o=domainAdmins,"+base;
		  

		   try
		   {
		   Hashtable<String, String> env = new Hashtable<String, String>();

		    env.put(Context.INITIAL_CONTEXT_FACTORY, INITCTX);

		    env.put(Context.PROVIDER_URL, MY_HOST);
		    env.put(Context.SECURITY_AUTHENTICATION, "simple");
		    env.put(Context.SECURITY_PRINCIPAL, MGR_DN);
		    env.put(Context.SECURITY_CREDENTIALS, MGR_PW);

		   DirContext ctx = new InitialDirContext(env);

		   ModificationItem[] mods = new ModificationItem[1];
		   Attribute mod0 = new BasicAttribute("cn", cn);
		   mods[0] = new ModificationItem(DirContext.REPLACE_ATTRIBUTE, mod0);
		   ctx.modifyAttributes(MY_ENTRY, mods);
		    
		    
		    ModificationItem[] mods1 = new ModificationItem[1];
		    Attribute mod1 = new BasicAttribute("accountStatus", acc);
		    mods1[0] = new ModificationItem(DirContext.REPLACE_ATTRIBUTE, mod1);
		    ctx.modifyAttributes(MY_ENTRY, mods1);
		    
		    
		    if(ps!=null && !(ps.equals("")))
		    {
		    	ModificationItem[] mods2 = new ModificationItem[1];
		    Attribute mod2 = new BasicAttribute("userPassword", ps);
		    mods2[0] = new ModificationItem(DirContext.REPLACE_ATTRIBUTE, mod2);
		    ctx.modifyAttributes(MY_ENTRY, mods2);
		    }
		    
			   
		    
		    try
	        {
	        	LDAPConnection.closeConn( ctx);
	        }
	        catch(Exception ec)
	        {
	        	ec.printStackTrace();
	        }
		   }
		   catch(Exception e1)
		   {
			  
			  System.out.print(e1.toString());
			  
		   }
		   
		   String dm="";
		   String arr[]=mail.split("@");
		   
		      String ip= (String)hs.getAttribute("ip");
				String utype= (String)hs.getAttribute("user_name");
				String adm="";
				if(utype.equals("Admin"))
				{
					adm="Global Admin";
				}
				else
				{
					adm=mail;
				}
				String sql="insert into log (ip,name,domain,msg) values(?,?,?,?)";
				String data=ip+","+adm+","+arr[1]+",Edit Domain Admin Profile: "+mail;
				int mg=Crudoperation.insertlog(sql, data);
		   
		   response.sendRedirect("/unifiedmail/global/editdomainadminprofile.jsp?ml="+mail+"&status=succ");
		out.flush();
		out.close();
	}

}
