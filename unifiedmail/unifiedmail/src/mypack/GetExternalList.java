package mypack;

import java.util.Enumeration;

import javax.naming.NamingEnumeration;
import javax.naming.directory.Attribute;
import javax.naming.directory.Attributes;
import javax.naming.directory.DirContext;
import javax.naming.directory.SearchControls;
import javax.naming.directory.SearchResult;

public class GetExternalList {
	public static String getExternalList(String url,String username,String password,String base1,String dname,String att, String val)
	{
		String lst="";
		
	try
	{


	String base="ou=Externals,domainName="+dname+",o=domains,"+base1;//dc=springbirds,dc=co,dc=in";//"ou=Users,domainName="+arr_dm[i]+",o=domains"+(String)hs.getAttribute("base");
	DirContext ctx=LDAPConnection.getConnection(url, base, username, password);

	String v3="";

	SearchControls constraints = new SearchControls(); 
	constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
	String attrList[] = {"mail"}; 
	constraints.setReturningAttributes(attrList);
	NamingEnumeration results =ctx.search(base,att+"="+val, constraints);

	while (results.hasMore()) {

	SearchResult si =(SearchResult)results.next();
	String ck=si.getName();
	System.out.println("<br><br><br>"+ck);
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
	 if(id.equalsIgnoreCase("mail"))
	{
		 if(lst.equalsIgnoreCase(""))
			{
			lst=str;	
			}
			else
			{
				lst=lst+","+str;
			}
	}



	System.out.println("  <br> "+id + ":--- " +str);
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
	catch(Exception e){System.out.print(e);}
		return lst;
	}


}
