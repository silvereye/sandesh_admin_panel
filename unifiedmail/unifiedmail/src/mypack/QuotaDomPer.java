package mypack;

import java.util.Enumeration;
import javax.naming.NamingEnumeration;
import javax.naming.directory.Attribute;
import javax.naming.directory.Attributes;
import javax.naming.directory.DirContext;
import javax.naming.directory.SearchControls;
import javax.naming.directory.SearchResult;
public class QuotaDomPer {
public static long quotaPer(String url,String username,String password,String base1,String dname)
{
	String base=base1;
	String cqt="";
	String dqt="";
	long per=0;
	try
	{
	DirContext ctx=LDAPConnection.getConnection(url, base, username, password);

	SearchControls constraints = new SearchControls(); 
	constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
	String attrList[] = {"domainCurrentQuotaSize","domainMaxQuotaSize"}; 
	constraints.setReturningAttributes(attrList);
	NamingEnumeration results =ctx.search(base,"domainName="+dname, constraints);
	int f=0;
	int x=0;
	while (results.hasMore()) {
	f=1;
	    SearchResult si =(SearchResult)results.next();
	    String ck=si.getName();
	   System.out.println("<br><br><br>"+ck);
	    Attributes attrs = si.getAttributes();

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
	         if(id.equalsIgnoreCase("domainCurrentQuotaSize"))
	        {
	        cqt=str;
	        }
	         else if(id.equalsIgnoreCase("domainMaxQuotaSize"))
	        {
	        dqt=str;
	        }
	     

	           //out.println("  <br> "+id + ":--- " +str);
	           }
	    }
	    //NoOfUser nof=new NoOfUser();
	}
	if(Long.parseLong(dqt)==0)
	{
		per=-1;
	}
	else
	{
	per=(Long.parseLong(cqt)*100)/(Long.parseLong(dqt));
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
	catch (Exception e) {
		// TODO: handle exception
	}
return per;	
}
}
