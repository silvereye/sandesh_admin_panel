package mypack;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.naming.NamingEnumeration;
import javax.naming.NamingException;
import javax.naming.directory.Attribute;
import javax.naming.directory.Attributes;
import javax.naming.directory.DirContext;
import javax.naming.directory.SearchControls;
import javax.naming.directory.SearchResult;

public class Temp {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		 String base ="dc=silvereye,dc=in";
		 String url ="ldap://mail.silvereye.in:389";

		 String password ="??HpDell??##9898";
		String username="cn=admin,"+base;
		//base="o=domains,"+base;
		DirContext ctx=LDAPConnection.getConnection(url, base, username, password);
		String entry="mail=nirbhay@silvereye.in,ou=Users,domainName=silvereye.in,o=domains,"+base;
		 Attributes testAttributes;
		try {
			testAttributes = ctx.getAttributes(entry);
		
	     Attribute jpegPhoto1 = testAttributes.get("jpegPhoto");
	     byte[] jpegBytes1 = (byte[]) jpegPhoto1.get();
	   String  photo = new sun.misc.BASE64Encoder().encode(jpegBytes1);
	   
	   jpegPhoto1 = testAttributes.get("postalAddress");
		  String adr =jpegPhoto1.get().toString();
	   jpegPhoto1 = testAttributes.get("enabledService");
	 String [] arr =(String[])jpegPhoto1.get();
	   ctx.close();
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	   // String base="o=domains,"+mbase;
        String acc="";
       // hs.setAttribute("user_domain",dn);
/*String cn="";
String des="";
String photo="";
     String dn="silvereye.in" ;  
try
{


DirContext ctx=LDAPConnection.getConnection(url, base, username, password);
SearchControls constraints = new SearchControls(); 
constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
String attrList[] = {"domainName","cn","accountStatus","domainCurrentQuotaSize","domainCurrentAliasNumber","domainCurrentListNumber","domainCurrentUserNumber","domainMaxQuotaSize"}; 
constraints.setReturningAttributes(attrList);
NamingEnumeration results =ctx.search(base,"domainName=*", constraints);
int f=0;
int x=0;

while (results.hasMore()) {
	results.next();
f++;
    
}
System.out.print(f);
ctx.close();
}
catch(Exception e){System.out.print("<tr class='grey'><td></td><td>"+e+"</td></tr>");}
	}*/
	
}
