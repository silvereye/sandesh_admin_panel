package mypack;

import java.io.IOException;
import java.io.PrintWriter;
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

public class CountUserServlet extends HttpServlet {

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
		String uid=request.getParameter("val");
		HttpSession hs=request.getSession(false);
        String username=(String)hs.getAttribute("id");
        String password=(String)hs.getAttribute("password");
        String url=(String)hs.getAttribute("url");
        String base1=(String)hs.getAttribute("base");
		String base="ou=Users,domainName="+dm+",o=domains,"+base1;//dc=springbirds,dc=co,dc=in";//"ou=Users,domainName="+arr_dm[i]+",o=domains"+(String)hs.getAttribute("base");
		DirContext ctx=LDAPConnection.getConnection(url, base, username, password);
		
		String v3="";
		int f=0;
		try
		{
		SearchControls constraints = new SearchControls(); 
		constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
		String attrList[] = {"mail"}; 
		constraints.setReturningAttributes(attrList);
		NamingEnumeration results =ctx.search(base,"mail="+uid, constraints);

		while (results.hasMore()) {
		//f=1;
		String photo="";
		    SearchResult si =(SearchResult)results.next();
		    String ck=si.getName();
		   //System.out.println("<br><br><br>"+ck);
		    Attributes attrs = si.getAttributes();
		String arr[]=ck.split(",");
		int l=arr.length;

		    if (attrs == null) {
		    //   out.println("   No attributes");
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
		       
		         if(id.equalsIgnoreCase("mail"))
		        {
		        	 f++;
		        v3=str;
		        }
		        System.out.println("  <br> "+id + ":--- " +str);
		           }
		    }
		}
		ctx.close();
		}
		catch (Exception e) {
			//System.out.println(e);
			// TODO: handle exception
			f=0;
		}
if(f>0)
	f--;
out.print(f);
		
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
