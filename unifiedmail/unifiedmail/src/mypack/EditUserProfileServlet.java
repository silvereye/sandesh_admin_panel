package mypack;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;

import javax.naming.NamingEnumeration;
import javax.naming.directory.Attribute;
import javax.naming.directory.Attributes;
import javax.naming.directory.DirContext;
import javax.naming.directory.SearchControls;
import javax.naming.directory.SearchResult;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbutil.Crudoperation;

public class EditUserProfileServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public EditUserProfileServlet() {
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
		HttpSession hs=request.getSession();
		String init=request.getParameter("init");
		String cn=request.getParameter("cn");
		String sn=request.getParameter("sn");
		String fn=request.getParameter("fn");
		String eno=request.getParameter("eno");
		String mail=request.getParameter("hid_mail");
		String old_qt=request.getParameter("hid_old_qt");
		String mq=request.getParameter("mq");
		String arr[]=request.getParameterValues("qt");
		String qt=arr[0];
		String fmq=request.getParameter("fmq");
		String farr[]=request.getParameterValues("fqt");
		String fqt=farr[0];
		String acc_arr[]=request.getParameterValues("acc");
		String acc="disabled";
		if(acc_arr!=null && acc_arr.length>0)
			acc="active";
		else
			acc="disabled";
		
		String fpc_arr[]=request.getParameterValues("fpc");
		String fpc="FALSE";
		if(fpc_arr!=null && fpc_arr.length>0)
			fpc="TRUE";
		else
			fpc="FALSE";
		
		String ftp_arr[]=request.getParameterValues("ftp");
		String ftp="disabled";
		if(ftp_arr!=null && ftp_arr.length>0)
			ftp="enabled";
		else
			ftp="disabled";
		
		String arr1[]=request.getParameterValues("abook");
		String book="";
		if(arr1!=null && arr1.length>0)
			book="yes";
		else
			book="no";
		String dn=request.getParameter("hid_dn");
		String dob=request.getParameter("dob");
		String doj=request.getParameter("doj");
		String edt=request.getParameter("edt");
		String anni=request.getParameter("anni");
		String padd=request.getParameter("padd");
		String pcode=request.getParameter("pcode");
		String  mobile=request.getParameter("mobile");
		String  hmobile=request.getParameter("hmobile");
		String  tel=request.getParameter("tel");
		String prelang=request.getParameter("prelang");
		String serv=request.getParameter("hid_serv");
		String macAddr=request.getParameter("macAddr");
		String device=request.getParameter("device");
	/*	System.out.println("ftp  "+ftp);
		System.out.println("cn  "+cn);
		System.out.println("mail  "+mail);
		System.out.println("old_qt  "+old_qt);
		System.out.println("mq  "+mq);
		System.out.println("qt  "+qt);
		System.out.println("acc  "+acc);
		System.out.println("book  "+book);
		System.out.println("dn  "+dn);
		System.out.println("dob  "+dob);
		System.out.println("doj  "+doj);
		System.out.println("anni  "+anni);
		System.out.println("padd  "+padd);
		System.out.println("pcode  "+pcode);
		System.out.println("mobile  "+mobile);
		System.out.println("hmobile  "+hmobile);
		System.out.println("tel  "+tel);
		System.out.println("prelang  "+prelang);
		System.out.println("serv  "+serv);*/
		
		if(cn!=null && !(cn.equals("")))
	    {
	     ModifyAtt.modyfyAtt(hs, mail, dn, "cn", cn);
	    }
		
		if(fn!=null && !(fn.equals("")))
	    {
	    
	    ModifyAtt.modyfyAtt(hs, mail, dn, "givenName", fn);
	    }
		
		
		if(sn!=null && !(sn.equals("")))
	    {
	    
	    ModifyAtt.modyfyAtt(hs, mail, dn, "sn", sn);
	    }
		
		if(init!=null && !(init.equals("")))
	    {
	    	    ModifyAtt.modyfyAtt(hs, mail, dn, "initials", init);
	    }
		
		
		 if(doj!=null && !(doj.equals("")))
		    {
		    String dateoj[]=doj.split("-");
		    doj=""+dateoj[0]+dateoj[1]+dateoj[2];
		    ModifyAtt.modyfyAtt(hs, mail, dn, "dateOfJoining", doj);
		    }
		 else
		 {
			 ModifyRemAtt.modyfyRemAtt(hs, dn, mail, "dateOfJoining")	;	 
		 }
		 
		 
		 if(edt!=null && !(edt.equals("")))
		    {
		    String dateoj[]=edt.split("-");
		    edt=""+dateoj[0]+dateoj[1]+dateoj[2]+"0000Z";
		    ModifyAtt.modyfyAtt(hs, mail, dn, "expiredDate", edt);
		    }
		 else
		 {
			 ModifyRemAtt.modyfyRemAtt(hs, dn, mail, "expiredDate")	;	 
		 }

		 if(dob!=null && !(dob.equals("")))
		    {
		    String dateob[]=dob.split("-");
		    dob=""+dateob[0]+dateob[1]+dateob[2];
		    ModifyAtt.modyfyAtt(hs, mail, dn, "dateOfBirth", dob);
		    }
		 else
		 {
			 ModifyRemAtt.modyfyRemAtt(hs, dn, mail, "dateOfBirth")	;	 
		 }
		 
		 if(anni!=null && !(anni.equals("")))
		    {
		    String dateob[]=anni.split("-");
		    anni=""+dateob[0]+dateob[1]+dateob[2];
		    ModifyAtt.modyfyAtt(hs, mail, dn, "anniversary", anni);
		    }
		 else
		 {
			 ModifyRemAtt.modyfyRemAtt(hs, dn, mail, "anniversary")	;	 
		 }

		if(!cn.equalsIgnoreCase("") && cn!=null)
		{
		ModifyAtt.modyfyAtt(hs, mail, dn, "cn", cn);
		}
		
		if(!acc.equalsIgnoreCase("") && acc!=null)
		{
		ModifyAtt.modyfyAtt(hs, mail, dn, "accountStatus", acc);
		}
		
		if(!fpc.equalsIgnoreCase("") && fpc!=null)
		{
		ModifyAtt.modyfyAtt(hs, mail, dn, "forcePasswordChange", fpc);
		}
		
		if(!ftp.equalsIgnoreCase("") && ftp!=null)
		{
		ModifyAtt.modyfyAtt(hs, mail, dn, "FTPStatus", ftp);
		}
		
		if(mobile.equalsIgnoreCase("") || mobile==null)
		{
		ModifyRemAtt.modyfyRemAtt(hs, dn, mail, "mobile")	;		
		}
		else
		{
			ModifyAtt.modyfyAtt(hs, mail, dn, "mobile", mobile);	
		}
		
		if(eno.equalsIgnoreCase("") || eno==null)
		{
		ModifyRemAtt.modyfyRemAtt(hs, dn, mail, "employeeNumber")	;		
		}
		else
		{
			ModifyAtt.modyfyAtt(hs, mail, dn, "employeeNumber", eno);	
		}
		
		
		if(hmobile.equalsIgnoreCase("") || hmobile==null)
		{
		ModifyRemAtt.modyfyRemAtt(hs, dn, mail, "homePhone")	;		
		}
		else
		{
			ModifyAtt.modyfyAtt(hs, mail, dn, "homePhone", hmobile);	
		}
		
		
		if(tel.equalsIgnoreCase("") || tel==null)
		{
		ModifyRemAtt.modyfyRemAtt(hs, dn, mail, "telephoneNumber")	;		
		}
		else
		{
			ModifyAtt.modyfyAtt(hs, mail, dn, "telephoneNumber", tel);	
		}
		
		
		if(device.equalsIgnoreCase("") || device==null)
		{
		ModifyRemAtt.modyfyRemAtt(hs, dn, device, "device")	;		
		}
		else
		{
			ModifyAtt.modyfyAtt(hs, mail, dn, "device", device);	
		}
		
		if(macAddr.equalsIgnoreCase("") || macAddr==null)
		{
		ModifyRemAtt.modyfyRemAtt(hs, dn, macAddr, "macAddr")	;		
		}
		else
		{
			ModifyAtt.modyfyAtt(hs, mail, dn, "macAddr", macAddr);	
		}
		 
		
		if(prelang.equalsIgnoreCase("") || prelang==null)
		{
		ModifyRemAtt.modyfyRemAtt(hs, dn, mail, "preferredLanguage")	;		
		}
		else
		{
			ModifyAtt.modyfyAtt(hs, mail, dn, "preferredLanguage", prelang);	
		}
		
		
		if(padd.equalsIgnoreCase("") || padd==null)
		{
		ModifyRemAtt.modyfyRemAtt(hs, dn, mail, "postalAddress")	;		
		}
		else
		{
			ModifyAtt.modyfyAtt(hs, mail, dn, "postalAddress", padd);	
		}
		
		
		
		if(pcode.equalsIgnoreCase("") || pcode==null)
		{
		ModifyRemAtt.modyfyRemAtt(hs, dn, mail, "postalCode")	;		
		}
		else
		{
			ModifyAtt.modyfyAtt(hs, mail, dn, "postalCode", pcode);	
		}
		
		
		
		if(book.equalsIgnoreCase("no") && serv.indexOf("displayedInGlobalAddressBook")<0)
		{
			
		}
		else if(serv.indexOf("displayedInGlobalAddressBook")<0)
		{
			ModifyAtt.modyfyAtt(hs, mail, dn, "enabledService", "displayedInGlobalAddressBook");		
			String ser_arr[]=serv.split(",");
			for(int i=0;i<ser_arr.length;i++)
			{
				ModifyAddAtt.modyfyAddAtt(hs, mail, dn, "enabledService", ser_arr[i]);
			}
		}
		else if(book.equalsIgnoreCase("no"))
		{
			String ser_arr[]=serv.split(",");
			for(int i=0,j=0;i<ser_arr.length;i++)
			{
				if(ser_arr[i].equalsIgnoreCase("displayedInGlobalAddressBook"))
				{
					continue;
				}
				j++;
				if(j==1)
				{
					ModifyAtt.modyfyAtt(hs, mail, dn, "enabledService",ser_arr[i]);
				}
				else
				{
				ModifyAddAtt.modyfyAddAtt(hs, mail, dn, "enabledService", ser_arr[i]);
				}
			}

		}
		else
		{
			
		}

		
		String fmq_mt=fmq;
		if(fmq!=null && fqt.equalsIgnoreCase("GB"))
		{
			fmq_mt=""+(Integer.parseInt(fmq)*1024);
		}
		if(fmq_mt.equalsIgnoreCase("") || fmq_mt==null)
		{
		ModifyRemAtt.modyfyRemAtt(hs, dn, mail, "FTPQuotaMBytes")	;		
		}
		else
		{
			ModifyAtt.modyfyAtt(hs, mail, dn, "FTPQuotaMBytes", fmq_mt);	
		}
		
		
		
		
		
		String mq_mt=mq;
		if(qt.equalsIgnoreCase("GB"))
		{
			mq_mt=""+(Integer.parseInt(mq)*1024);
		}
		
		if(Long.parseLong(mq_mt)!=Long.parseLong(old_qt))
		{
		 // HttpSession hs=request.getSession(false);
	        String username= (String)hs.getAttribute("id");
	        String password= (String)hs.getAttribute("password");
	        String url= (String)hs.getAttribute("url");
	        String mbase= (String)hs.getAttribute("base");
	      String base="o=domains,"+mbase;
	      DirContext ctx = null;
	      String cqt="";
	       
	        try
	   {


	  ctx=LDAPConnection.getConnection(url, base, username, password);

	  SearchControls constraints = new SearchControls(); 
	  constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
	   String attrList[] = {"domainCurrentQuotaSize","domainCurrentUserNumber"}; 
	   constraints.setReturningAttributes(attrList);
	   NamingEnumeration results =ctx.search(base,"domainName="+dn, constraints);
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
	           
	            
	           

	              //out.println("  <br> "+id + ":--- " +str);
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
	   
	   Long q=(Long.parseLong(mq_mt))-(Long.parseLong(old_qt));
	   q=(Long.parseLong(cqt)+q);
	   ModifyDomainAtt.modyfyAtt(hs, dn, "domainCurrentQuotaSize", ""+q);
	   
	   q=Long.parseLong(mq_mt)*1024*1024;
	   ModifyAtt.modyfyAtt(hs, mail, dn, "mailQuota",""+q);
	   
	   
		}
	   
	   
		
		
		String arr_list[]=request.getParameterValues("mem_list");
		if(arr_list!=null)
		{
		for(int i=0;i<arr_list.length;i++)
		{
			System.out.println("list mem   "+arr_list[i]);
			if(i==0)
			{
				ModifyAtt.modyfyAtt(hs, mail, dn, "memberOfGroup",arr_list[i]);
			}
			else
			{
				ModifyAddAtt.modyfyAddAtt(hs, mail, dn, "memberOfGroup", arr_list[i]);
			}
		}
		}
		else
		{
			ModifyRemAtt.modyfyRemAtt(hs, dn, mail, "memberOfGroup")	;		
		}
		
		
		
		
		String arr_alias[]=request.getParameterValues("mem_alias");
		String old_alias_list=request.getParameter("hid_old_alias");
		String new_alias_list="";
		if(arr_alias!=null)
		{
		for(int i=0;i<arr_alias.length;i++)
		{
			new_alias_list=new_alias_list+","+arr_alias[i];
			System.out.println("alias mem   "+arr_alias[i]);
			if(old_alias_list.indexOf(arr_alias[i])<0)
			{
				ModifyAtt.modyfyAtt(hs, arr_alias[i], dn, "Aliases", "mailForwardingAddress", mail);
			}
		}
		
		}
		

		String username= (String)hs.getAttribute("id");
		String password= (String)hs.getAttribute("password");
		String url= (String)hs.getAttribute("url");
		String mbase= (String)hs.getAttribute("base");
		String old_arr[]=old_alias_list.split(",");
		
		for(int i=1;i<old_arr.length;i++)
		{
			if(new_alias_list.indexOf(old_arr[i])<0)
			{
			String list=	GetMValueAtt.getMValueAtt(url, username, password, mbase, dn, "Aliases", "mailForwardingAddress", "mail", old_arr[i]);
			System.out.println("Ali  "+old_arr[i]+"  frd lst ="+list);
			String in_arr[]=list.split(",");
			int f=0;
			if(in_arr!=null)
			{
			for(int j=0;j<in_arr.length;j++)
			{
				System.out.println(mail+"=one by one mail="+in_arr[j]);
			
			if(mail.equalsIgnoreCase(in_arr[j]))
				{
					continue;
				}
				f++;
				if(f==1)
				{
					ModifyAtt.modyfyAtt(hs, old_arr[i], dn, "Aliases", "mailForwardingAddress", in_arr[j]);
				}
				else
				{
					ModifyAddAtt.modyfyAddAtt(hs, old_arr[i], dn, "Aliases", "mailForwardingAddress", in_arr[j]);
				}
			}
			if(f==0)
			{
				ModifyRemAtt.modyfyRemAtt(hs, dn, "Aliases", old_arr[i], "mailForwardingAddress");
			
			}
			
			
			}
		}
		}
		
		System.out.println("old alias lst   "+old_alias_list);
		
		
		

		String ip= (String)hs.getAttribute("ip");
		String utype= (String)hs.getAttribute("user_name");
		String adm="";
		if(utype.equals("Admin"))
		{
			adm="Global Admin";
		}
		else
		{
			adm="mail-admin@"+dn;
		}
		String sql="insert into log (ip,name,domain,msg) values(?,?,?,?)";
		String data=ip+","+adm+","+dn+",Edit User Profile -General : "+mail;
		int mg=Crudoperation.insertlog(sql, data);
		
		 response.sendRedirect("/unifiedmail/global/edituserprofile.jsp?ml="+mail+"&status=succ");
		
		
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
