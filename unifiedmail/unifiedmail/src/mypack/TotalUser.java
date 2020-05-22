package mypack;

import java.util.Enumeration;

import javax.naming.NamingEnumeration;
import javax.naming.directory.Attribute;
import javax.naming.directory.Attributes;
import javax.naming.directory.DirContext;
import javax.naming.directory.SearchControls;
import javax.naming.directory.SearchResult;

public class TotalUser {

	public static int totUser(String url,String mbase,String base,String username,String password)
	{
		
		int tot=0;
		try
		{
		DirContext ctx=LDAPConnection.getConnection(url, base, username, password);

		SearchControls constraints = new SearchControls(); 
		constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
		String attrList[] = {"domainName"}; 
		constraints.setReturningAttributes(attrList);
		NamingEnumeration results =ctx.search(base,"domainName=*", constraints);
		int f=0;
		while (results.hasMore()) {
		f=1;
		    SearchResult si =(SearchResult)results.next();
		    String ck=si.getName();
		   System.out.println("<br><br><br>"+ck);
		    Attributes attrs = si.getAttributes();

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
		        int uno=Integer.parseInt(GetMValueAtt.getDomValueAtt(url,username,password,mbase,str,"domainCurrentUserNumber"));
		  		//out.print("<br>"+str+"----"+uno);
		  		tot=tot+uno;
		           //out.println("  <br> "+id + ":--- " +str);
		           }
		    }}
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
		
		return tot;
	}
}
