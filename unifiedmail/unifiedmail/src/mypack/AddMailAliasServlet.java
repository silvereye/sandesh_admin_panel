package mypack;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import java.util.Hashtable;

import javax.naming.Context;
import javax.naming.NamingEnumeration;
import javax.naming.NamingException;
import javax.naming.directory.Attribute;
import javax.naming.directory.Attributes;
import javax.naming.directory.BasicAttribute;
import javax.naming.directory.BasicAttributes;
import javax.naming.directory.DirContext;
import javax.naming.directory.InitialDirContext;
import javax.naming.directory.SearchControls;
import javax.naming.directory.SearchResult;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbutil.Crudoperation;

public class AddMailAliasServlet extends HttpServlet {

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
		String ml=request.getParameter("mail").trim();
		String domain=request.getParameter("domain").trim();
		String mail=ml+"@"+domain;
		String cn=request.getParameter("dn");
		String acc=request.getParameter("acc");
		String arr1[]=request.getParameterValues("abook");
		
		
		
		
		
		  HttpSession hs=request.getSession(false);
	        String username= (String)hs.getAttribute("id");
	        String password= (String)hs.getAttribute("password");
	        String url= (String)hs.getAttribute("url");
	        String mbase= (String)hs.getAttribute("base");
	        
	        String  base="o=domains,"+mbase;
	        DirContext ctx = null;
	       String clistno="0";
		   String dan="";  
	        try
	   {


	  ctx=LDAPConnection.getConnection(url, base, username, password);

	  SearchControls constraints = new SearchControls(); 
	  constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
	   String attrList[] = {"domainCurrentAliasNumber","domainAliasName"}; 
	   constraints.setReturningAttributes(attrList);
	   NamingEnumeration results =ctx.search(base,"domainName="+domain, constraints);
	   int f=0;
	   int x=0;
	   while (results.hasMore()) {
	   f=1;
	       SearchResult si =(SearchResult)results.next();
	       String ck=si.getName();
	      System.out.println("<br><br><br>"+ck);
	       Attributes attrs = si.getAttributes();

	       if (attrs == null) {
	          out.println("   No attributes");
	           continue;
	       }
	       
	      
	       
	       NamingEnumeration ae = attrs.getAll(); 
	       while (ae.hasMoreElements()) {
	           Attribute attr =(Attribute)ae.next();
	           String id = attr.getID();
	           Enumeration vals = attr.getAll();
	           while (vals.hasMoreElements())
	           {
	           String str= vals.nextElement().toString();
	            if(id.equalsIgnoreCase("domainCurrentAliasNumber"))
	           {
	           clistno=str;
	           }
	            else if(id.equalsIgnoreCase("domainAliasName"))
		           {
	            	if(dan.equals(""))
	            	{
	            		dan=str;
	            	}
	            	else
	            	{
	            		dan=dan+","+str;
	            	}
	 	         
	 	           }
	           
	           

	              System.out.println(" dom <br> "+id + ":--- " +str);
	              }
	       }
	       //NoOfUser nof=new NoOfUser();
	    

	   }
	   
	   }
	   catch(Exception e){System.out.print("<tr class='grey'><td></td><td>"+e+"</td></tr>");}

	     	        
	        
	        
	        
	        
	        
	        
	        
	        
	        
	        
	        
	        
	        
	        
	        
	         base="ou=Aliases,domainName="+domain+",o=domains,"+mbase;
		   
	 Hashtable env = new Hashtable();
		    
		   env.put(Context.INITIAL_CONTEXT_FACTORY,"com.sun.jndi.ldap.LdapCtxFactory");
		   env.put(Context.PROVIDER_URL, url); // LDAP host and base
		   env.put(Context.SECURITY_AUTHENTICATION, "simple");
		   env.put(Context.SECURITY_PRINCIPAL, username);
		   env.put(Context.SECURITY_CREDENTIALS, password);
		  
		  


		   
		    try {
		        // get a handle to an Initial DirContext
		      ctx = new InitialDirContext(env);
		    	
		        // build the entry
		        Attributes entry = new BasicAttributes();
		 
		       
		        
		        String entryDN ="mail="+mail+","+base;///"uid=amit,ou=Users,dc=silvereye,dc=in";
		            
		            Attribute oc = new BasicAttribute("objectClass");  
		            oc.add("mailAlias");
		            oc.add("top");
		             
		            
		            entry.put(oc);  
		            Attribute oc1 = new BasicAttribute("enabledService");  
		            oc1.add("mail");
		            oc1.add("deliver");
		            if(arr1!=null && arr1.length>0)
		            {
		            oc1.add("displayedInGlobalAddressBook");
		            }
		            entry.put(oc1);  
		            
		             
		            entry.put( new BasicAttribute("cn", cn) );
		            entry.put( new BasicAttribute("mail", mail ) );
		            entry.put( new BasicAttribute( "accountStatus",acc ) );
		            Attribute oc2 = new BasicAttribute("shadowAddress");  
		            String arr_dan[]=dan.split(",");
		            for(int i=0;i<arr_dan.length;i++)
		            {
		            	oc2.add(ml+"@"+arr_dan[i]);	
		            }
		            entry.put(oc2);  
	
		          // Add the entry
		        ctx.createSubcontext(entryDN, entry);
		       System.out.println( "AddUser: added entry " + entryDN + ".");
		      
		       clistno=""+(Integer.parseInt(clistno)+1); 
		   
		    ModifyDomainAtt.modyfyAtt(hs, domain, "domainCurrentAliasNumber", clistno);
		    
		    
		    
		    
		    String ip= (String)hs.getAttribute("ip");
			String utype= (String)hs.getAttribute("user_name"); 
		    String adm="";
		    if(utype.equals("Admin"))
		    {
		    	adm="Global Admin";
		    }
		    else
		    {
		    	adm="mail-admin@"+domain;
		    }

	        String sql="insert into log (ip,name,domain,msg) values(?,?,?,?)";
	        String data=ip+","+adm+","+domain+",Add Alias: "+mail;
	        int mg=Crudoperation.insertlog(sql, data);
		    
	        try
	        {
	        	LDAPConnection.closeConn( ctx);
	        }
	        catch(Exception ec)
	        {
	        	ec.printStackTrace();
	        }
		    
		    response.sendRedirect("/unifiedmail/global/addalias.jsp?status=succ&nm="+mail);  
		     
		    } catch (NamingException e) {
		        System.out.println("AddUser: error adding entry." + e);
		        response.sendRedirect("/unifiedmail/global/addalias.jsp?status=error");

		        

		    }
		    

		out.flush();
		out.close();
	}

}
