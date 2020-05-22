package mypack;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Hashtable;

import javax.naming.Context;
import javax.naming.NamingEnumeration;
import javax.naming.directory.DirContext;
import javax.naming.directory.InitialDirContext;
import javax.naming.directory.SearchControls;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbutil.Crudoperation;

public class CheckloginServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public CheckloginServlet() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

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
		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
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
String pass=request.getParameter("pass");
String adm="";	    
/***************************  

	     String url ="ldap://192.168.1.100:389";
	    
	    String password =pass;
	   String base1 ="dc=springbirds,dc=co,dc=in";
	    String base=base1;
	    String id=request.getParameter("id");    //"cn=admin,"+base;
	    String username ="";
	    String utype="";
	    String search="";
	    int chk_admin=1;
	    String sbase=base.replaceAll("dc=", "");
	    sbase=sbase.replaceAll(",", ".");
	    if(id.equalsIgnoreCase("admin@"+sbase))
	    {
	    	username="cn=admin,"+base;
	    	utype="Admin";
	    	search="cn";
	    	adm="Global Admin";
	    }
	    else
	    {
	    	adm=id;
	    	String arr[]=id.split("@");
	    	//base="ou=Users,domainName="+arr[1]+",o=domains,"+base1;
	    	if(arr!=null && arr.length==2)
	    	{
	    	sbase=arr[1];
	    	}
	    	base=base1;
	    	username="mail="+id+",o=domainAdmins,"+base;
	    	utype="LocalAdmin";
	    	search="mail";
	    	if(arr[0].equalsIgnoreCase("mail-admin"))
	    	{
	    		chk_admin=1;
	    	}
	    	else
	    	{
	    		chk_admin=0;
	    	}
	    }
	 
	    
	  ***************************/  
//String url ="ldap://127.0.0.1:389";
String url ="ldap://mail.avi-oil.com:389";

String password =pass;
	    
	  //  String base1 ="dc=wii,dc=gov,dc=in";
String base1 ="dc=avi-oil,dc=com";
	    String base=base1;
	    String id=request.getParameter("id");    //"cn=admin,"+base;
	    String username ="";
	    String utype="";
	    String search="";
	    int chk_admin=1;
	    String sbase=base.replaceAll("dc=", "");
	    sbase=sbase.replaceAll(",", ".");
	    if(id.equalsIgnoreCase("admin@"+sbase))
	    {
	    	username="cn=admin,"+base;
	    	utype="Admin";
	    	search="cn";
	    	adm="Global Admin";
	    }
	    else
	    {
	    	adm=id;
	    	String arr[]=id.split("@");
	    	if(arr!=null && arr.length==2)
	    	{
	    	sbase=arr[1];
	    	}
	    	//base="ou=Users,domainName="+arr[1]+",o=domains,"+base1;
	    	base=base1;
	    	username="mail="+id+",o=domainAdmins,"+base;
	    	utype="LocalAdmin";
	    	search="mail";
	    	if(arr[0].equalsIgnoreCase("mail-admin"))
	    	{
	    		chk_admin=1;
	    	}
	    	else
	    	{
	    		chk_admin=0;
	    	}
	    }
	
	    
	    
	    
	    DirContext ctx=null;
	    int f=0;
	    try
	    {
	    	 Hashtable env = new Hashtable();
	    env.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
	    env.put(Context.PROVIDER_URL, url); // LDAP host and base

	    // LDAP authentication options
	    env.put(Context.SECURITY_AUTHENTICATION, "simple");
	    env.put(Context.SECURITY_PRINCIPAL, username);
	    env.put(Context.SECURITY_CREDENTIALS, password);

	   ctx = new InitialDirContext(env);
	//DirContext ctx=LDAPConnection.getConnection();
	    SearchControls constraints = new SearchControls(); 
	    constraints.setSearchScope(SearchControls.SUBTREE_SCOPE);
	    String attrList[] = {"*"}; 
	    constraints.setReturningAttributes(attrList);
	    NamingEnumeration results =ctx.search(base,search+"=*", constraints);
	   
	    while (results.hasMore()) {
	    f=1;
	    System.out.print("f="+f);
	     /*   SearchResult si =(SearchResult)results.next();
	        System.out.println(si.getName());
	        
	        Attributes attrs = si.getAttributes();
	        if (attrs == null) {
	           out.println("   No attributes");
	            continue;
	        }*/
	        break;
	      		    }
	   
	    }
	    catch(Exception e){
	    	System.out.print(e);
	    	f=0;
	    	}
	    finally {
	    	if(ctx!=null)
	    		ctx.close();
		}
	    
	    
	    
	    if(f==1 && chk_admin==1)//&& id.equals("cn=Manager,"+base))// && (pass.equals("redhat") ||pass.equals("google")))
	    {
	    	String ipAddress=null;
			String getWay = request.getHeader("VIA");   // Gateway
			ipAddress = request.getHeader("X-FORWARDED-FOR");   // proxy
			if(ipAddress==null)
			{
			    ipAddress = request.getRemoteAddr();
			}
			System.out.println("IP Address: "+ipAddress);
	    	HttpSession hs=request.getSession();
	    	hs.setAttribute("id", username);
	    	hs.setAttribute("user_name", utype);
	    	hs.setAttribute("password", pass);
	    	hs.setAttribute("base", base1);
	    	hs.setAttribute("url", url);
	    	hs.setAttribute("ip", ipAddress);
	    	hs.setAttribute("adm_id", adm);
	    	
	    	
	    	/*
	    	
		        String sql="insert into log (ip,name,domain,msg) values(?,?,?,?)";
		        String data=ipAddress+","+adm+","+sbase+",Login success";
		        int mg=Crudoperation.insertlog(sql, data);
	    	*/
	    	
	      response.sendRedirect("/unifiedmail/global/dashboard.jsp");
	     }
	     else
	     {
	     response.sendRedirect("/unifiedmail/login/login.jsp?val=notpass");
	     }
		}
		catch(Exception e){
	    	System.out.print(e);
	    	response.sendRedirect("/unifiedmail/login/login.jsp?val=notpass");
		}
		
		out.flush();
		out.close();
	}

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}

}
