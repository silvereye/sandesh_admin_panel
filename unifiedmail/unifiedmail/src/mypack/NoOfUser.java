package mypack;

import java.util.Enumeration;

import javax.naming.NamingEnumeration;
import javax.naming.directory.Attribute;
import javax.naming.directory.Attributes;
import javax.naming.directory.DirContext;
import javax.naming.directory.SearchControls;
import javax.naming.directory.SearchResult;

public class  NoOfUser {
	
	public static int domCount(String url,String username,String password,String base1)
	{int f=0;
		try
		{
		
			String base="o=domains,"+base1;//dc=springbirds,dc=co,dc=in";//"ou=Users,domainName="+arr_dm[i]+",o=domains"+(String)hs.getAttribute("base");
			DirContext ctx=LDAPConnection.getConnection(url, base, username, password);
			
			SearchControls constraints = new SearchControls(); 
			constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
			String attrList[] = {"domainName"}; 
			constraints.setReturningAttributes(attrList);
			NamingEnumeration results =ctx.search(base,"domainName=*", constraints);
					
			while (results.hasMore()) {
				results.next();
			f++;
			    
			}
			
			ctx.close();

		
		if(f==0)
		{
		System.out.print("Search not found");
		}

	}
		catch(Exception e)
		{System.out.print(e);
		}
		return f;
	}
	
public static int uCount(String url,String username,String password,String base1,String dname)
{int f=0;
	try
	{
	
		String base="ou=Users,domainName="+dname+",o=domains,"+base1;//dc=springbirds,dc=co,dc=in";//"ou=Users,domainName="+arr_dm[i]+",o=domains"+(String)hs.getAttribute("base");
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
	       
	        f++;
	       
	           //out.println("  <br> "+id + ":--- " +str);
	           }
	    }


	}
	if(f==0)
	{
	System.out.print("Search not found");
	}

}
	catch(Exception e)
	{System.out.print(e);
	}
	return f;
}







public static int aliasCount(String url,String username,String password,String base1,String dname)
{int f=0;
try
{

	String base="ou=Aliases,domainName="+dname+",o=domains,"+base1;//dc=springbirds,dc=co,dc=in";//"ou=Users,domainName="+arr_dm[i]+",o=domains"+(String)hs.getAttribute("base");
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
       
        f++;
       
           //out.println("  <br> "+id + ":--- " +str);
           }
    }


}
if(f==0)
{
System.out.print("Search not found");
}

}
catch(Exception e)
{System.out.print(e);
}
return f;
}





public static int listCount(String url,String username,String password,String base1,String dname)
{int f=0;
try
{

	String base="ou=Groups,domainName="+dname+",o=domains,"+base1;//dc=springbirds,dc=co,dc=in";//"ou=Users,domainName="+arr_dm[i]+",o=domains"+(String)hs.getAttribute("base");
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
       
        f++;
       
           //out.println("  <br> "+id + ":--- " +str);
           }
    }


}
if(f==0)
{
System.out.print("Search not found");
}

}
catch(Exception e)
{System.out.print(e);
}
return f;
}
}
