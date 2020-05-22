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
    
    <title>My JSP 'userlistdata.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script type="text/javascript">
function mydel_dom()
{
var r=confirm("Do you want to Domain: ");
if (r==true)
  {
  
 //document.getElementById("myLink_restart").href ="/unifiedmail/servlet/RestartServlet";
   
  }

}

</script>
  </head>
  
  <body>
   <%
           HttpSession ses=request.getSession(false);
String utp=(String)ses.getAttribute("user_name");
          if(ses!=null && !(utp.equalsIgnoreCase("Admin")))
          {
           %>  
      
	<div class="sublev-nav">	
   	<ul>
   		<li>Access is Denied.</li>

   	</ul>
   	<div class="clr"></div>
   	</div>
        
        <%}
        else
        {
         %>
    <table width="100%" border="0" cellpadding="3" cellspacing="0" class="user-under-domain dlist1111">
    <thead>
    <tr>
    <td width="5"></td>
    <td width="220">Display Name</td>
    <td width="147" align="left">E-mail</td>
    <td width="80" align="center">Status</td>
  </tr>
    </thead>
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
 int no=Integer.parseInt(request.getParameter("no"));
  String uid=request.getParameter("val");



String base="o=domainAdmins,"+base1;//dc=springbirds,dc=co,dc=in";
DirContext ctx=LDAPConnection.getConnection(url, base, username, password);
String v1="";
String v2="";
String v3="";


SearchControls constraints = new SearchControls(); 
constraints.setSearchScope(SearchControls.SUBTREE_SCOPE);
String attrList[] = {"cn","accountStatus","mail"}; 
constraints.setReturningAttributes(attrList);
NamingEnumeration results =ctx.search(base,"mail="+uid, constraints);

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
    
    
     if(no!=0 && x>no)
     {
     break;
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
        else if(id.equalsIgnoreCase("accountStatus"))
        {
        v2=str;
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
if(x!=1)
{
%>




<tr><td></td></tr>
<%}
 %>
 
    <tr class="grey" style=" padding: 2px 0;">
   <td width="5" style=" padding: 2px 0;"></td>
   <td width="126" style=" padding: 2px 0;"><%=v1 %></td>
    <td width="300" align="left" style=" padding: 2px 0;"><a href="/unifiedmail/global/editdomainadminprofile.jsp?ml=<%=v3 %>"><%=v3 %></a></td>
     
    
   
    <td width="120" align="center" style=" padding: 2px 0;">
      <table >
      <tr>
       <%
		if(v2.equalsIgnoreCase("active"))
		{
 		%>
         <td>
         <a class="tooltips" href="#"><img src="/unifiedmail/images/right_mark.png" />
<span>Enabled</span></a>
         </td>
         <%}
         else
         { %>
        <td>
        <a class="tooltips" href="#"><img  src="/unifiedmail/images/image1.png" />
<span>Disabled</span></a>
        </td>
       <%} %>
       <td width="10px"></td>
       <td>
        <a  href="/unifiedmail/global/editdomainadminprofile.jsp?ml=<%=v3 %>"><img  src="/unifiedmail/images/action_edit.png" />
</a>
        </td>
        </tr></table>
      
      </td>
  </tr>


<%
}
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
	}
	 %>
	 </table>
  </body>
</html>
