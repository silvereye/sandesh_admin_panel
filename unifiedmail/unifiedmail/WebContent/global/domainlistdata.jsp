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
     
                        
      <table width="100%" border="0" cellpadding="3" cellspacing="0" class="dlist1111">
    <thead>
    <tr>
    <td align="center"width="20"><input type="checkbox" name="checkall" value="checkbox" id="CheckboxGroup1_0" onclick='checkedAll(frm1);'/></td>
    <td width="91">Domain</td>
    <td width="147">Name</td>
    <td width="100" >Quota</td>
    <td width="52" align="center">Users</td>
    <td width="48" align="center">Lists</td>
    <td width="53" align="center">Alias</td>
    <td width="122" align="center">Status</td>
  </tr>
    </thead>
  
  
  
  
              
<%
int no=Integer.parseInt(request.getParameter("val").trim());
int perpg=Integer.parseInt(request.getParameter("perpg").trim());
int icnt=0;
no=(no-1)*perpg;
int lt=no+perpg;
//int no=Integer.parseInt(request.getParameter("no"));

  String uid=request.getParameter("uid");
                                    HttpSession hs=request.getSession(false);
		        String username= (String)hs.getAttribute("id");
		        String password= (String)hs.getAttribute("password");
		        String url= (String)hs.getAttribute("url");
		        String mbase= (String)hs.getAttribute("base");
		       String base="o=domains,"+mbase;
		       String utype=(String)hs.getAttribute("user_name");
		        String v1="";
String v2="";
String v3="";
String cqt="";
String dqt="";
String no1="";
String no2="";
String no3="";	       
try
{
/*Hashtable env = new Hashtable();
env.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
env.put(Context.PROVIDER_URL, "ldap://192.168.1.16:389"); // LDAP host and base

// LDAP authentication options
env.put(Context.SECURITY_AUTHENTICATION, "simple");
env.put(Context.SECURITY_PRINCIPAL, username);
env.put(Context.SECURITY_CREDENTIALS, password);*/

DirContext ctx=LDAPConnection.getConnection(url, base, username, password);

SearchControls constraints = new SearchControls(); 
constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
String attrList[] = {"domainName","cn","accountStatus","domainCurrentQuotaSize","domainCurrentAliasNumber","domainCurrentListNumber","domainCurrentUserNumber","domainMaxQuotaSize"}; 
constraints.setReturningAttributes(attrList);
NamingEnumeration results =ctx.search(base,"domainName="+uid, constraints);
int f=0;
int x=0;
while (results.hasMore()) {
f=1;
    SearchResult si =(SearchResult)results.next();
    String ck=si.getName();
   System.out.println("<br><br><br>"+ck);
    Attributes attrs = si.getAttributes();
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
         else if(id.equalsIgnoreCase("domainName"))
        {
        v3=str;
        }
         else if(id.equalsIgnoreCase("domainCurrentQuotaSize"))
        {
        cqt=str;
        }
        else if(id.equalsIgnoreCase("domainCurrentUserNumber"))
        {
        no1=str;
        }
        else if(id.equalsIgnoreCase("domainCurrentListNumber"))
        {
        no2=str;
        }
        else if(id.equalsIgnoreCase("domainCurrentAliasNumber"))
        {
        no3=str;
        }
        else if(id.equalsIgnoreCase("domainMaxQuotaSize"))
        {
        dqt=str;
        }
     

           //out.println("  <br> "+id + ":--- " +str);
           }
    }
    //NoOfUser nof=new NoOfUser();
  if(x!=1)
  {          
%>
   <tr><td></td></tr>
   <%} %>          
  

 <tr class="grey">
    <td align="center"><label>
      <input type="checkbox" name="CheckboxGroup1" id="checkbox" value="<%=v3 %>"/>
    </label></td>
    <td><a href="/unifiedmail/global/editdomainprofile.jsp?dn=<%=v3 %>" title="Click to Edit"><%=v3 %></a></td>
    <td ><%=v1 %></td>
    <td >
    <%
     long used=Long.parseLong(cqt);
    
    String usedstr="";
    if((used/1024)>0)
     {
     used=used/1024;
     usedstr=""+used+"GB ";
} 
    else   if(used >0)
     {
       usedstr=""+used+"MB ";
       } 
    else
     {
      usedstr="0MB ";
    }
    if(Long.parseLong(dqt)>0)
    {
    long per=(Long.parseLong(cqt)*100)/(Long.parseLong(dqt));
     %>
    
    
    
    
    
                        	 <table border="1"  style="border-style: inherit; ">
                            <tr height="10px" >
                            <%if(per<80)
                            { 
                            if(per>=10)
                            {%>
                            <td style="background-color: green" bgcolor="green" width="8px" ></td>
                            <%}
                            else
                            { %>
                            <td  style="background-color: white; " bgcolor="white;" width="8px" ></td>
                            <%}
                            if(per>=20)
                            {
                             %>
                              <td style="background-color: green " bgcolor="green" width="8px" ></td>
                              <%}
                              else
                              { %>
                            <td style="background-color: white;" bgcolor="white;" width="8px" ></td>
                            <%} 
                             if(per>=30)
                            {
                             %>
                              <td style="background-color: green"  bgcolor="green" width="8px" ></td>
                              <%}
                              else
                              { %>
                            <td style="background-color: white;" bgcolor="white;" width="8px" ></td>
                            <%} 
                             if(per>=40)
                            {
                             %>
                              <td style="background-color: green"  bgcolor="green" width="8px" ></td>
                              <%}
                              else
                              { %>
                            <td style="background-color: white;" bgcolor="white;" width="8px" ></td>
                            <%} 
                            if(per>=50)
                            {
                             %>
                              <td style="background-color: green"  bgcolor="green" width="8px" ></td>
                              <%}
                              else
                              { %>
                            <td style="background-color: white;"  bgcolor="white;" width="8px" ></td>
                            <%} 
                            if(per>=60)
                            {
                             %>
                              <td style="background-color: green" bgcolor="green" width="8px" ></td>
                              <%}
                              else
                              { %>
                            <td style="background-color: white;"  bgcolor="white;" width="8px" ></td>
                            <%} 
                             if(per>=70)
                            {
                             %>
                              <td style="background-color: green" bgcolor="green" width="8px" ></td>
                              <%}
                              else
                              { %>
                            <td style="background-color: white;" bgcolor="white;" width="8px" ></td>
                            <%} 
                            %>
                           
                            <td style="background-color: white;"  bgcolor="white;" width="8px" ></td>
                            <td  style="background-color: white;" bgcolor="white;" width="8px" ></td>
                            <td  style="background-color: white;" bgcolor="white;" width="8px" ></td>
                            
                            <%}
                            else
                            {
                             %>
                            <td style="background-color: #B2170C"  bgcolor="#B2170C" width="8px" ></td>
                            <td style="background-color: #B2170C" bgcolor="#B2170C" width="8px" ></td>
                            <td style="background-color: #B2170C" bgcolor="#B2170C" width="8px" ></td>
                            <td style="background-color: #B2170C"  bgcolor="#B2170C" width="8px" ></td>
                            <td style="background-color: #B2170C" bgcolor="#B2170C" width="8px" ></td>
                            <td style="background-color: #B2170C" bgcolor="#B2170C" width="8px" ></td>
                            <td style="background-color: #B2170C" bgcolor="#B2170C" width="8px" ></td>
                            <td  style="background-color: #B2170C" bgcolor="#B2170C" width="8px" ></td>
                           <%if(per>=90) 
                           {%>
                            <td style="background-color: #B2170C"  bgcolor="#B2170C" width="8px" ></td>
                            <%}
                            else
                            { %>
                            <td style="background-color: white;"  bgcolor="white;" width="8px" ></td>
                            <%}
                            if(per>=100)
                            {
                             %>
                            <td style="background-color: #B2170C" bgcolor="#B2170C" width="8px" ></td>
                            <%}
                            else
                            { %>
                             <td style="background-color: white;" bgcolor="white;" width="8px" ></td>
                             <%}} %>
                       </tr></table>
    <font class="dlimit">
   <%=usedstr %>/<%=Long.parseLong(dqt)/1024 %>GB&nbsp; <%=per %>% Used
    </font> 
    
    <%
    }
    else
    {
    %>
    <%=usedstr %>/ Unlimited
    <%
        }
   %>
   
    
    
    
    
    
    
    </td>
    <td align="center"><a href="/unifiedmail/global/userslist.jsp?dm=<%=v3 %>"><%=no1 %></a></td>
    <td align="center"><a href="/unifiedmail/global/maillistslist.jsp?dm=<%=v3 %>"><%=no2 %></a></td>
    <td align="center"><a href="/unifiedmail/global/mailaliaseslist.jsp?dm=<%=v3 %>"><%=no3 %></a></td>
    <td><table width="100%">
      <tr>
      <%
		if(v2.equalsIgnoreCase("active"))
		{
 		%>
         <td>
          <a class="tooltips" ><img src="images/right_mark.png" />
<span>Enabled</span></a>
         </td>
         <%}
         else
         {
          %>
        <td>
        <a class="tooltips" ><img src="images/wrong_mark.png" />
<span>Disabled</span></a>
        </td>
        <%} %>
       <td>
        <a class="tooltips" href="/unifiedmail/global/domainsentmail.jsp?dn=<%=v3 %>"><img src="images/flow_mark.png" />
<span>Domain activity</span></a>
       </td>
        <td>
        <%
        if(utype.equalsIgnoreCase("Admin"))
        {
         %>
        <a class="tooltips" id="<%=v3 %>"><img src="images/delete-icon.png"  name="<%=v3 %>" onclick="mydel_dom(this.name)"/>
<span>Delete</span></a>
<%} %>
        </td>
      </tr>
    </table></td>
  </tr>
 




            
<%
}

if(f==0)
{
out.print("<tr class='grey'><td></td><td>Search not found</td></tr>");
}

}
catch(Exception e){out.print("<tr class='grey'><td></td><td>"+e+"</td></tr>");}
%>  
       
  
  
  
  
  
  
  
  
  
</table>

                        	
                        		  </body>
</html>
