package mypack;

import java.util.Hashtable;

import javax.naming.Context;
import javax.naming.NamingException;
import javax.naming.directory.Attribute;
import javax.naming.directory.Attributes;
import javax.naming.directory.BasicAttribute;
import javax.naming.directory.BasicAttributes;
import javax.naming.directory.DirContext;
import javax.naming.directory.InitialDirContext;

public class SubDomain {
static void add(String ou,String username,String password,String url,String base )
{
	
	
	   
	 Hashtable env = new Hashtable();
		    
		   env.put(Context.INITIAL_CONTEXT_FACTORY,"com.sun.jndi.ldap.LdapCtxFactory");
		   env.put(Context.PROVIDER_URL, url); // LDAP host and base
		   env.put(Context.SECURITY_AUTHENTICATION, "simple");
		   env.put(Context.SECURITY_PRINCIPAL, username);
		   env.put(Context.SECURITY_CREDENTIALS, password);
		  
		  


		    DirContext ctx = null;

		    try {
		        // get a handle to an Initial DirContext
		      ctx = new InitialDirContext(env);
		    	
		        // build the entry
		        Attributes entry = new BasicAttributes();
		 
		       
		        
		        String entryDN ="ou="+ou+","+base;///"uid=amit,ou=Users,dc=silvereye,dc=in";
		            
		            Attribute oc = new BasicAttribute("objectClass");  
		            oc.add("organizationalUnit");
		            oc.add("top");
		           entry.put(oc);  
		           entry.put(new BasicAttribute("ou", ou));  
		            
		          // Add the entry
		           
		        ctx.createSubcontext(entryDN, entry);
		       System.out.println( "AddUser: added entry " + entryDN + ".");
		       try
		        {
		        	LDAPConnection.closeConn( ctx);
		        }
		        catch(Exception ec)
		        {
		        	ec.printStackTrace();
		        }
		       
		    } catch (NamingException e) {
		        System.out.println("AddUser: error adding entry." + e);
		    }
}
}
