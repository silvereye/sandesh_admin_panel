package mypack;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Hashtable;

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


public class EditBCCDomainServlet extends HttpServlet {

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
		String bcc_rec=request.getParameter("bcc_rec");
		if(bcc_rec.equals("") || bcc_rec==null)
		{
			ModifyDomainRemAtt.modyfyRemAtt(hs, dn, "domainRecipientBccAddress");
		}
		else
		{
		ModifyDomainAtt.modyfyAtt(hs, dn, "domainRecipientBccAddress", bcc_rec);
		}
		String bcc_sen=request.getParameter("bcc_sen");
		if(bcc_sen.equals("") || bcc_sen==null)
		{
			ModifyDomainRemAtt.modyfyRemAtt(hs, dn, "domainSenderBccAddress");
		}
		else
		{
		ModifyDomainAtt.modyfyAtt(hs, dn, "domainSenderBccAddress", bcc_sen);
		}
		int f_rec=0;
		int f_sen=0;
		String rec[] = request.getParameterValues("chk_rec");
		   if (rec != null && rec.length>0) 
		   {
			   f_rec=1;
			  // out.print("rec     1");
			 //  ModifyDomainAtt.modyfyAtt(hs, dn, "accountStatus", "active");
		   }
		   else
		   {
			   f_rec=0;
			   //out.print("rec     0");
			 //  ModifyDomainAtt.modyfyAtt(hs, dn, "accountStatus", "disabled");
			   
		   }
		   
		   String sen[] = request.getParameterValues("chk_sen");
		   if (sen != null && sen.length>0) 
		   {
			   f_sen=1;
			   //out.print("sen     1");
			 //  ModifyDomainAtt.modyfyAtt(hs, dn, "accountStatus", "active");
		   }
		   else
		   {
			   f_sen=0;
			   //out.print("sen     0");
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
	if(f_rec==1 && f_sen==1)
	{
		ModifyDomainAtt.modyfyAtt(hs, dn, "enabledService", "recipientbcc");
		ModifyDomainAddAtt.modyfyAddAtt(hs, dn, "enabledService", "senderbcc");
		flg=1;
	}
	else if(f_rec==1)
	{
		ModifyDomainAtt.modyfyAtt(hs, dn, "enabledService", "recipientbcc");
		flg=1;
	}
	else if(f_sen==1)
	{
		ModifyDomainAtt.modyfyAtt(hs, dn, "enabledService", "senderbcc");
		flg=1;
	}
	String arr[]=serv.split(",");
	for(int i=0,cnt=0;i<arr.length;i++)
	{
		if(arr[i].equalsIgnoreCase("recipientbcc") || arr[i].equalsIgnoreCase("senderbcc"))
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
String data=ip+","+adm+","+dn+",Edit Domain Profile -BCC : "+dn;
int mg=Crudoperation.insertlog(sql, data);


response.sendRedirect("/unifiedmail/global/bccdomain.jsp?dn="+dn+"&status=succ");

		out.flush();
		out.close();
	}

}
