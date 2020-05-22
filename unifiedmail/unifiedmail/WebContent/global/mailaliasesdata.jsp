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

  </head>
  
  <body>
    <table width="100%" border="0" cellpadding="3" cellspacing="0" class="user-under-domain dlist1111">
    <thead>
    <tr>
    <td width="30" align="center"><input type="checkbox" name="checkall" value="checkbox" id="CheckboxGroup1_0" onclick='checkedAll(frm1);'/></td>

    <td width="220">Display Name</td>
    <td width="147" align="left">E-mail</td>
    <td width="183" align="left">No Of Members</td>
    <td width="80" align="center">Alias Status</td>
  </tr>
    </thead>
    <%
				HttpSession hs=request.getSession(false);
		        String username=(String)hs.getAttribute("id");
		        String password=(String)hs.getAttribute("password");
		        String url=(String)hs.getAttribute("url");
		        String base1=(String)hs.getAttribute("base");
try
{
int f=0;
int x=0;
int icnt=0;
int no=Integer.parseInt(request.getParameter("val").trim());
int perpg=Integer.parseInt(request.getParameter("perpg").trim());
int chk=0;
no=(no-1)*perpg;
int lt=no+perpg;

String uid=request.getParameter("uid");
String dom="";
dom=request.getParameter("dm");
System.out.println("dom="+dom);
if(dom.equals("") || dom==null)
{
dom=domainlist.getDomList(hs);
}



System.out.println("list           "+dom); 
String arr_dm[]=dom.split(",");
for(int i=0;i<arr_dm.length;i++)
{
String base="ou=Aliases,domainName="+arr_dm[i]+",o=domains,"+base1;//dc=springbirds,dc=co,dc=in";//"ou=Users,domainName="+arr_dm[i]+",o=domains"+(String)hs.getAttribute("base");
DirContext ctx=LDAPConnection.getConnection(url, base, username, password);
String v1="";
String v2="";
String v3="";
int v4=0;
SearchControls constraints = new SearchControls(); 
constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
String attrList[] = {"cn","accountStatus","mail","mailForwardingAddress"}; 
constraints.setReturningAttributes(attrList);
NamingEnumeration results =ctx.search(base,"mail="+uid, constraints);

while (results.hasMore()) {
f=1;
v4=0;
    SearchResult si =(SearchResult)results.next();
    String ck=si.getName();
//   System.out.println("<br><br><br>"+ck);
    Attributes attrs = si.getAttributes();
String arr[]=ck.split(",");
int l=arr.length;

x++;
if (attrs == null || x<=no) {
    //   out.println("   No attributes");
        continue;
    }
    
    
     if(( x>lt))
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
        else if(id.equalsIgnoreCase("mailForwardingAddress"))
        {
        v4=v4+1;
        }



           System.out.println("  <br> "+id + ":--- " +str);
           }
    }

if(v3.indexOf("@")>0)
{

 %>
    <tr class="grey">
    <td  width="30" align="center"><label>
         <input type="checkbox" name="CheckboxGroup1" id="checkbox" value="<%=v3 %>"/>
    </label></td>

    <td width="126"><%=v1 %></td>
    <td width="300" align="left"><a href="/unifiedmail/global/editmailaliasprofile.jsp?ml=<%=v3 %>"><%=v3 %></a></td>
    <td width="120" align="left"><%=v4 %></td>
   
    <td width="80" align="center"><table width="60%">
      <tr>
       <%
		if(v2.equalsIgnoreCase("active"))
		{
 		%>
         <td><a ><img title="Enable" src="/unifiedmail/images/right_mark.png" /></a></td>
         <%}
         else
         { %>
        <td><a ><img title="Disable" src="/unifiedmail/images/image1.png" /></a></td>
       <%} %>
      <td><a class="tooltips" id="<%=v3 %>"><img src="/unifiedmail/images/delete-icon.png"  name="<%=v3 %>" onclick="mydel_dom(this.name)"/>
<span>Delete</span></a></td>
        
      </tr>
    </table></td>
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
}
catch(Exception e){System.out.print(e);
%>
<tr><td colspan="5" align="center"><h4><%=e %></h4></td></tr>
<%
}
	
	 %>
	 </table>
  </body>
</html>
