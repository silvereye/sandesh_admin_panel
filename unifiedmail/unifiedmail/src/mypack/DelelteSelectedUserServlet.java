package mypack;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.naming.directory.DirContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbutil.Crudoperation;

public class DelelteSelectedUserServlet extends HttpServlet {

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
		String dm="";
		String ml_val=request.getParameter("ml_val");
		if(ml_val!=null && ml_val.length()>0)
		{
			
		String mlarr[]=ml_val.split(",");
		for(int i=0;i<mlarr.length;i++)
		{
					
		String ml=mlarr[i];
		String arr[]=ml.split("@");
		String nm=arr[0];
		 dm=arr[1];
		//out.print("<br>ml"+ml);
		//out.print("<br>dm"+dm);
		try
		{
		HttpSession hs=request.getSession(false);
        String username=(String)hs.getAttribute("id");
        String password=(String)hs.getAttribute("password");
        String url=(String)hs.getAttribute("url");
        String mbase=(String)hs.getAttribute("base");
        
        String ip= (String)hs.getAttribute("ip");
        String utype= (String)hs.getAttribute("user_name");
        
		long uqt=Long.parseLong( GetMValueAtt.getMValueAtt(url, username, password, mbase, dm, "Users", "mailQuota", "mail", ml));
		long cdqt=Long.parseLong( GetMValueAtt.getDomValueAtt(url, username, password, mbase, dm, "domainCurrentQuotaSize") );
		int cdusr=Integer.parseInt( GetMValueAtt.getDomValueAtt(url, username, password, mbase, dm, "domainCurrentUserNumber") );	
		String qt=""+(cdqt-(uqt/1024/1024));
		String usr=""+(cdusr-1);
		out.print("<br>uqt"+uqt);
		out.print("<br>uno"+cdusr);
		out.print("<br>cdqt"+cdqt);
		
		ModifyDomainAtt.modyfyAtt(hs, dm, "domainCurrentUserNumber", usr);
		ModifyDomainAtt.modyfyAtt(hs, dm, "domainCurrentQuotaSize", qt);
		////delete users	
			String base="ou=Users,domainName="+dm+",o=domains,"+mbase;//dc=springbirds,dc=co,dc=in";//"ou=Users,domainName="+arr_dm[i]+",o=domains"+(String)hs.getAttribute("base");
			
			
			
			
		        String MY_ENTRY="mail="+ml+","+base;
		        DirContext del_ctx=LDAPConnection.getConnection(url, base, username, password);
			    del_ctx.destroySubcontext(MY_ENTRY);
			    Date date = new Date();
			    SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd h:mm:ss a");
			    String formattedDate = sdf.format(date);
			    formattedDate=formattedDate.replace("/","");
			    formattedDate=formattedDate.replace(":","");
			    formattedDate=formattedDate.replace(" ","");
			    out.print(formattedDate);
			    Process p = Runtime.getRuntime().exec("mv /maildir/domains/"+dm+"/users/"+nm+" /maildir/domains/"+dm+"/users/"+nm+formattedDate );
			
			    
			    
			    String adm="";
			    if(utype.equals("Admin"))
			    {
			    	adm="Global Admin";
			    }
			    else
			    {
			    	adm="mail-admin@"+dm;
			    }

		        String sql="insert into log (ip,name,domain,msg) values(?,?,?,?)";
		        String data=ip+","+adm+","+dm+",Delete User: "+ml;
		        int mg=Crudoperation.insertlog(sql, data);
		      
	}
		catch(Exception e)
		{System.out.print(e);
		}
		
		}
		}
		response.sendRedirect("/unifiedmail/global/userslist.jsp?dm="+dm+"&msg=Deleted");
		
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
		out
				.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<HTML>");
		out.println("  <HEAD><TITLE>A Servlet</TITLE></HEAD>");
		out.println("  <BODY>");
		out.print("    This is ");
		out.print(this.getClass());
		out.println(", using the POST method");
		out.println("  </BODY>");
		out.println("</HTML>");
		out.flush();
		out.close();
	}

}
