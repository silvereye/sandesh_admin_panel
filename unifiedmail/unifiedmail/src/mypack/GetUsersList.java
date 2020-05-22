package mypack;
import java.util.Enumeration;

import javax.naming.NamingEnumeration;
import javax.naming.directory.Attribute;
import javax.naming.directory.Attributes;
import javax.naming.directory.DirContext;
import javax.naming.directory.SearchControls;
import javax.naming.directory.SearchResult;
public class GetUsersList {
public static String getUsersList(String url,String username,String password,String base1,String dname,String att, String val)
{
	String lst="";
	
try
{


String base="ou=Users,domainName="+dname+",o=domains,"+base1;//dc=springbirds,dc=co,dc=in";//"ou=Users,domainName="+arr_dm[i]+",o=domains"+(String)hs.getAttribute("base");
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
v3=str;
}



System.out.println("  <br> "+id + ":--- " +str);
}
}

if(v3.indexOf("@")>0)
{
if(lst.equalsIgnoreCase(""))
{
lst=v3;	
}
else
{
	lst=lst+","+v3;
}
}
}
ctx.close();

}
catch(Exception e){System.out.print(e);}
	return lst;
}


public static String getUsersListNew(String url,String username,String password,String base1,String dname,String att, String val)
{
	String lst="";
	
try
{


String base="ou=Users,domainName="+dname+",o=domains,"+base1;//dc=springbirds,dc=co,dc=in";//"ou=Users,domainName="+arr_dm[i]+",o=domains"+(String)hs.getAttribute("base");
DirContext ctx=LDAPConnection.getConnection(url, base, username, password);

String v3="";
String nm="";
String acc="";
SearchControls constraints = new SearchControls(); 
constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
String attrList[] = {"mail","cn","accountStatus"}; 
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
v3=str;
}
 else if(id.equalsIgnoreCase("cn"))
 {
	 nm=str;
	 }
 else if(id.equalsIgnoreCase("accountStatus"))
 {
	 acc=str;
	 }

 
//System.out.println("  <br> "+id + ":--- " +str);
}
}

if(v3.indexOf("@")>0)
{
if(lst.equalsIgnoreCase(""))
{
lst=v3+"<#nps#>"+nm+"<#nps#>"+acc;	
}
else
{
	lst=lst+"<!nps!>"+v3+"<#nps#>"+nm+"<#nps#>"+acc;
}
}
}
ctx.close();

}
catch(Exception e){System.out.print(e);}
	return lst;
}




public static String getUsersListNewNp(String url,String username,String password,String base1,String dname,String att, String val)
{
	String lst="";
	
try
{


String base="ou=Users,domainName="+dname+",o=domains,"+base1;//dc=springbirds,dc=co,dc=in";//"ou=Users,domainName="+arr_dm[i]+",o=domains"+(String)hs.getAttribute("base");
DirContext ctx=LDAPConnection.getConnection(url, base, username, password);

String v3="";
String nm="";
String acc="";

SearchControls constraints = new SearchControls(); 
constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
String attrList[] = {"mail","cn","accountStatus","givenName","sn"}; 
constraints.setReturningAttributes(attrList);
NamingEnumeration results =ctx.search(base,att+"="+val, constraints);

while (results.hasMore()) {
	String fn="";
	String sn="";
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
v3=str;
}
 else if(id.equalsIgnoreCase("cn"))
 {
	 nm=str;
	 }
 else if(id.equalsIgnoreCase("accountStatus"))
 {
	 acc=str;
	 }
 else if(id.equalsIgnoreCase("givenName"))
 {
	 fn=str;
	 }
 else if(id.equalsIgnoreCase("sn"))
 {
	 sn=str;
	 }

 
//System.out.println("  <br> "+id + ":--- " +str);
}
}
if(fn.length()<=0)
{
	fn=" ";
}

if(v3.indexOf("@")>0)
{
if(lst.equalsIgnoreCase(""))
{
lst=v3+"<#nps#>"+nm+"<#nps#>"+acc+"<#nps#>"+fn+"<#nps#>"+sn;
}
else
{
	lst=lst+"<!nps!>"+v3+"<#nps#>"+nm+"<#nps#>"+acc+"<#nps#>"+fn+"<#nps#>"+sn;
}
}
}
ctx.close();

}
catch(Exception e){System.out.print(e);}
	return lst;
}



public static String getUsersListMem(String url,String username,String password,String base1,String dname,String att, String val,String ml)
{
	String mem="";
	
try
{


String base="ou=Users,domainName="+dname+",o=domains,"+base1;//dc=springbirds,dc=co,dc=in";//"ou=Users,domainName="+arr_dm[i]+",o=domains"+(String)hs.getAttribute("base");
DirContext ctx=LDAPConnection.getConnection(url, base, username, password);

String v3="";

SearchControls constraints = new SearchControls(); 
constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
String attrList[] = {"memberOfGroup"}; 
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
 if(id.equalsIgnoreCase("memberOfGroup"))
{
mem=mem+","+str;
}



System.out.println("  <br> "+id + ":--- " +str+"            mem="+mem);
}

}

}

ctx.close();
}
catch(Exception e){System.out.print(e);}

	return mem;

}





public static String getMailListMem(String url,String username,String password,String base1,String dname,String att, String val)
{
	String mem="";
	
try
{


String base="ou=Users,domainName="+dname+",o=domains,"+base1;//dc=springbirds,dc=co,dc=in";//"ou=Users,domainName="+arr_dm[i]+",o=domains"+(String)hs.getAttribute("base");
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
	 if(mem.equals(""))
	 {
		 mem=str;
	 }
	 else
	 {
		 mem=mem+","+str;	 
	 }

}



System.out.println("  <br> "+id + ":--- " +str+"            mem="+mem);
}

}

}

ctx.close();
}
catch(Exception e){System.out.print(e);}

	return mem;

}



}
