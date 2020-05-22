package mypack;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.List;

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

public class AutoCompServlet extends HttpServlet {

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
		String name=request.getParameter("ml");
        List li = new ArrayList();
HttpSession hs=request.getSession(false);
		        String username=(String)hs.getAttribute("id");
		        String password=(String)hs.getAttribute("password");
		        String url=(String)hs.getAttribute("url");
		        String base1=(String)hs.getAttribute("base");
try
{
String dom="";

dom=request.getParameter("dn");


String base="ou=Users,domainName="+dom+",o=domains,"+base1;//dc=springbirds,dc=co,dc=in";//"ou=Users,domainName="+arr_dm[i]+",o=domains"+(String)hs.getAttribute("base");
DirContext ctx=LDAPConnection.getConnection(url, base, username, password);

SearchControls constraints = new SearchControls(); 
constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
String attrList[] = {"mail"}; 
constraints.setReturningAttributes(attrList);
NamingEnumeration results =ctx.search(base,"mail=*", constraints);
int f=0;
while (results.hasMore()) {
f=1;
  SearchResult si =(SearchResult)results.next();
  String ck=si.getName();
 System.out.println("<br><br><br>"+ck);
  Attributes attrs = si.getAttributes();
String arr[]=ck.split(",");
int l=arr.length;

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
if(id.equalsIgnoreCase("mail"))
      {
              li.add(str);
      }
     


         System.out.println("  <br> "+id + ":--- " +str);
         }
  }
}
if(f==0)
{
//out.print("Search not found");
}
String[] str = new String[li.size()];
     Iterator it = li.iterator();

     int i = 0;
     while(it.hasNext())
     {
         String p = (String)it.next();
         str[i] = p;
         i++;
     }

  //jQuery related start
     String query = (String)request.getParameter("q");

     int cnt=1;
     for(int j=0;j<str.length;j++)
     {
         if(str[j].toUpperCase().startsWith(query.toUpperCase()))
         {
            out.print(str[j]+"\n");
            if(cnt>=5)// 5=How many results have to show while we are typing(auto suggestions)
            break;
            cnt++;
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
     
  //jQuery related end}
}catch(Exception e){System.out.print(e);}
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
