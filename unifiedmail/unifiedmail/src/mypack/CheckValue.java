package mypack;

import java.util.Enumeration;

import javax.naming.NamingEnumeration;
import javax.naming.directory.Attribute;
import javax.naming.directory.Attributes;
import javax.naming.directory.DirContext;
import javax.naming.directory.SearchControls;
import javax.naming.directory.SearchResult;
import javax.servlet.http.HttpSession;

public class CheckValue {
public static int checkDomain(HttpSession hs,String dom)
{
	int f=0;
	  String username= (String)hs.getAttribute("id");
	  String password= (String)hs.getAttribute("password");
	  String url= (String)hs.getAttribute("url");
	  String mbase= (String)hs.getAttribute("base");
	  String base="o=domains,"+mbase;


	  try
	  {

	  DirContext ctx=LDAPConnection.getConnection(url, base, username, password);

	  SearchControls constraints = new SearchControls(); 
	  constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
	  String attrList[] = {"domainName"}; 
	  constraints.setReturningAttributes(attrList);
	  NamingEnumeration results =ctx.search(base,"domainName="+dom, constraints);

	  while (results.hasMore()) {
	  f=1;
	  break;

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
	  return f;
}







public static int checkUserMail(HttpSession hs,String dom, String mail)

{
	int f=0;


	String username= (String)hs.getAttribute("id");
	String password= (String)hs.getAttribute("password");
	String url= (String)hs.getAttribute("url");
	String mbase= (String)hs.getAttribute("base");
	String base="ou=Users,domainName="+dom+",o=domains,"+mbase;


	try
	{

	DirContext ctx=LDAPConnection.getConnection(url, base, username, password);

	SearchControls constraints = new SearchControls(); 
	constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
	String attrList[] = {"mail"}; 
	constraints.setReturningAttributes(attrList);
	NamingEnumeration results =ctx.search(base,"mail="+mail, constraints);

	while (results.hasMore()) {
	f=1;
	break;

	}

	System.out.print(""+f);

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



	 return f;

}








public static int valDomainAtt(HttpSession hs,String dom, String val)
{
	int qt=0;
	
	
	 String username= (String)hs.getAttribute("id");
     String password= (String)hs.getAttribute("password");
     String url= (String)hs.getAttribute("url");
     String mbase= (String)hs.getAttribute("base");
     
     String  base="o=domains,"+mbase;
     DirContext ctx = null;
     String dalias="";
	       
     try
{


ctx=LDAPConnection.getConnection(url, base, username, password);

SearchControls constraints = new SearchControls(); 
constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
String attrList[] = {val}; 
constraints.setReturningAttributes(attrList);
NamingEnumeration results =ctx.search(base,"domainName="+dom, constraints);
int f=0;
int x=0;
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
         if(id.equalsIgnoreCase(val))
        {
        qt=Integer.parseInt( str);
        }
        

           System.out.println(" dom <br> "+id + ":--- " +str);
           }
    }
    //NoOfUser nof=new NoOfUser();
 

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

     System.out.println("dalias       "+dalias);
     
     
	
	
	return qt;
}


public static Long valDomainAttLong(HttpSession hs,String dom, String val)
{
	Long qt=0l;
	
	
	 String username= (String)hs.getAttribute("id");
     String password= (String)hs.getAttribute("password");
     String url= (String)hs.getAttribute("url");
     String mbase= (String)hs.getAttribute("base");
     
     String  base="o=domains,"+mbase;
     DirContext ctx = null;
     String dalias="";
	       
     try
{


ctx=LDAPConnection.getConnection(url, base, username, password);

SearchControls constraints = new SearchControls(); 
constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
String attrList[] = {val}; 
constraints.setReturningAttributes(attrList);
NamingEnumeration results =ctx.search(base,"domainName="+dom, constraints);
int f=0;
int x=0;
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
         if(id.equalsIgnoreCase(val))
        {
        qt=Long.parseLong( str);
        }
        

           System.out.println(" dom <br> "+id + ":--- " +str);
           }
    }
    //NoOfUser nof=new NoOfUser();
 

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

     System.out.println("dalias       "+dalias);
     
     
	
	
	return qt;
}

	
}
