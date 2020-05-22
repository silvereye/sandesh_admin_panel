<%@ page language="java" import="java.util.*,mypack.*" pageEncoding="UTF-8"%>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.regex.*" %>
<%@ page import="javax.naming.directory.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
  </head>
  
  <body>
   
<%
String dm=request.getParameter("dm");
 HttpSession hs=request.getSession(false);
		        String username= (String)hs.getAttribute("id");
		        String password= (String)hs.getAttribute("password");
		        String url= (String)hs.getAttribute("url");
		        String mbase= (String)hs.getAttribute("base");
		        String base="o=domains,"+mbase;
	String mqt="";
	String cqt="";
	String dqt="";	 
	Long mno=0l;
	Long cno=0l;       
	
	try
	{
	DirContext ctx=LDAPConnection.getConnection(url, base, username, password);

SearchControls constraints = new SearchControls(); 
constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
String attrList[] = {"domainMaxQuotaSize","domainDefaultUserQuota","domainCurrentQuotaSize","domainMaxUserNumber","domainCurrentUserNumber"}; 
constraints.setReturningAttributes(attrList);
NamingEnumeration results =ctx.search(base,"domainName="+dm, constraints);
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
        else if(id.equalsIgnoreCase("domainMaxQuotaSize"))
        {
        mqt=str;
        }
         else if(id.equalsIgnoreCase("domainDefaultUserQuota"))
        {
        dqt=str;
        }
         else if(id.equalsIgnoreCase("domainMaxUserNumber"))
        {
        mno=Long.parseLong(str);
        }
        
         else if(id.equalsIgnoreCase("domainCurrentUserNumber"))
        {
        cno=Long.parseLong(str);
        }
        
        

           //out.println("  <br> "+id + ":--- " +str);
           }
    }
    //NoOfUser nof=new NoOfUser();
 

}
if(f==0)
{
System.out.println("Search not found");
}

}
catch(Exception e){System.out.println(e);}
     

long qt=Long.parseLong(mqt) - Long.parseLong(cqt);

 %>
 Max User limit: <font color="#FF6600"><%=mno %></font><br/>
 Available Users limit: <font color="#FF6600"><%=(mno-cno) %></font><br/>
 Max Quota Limit:<font color="#FF6600">
 <%if((mqt.trim()).equals("0")) 
 {
 %>
 Unlimited
 <%
 }
 else
 {
 %>
  <%=mqt %>&nbsp;MB&nbsp;(<%=(Long.parseLong(mqt)/1024) %>GB)
  <%} %>
  </font><br/>
  <%if(!(mqt.trim()).equals("0")) 
 {
 %>
 Available Quota limit:<font color="#FF6600"> <%=qt %>&nbsp;MB&nbsp;(<%=(qt/1024) %>GB)</font><br/><br/>
 <%} %>
  </body>
</html>
