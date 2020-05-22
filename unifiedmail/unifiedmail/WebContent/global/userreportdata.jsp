<%@ page language="java" import="java.util.*,mypack.*" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
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
    <base href="<%=basePath%>">
    
    <title>My JSP 'userreportdata.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
   <% String domain=request.getParameter("domain");
   
    %>
     <table class="style1" cellspacing="0">
        <thead>
        <tr>
            
                <th class="checkbox">SN.</th>
            
            <th>Mail</th> <th>Name</th>
            <th align="center" colspan="4">Activity</th>
            
        </tr>
        </thead>

        
        <tbody>
        <%
     
				HttpSession hs=request.getSession(false);
		        String username=(String)hs.getAttribute("id");
		        String password=(String)hs.getAttribute("password");
		        String url=(String)hs.getAttribute("url");
		        String base1=(String)hs.getAttribute("base");
		        String utype=(String)hs.getAttribute("user_name");
try
{
int f=0;
int x=0;
int icnt=0;


String base="ou=Users,domainName="+domain+",o=domains,"+base1;//dc=springbirds,dc=co,dc=in";//"ou=Users,domainName="+arr_dm[i]+",o=domains"+(String)hs.getAttribute("base");
DirContext ctx=LDAPConnection.getConnection(url, base, username, password);
String v1="";
String v3="";


SearchControls constraints = new SearchControls(); 
constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
String attrList[] = {"cn","mail"}; 
constraints.setReturningAttributes(attrList);
NamingEnumeration results =ctx.search(base,"mail=*", constraints);

while (results.hasMore()) {
f=1;
String photo="";
    SearchResult si =(SearchResult)results.next();
    String ck=si.getName();
   System.out.println("<br><br><br>"+ck);
    Attributes attrs = si.getAttributes();
String arr[]=ck.split(",");
int l=arr.length;

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
        if(id.equalsIgnoreCase("cn"))
        {
        v1=str;
        }
       else if(id.equalsIgnoreCase("mail"))
        {
        v3=str;
        }
        



           System.out.println("  <br> "+id + ":--- " +str);
           }
    }

if(v3.indexOf("@")>0)
{
 x++;

 %>
       

     <tr>
                        
                            <td class="checkbox"><%=x %></td>
                        <td><%=v3 %></td>
                        <td><%=v1 %></td>
                        <td><a href="/unifiedmail/global/usersentmails.jsp?ml=<%=v3 %>">Sent Mails</a></td>
                        <td><a href="/unifiedmail/global/userreceivedmails.jsp?ml=<%=v3 %>">Received Mails</a></td>
                        <td><a href="/unifiedmail/global/userspamvirusmails.jsp?ml=<%=v3 %>">Spam/Virus</a></td>
                        <td><a href="/unifiedmail/global/userquarantmails.jsp?ml=<%=v3 %>">Quarantined Mails</a></td>
                       
                    </tr>
                    <%} 
                    }
if(f==0)
{
//out.print("Search not found");
%>
<tr><td colspan="5" align="center"><h4>Search not found</h4></td></tr>
<%
}


}
catch(Exception e){System.out.print(e);
%>
<tr><td colspan="5" align="center"><h4><%=e %></h4></td></tr>
<%
}
	
	 %>
                    </tbody>
                    </table>
        
  </body>
</html>
