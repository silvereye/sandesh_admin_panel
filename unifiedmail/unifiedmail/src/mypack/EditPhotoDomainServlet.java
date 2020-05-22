package mypack;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;

import javax.naming.directory.Attribute;
import javax.naming.directory.Attributes;
import javax.naming.directory.BasicAttribute;
import javax.naming.directory.DirContext;
import javax.naming.directory.ModificationItem;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import dbutil.Crudoperation;

public class EditPhotoDomainServlet extends HttpServlet {

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
		String username= (String)hs.getAttribute("id");
        String password= (String)hs.getAttribute("password");
        String url= (String)hs.getAttribute("url");
        String base= (String)hs.getAttribute("base");
        String dn=(String)hs.getAttribute("user_domain");
       
        
        
        
		try
		{
		String fname=null;
		String mptoken=null;
		File fobj=null;
		int an=0;
	    String path= "/maildir/domains/";
	   // String path= "F:/";
		String ui="photo";   
		
		String nwpath=path+ui;
		System.out.println("path "+nwpath);
		File f=new File(nwpath);
		if(!f.exists())
		{
			f.mkdir();       
		}
		MultipartRequest mpt=new MultipartRequest(request,nwpath,1024*1024*1000);
		Enumeration e=mpt.getFileNames();
		while(e.hasMoreElements())
		{
			mptoken=(String)e.nextElement();
			fobj=mpt.getFile(mptoken);
			fname=fobj.getName();                 
			out.println("filename is"+fname);
			
			}	
		
		
		
		String old=nwpath+"/"+dn+".jpg";
		File fileTemp = new File(old);
		if (fileTemp.exists()){
		    fileTemp.delete();
		    out.print("deleted");
		}
		File jpg = new File(nwpath+"/"+fname);
		 File temp = new File(nwpath+"/"+dn+".jpg");
		 jpg.renameTo(temp);
		
		/* 
		 byte[] bFile = new byte[(int) temp.length()];
	        
	     
         //convert file into array of bytes
     FileInputStream   fileInputStream = new FileInputStream(temp);
	 fileInputStream.read(bFile);*/
	 
	 
		
		   String MY_ENTRY = "domainName="+dn+",o=domains,"+base;
		   
		   try
		   {
			   DirContext ctx=LDAPConnection.getConnection(url, base, username, password);
			   
			  /* ModificationItem[] mods = new ModificationItem[1];
				 javax.naming.directory.Attribute mod0 = new javax.naming.directory.BasicAttribute("domainPhoto", bFile);

					    mods[0] = new ModificationItem(DirContext.REPLACE_ATTRIBUTE, mod0);
					    ctx.modifyAttributes(MY_ENTRY, mods);*/
		 
		  String ur = (request.getRequestURL()).toString();
				  int ur_i=ur.lastIndexOf(":");
				 String ur_prt=ur.substring(0,ur_i);
				 
					    ModificationItem[] mods = new ModificationItem[1];
						    Attribute mod0 = new BasicAttribute("domainPhoto", ur_prt+"/photo/"+dn+".jpg");
						    mods[0] = new ModificationItem(DirContext.REPLACE_ATTRIBUTE, mod0);
						    ctx.modifyAttributes(MY_ENTRY, mods);
					    
					    
					/*    
					    Attributes	testAttributes = ctx.getAttributes(MY_ENTRY);
						
					   // Attribute jpegPhoto1 = testAttributes.get("domainPhoto");
					   // String bcode=jpegPhoto1.get().toString();
					   // byte[] jpegBytes1 = bcode.getBytes();
					    //byte[] jpegBytes1 = (byte[]) jpegPhoto1.get();
					    
					// String  photo = new sun.misc.BASE64Encoder().encode(jpegBytes1); */
					   
				   ctx.close();
		  
		  System.out.print("succ");
		   }
		   catch(Exception e1)
		   {
			  
			   			out.print( e1.toString());   
		   }
		   
		   
		 //  fileInputStream.close();
		   
		   
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
			String data=ip+","+adm+","+dn+",Edit Domain -Photo : "+dn;
			int mg=Crudoperation.insertlog(sql, data);
		   
		  // response.sendRedirect("/unifiedmail/global/ImageCrop.jsp?nm="+mail+".jpg");
			response.sendRedirect("/unifiedmail/global/editdomainprofile.jsp?dn="+dn+"&status=succ"); 
		}
		catch(Exception exp){
			if(exp.toString().equalsIgnoreCase("java.lang.NullPointerException"))
			{
				out.print("ERROR: NullPointerException"+exp);	
			}
			else
			{
			out.print("ERROR: "+exp);
			}
			
			}
		out.flush();
		out.close();
	}

}
