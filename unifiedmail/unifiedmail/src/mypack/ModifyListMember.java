package mypack;

import java.util.Hashtable;

import javax.naming.Context;
import javax.naming.directory.Attribute;
import javax.naming.directory.BasicAttribute;
import javax.naming.directory.DirContext;
import javax.naming.directory.InitialDirContext;
import javax.naming.directory.ModificationItem;
import javax.servlet.http.HttpSession;

public class ModifyListMember {

	public static String modyfyAddMemInList(HttpSession hs,String dn, String mlist, String ml)
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

		   String MY_ENTRY ="mail="+ml+",ou=Groups,domainName="+dn+",o=domains,"+base;
		  //mail=support@silvereye.in,ou=Groups,domainName=silvereye.in,o=domains,dc=silvereye,dc=in
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
		    Attribute mod0 = new BasicAttribute("member");
		    try
		    {
		    mods[0] = new ModificationItem(DirContext.REMOVE_ATTRIBUTE, mod0);
		    ctx.modifyAttributes(MY_ENTRY, mods);
		    }
		    catch(Exception e1)
		    {
		    	e1.printStackTrace();
		    }
		
		    String arr[]=mlist.split(",");
		   for(int i=0;i< arr.length;i++)
		   {
			   if(arr[i]!=null && !(arr[i].equals("")))
			   {
				   String udn="mail="+arr[i]+",ou=Users,domainName="+dn+",o=domains,"+base;
				   mods = new ModificationItem[1];
				    mod0 = new BasicAttribute("member",udn);
				    mods[0] = new ModificationItem(DirContext.ADD_ATTRIBUTE, mod0);
				    ctx.modifyAttributes(MY_ENTRY, mods);
			   }
		   }
		    
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
