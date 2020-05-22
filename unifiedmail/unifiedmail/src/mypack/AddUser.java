package mypack;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.util.Enumeration;
import java.util.Hashtable;

import javax.naming.Context;
import javax.naming.NamingEnumeration;
import javax.naming.NamingException;
import javax.naming.directory.Attribute;
import javax.naming.directory.Attributes;
import javax.naming.directory.BasicAttribute;
import javax.naming.directory.BasicAttributes;
import javax.naming.directory.DirContext;
import javax.naming.directory.InitialDirContext;
import javax.naming.directory.SearchControls;
import javax.naming.directory.SearchResult;
import javax.servlet.http.HttpSession;

import dbutil.Crudoperation_Policy;

public class AddUser {
public static int addUser(HttpSession hs,String dm,String mail,String qt,String pass)
{
	
	int flg=0;
	
	String cuser="";
	String cqt="";
	String addqt="";
	String dn[]=mail.split("@");
	String ml=dn[0];
	String domain=dm;
//	String mail=ml+"@"+domain;
	//String pass=request.getParameter("np");
	String acc="active";
	String prelang="en_US";
	String cn=ml;
	String mq=qt;
	
	//mq=""+(Integer.parseInt(mq)*1024*1024);
	Long lqt=0l;
	
	lqt=(Long.parseLong(mq))*1024*1024;	
	addqt=mq;
	
	mq=""+lqt;
	String qftp="";
	 System.out.println("mail="+mail);
	 System.out.println("cn="+cn);
	 System.out.println("lang="+prelang);
	// System.out.println("ex="+exqt);
	    System.out.println("mq"+mq);
	    System.out.println("pass="+pass);
	    
	    
	    try
		{
		//pass=SHA256.encode(pass);
			pass=Encryption.puttySSHA512(pass);
		}
		catch (Exception e) {
			System.out.println(e);
		}
	    
	    
	   // HttpSession hs=request.getSession(false);
        String username= (String)hs.getAttribute("id");
        String password= (String)hs.getAttribute("password");
        String url= (String)hs.getAttribute("url");
        String mbase= (String)hs.getAttribute("base");
        
        String  base="o=domains,"+mbase;
        DirContext ctx = null;
        String dalias="";
        String basedir="";
        try
   {


  ctx=LDAPConnection.getConnection(url, base, username, password);

  SearchControls constraints = new SearchControls(); 
  constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
   String attrList[] = {"domainCurrentQuotaSize","domainCurrentUserNumber","domainBaseStorage","domainAliasName","domainDefaultFtpQuota"}; 
   constraints.setReturningAttributes(attrList);
   NamingEnumeration results =ctx.search(base,"domainName="+domain, constraints);
   int f=0;
   int x=0;
   while (results.hasMore()) {
   f=1;
       SearchResult si =(SearchResult)results.next();
       String ck=si.getName();
      System.out.println("<br><br><br>"+ck);
       Attributes attrs = si.getAttributes();

       if (attrs == null) {
       //   out.println("   No attributes");
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
            if(id.equalsIgnoreCase("domainCurrentQuotaSize"))
           {
           cqt=str;
           }
           else if(id.equalsIgnoreCase("domainCurrentUserNumber"))
           {
           cuser=str;
           }
           else if(id.equalsIgnoreCase("domainAliasName"))
           {
        	   if(dalias.equalsIgnoreCase(""))
        	   {
        		   dalias=str;
        	   }
        	   else
        	   {
        		   dalias=dalias+","+str;
        	   }
           //cuser=str;
           }
           else if(id.equalsIgnoreCase("domainBaseStorage"))
           {
           basedir=str;
           }
           else if(id.equalsIgnoreCase("domainDefaultFtpQuota"))
           {
           qftp=str;
           }

           

              System.out.println(" dom <br> "+id + ":--- " +str);
              }
       }
       //NoOfUser nof=new NoOfUser();
    

   }
   
   }
   catch(Exception e){System.out.print("<tr class='grey'><td></td><td>"+e+"</td></tr>");}

        System.out.println("dalias       "+dalias);
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
         base="ou=Users,domainName="+domain+",o=domains,"+mbase;
         String ftpdom=GetMValueAtt.getDomValueAtt(url,username,password,mbase,domain,"domainFTPStatus");
 Hashtable env = new Hashtable();
	    
	   env.put(Context.INITIAL_CONTEXT_FACTORY,"com.sun.jndi.ldap.LdapCtxFactory");
	   env.put(Context.PROVIDER_URL, url); // LDAP host and base
	   env.put(Context.SECURITY_AUTHENTICATION, "simple");
	   env.put(Context.SECURITY_PRINCIPAL, username);
	   env.put(Context.SECURITY_CREDENTIALS, password);
	  
	  
	//File   dir = new File("/mailstorage/domains/"+domain+"/users/"+ml+"/ftpdir" );
	    
	    // attempt to create the directory here
	 // boolean   successful = dir.mkdirs();
	  try {
	//  Process p = Runtime.getRuntime().exec("sudo chown -R vmail.vmail /maildir/domains/users/"+ml);
	   
		  Process p = Runtime.getRuntime().exec("sudo mkdir "+basedir+domain+"/users/"+ml);
		  
		   p = Runtime.getRuntime().exec("sudo chmod 770 -R  "+basedir+domain+"/users/"+ml);
			 p = Runtime.getRuntime().exec("sudo chown -R vmail.vmail "+basedir+domain+"/users/"+ml);
			   
		  
			 p = Runtime.getRuntime().exec("sudo mkdir "+basedir+domain+"/users/"+ml+"/ftpdir");
		  /*dir = new File(basedir+domain+"/users/"+ml+"/ftpdir" );
		  successful = dir.mkdir();*/
		 p = Runtime.getRuntime().exec("sudo chmod 770 -R  "+basedir+domain+"/users/"+ml+"/ftpdir");
		 p = Runtime.getRuntime().exec("sudo chown -R vmail.vmail "+basedir+domain+"/users/"+ml+"/ftpdir");
		  
	   
	   
	        // get a handle to an Initial DirContext
	      ctx = new InitialDirContext(env);
	    	
	        // build the entry
	        Attributes entry = new BasicAttributes();
	 
	       
	        
	        String entryDN ="mail="+mail+","+base;///"uid=amit,ou=Users,dc=silvereye,dc=in";
	            
	            Attribute oc = new BasicAttribute("objectClass");  
	            oc.add("amavisAccount");
	            oc.add("mailUser");
	            oc.add("shadowAccount");
	            oc.add("inetOrgPerson");
	            oc.add("top");
	            oc.add("PureFTPdUser");
	             
	            
	            entry.put(oc);  
	            Attribute oc1 = new BasicAttribute("enabledService");  
	            oc1.add("mail");
	            oc1.add("internal");
	            oc1.add("doveadm");
	            oc1.add("smtp");
	            oc1.add("smtpsecured");
	            oc1.add("pop3");
	            oc1.add("pop3secured");
	            oc1.add("imap");
	            oc1.add("imapsecured");
	            oc1.add("deliver");
	            oc1.add("lda");
	            oc1.add("forward");
	            oc1.add("senderbcc");
	            oc1.add("recipientbcc");
	            oc1.add("managesieve");
	            oc1.add("managesievesecured");
	            oc1.add("sieve");
	            oc1.add("sievesecured");
	            oc1.add("displayedInGlobalAddressBook");
	            oc1.add("shadowaddress");
	            oc1.add("lib-storage");
	            oc1.add("domainadmin");
	            oc1.add("lmtp");
	            oc1.add("chat");
	            oc1.add("indexer-worker");
	            entry.put(oc1);  
	            
	            entry.put(new BasicAttribute("uid", ml));  
	            entry.put( new BasicAttribute("cn", cn) );
	            entry.put( new BasicAttribute("sn", cn) );
	            entry.put( new BasicAttribute("givenName", cn) );
	            entry.put( new BasicAttribute( "userPassword",pass ) );
	            entry.put( new BasicAttribute("mail", mail ) );
	            entry.put( new BasicAttribute( "accountStatus",acc ) );
	            if(ftpdom!=null && ftpdom.equalsIgnoreCase("TRUE"))
	            {
	            entry.put( new BasicAttribute( "FTPStatus","enabled" ) );
	            }
	            else
	            {
	            	entry.put( new BasicAttribute( "FTPStatus","disabled" ) );	
	            }
				entry.put( new BasicAttribute( "FTPHomeDir","/maildir/domains/"+domain+"/users/"+ml+"/ftpdir" ) );
	            entry.put( new BasicAttribute( "mailQuota",mq ) );
			    entry.put( new BasicAttribute( "storageBaseDirectory","/maildir/domains/" ) );
			    entry.put( new BasicAttribute( "homeDirectory","/maildir/domains/"+domain+"/users/"+ml ) );
			   entry.put( new BasicAttribute( "mailMessageStore",domain+"/users/"+ml ) );
			   entry.put( new BasicAttribute( "preferredLanguage",prelang ) );
			   entry.put( new BasicAttribute( "forcePasswordChange","FALSE" ) );
			   entry.put( new BasicAttribute( "createprofile","TRUE" ) );
			   entry.put( new BasicAttribute( "FTPQuotaMBytes",qftp ) );
			   entry.put( new BasicAttribute( "FTPDownloadBandwidth", "1024" ) );
			   entry.put( new BasicAttribute( "FTPUploadBandwidth", "1024" ) );
			   entry.put( new BasicAttribute( "FTPDownloadRatio", "5" ) );
			   entry.put( new BasicAttribute( "FTPUploadRatio", "5" ) );
			   
			   if(dalias!=null && !(dalias.equals("")))
			   {
			   String arr_dl[]=dalias.split(",");
			   Attribute oc2 = new BasicAttribute("shadowAddress");  
			   for(int i=0;i<arr_dl.length;i++)
			   {
				   oc2.add(ml+"@"+arr_dl[i]);
				    
			   }
			   entry.put(oc2);  
			   }
	          // Add the entry
	        ctx.createSubcontext(entryDN, entry);
	    //   out.println( "AddUser: added entry " + entryDN + ".");
	        
	      
	       
	       cuser=""+(Integer.parseInt(cuser)+1); 
	    cqt=""+((Long.parseLong(cqt))+(Long.parseLong(addqt)));
	     
	    ModifyDomainAtt.modyfyAtt(hs, domain, "domainCurrentQuotaSize", cqt);
	    ModifyDomainAtt.modyfyAtt(hs, domain, "domainCurrentUserNumber", cuser);  
	    
	    
	    
	    
	    
	    
	    try
        {
        
            String loc="";
             
     try
               {
               FileInputStream in = new FileInputStream("/maildir/domains/welcomemail/content.html");
               BufferedReader br = new BufferedReader(new InputStreamReader(in));
               String strLine;
      
               // Read file line by line
               // Processing would be called here
               while((strLine = br.readLine())!= null)
               {
               loc=loc+strLine;
                System.out.println(strLine);
               }
      
               }catch(Exception e){
                System.out.println(e);
               }
               
               
               
               
         loc=loc.trim();
         if(loc!=null && !loc.equals(""))
         {
        	 loc=loc.replace("Username", cn);
        	 loc=loc.replace("id@domain.com", mail);
         }
         String sender="postmaster@";
	    String arr=mbase.replace("dc=","");
	    arr=arr.replace(",", ".");
	      // out.print("sender="+sender+base);
	    sender=sender+arr;
        WelcomeMail.send(sender,mail, "Silvereye Unified Messaging Server",loc);
       }
        catch (Exception e) {
		System.out.println(e);
        	// TODO: handle exception
		}
	    
	    try
        {
        	LDAPConnection.closeConn( ctx);
        }
        catch(Exception ec)
        {
        	ec.printStackTrace();
        }
	    

	    
	    /*********DB Policy *********/
        
  /*      String outnm=mail+" Outbound";
        String innm=mail+" Inbound";
        int fdb=Crudoperation_Policy.insertPolicy(outnm, "Outbound Policy for "+mail, 10);
        int fdb1=Crudoperation_Policy.insertPolicy(innm, "Inbound Policy for "+mail, 10);
        int fdb2=Crudoperation_Policy.insertPolicyGroups(mail);
        
       int pgid=Crudoperation_Policy.getPGID(mail);
       int fdb3=Crudoperation_Policy.insertPolicyGroupsMembers(mail, pgid);
       
       int inpid=Crudoperation_Policy.getPID(innm);
       String insou="!%internal_ips,!%"+mail;
       String indis="%"+mail;
       int fdb4=Crudoperation_Policy.insertPolicyMembers(inpid, insou, indis);
       
       int outpid=Crudoperation_Policy.getPID(outnm);
       String outsou="%internal_ips,%"+mail;
       String outdis="!%"+mail;
       int fdb5=Crudoperation_Policy.insertPolicyMembers(outpid, outsou, outdis);
	    */
	    
	   // response.sendRedirect("/unifiedmail/global/adduser.jsp?status=succ&nm="+mail);  
	    } catch (Exception e) {
	        System.out.println("AddUser: error adding entry." + e);
	       // response.sendRedirect("/unifiedmail/global/adduser.jsp?status=error");

	    }
	
	
	
	
	
	return flg;
}















public static int addUser(HttpSession hs,String dm,String ftn, String sn,String mail,String qt,String pass)
{
	
	int flg=0;
	int totno=0;
	
	String cuser="";
	String cqt="";
	String addqt="";
	String dn[]=mail.split("@");
	String ml=dn[0];
	String domain=dm;
//	String mail=ml+"@"+domain;
	//String pass=request.getParameter("np");
	String acc="active";
	String prelang="en_US";
	String cn=ftn+" "+sn;;
	String mq=qt;
	
	//mq=""+(Integer.parseInt(mq)*1024*1024);
	Long lqt=0l;
	
	lqt=(Long.parseLong(mq))*1024*1024;	
	addqt=mq;
	
	mq=""+lqt;
	String qftp="";
	 System.out.println("mail="+mail);
	 System.out.println("cn="+cn);
	 System.out.println("lang="+prelang);
	// System.out.println("ex="+exqt);
	    System.out.println("mq"+mq);
	    System.out.println("pass="+pass);
	    
	    
	    try
		{
		//pass=SHA256.encode(pass);
			pass=Encryption.puttySSHA512(pass);
		}
		catch (Exception e) {
			System.out.println(e);
		}
	    
	    
	   // HttpSession hs=request.getSession(false);
        String username= (String)hs.getAttribute("id");
        String password= (String)hs.getAttribute("password");
        String url= (String)hs.getAttribute("url");
        String mbase= (String)hs.getAttribute("base");
        
        String  base="o=domains,"+mbase;
        totno=TotalUser.totUser(url,mbase, base, username, password);
       /* if(totno>=500)
          {
        	return 1;
        }
        */
        DirContext ctx = null;
        String dalias="";
	       
        try
   {


  ctx=LDAPConnection.getConnection(url, base, username, password);

  SearchControls constraints = new SearchControls(); 
  constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
   String attrList[] = {"domainCurrentQuotaSize","domainCurrentUserNumber","domainAliasName","domainDefaultFtpQuota"}; 
   constraints.setReturningAttributes(attrList);
   NamingEnumeration results =ctx.search(base,"domainName="+domain, constraints);
   int f=0;
   int x=0;
   while (results.hasMore()) {
   f=1;
       SearchResult si =(SearchResult)results.next();
       String ck=si.getName();
      System.out.println("<br><br><br>"+ck);
       Attributes attrs = si.getAttributes();

       if (attrs == null) {
       //   out.println("   No attributes");
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
            if(id.equalsIgnoreCase("domainCurrentQuotaSize"))
           {
           cqt=str;
           }
           else if(id.equalsIgnoreCase("domainCurrentUserNumber"))
           {
           cuser=str;
           }
           else if(id.equalsIgnoreCase("domainAliasName"))
           {
        	   if(dalias.equalsIgnoreCase(""))
        	   {
        		   dalias=str;
        	   }
        	   else
        	   {
        		   dalias=dalias+","+str;
        	   }
           //cuser=str;
           }
           else if(id.equalsIgnoreCase("domainDefaultFtpQuota"))
           {
           qftp=str;
           }

           

              System.out.println(" dom <br> "+id + ":--- " +str);
              }
       }
       //NoOfUser nof=new NoOfUser();
    

   }
   
   }
   catch(Exception e){System.out.print("<tr class='grey'><td></td><td>"+e+"</td></tr>");}

        System.out.println("dalias       "+dalias);
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
         base="ou=Users,domainName="+domain+",o=domains,"+mbase;
	   
 Hashtable env = new Hashtable();
	    
	   env.put(Context.INITIAL_CONTEXT_FACTORY,"com.sun.jndi.ldap.LdapCtxFactory");
	   env.put(Context.PROVIDER_URL, url); // LDAP host and base
	   env.put(Context.SECURITY_AUTHENTICATION, "simple");
	   env.put(Context.SECURITY_PRINCIPAL, username);
	   env.put(Context.SECURITY_CREDENTIALS, password);
	  
	  
	File   dir = new File("/mailstorage/domains/"+domain+"/users/"+ml+"/ftpdir" );
	    
	    // attempt to create the directory here
	  boolean   successful = dir.mkdirs();
	  try {
	  Process p = Runtime.getRuntime().exec("sudo chown -R vmail.vmail /maildir/domains/users/"+ml);
	   
		 
	   
	   
	        // get a handle to an Initial DirContext
	      ctx = new InitialDirContext(env);
	    	
	        // build the entry
	        Attributes entry = new BasicAttributes();
	 
	       
	        
	        String entryDN ="mail="+mail+","+base;///"uid=amit,ou=Users,dc=silvereye,dc=in";
	            
	            Attribute oc = new BasicAttribute("objectClass");  
	            oc.add("amavisAccount");
	            oc.add("mailUser");
	            oc.add("shadowAccount");
	            oc.add("inetOrgPerson");
	            oc.add("top");
	            oc.add("PureFTPdUser");
	             
	            
	            entry.put(oc);  
	            Attribute oc1 = new BasicAttribute("enabledService");  
	            oc1.add("mail");
	            oc1.add("internal");
	            oc1.add("doveadm");
	            oc1.add("smtp");
	            oc1.add("smtpsecured");
	            oc1.add("pop3");
	            oc1.add("pop3secured");
	            oc1.add("imap");
	            oc1.add("imapsecured");
	            oc1.add("deliver");
	            oc1.add("lda");
	            oc1.add("forward");
	            oc1.add("senderbcc");
	            oc1.add("recipientbcc");
	            oc1.add("managesieve");
	            oc1.add("managesievesecured");
	            oc1.add("sieve");
	            oc1.add("sievesecured");
	            oc1.add("displayedInGlobalAddressBook");
	            oc1.add("shadowaddress");
	            oc1.add("lib-storage");
	            oc1.add("domainadmin");
	            oc1.add("lmtp");
	            oc1.add("chat");
	            oc1.add("indexer-worker");
	            entry.put(oc1);  
	            
	            entry.put(new BasicAttribute("uid", ml));  
	            entry.put( new BasicAttribute("cn", cn) );
	            entry.put( new BasicAttribute("sn", sn) );
	            entry.put( new BasicAttribute("givenName", ftn) );
	            entry.put( new BasicAttribute( "userPassword",pass ) );
	            entry.put( new BasicAttribute("mail", mail ) );
	            entry.put( new BasicAttribute( "accountStatus",acc ) );
				entry.put( new BasicAttribute( "FTPStatus","enabled" ) );
				entry.put( new BasicAttribute( "FTPHomeDir","/maildir/domains/"+domain+"/users/"+ml+"/ftpdir" ) );
	            entry.put( new BasicAttribute( "mailQuota",mq ) );
			    entry.put( new BasicAttribute( "storageBaseDirectory","/maildir/domains/" ) );
			    entry.put( new BasicAttribute( "homeDirectory","/maildir/domains/"+domain+"/users/"+ml ) );
			   entry.put( new BasicAttribute( "mailMessageStore",domain+"/users/"+ml ) );
			   entry.put( new BasicAttribute( "preferredLanguage",prelang ) );
			   entry.put( new BasicAttribute( "forcePasswordChange","FALSE" ) );
			   entry.put( new BasicAttribute( "createprofile","TRUE" ) );
			   entry.put( new BasicAttribute( "FTPQuotaMBytes",qftp ) );
			   entry.put( new BasicAttribute( "FTPDownloadBandwidth", "1024" ) );
			   entry.put( new BasicAttribute( "FTPUploadBandwidth", "1024" ) );
			   entry.put( new BasicAttribute( "FTPDownloadRatio", "5" ) );
			   entry.put( new BasicAttribute( "FTPUploadRatio", "5" ) );
			   
			   if(dalias!=null && !(dalias.equals("")))
			   {
			   String arr_dl[]=dalias.split(",");
			   Attribute oc2 = new BasicAttribute("shadowAddress");  
			   for(int i=0;i<arr_dl.length;i++)
			   {
				   oc2.add(ml+"@"+arr_dl[i]);
				    
			   }
			   entry.put(oc2);  
			   }
	          // Add the entry
	        ctx.createSubcontext(entryDN, entry);
	    //   out.println( "AddUser: added entry " + entryDN + ".");
	        
	      
	       
	       cuser=""+(Integer.parseInt(cuser)+1); 
	    cqt=""+((Long.parseLong(cqt))+(Long.parseLong(addqt)));
	     
	    ModifyDomainAtt.modyfyAtt(hs, domain, "domainCurrentQuotaSize", cqt);
	    ModifyDomainAtt.modyfyAtt(hs, domain, "domainCurrentUserNumber", cuser);  
	    
	    
	    
	    
	    try
        {
        
            String loc="";
             
     try
               {
               FileInputStream in = new FileInputStream("/maildir/domains/welcomemail/content.html");
               BufferedReader br = new BufferedReader(new InputStreamReader(in));
               String strLine;
      
               // Read file line by line
               // Processing would be called here
               while((strLine = br.readLine())!= null)
               {
               loc=loc+strLine;
                System.out.println(strLine);
               }
      
               }catch(Exception e){
                System.out.println(e);
               }
               
               
               
               
         loc=loc.trim();
         if(loc!=null && !loc.equals(""))
         {
        	 loc=loc.replace("Username", cn);
        	 loc=loc.replace("id@domain.com", mail);
         }
         String sender="postmaster@";
	       String arr=mbase.replace("dc=","");
	       arr=arr.replace(",", ".");
	      // out.print("sender="+sender+base);
	       sender=sender+arr;
        WelcomeMail.send(sender,mail, "Welcome "+cn,loc);
       }
        catch (Exception e) {
		System.out.println(e);
        	// TODO: handle exception
		}
	    
	    
	    
	    

	    
	    /*********DB Policy *********/
        
        String outnm=mail+" Outbound";
        String innm=mail+" Inbound";
        int fdb=Crudoperation_Policy.insertPolicy(outnm, "Outbound Policy for "+mail, 10);
        int fdb1=Crudoperation_Policy.insertPolicy(innm, "Inbound Policy for "+mail, 10);
        int fdb2=Crudoperation_Policy.insertPolicyGroups(mail);
        
       int pgid=Crudoperation_Policy.getPGID(mail);
       int fdb3=Crudoperation_Policy.insertPolicyGroupsMembers(mail, pgid);
       
       int inpid=Crudoperation_Policy.getPID(innm);
       String insou="!%internal_ips,!%"+mail;
       String indis="%"+mail;
       int fdb4=Crudoperation_Policy.insertPolicyMembers(inpid, insou, indis);
       
       int outpid=Crudoperation_Policy.getPID(outnm);
       String outsou="%internal_ips,%"+mail;
       String outdis="!%"+mail;
       int fdb5=Crudoperation_Policy.insertPolicyMembers(outpid, outsou, outdis);
	    
	    
	   // response.sendRedirect("/unifiedmail/global/adduser.jsp?status=succ&nm="+mail);  
	    } catch (Exception e) {
	        System.out.println("AddUser: error adding entry." + e);
	       // response.sendRedirect("/unifiedmail/global/adduser.jsp?status=error");

	    }
	
	
	  try
      {
      	LDAPConnection.closeConn( ctx);
      }
      catch(Exception ec)
      {
      	ec.printStackTrace();
      }
	
	
	return flg;
}
	
}
