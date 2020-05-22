package mypack;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;

import javax.naming.NamingEnumeration;
import javax.naming.directory.Attribute;
import javax.naming.directory.Attributes;
import javax.naming.directory.DirContext;
import javax.naming.directory.SearchControls;
import javax.naming.directory.SearchResult;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbutil.Crudoperation;

public class DelelteDomainServlet extends HttpServlet {

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
		String dm=request.getParameter("dm");
		 HttpSession hs=request.getSession(false);
	        String username= (String)hs.getAttribute("id");
	        String password= (String)hs.getAttribute("password");
	        String url= (String)hs.getAttribute("url");
	        String mbase= (String)hs.getAttribute("base");

			
		////delete users	
		try
		{
			String base="ou=Users,domainName="+dm+",o=domains,"+mbase;//dc=springbirds,dc=co,dc=in";//"ou=Users,domainName="+arr_dm[i]+",o=domains"+(String)hs.getAttribute("base");
			
			DirContext ctx=LDAPConnection.getConnection(url, base, username, password);
			
			SearchControls constraints = new SearchControls(); 
			constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
			String attrList[] = {"mail"}; 
			constraints.setReturningAttributes(attrList);
			NamingEnumeration results =ctx.search(base,"mail=*", constraints);
			
			while (results.hasMore()) {
			//f=0;
			
			    SearchResult si =(SearchResult)results.next();
			    String ck=si.getName();
			   System.out.println("<br><br><br>1"+ck);
			    Attributes attrs = si.getAttributes();
			String arr[]=ck.split(",");
			int l=arr.length;

			    if (attrs == null) {
			      // out.println("   No attributes");
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
		        String MY_ENTRY="mail="+str+","+base;
		        DirContext del_ctx=LDAPConnection.getConnection(url, base, username, password);
			    del_ctx.destroySubcontext(MY_ENTRY);
		      
		       
		           //out.println("  <br> "+id + ":--- " +str);
		           }
		    }


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
		catch(Exception e)
		{System.out.print(e);
		}
		
		
		
		/////Delete aliases 
		
		try
		{
			String base="ou=Aliases,domainName="+dm+",o=domains,"+mbase;//dc=springbirds,dc=co,dc=in";//"ou=Users,domainName="+arr_dm[i]+",o=domains"+(String)hs.getAttribute("base");
			
			DirContext ctx=LDAPConnection.getConnection(url, base, username, password);
			
			SearchControls constraints = new SearchControls(); 
			constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
			String attrList[] = {"mail"}; 
			constraints.setReturningAttributes(attrList);
			NamingEnumeration results =ctx.search(base,"mail=*", constraints);
			
			while (results.hasMore()) {
			//f=0;
			
			    SearchResult si =(SearchResult)results.next();
			    String ck=si.getName();
			   System.out.println("<br><br><br>1"+ck);
			    Attributes attrs = si.getAttributes();
			String arr[]=ck.split(",");
			int l=arr.length;

			    if (attrs == null) {
			      // out.println("   No attributes");
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
		        String MY_ENTRY="mail="+str+","+base;
		        DirContext del_ctx=LDAPConnection.getConnection(url, base, username, password);
			    del_ctx.destroySubcontext(MY_ENTRY);
		      
		       
		           //out.println("  <br> "+id + ":--- " +str);
		           }
		    }


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
		catch(Exception e)
		{System.out.print(e);
		}
		
		
		//delete Groups
		try
		{
			String base="ou=Groups,domainName="+dm+",o=domains,"+mbase;//dc=springbirds,dc=co,dc=in";//"ou=Users,domainName="+arr_dm[i]+",o=domains"+(String)hs.getAttribute("base");
			
			DirContext ctx=LDAPConnection.getConnection(url, base, username, password);
			
			SearchControls constraints = new SearchControls(); 
			constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
			String attrList[] = {"mail"}; 
			constraints.setReturningAttributes(attrList);
			NamingEnumeration results =ctx.search(base,"mail=*", constraints);
			
			while (results.hasMore()) {
			//f=0;
			
			    SearchResult si =(SearchResult)results.next();
			    String ck=si.getName();
			   System.out.println("<br><br><br>1"+ck);
			    Attributes attrs = si.getAttributes();
			String arr[]=ck.split(",");
			int l=arr.length;

			    if (attrs == null) {
			      // out.println("   No attributes");
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
		        String MY_ENTRY="mail="+str+","+base;
		        DirContext del_ctx=LDAPConnection.getConnection(url, base, username, password);
			    del_ctx.destroySubcontext(MY_ENTRY);
		      
			    String base1="ou=Externals,domainName="+dm+",o=domains,"+mbase;
			    String MY_ENTRY1="memberOfGroup="+str+","+base1;
		        DirContext del_ctx1=LDAPConnection.getConnection(url, base1, username, password);
			    del_ctx1.destroySubcontext(MY_ENTRY1);
		      
		       
		           //out.println("  <br> "+id + ":--- " +str);
		           }
		    }


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
		catch(Exception e)
		{System.out.print(e);
		}
		
		
		try
		{
			String base1="domainName="+dm+",o=domains,"+mbase;
		    String MY_ENTRY1="ou=Externals,"+base1;
	        DirContext del_ctx1=LDAPConnection.getConnection(url, base1, username, password);
		    del_ctx1.destroySubcontext(MY_ENTRY1);	
			
		    MY_ENTRY1="ou=Aliases,"+base1;
	        del_ctx1=LDAPConnection.getConnection(url, base1, username, password);
		    del_ctx1.destroySubcontext(MY_ENTRY1);
		    
		    MY_ENTRY1="ou=Groups,"+base1;
	        del_ctx1=LDAPConnection.getConnection(url, base1, username, password);
		    del_ctx1.destroySubcontext(MY_ENTRY1);
		    
		    MY_ENTRY1="ou=Users,"+base1;
	        del_ctx1=LDAPConnection.getConnection(url, base1, username, password);
		    del_ctx1.destroySubcontext(MY_ENTRY1);
			
		}
		catch (Exception e) {
			System.out.println(e);
			// TODO: handle exception
		}
		
		try
		{
		String dm_base="o=domains,"+mbase;
		 String dm_MY_ENTRY="domainName="+dm+","+dm_base;
	        DirContext dm_del_ctx=LDAPConnection.getConnection(url, dm_base, username, password);
		    dm_del_ctx.destroySubcontext(dm_MY_ENTRY);
		}
		catch (Exception e) {
			System.out.println(e);
			// TODO: handle exception
		}
	
		
		
		try
		{
		String dm_base="o=domainAdmins,"+mbase;
		 String dm_MY_ENTRY="mail=mail-admin@"+dm+","+dm_base;
	        DirContext dm_del_ctx=LDAPConnection.getConnection(url, dm_base, username, password);
		    dm_del_ctx.destroySubcontext(dm_MY_ENTRY);
		}
		catch (Exception e) {
			System.out.println(e);
			// TODO: handle exception
		}
		
		
		String basedir=GetMValueAtt.getDomValueAtt(url, username, password, mbase, dm, "domainBaseStorage");
		
		
		Date date = new Date();
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd h:mm:ss a");
	    String formattedDate = sdf.format(date);
	    formattedDate=formattedDate.replace("/","");
	    formattedDate=formattedDate.replace(":","");
	    formattedDate=formattedDate.replace(" ","");
	    out.print(formattedDate);
	    
	    Process p = Runtime.getRuntime().exec("sudo mv "+basedir+dm+" "+basedir+dm+formattedDate );
		  
	    
	     p = Runtime.getRuntime().exec("sudo mv /maildir/domains/"+dm+" /maildir/domains/"+dm+formattedDate );
	  
	    
	    
	    
	    
	    
	    String ip= (String)hs.getAttribute("ip");
	    String sql="insert into log (ip,name,domain,msg) values(?,?,?,?)";
        String data=ip+","+"Global Admin"+","+dm+",Delete Domain: "+dm;
        int mg=Crudoperation.insertlog(sql, data);
        
        
	    
		 response.sendRedirect("/unifiedmail/global/domainlist.jsp?msg=Deleted");
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
