package mypack;

import java.io.*;
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
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbutil.Crudoperation;
import dbutil.Crudoperation_Policy;

public class AddUserServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public AddUserServlet() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

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
		String str=request.getParameter("cn");
		out.print(str);
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
		String init=request.getParameter("init");
		String chk=request.getParameter("hid_chk");
		String domain=request.getParameter("domain").trim();
		if(chk.equalsIgnoreCase("true"))
		{
		String basedir="";
		String cuser="";
		String cqt="";
		String addqt="";
		String qtdir="";
		String ml=request.getParameter("mail").trim();
		
		String mail=ml+"@"+domain;
		String pass=request.getParameter("np");
		String acc=request.getParameter("acc");
		String prelang=request.getParameter("prelang");
		String fn=request.getParameter("fn");
		String ln=request.getParameter("sn");
		String cn=request.getParameter("cn");
		String mq=request.getParameter("mq");
		String fpc_arr[]=request.getParameterValues("fpc");
		String edt=request.getParameter("edt");
		
		String fpc="FALSE";
		if(fpc_arr!=null && fpc_arr.length>0)
			fpc="TRUE";
		else
			fpc="FALSE";
		try
		{
		//pass=SHA256.encode(pass);
			pass=Encryption.puttySSHA512(pass);
			
		}
		catch (Exception e) {
			System.out.println(e);
		}
		//String qt[]=request.getParameterValues("qt");
		//String exqt=qt[0];
		//mq=""+(Integer.parseInt(mq)*1024*1024);
		Long lqt=0l;
		
		lqt=(Long.parseLong(mq))*1024*1024;	
		addqt=mq;
		
		mq=""+lqt;
		
		 System.out.println("mail="+mail);
		 System.out.println("cn="+cn);
		 System.out.println("lang="+prelang);
		 //System.out.println("ex="+exqt);
		    System.out.println("mq"+mq);
		    System.out.println("pass="+pass);
		    
		    HttpSession hs=request.getSession(false);
	        String username= (String)hs.getAttribute("id");
	        String password= (String)hs.getAttribute("password");
	        String url= (String)hs.getAttribute("url");
	        String mbase= (String)hs.getAttribute("base");
	        String ip= (String)hs.getAttribute("ip");
	        String utype= (String)hs.getAttribute("user_name");
	        String  base="o=domains,"+mbase;
	        DirContext ctx = null;
	        String dalias="";
	        String ftpdom=GetMValueAtt.getDomValueAtt(url,username,password,mbase,domain,"domainFTPStatus");
	        int totno=0;
	        totno=TotalUser.totUser(url,mbase, base, username, password);
	       // if(totno<500)
	        if(true)
	        {
	        	
	        
	        try
	   {


	  ctx=LDAPConnection.getConnection(url, base, username, password);

	  SearchControls constraints = new SearchControls(); 
	  constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
	   String attrList[] = {"domainCurrentQuotaSize","domainCurrentUserNumber","domainAliasName","domainBaseStorage","domainDefaultFtpQuota"}; 
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
	          out.println("   No attributes");
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
	           qtdir=str;
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
		  
		 
		   /*File   dir = new File(basedir+domain );
			
		    // attempt to create the directory here
		  boolean   successful = dir.mkdirs();
		  Process p = Runtime.getRuntime().exec("sudo chmod 770 -R  "+basedir+domain);
			 p = Runtime.getRuntime().exec("sudo chown -R vmail.vmail "+basedir+domain);
			   */
		  
		   
		   
		   
		   /*dir = new File(basedir+domain+"/users/"+ml );
	
		    // attempt to create the directory here
		    successful = dir.mkdirs();*/
		   Process p = Runtime.getRuntime().exec("sudo mkdir "+basedir+domain+"/users/"+ml);
		  
		   p = Runtime.getRuntime().exec("sudo chmod 770 -R  "+basedir+domain+"/users/"+ml);
			 p = Runtime.getRuntime().exec("sudo chown -R vmail.vmail "+basedir+domain+"/users/"+ml);
			   
		  
			 p = Runtime.getRuntime().exec("sudo mkdir "+basedir+domain+"/users/"+ml+"/ftpdir");
		  /*dir = new File(basedir+domain+"/users/"+ml+"/ftpdir" );
		  successful = dir.mkdir();*/
		 p = Runtime.getRuntime().exec("sudo chmod 770 -R  "+basedir+domain+"/users/"+ml+"/ftpdir");
		 p = Runtime.getRuntime().exec("sudo chown -R vmail.vmail "+basedir+domain+"/users/"+ml+"/ftpdir");
		 
		   
		  
		   
		   
		    try {
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
		            
		            entry.put(new BasicAttribute("initials", init));  
		            entry.put(new BasicAttribute("uid", ml));  
		            entry.put( new BasicAttribute("cn", cn) );
		            entry.put( new BasicAttribute("sn", ln) );
		            entry.put( new BasicAttribute("givenName", fn) );
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
					entry.put( new BasicAttribute( "FTPHomeDir",basedir+domain+"/users/"+ml+"/ftpdir" ) );
		            entry.put( new BasicAttribute( "mailQuota",mq ) );
				    entry.put( new BasicAttribute( "storageBaseDirectory",basedir ) );
				    entry.put( new BasicAttribute( "homeDirectory",basedir+domain+"/users/"+ml ) );
				   entry.put( new BasicAttribute( "mailMessageStore",domain+"/users/"+ml ) );
				   entry.put( new BasicAttribute( "preferredLanguage",prelang ) );
				   entry.put( new BasicAttribute( "forcePasswordChange",fpc ) );
				   entry.put( new BasicAttribute( "createprofile","TRUE" ) );
				   entry.put( new BasicAttribute( "FTPQuotaMBytes",qtdir ) );
				   entry.put( new BasicAttribute( "FTPDownloadBandwidth", "1024" ) );
				   entry.put( new BasicAttribute( "FTPUploadBandwidth", "1024" ) );
				   entry.put( new BasicAttribute( "FTPDownloadRatio", "5" ) );
				   entry.put( new BasicAttribute( "FTPUploadRatio", "5" ) );
				   
				   if(edt!=null && !(edt.equals("")))
				    {
				    String datedt[]=edt.split("-");
				    edt=""+datedt[0]+datedt[1]+datedt[2]+"0000Z";
				    entry.put( new BasicAttribute( "expiredDate", edt ) );
				    }
				   
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
		       out.println( "AddUser: added entry " + entryDN + ".");
		        
		      
		       
		       cuser=""+(Integer.parseInt(cuser)+1); 
		    cqt=""+((Long.parseLong(cqt))+(Long.parseLong(addqt)));
		     
		    ModifyDomainAtt.modyfyAtt(hs, domain, "domainCurrentQuotaSize", cqt);
		    ModifyDomainAtt.modyfyAtt(hs, domain, "domainCurrentUserNumber", cuser); 
		    
		    
		    
		    
		    
		    
		    /*********DB Policy *********/
	        
	       /* String outnm=mail+" Outbound";
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
		    
		    
		    String adm="";
		    if(utype.equals("Admin"))
		    {
		    	adm="Global Admin";
		    }
		    else
		    {
		    	adm="mail-admin@"+domain;
		    }

	        String sql="insert into log (ip,name,domain,msg) values(?,?,?,?)";
	        String data=ip+","+adm+","+domain+",Add User: "+mail;
	        int mg=Crudoperation.insertlog(sql, data);
	        
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
	        
	        try
	        {
	        	LDAPConnection.closeConn( ctx);
	        }
	        catch(Exception ec)
	        {
	        	ec.printStackTrace();
	        }
	        
		    response.sendRedirect("/unifiedmail/global/adduser.jsp?status=succ&nm="+mail);  
		    } catch (NamingException e) {
		        out.println("AddUser: error adding entry." + e);
		      
		        
		        response.sendRedirect("/unifiedmail/global/adduser.jsp?status=error");

		    }
		}
		else
		{
			response.sendRedirect("/unifiedmail/global/adduser.jsp?status=error&dm="+domain);
		}
		}
		else
		{
			response.sendRedirect("/unifiedmail/global/adduser.jsp?status=error&dm="+domain);
		}
		out.flush();
		out.close();
	}

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}

}
