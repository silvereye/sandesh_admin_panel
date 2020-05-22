package mypack;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.Hashtable;

import javax.mail.MessagingException;
import javax.naming.Context;
import javax.naming.NamingException;
import javax.naming.directory.Attribute;
import javax.naming.directory.Attributes;
import javax.naming.directory.BasicAttribute;
import javax.naming.directory.BasicAttributes;
import javax.naming.directory.DirContext;
import javax.naming.directory.InitialDirContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbutil.Crudoperation;
import dbutil.Crudoperation_Policy;

public class AddDomainServlet extends HttpServlet {

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out
				.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<HTML>");
		out.println("  <HEAD><TITLE>A Servlet</TITLE></HEAD>");
		out.println("  <BODY>");
		out.print("    This is ");
		out.print(this.getClass());
		out.println(", using the GET method");
		out.println("  </BODY>");
		out.println("</HTML>");
		out.flush();
		out.close();
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		String mq=request.getParameter("mq");
		String cn=request.getParameter("cn");
		String dn=request.getParameter("dn");
		String prelang=request.getParameter("prelang");
		String post_pass=request.getParameter("post_pass");
		String admin_pass=request.getParameter("admin_pass");
		String ftpdom=request.getParameter("ftpdom");
		System.out.println("postmaster pass:-------------"+post_pass);
		
		try
		{
		//pass=SHA256.encode(pass);  post_pass=Encryption.puttySSHA512(post_pass);
			post_pass=Encryption.puttySSHA512(post_pass);
		}
		catch (Exception e) {
			out.println(e);
		}
		
		
		try
		{
		//pass=SHA256.encode(pass); 
			admin_pass=Encryption.puttySSHA512(admin_pass);
		}
		catch (Exception e) {
			System.out.println(e);
		}
		
		
		
		String dirbase=request.getParameter("dir");
		long ql=Long.parseLong(mq);
		mq=""+(ql*1024);
		
		
		    System.out.println("cn"+cn);
		    System.out.println("mq"+mq);
	
		
		  HttpSession hs=request.getSession(false);
	        String username= (String)hs.getAttribute("id");
	        String password= (String)hs.getAttribute("password");
	        String url= (String)hs.getAttribute("url");
	        String mbase= (String)hs.getAttribute("base");
	        String ip= (String)hs.getAttribute("ip");
	        String base="o=domains,"+mbase;
		   
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
		 
		       
		        
		        String entryDN ="domainName="+dn+","+base;///"uid=amit,ou=Users,dc=silvereye,dc=in";
		            
		            Attribute oc = new BasicAttribute("objectClass");  
		            oc.add("mailDomain");
		           entry.put(oc);  
		            Attribute oc1 = new BasicAttribute("enabledService");  
		            oc1.add("mail");
		            oc1.add("senderbcc");
		            oc1.add("recipientbcc");
		            entry.put(oc1);  
		            entry.put(new BasicAttribute("domainName", dn));  
		            entry.put( new BasicAttribute("cn", cn ) );
		           entry.put( new BasicAttribute( "accountStatus","active" ) );
		            entry.put( new BasicAttribute( "domainMaxQuotaSize",mq ) );
		            entry.put( new BasicAttribute( "domainCurrentAliasNumber","0" ) );
		            entry.put( new BasicAttribute( "domainCurrentListNumber","0" ) );
		            entry.put( new BasicAttribute( "domainCurrentUserNumber","1" ) );
		            entry.put( new BasicAttribute( "domainCurrentQuotaSize","1024" ) );
		            entry.put( new BasicAttribute( "domainMaxAliasNumber","20" ) );
		            entry.put( new BasicAttribute( "domainMaxListNumber","20" ) );
		            entry.put( new BasicAttribute( "domainMaxUserNumber","50" ) );
		            entry.put( new BasicAttribute( "domainDefaultUserQuota","1024" ) );
		            entry.put( new BasicAttribute( "domainDefaultFtpQuota","10" ) );
		            entry.put( new BasicAttribute( "preferredLanguage", prelang ) );
		            entry.put( new BasicAttribute( "domainBaseStorage", dirbase ) );
		            entry.put( new BasicAttribute( "mtaTransport", "lmtp:127.0.0.1:7025" ) );
		            if(ftpdom!=null && ftpdom.equalsIgnoreCase("TRUE"))
		            {
		            	entry.put( new BasicAttribute( "domainFTPStatus", "TRUE" ) );
		            }
		          // Add the entry
		        ctx.createSubcontext(entryDN, entry);
		       out.println( "AddUser: added entry " + entryDN + ".");
		        
		       base=entryDN;
		       SubDomain.add("Aliases", username, password, url, base);
		       SubDomain.add("Externals", username, password, url, base);
		       SubDomain.add("Groups", username, password, url, base);
		       SubDomain.add("Users", username, password, url, base);
		       base="ou=Users,"+entryDN;
		       
		       
		       
		       
		     
					        // get a handle to an Initial DirContext
			      ctx = new InitialDirContext(env);
			    	
			        // build the entry
			      Attributes  entry1 = new BasicAttributes();
			 
			       
			        
			         entryDN ="mail=@"+dn+","+base;///"uid=amit,ou=Users,dc=silvereye,dc=in";
			            
			            Attribute ocn = new BasicAttribute("objectClass");  
			            ocn.add("inetOrgPerson");
			           	ocn.add("mailUser");
			            ocn.add("top");
			           
			            entry1.put(ocn);  
			            entry1.put(new BasicAttribute("uid", "catch-all-"+dn));  
			            entry1.put( new BasicAttribute("cn", "catch-all") );
			            entry1.put( new BasicAttribute("sn", "catch-all" ) );
			            entry1.put( new BasicAttribute("givenName", "catch-all" ) );
			            entry1.put( new BasicAttribute("mail", "@"+dn ) );
			            entry1.put( new BasicAttribute( "accountStatus","active" ) );
			           			          // Add the entry
			        ctx.createSubcontext(entryDN, entry1);
			       out.println( "AddUser: added entry " + entryDN + ".");
			        
			      /* File dir = new File(dirbase+dn+"/users");
				    
				    // attempt to create the directory here
				    boolean successful = dir.mkdirs();*/
			       
				    Process p = Runtime.getRuntime().exec("sudo mkdir "+dirbase+dn+"/users");
				    
				    p = Runtime.getRuntime().exec("sudo mkdir "+dirbase+dn+"/deleted");
			       
				    p = Runtime.getRuntime().exec("sudo mkdir "+dirbase+dn+"/users/postmaster");
				    p = Runtime.getRuntime().exec("sudo mkdir "+dirbase+dn+"/users/postmaster/ftpdir");
				    
				   /* dir = new File(dirbase+dn+"/users/postmaster/ftpdir");
				    
				    // attempt to create the directory here
				     successful = dir.mkdirs();*/
				      p = Runtime.getRuntime().exec("sudo chown -R vmail.vmail "+dirbase+dn);
				     p = Runtime.getRuntime().exec("sudo chmod 770 -R "+dirbase+dn);
				    /* dir = new File("/mailstorage/domains/"+dn+"/users/postmaster@"+dn);
					    
					    // attempt to create the directory here
					     successful = dir.mkdirs();
			       
			       */
				     ctx = new InitialDirContext(env);
			    	
			        // build the entry
			        entry = new BasicAttributes();
			 
			       
			        
			        entryDN ="mail=postmaster@"+dn+","+base;///"uid=amit,ou=Users,dc=silvereye,dc=in";
			            
			            Attribute oc11 = new BasicAttribute("objectClass");  
			            oc11.add("amavisAccount");
			            oc11.add("mailUser");
			            oc11.add("shadowAccount");
			            oc11.add("inetOrgPerson");
			            oc11.add("top");
			            oc11.add("PureFTPdUser");
			             
			            
			            entry.put(oc11);  
			            Attribute oc12 = new BasicAttribute("enabledService");  
			            oc12.add("mail");
			            oc12.add("internal");
			            oc12.add("doveadm");
			            oc12.add("smtp");
			            oc12.add("smtpsecured");
			            oc12.add("pop3");
			            oc12.add("pop3secured");
			            oc12.add("imap");
			            oc12.add("imapsecured");
			            oc12.add("deliver");
			            oc12.add("lda");
			            oc12.add("forward");
			            oc12.add("senderbcc");
			            oc12.add("recipientbcc");
			            oc12.add("managesieve");
			            oc12.add("managesievesecured");
			            oc12.add("sieve");
			            oc12.add("sievesecured");
			            oc12.add("displayedInGlobalAddressBook");
			            oc12.add("shadowaddress");
			            oc12.add("lib-storage");
			            oc12.add("domainadmin");
			            oc12.add("lmtp");
			            oc12.add("chat");
			            oc12.add("indexer-worker");
			            entry.put(oc12);  
			            
			            entry.put(new BasicAttribute("uid", "postmaster"));  
			            entry.put( new BasicAttribute("cn", "postmaster") );
			            entry.put( new BasicAttribute("sn", "postmaster") );
			            entry.put( new BasicAttribute("givenName", "postmaster") );
			            entry.put( new BasicAttribute( "userPassword",post_pass ) );
			            entry.put( new BasicAttribute("mail", "postmaster@"+dn ) );
			            entry.put( new BasicAttribute( "accountStatus","active" ) );
			            if(ftpdom!=null && ftpdom.equalsIgnoreCase("TRUE"))
			            {
						entry.put( new BasicAttribute( "FTPStatus","enabled" ) );
			            }
			            else
			            {
			            entry.put( new BasicAttribute( "FTPStatus","disabled" ) );	
			            }
						entry.put( new BasicAttribute( "FTPHomeDir",dirbase+dn+"/users/postmaster/ftpdir" ) );
			            entry.put( new BasicAttribute( "mailQuota","1073741824" ) );
					    entry.put( new BasicAttribute( "storageBaseDirectory",dirbase ) );
					    entry.put( new BasicAttribute( "homeDirectory",dirbase+dn+"/users/postmaster") );
					   entry.put( new BasicAttribute( "mailMessageStore",dn+"/users/postmaster" ) );
					   entry.put( new BasicAttribute( "preferredLanguage",prelang ) );
					   entry.put( new BasicAttribute( "domainGlobalAdmin", "yes" ) );
					   entry.put( new BasicAttribute( "forcePasswordChange","FALSE" ) );
					   entry.put( new BasicAttribute( "createprofile","TRUE" ) );
					   entry.put( new BasicAttribute( "FTPQuotaMBytes", "50" ) );
					   entry.put( new BasicAttribute( "FTPDownloadBandwidth", "1024" ) );
					   entry.put( new BasicAttribute( "FTPUploadBandwidth", "1024" ) );
					   entry.put( new BasicAttribute( "FTPDownloadRatio", "5" ) );
					   entry.put( new BasicAttribute( "FTPUploadRatio", "5" ) );
					  
			          // Add the entry
			        ctx.createSubcontext(entryDN, entry);
			       
			        /********* domain admin*********/
			        
			        
			        
			        try		     
			        {
			        env = new Hashtable();
			        		    
			        		   env.put(Context.INITIAL_CONTEXT_FACTORY,"com.sun.jndi.ldap.LdapCtxFactory");
			        		   env.put(Context.PROVIDER_URL, url); // LDAP host and base
			        		   env.put(Context.SECURITY_AUTHENTICATION, "simple");
			        		   env.put(Context.SECURITY_PRINCIPAL, username);
			        		   env.put(Context.SECURITY_CREDENTIALS, password);

			         ctx = new InitialDirContext(env);
			        		    	
			        		        // build the entry
			        		         entry = new BasicAttributes();
			        		 
			        		       
			        		        
			        		        entryDN ="mail=mail-admin@"+dn+",o=domainAdmins,"+mbase;///"uid=amit,ou=Users,dc=silvereye,dc=in";
			        		            
			        		           oc = new BasicAttribute("objectClass");  
			        		           oc.add("mailUser");
			        		           oc.add("inetOrgPerson");
			        		           oc.add("top");
			        		           
			        		             
			        		            
			        		            entry.put(oc);  
			        		           
			        		            entry.put(new BasicAttribute("uid", "mail-admin"+dn));  
			        		            entry.put( new BasicAttribute("cn", "Admin of "+dn) );
			        		            entry.put( new BasicAttribute("sn", "admin") );
			        		            entry.put( new BasicAttribute("givenName", "domain") );
			        		            entry.put( new BasicAttribute( "userPassword",admin_pass ) );
			        		            entry.put( new BasicAttribute("mail", "mail-admin@"+dn ) );
			        		            entry.put( new BasicAttribute( "accountStatus","active" ) );
			        					
			        		          // Add the entry
			        		        ctx.createSubcontext(entryDN, entry);
			        		       System.out.println( "AddUser: added entry " + entryDN + ".");
			        }
			        catch(Exception e){System.out.print(e);

			        }
			        
			        
			        
			        
			        
			        
			        /*********DB Policy for domain *********/
			    /*    if(true)
			        {
			        String outnm=dn+" Outbound";
			        String innm=dn+" Inbound";
			        int fdb=Crudoperation_Policy.insertPolicy(outnm, "Outbound Policy for "+dn, 20);
			        int fdb1=Crudoperation_Policy.insertPolicy(innm, "Inbound Policy for "+dn, 20);
			        int fdb2=Crudoperation_Policy.insertPolicyGroups(dn);
			        
			       int pgid=Crudoperation_Policy.getPGID(dn);
			       int fdb3=Crudoperation_Policy.insertPolicyGroupsMembers("@"+dn, pgid);
			       
			       int inpid=Crudoperation_Policy.getPID(innm);
			       String insou="!%internal_ips,!%"+dn;
			       String indis="%"+dn;
			       int fdb4=Crudoperation_Policy.insertPolicyMembers(inpid, insou, indis);
			       
			       int outpid=Crudoperation_Policy.getPID(outnm);
			       String outsou="%internal_ips,%"+dn;
			       String outdis="!%"+dn;
			       int fdb5=Crudoperation_Policy.insertPolicyMembers(outpid, outsou, outdis);
			        }
			        */
			        
			        
			        /*********DB Policy for postmaster *********/
			     /*   if(true)
			        {
			        String outnm="postmaster@"+dn+" Outbound";
			        String innm="postmaster@"+dn+" Inbound";
			        int fdb=Crudoperation_Policy.insertPolicy(outnm, "Outbound Policy for "+"postmaster@"+dn, 10);
			        int fdb1=Crudoperation_Policy.insertPolicy(innm, "Inbound Policy for "+"postmaster@"+dn, 10);
			        int fdb2=Crudoperation_Policy.insertPolicyGroups("postmaster@"+dn);
			        
			       int pgid=Crudoperation_Policy.getPGID("postmaster@"+dn);
			       int fdb3=Crudoperation_Policy.insertPolicyGroupsMembers("postmaster@"+dn, pgid);
			       
			       int inpid=Crudoperation_Policy.getPID(innm);
			       String insou="!%internal_ips,!%"+"postmaster@"+dn;
			       String indis="%"+"postmaster@"+dn;
			       int fdb4=Crudoperation_Policy.insertPolicyMembers(inpid, insou, indis);
			       
			       int outpid=Crudoperation_Policy.getPID(outnm);
			       String outsou="%internal_ips,%"+"postmaster@"+dn;
			       String outdis="!%"+"postmaster@"+dn;
			       int fdb5=Crudoperation_Policy.insertPolicyMembers(outpid, outsou, outdis);
			        }*/
			        
			        
			     
			        
			        
			        String sql="insert into log (ip,name,domain,msg) values(?,?,?,?)";
			        String data=ip+","+"Global Admin"+","+dn+",Add Domain: "+dn;
			        int mg=Crudoperation.insertlog(sql, data);
			        
			        
			        
			        /*** welcome mail ***/
			        
			        
			        
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
				               
				               
				               
				             String rec_mail=  "postmaster@"+dn;
				         loc=loc.trim();
				         if(loc!=null && !loc.equals(""))
				         {
				        	 loc=loc.replace("Username", "Postmaster");
				        	 loc=loc.replace("id@domain.com", rec_mail);
				         }
				         String sender="postmaster@";
					       String arr=mbase.replace("dc=","");
					       arr=arr.replace(",", ".");
					      // out.print("sender="+sender+base);
					       sender=sender+arr;
				        WelcomeMail.send(sender,rec_mail, "Silvereye Unified Messaging Server",loc);
			        
			        
			        try
			        {
			        	LDAPConnection.closeConn( ctx);
			        }
			        catch(Exception ec)
			        {
			        	ec.printStackTrace();
			        }
		       response.sendRedirect("/unifiedmail/global/adddomain.jsp?status=succ&nm="+dn);
		     
		    } catch (NamingException e) {
		    	System.out.println(e);
		    	response.sendRedirect("/unifiedmail/global/adddomain.jsp?status=error");
		    } catch (MessagingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		out.flush();
		out.close();
	}

}
