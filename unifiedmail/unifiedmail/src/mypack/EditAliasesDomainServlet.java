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

import dbutil.Crudoperation;

public class EditAliasesDomainServlet extends HttpServlet {

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
		HttpSession hs=request.getSession();
		String dn=request.getParameter("hid_dn");
		
		int f_al=0;
	
		String rec[] = request.getParameterValues("acc");
		   if (rec != null && rec.length>0) 
		   {
			   f_al=1;
			  // out.print("rec     1");
			 //  ModifyDomainAtt.modyfyAtt(hs, dn, "accountStatus", "active");
		   }
		   else
		   {
			   f_al=0;
			   //out.print("rec     0");
			 //  ModifyDomainAtt.modyfyAtt(hs, dn, "accountStatus", "disabled");
			   
		   }
		   
		   
		   
		   String username= (String)hs.getAttribute("id");
	        String password= (String)hs.getAttribute("password");
	        String url= (String)hs.getAttribute("url");
	        String mbase= (String)hs.getAttribute("base");
	        String base="o=domains,"+mbase;
	       String serv=""; 
	       int f=0;
try
{


DirContext ctx=LDAPConnection.getConnection(url, base, username, password);

SearchControls constraints = new SearchControls(); 
constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
String attrList[] = {"enabledService"}; 
constraints.setReturningAttributes(attrList);
NamingEnumeration results =ctx.search(base,"domainName="+dn, constraints);

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
   if(id.equalsIgnoreCase("enabledService"))
   {
   	if(serv.equalsIgnoreCase(""))
   	{
   	serv=str;
   	}
   	else 
   	{
   	serv=serv+","+str;
   	}
   }
     

      //out.println("  <br> "+id + ":--- " +str);
      }
}
//NoOfUser nof=new NoOfUser();


}
if(f==0)
{
System.out.print("<tr class='grey'><td></td><td>Search not found</td></tr>");
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
catch(Exception e){System.out.print("<tr class='grey'><td></td><td>"+e+"</td></tr>");}

if(f!=0)
{
	System.out.println("serv     "+serv);
	int flg=0;
	if(f_al==1 )
	{
		ModifyDomainAtt.modyfyAtt(hs, dn, "enabledService", "domainalias");
		flg=1;
	}
	
	String arr[]=serv.split(",");
	for(int i=0,cnt=0;i<arr.length;i++)
	{
		if(arr[i].equalsIgnoreCase("domainalias") )
		{
			continue;
		}
		cnt++;
		if(cnt==1 && flg==0)
		{
			ModifyDomainAtt.modyfyAtt(hs, dn, "enabledService", arr[i]);
		}
		else
		{
			ModifyDomainAddAtt.modyfyAddAtt(hs, dn, "enabledService", arr[i]);
		}
	}
	
}


String ulst=GetUsersList.getUsersList(url, username, password, mbase, dn, "mail", "*");


String no=request.getParameter("hid_dalias");
int j=0;
for(int i=1;i<=Integer.parseInt(no);i++)
{
String fd=request.getParameter("dalias"+i);
if(fd.equals("") || fd==null)
{
	continue;
}
j++;
if(j==1)
{
	ModifyDomainAtt.modyfyAtt(hs, dn, "domainAliasName", fd);
	String arr[]=ulst.split(",");
	for(int z=0;z<arr.length;z++)
	{
		String ar[]=arr[z].split("@");
		String mdm=ar[0].trim();
		ModifyAtt.modyfyAtt(hs, arr[z], dn, "shadowAddress", mdm+"@"+fd);
	}
}
else
{
	ModifyDomainAddAtt.modyfyAddAtt(hs, dn, "domainAliasName", fd);
	String arr[]=ulst.split(",");
	for(int z=0;z<arr.length;z++)
	{
		String ar[]=arr[z].split("@");
		String mdm=ar[0].trim();
		ModifyAddAtt.modyfyAddAtt(hs, arr[z], dn, "shadowAddress", mdm+"@"+fd);
	}
	
}
}
System.out.println("j="+j);
if(j==0)
{
	ModifyDomainRemAtt.modyfyRemAtt(hs, dn, "domainAliasName");
	String arr[]=ulst.split(",");
	for(int z=0;z<arr.length;z++)
	{
		ModifyRemAtt.modyfyRemAtt(hs, dn, arr[z], "shadowAddress");
	}
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
String data=ip+","+adm+","+dn+",Edit Domain Profile -Aliases : "+dn;
int mg=Crudoperation.insertlog(sql, data);



		   response.sendRedirect("/unifiedmail/global/aliasesdomain.jsp?dn="+dn+"&status=succ");

		out.flush();
		out.close();
	}

}
