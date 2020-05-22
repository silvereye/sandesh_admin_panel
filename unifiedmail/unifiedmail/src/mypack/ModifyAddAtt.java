package mypack;

import java.util.Hashtable;

import javax.naming.Context;
import javax.naming.directory.Attribute;
import javax.naming.directory.BasicAttribute;
import javax.naming.directory.DirContext;
import javax.naming.directory.InitialDirContext;
import javax.naming.directory.ModificationItem;
import javax.servlet.http.HttpSession;

public class ModifyAddAtt {
	
	
	public static String modyfyAddAtt(HttpSession hs,String rdn,String rdnval,String dn, String ou,String att, String val)
	{
		 String username= (String)hs.getAttribute("id");
	        String password= (String)hs.getAttribute("password");
	        String url= (String)hs.getAttribute("url");
	        String base= (String)hs.getAttribute("base");
		
		 String INITCTX = "com.sun.jndi.ldap.LdapCtxFactory";

		   String MY_HOST =url;

		   String MGR_DN = username;

		   String MGR_PW = password;

		   String MY_SEARCHBASE = base;

		   String MY_ENTRY =rdn+"="+rdnval+",ou="+ou+",domainName="+dn+",o=domains,"+base;
		  
		   try
		   {
		   Hashtable<String, String> env = new Hashtable<String, String>();

		    env.put(Context.INITIAL_CONTEXT_FACTORY, INITCTX);

		    env.put(Context.PROVIDER_URL, MY_HOST);
		    env.put(Context.SECURITY_AUTHENTICATION, "simple");
		    env.put(Context.SECURITY_PRINCIPAL, MGR_DN);
		    env.put(Context.SECURITY_CREDENTIALS, MGR_PW);

		    DirContext ctx = new InitialDirContext(env);

		    ModificationItem[] mods = new ModificationItem[1];
		//Attribute mod1 = new BasicAttribute("FTP", "TRUE");
		  // Attribute mod1 = new BasicAttribute("phone", "555-555-5555");
		    Attribute mod0 = new BasicAttribute(att, val);

		    mods[0] = new ModificationItem(DirContext.ADD_ATTRIBUTE, mod0);
		   // mods[1] = new ModificationItem(DirContext.ADD_ATTRIBUTE, mod1);
		   //mods[1] = new ModificationItem(DirContext.REMOVE_ATTRIBUTE, mod1);
		    ctx.modifyAttributes(MY_ENTRY, mods);
		    ctx.close();
		   }
		   catch(Exception e1)
		   {
			  
			   System.out.print(e1.toString());
			   return e1.toString();   
		   }
		   return "SUCCESS";
	}

	
	
	
	
	
	public static String modyfyAddAtt(HttpSession hs,String mail,String dn, String ou,String att, String val)
	{
		 String username= (String)hs.getAttribute("id");
	        String password= (String)hs.getAttribute("password");
	        String url= (String)hs.getAttribute("url");
	        String base= (String)hs.getAttribute("base");
		
		 String INITCTX = "com.sun.jndi.ldap.LdapCtxFactory";

		   String MY_HOST =url;

		   String MGR_DN = username;

		   String MGR_PW = password;

		   String MY_SEARCHBASE = base;

		   String MY_ENTRY ="mail="+mail+",ou="+ou+",domainName="+dn+",o=domains,"+base;
		   
		   try
		   {
		   Hashtable<String, String> env = new Hashtable<String, String>();

		    env.put(Context.INITIAL_CONTEXT_FACTORY, INITCTX);

		    env.put(Context.PROVIDER_URL, MY_HOST);
		    env.put(Context.SECURITY_AUTHENTICATION, "simple");
		    env.put(Context.SECURITY_PRINCIPAL, MGR_DN);
		    env.put(Context.SECURITY_CREDENTIALS, MGR_PW);

		    DirContext ctx = new InitialDirContext(env);

		    ModificationItem[] mods = new ModificationItem[1];
		//Attribute mod1 = new BasicAttribute("FTP", "TRUE");
		  // Attribute mod1 = new BasicAttribute("phone", "555-555-5555");
		    Attribute mod0 = new BasicAttribute(att, val);

		    mods[0] = new ModificationItem(DirContext.ADD_ATTRIBUTE, mod0);
		   // mods[1] = new ModificationItem(DirContext.ADD_ATTRIBUTE, mod1);
		   //mods[1] = new ModificationItem(DirContext.REMOVE_ATTRIBUTE, mod1);
		    ctx.modifyAttributes(MY_ENTRY, mods);
		    ctx.close();
		   }
		   catch(Exception e1)
		   {
			  
			   System.out.print(e1.toString());
			   return e1.toString();   
		   }
		   return "SUCCESS";
	}

	
	
	public static String modyfyAddAtt(HttpSession hs,String mail,String dn, String att, String val)
	{
		 String username= (String)hs.getAttribute("id");
	        String password= (String)hs.getAttribute("password");
	        String url= (String)hs.getAttribute("url");
	        String base= (String)hs.getAttribute("base");
		
		 String INITCTX = "com.sun.jndi.ldap.LdapCtxFactory";

		   String MY_HOST =url;

		   String MGR_DN = username;

		   String MGR_PW = password;

		   String MY_SEARCHBASE = base;

		   String MY_ENTRY ="mail="+mail+",ou=Users,domainName="+dn+",o=domains,"+base;
		   
		   try
		   {
		   Hashtable<String, String> env = new Hashtable<String, String>();

		    env.put(Context.INITIAL_CONTEXT_FACTORY, INITCTX);

		    env.put(Context.PROVIDER_URL, MY_HOST);
		    env.put(Context.SECURITY_AUTHENTICATION, "simple");
		    env.put(Context.SECURITY_PRINCIPAL, MGR_DN);
		    env.put(Context.SECURITY_CREDENTIALS, MGR_PW);

		    DirContext ctx = new InitialDirContext(env);

		    ModificationItem[] mods = new ModificationItem[1];
		//Attribute mod1 = new BasicAttribute("FTP", "TRUE");
		  // Attribute mod1 = new BasicAttribute("phone", "555-555-5555");
		    Attribute mod0 = new BasicAttribute(att, val);

		    mods[0] = new ModificationItem(DirContext.ADD_ATTRIBUTE, mod0);
		   // mods[1] = new ModificationItem(DirContext.ADD_ATTRIBUTE, mod1);
		   //mods[1] = new ModificationItem(DirContext.REMOVE_ATTRIBUTE, mod1);
		    ctx.modifyAttributes(MY_ENTRY, mods);
		    ctx.close();
		   }
		   catch(Exception e1)
		   {
			  
			   System.out.print(e1.toString());
			   return e1.toString();   
		   }
		   return "SUCCESS";
	}


}
