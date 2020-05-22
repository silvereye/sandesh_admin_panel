package mypack;
import java.util.*;

import javax.naming.*;
import javax.naming.directory.*;
import javax.naming.ldap.InitialLdapContext;
import javax.naming.ldap.LdapContext;

public class LDAPConnection {
	public static DirContext getConnection(String url,String base,String username,String password)
	{
		// String id="cn=admin,dc=silvereye,dc=in";//request.getParameter("id");
		   // String pass="redhat";
		    DirContext ctx=null;
		   // String url ="ldap://192.168.1.13:389";
		   //String base ="dc=silvereye,dc=in";
		    int f=0;
		    try
		    {
		    Hashtable env = new Hashtable();
		    env.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
		    env.put(Context.PROVIDER_URL, url); // LDAP host and base
		    env.put("java.naming.ldap.attributes.binary", "jpegPhoto");
		    // LDAP authentication options
		    env.put(Context.SECURITY_AUTHENTICATION, "simple");
		    env.put(Context.SECURITY_PRINCIPAL, username);
		    env.put(Context.SECURITY_CREDENTIALS, password);

		     ctx = new InitialDirContext(env);
		
		    }
		    catch(Exception e){System.out.print(e.toString());}
		    return ctx;
	}
	
	
	public static void closeConn(DirContext ctx)
	{
		
		    try
		    {
		   if(ctx!=null)
		     ctx.close();
		
		    }
		    catch(Exception e){e.printStackTrace();}
		 
	}
	
	
}