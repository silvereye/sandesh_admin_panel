package mypack;

import java.util.Enumeration;

import javax.naming.NamingEnumeration;
import javax.naming.directory.Attribute;
import javax.naming.directory.Attributes;
import javax.naming.directory.DirContext;
import javax.naming.directory.SearchControls;
import javax.naming.directory.SearchResult;
import javax.servlet.http.HttpSession;

public class AliasForwording {

	public static int chkAliasFrd(HttpSession hs,String dn, String alias, String frd)
	{
		int ret=0;

String username= (String)hs.getAttribute("id");
String password= (String)hs.getAttribute("password");
String url= (String)hs.getAttribute("url");
String mbase= (String)hs.getAttribute("base");
String base="ou=Aliases,domainName="+dn+",o=domains,"+mbase;


try
{

DirContext ctx=LDAPConnection.getConnection(url, base, username, password);

SearchControls constraints = new SearchControls(); 
constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
String attrList[] = {"mailForwardingAddress"}; 
constraints.setReturningAttributes(attrList);
NamingEnumeration results =ctx.search(base,"mail="+alias, constraints);

while (results.hasMore()) {
	
	SearchResult si =(SearchResult)results.next();
    String ck=si.getName();
   //System.out.println("<br><br><br>"+ck);
    Attributes attrs = si.getAttributes();
String arr[]=ck.split(",");
int l=arr.length;

    if (attrs == null) {
       System.out.println("   No attributes");
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
        if(id.equalsIgnoreCase("mailForwardingAddress"))
        {
        	if(str.equalsIgnoreCase(frd))
        	{
        	ret=1;
        	}
        }
        
if(ret==1)
	break;


           System.out.println("<br> "+id + ":--- " +str);
           }
        if(ret==1)
        	break;
    }

    if(ret==1)
    	break;
}

System.out.print(""+ret);
try
{
	LDAPConnection.closeConn( ctx);
}
catch(Exception ec)
{
	ec.printStackTrace();
}

}
catch(Exception e){System.out.print(e);}
		
		return ret;
	}
}
