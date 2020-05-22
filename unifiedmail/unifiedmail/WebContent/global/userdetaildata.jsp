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
    <div id="pnt">
     <table class="style1" cellspacing="0">
        <thead>
        <tr>
            
                <th class="checkbox">SN.</th>
            <th>Domain</th>
            <th>Mail</th><th>Name</th>
            <th >Mobile</th><th>Date of Birth</th>
            
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



SearchControls constraints = new SearchControls(); 
constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
String attrList[] = {"cn","mail","dateOfBirth","mobile"}; 
constraints.setReturningAttributes(attrList);
NamingEnumeration results =ctx.search(base,"mail=*", constraints);

while (results.hasMore()) {
f=1;
String v1="";
String v2="";
String v3="";
String v4="";
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
        v2=str;
        }
        else if(id.equalsIgnoreCase("mobile"))
        {
        v3=str;
        }
        else if(id.equalsIgnoreCase("dateOfBirth") && str!=null && (!str.equals("")))
        {
        
        String yy="";
           String mm="";
           String dd="";
           
           for(int i=0;i<8;i++)
             {
             char ss=str.charAt(i);
             if(i<=3)
             {
             yy=yy+ss;
             }
             else if(i<=5)
             {
             mm=mm+ss;
             }
             else
             {
             dd=dd+ss;
             }
             }
           v4=""+yy+"-"+mm+"-"+dd;
        }
        



           System.out.println("  <br>1 "+id + ":--- " +str);
           }
    }

if(v2.indexOf("@")>0)
{
 x++;

 %>
       

     <tr>
                        
                            <td class="checkbox"><%=x %></td>
                            <td><%=domain %></td>
                        <td><%=v2 %></td>
                        <td><%=v1 %></td>
                       <td><%=v3 %></td>
                       <td><%=v4 %></td>
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
                     </div>
         <div class="tab-footer clear f1">
            
                <div class="fl">
                    <input type="button" value="Print" class="button fl-space" onclick="printDiv()"/> 
                   
                </div>
            
   
        </div>
       
  </body>
</html>
