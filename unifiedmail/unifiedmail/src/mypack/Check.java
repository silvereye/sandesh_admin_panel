package mypack;

import java.util.*;

import javax.naming.NamingEnumeration;
import javax.naming.directory.Attributes;
import javax.naming.directory.DirContext;
import javax.naming.directory.SearchControls;
import javax.naming.directory.SearchResult;
import javax.servlet.http.HttpSession;



public class Check {

	public static int checkMail(HttpSession hs,String mail)
	{
		
        String username= (String)hs.getAttribute("id");
        String password= (String)hs.getAttribute("password");
        String url= (String)hs.getAttribute("url");
        String base= (String)hs.getAttribute("base");
        int f=0;
try
{
	

DirContext ctx=LDAPConnection.getConnection(url, base, username, password);
String v1="";
String v2="";
String v3="";
String qt="";
SearchControls constraints = new SearchControls(); 
constraints.setSearchScope(SearchControls.SUBTREE_SCOPE);
String attrList[] = {"mail"}; 
constraints.setReturningAttributes(attrList);
NamingEnumeration results =ctx.search(base,"mail="+mail, constraints);

while (results.hasMore()) {
f=1;
SearchResult si =(SearchResult)results.next();
String ck=si.getName();
System.out.println("<br><br><br>"+ck);
Attributes attrs = si.getAttributes();
String arr[]=ck.split(",");
int l=arr.length;
if(!arr[l-1].equalsIgnoreCase("o=domains"))
{
continue;
}
if (attrs == null) {
System.out.println("   No attributes");
continue;
}
NamingEnumeration ae = attrs.getAll(); 
while (ae.hasMoreElements()) {
break;

   //out.println("  <br> "+id + ":--- " +str);
   
}




}
if(f==0)
{
System.out.print("Search not found");
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
catch(Exception e){System.out.print(e);
f=2;}
	
return f;
	}
}
