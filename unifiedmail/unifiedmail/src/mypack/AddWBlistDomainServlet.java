package mypack;

import java.io.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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

public class AddWBlistDomainServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public AddWBlistDomainServlet() {
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
	
		
		String domain=request.getParameter("dom").trim();
		//String mail=request.getParameter("mail").trim();
		String status=request.getParameter("status").trim();
		String val=request.getParameter("val").trim();
		String func="delWlist" ;
		if(status.equalsIgnoreCase("blacklist_from"))
		{
			func="delBlist" ;
		}

		String sql="insert into userpref (username,preference,value) values(?,?,?)";
		Connection con=Crudoperation.createSpamConnection();
		try
		{
		PreparedStatement ps=con.prepareStatement(sql);
		ps.setString(1, "%"+domain);
		ps.setString(2, status);
		ps.setString(3, val);
		int i=ps.executeUpdate();
		}
		catch(Exception ee){ee.printStackTrace();}
		
		
		  String sql1="select * from userpref where username=? and preference=? ";
          String res=" <table width='100%'>";
          try
         {
         PreparedStatement ps=con.prepareStatement(sql1);
         ps.setString(1,"%"+domain);
         ps.setString(2,status);
        int flg=0;
          ResultSet rs=ps.executeQuery();
          while(rs.next())
			{
			String vl=rs.getString("value");
			String preid=rs.getString("prefid");
			if(flg%2==0)
			{
          
				res+="<tr style='background: #e8e8e8;' >";
			}
			else
			{
			
				res+="<tr style='background: #fff;'>";
			}
			flg++;
			
			res+="<td width='90%' style='padding-left: 4px;'> "+vl+"</td>";
			res+="<td width='10%' style='text-align: right;'>";
			res+="<span style=' margin-right: 4px; cursor: pointer;' id='"+preid+"' onclick='"+func+"(this.id)'>";
			res+="<img src='/unifiedmail/images/delete-icon.png' style='margin-bottom: 3px;'/></span>";
			res+="</td></tr>";
		
	 
           
           }
         }
          catch(Exception ee){ee.printStackTrace();}
		
          res+="</table>";
		
		HttpSession hs=request.getSession(false);
	        String ip= (String)hs.getAttribute("ip");
	        String utype= (String)hs.getAttribute("user_name");
	     
		    
		    try
		    {
		    String adm="";
		    if(utype.equals("Admin"))
		    {
		    	adm="Global Admin";
		    }
		    else
		    {
		    	adm="mail-admin@"+domain;
		    }

	        String sql2="insert into log (ip,name,domain,msg) values(?,?,?,?)";
	        
	        String data=ip+","+adm+","+domain+",Edit White/Black List: "+domain;
	        int mg=Crudoperation.insertlog(sql2, data);
		    }
	        catch(Exception ee){ee.printStackTrace();}
	      
			
		   out.print(res);
		   
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
