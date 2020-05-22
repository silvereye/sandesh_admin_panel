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

public class EditPasswordAdminProfileServlet extends HttpServlet {

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
		
		String ps=request.getParameter("np");
		String pwd=ps;
		try
		{
		//pass=SHA256.encode(pass);
			ps=Encryption.puttySSHA512(ps);
		}
		catch (Exception e) {
			System.out.println(e);
		}
		HttpSession hs=request.getSession(false);
        String username= (String)hs.getAttribute("id");
        String password= (String)hs.getAttribute("password");
        String url= (String)hs.getAttribute("url");
        String mbase= (String)hs.getAttribute("base");
		   String utype=(String)hs.getAttribute("user_name");
		   if(utype.equalsIgnoreCase("Admin"))
		   {
			   String INITCTX = "com.sun.jndi.ldap.LdapCtxFactory";

			   String MY_HOST =url;

			   String MGR_DN = username;

			   String MGR_PW = password;

			   String MY_SEARCHBASE = mbase;

			   String MY_ENTRY = username;
			  

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
			    Attribute mod0 = new BasicAttribute("userPassword", ps);

			    mods[0] = new ModificationItem(DirContext.REPLACE_ATTRIBUTE, mod0);
			    ctx.modifyAttributes(MY_ENTRY, mods);
			   
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
			   
			   
		   }
		   else if( utype.equalsIgnoreCase("LocalAdmin"))
		   {
			   String INITCTX = "com.sun.jndi.ldap.LdapCtxFactory";

			   String MY_HOST =url;

			   String MGR_DN = "cn=vmailadmin,"+mbase;

			   String MGR_PW = "3MtAyuE9o01AwnSKgaU9HDPwER4J";

			   String MY_SEARCHBASE = mbase;

			   String MY_ENTRY = username;
			  

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
			    Attribute mod0 = new BasicAttribute("userPassword", ps);

			    mods[0] = new ModificationItem(DirContext.REPLACE_ATTRIBUTE, mod0);
			    ctx.modifyAttributes(MY_ENTRY, mods);
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
			   
			   
		   }
		   hs.setAttribute("password", pwd);
		 response.sendRedirect("/unifiedmail/global/dashboard.jsp");
		  /* hs.removeAttribute("id");
			hs.removeAttribute("password");
			hs.invalidate();
			response.sendRedirect("/unifiedmail/login/login.jsp?val=passch");
		   */
		   
		out.flush();
		out.close();
	}

}
