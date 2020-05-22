
<%@ page language="java" import="java.util.*,mypack.*" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.regex.*" %>
<%@ page import="javax.naming.directory.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
    <title>Add Mail Alias  | Silvereye Unified E-mail Server</title>
 <noscript><meta http-equiv="refresh" content="0; URL=/unifiedmail/error/nojavascritp.jsp"></noscript>

    
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/reset.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/screen.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/fancybox.css" />

    <!--[if IE 7]>
        <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/ie7.css">
    <![endif]-->
<link rel="stylesheet" href="/unifiedmail/css/tooltip.css" type="text/css" />
<script type="text/javascript">
function removeMsg(id)
{
var element = document.getElementById(id);
element.parentNode.removeChild(element);
//alert(id);
}

</script>
<script type="text/javascript">
function chkList(val)
{
val=val.trim();
document.getElementById("mail").value=val;
var n = val.indexOf("@");
if(n>=0)
{
alert("Please input email without @")
document.getElementById("mail").value="";
 document.getElementById("sp1").innerHTML="";
}
else if(val!=null && val!="")
{
var dm=document.getElementById("domain").value;
if(dm=='index')
{
alert('Please Select domain.')
document.getElementById("mail").value="";
}
else
{
var usr=val+"@"+dm;
//alert(usr)


if (window.XMLHttpRequest)
    {// code for IE7+, Firefox, Chrome, Opera, Safari
    xmlhttp=new XMLHttpRequest();
    }
    else
    {// code for IE6, IE5
    xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
    xmlhttp.onreadystatechange=function()
    {
      //alert(xmlhttp.readyState);
    if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
 
   var vall=xmlhttp.responseText;
     //alert(vall);
     if(vall=="0")
     {
      document.getElementById("sp1").innerHTML = "<font color='green'>Email id is correct.</font>";
	 }
	 else if(vall=="1")
	 {
	 document.getElementById("sp1").innerHTML = "<font color='red'>Email id is already exist.</font>";
	document.getElementById("mail").value="";
	 }
	 else
	 {
	 document.getElementById("sp1").innerHTML =vall;
	 }
	 
    }
    }
    xmlhttp.open("GET","/unifiedmail/servlet/CheckAliasMailServlet?mail="+usr+"&dm="+dm,true);
   //var xx=document.f.chk.value;
   //alert(xx);
    xmlhttp.send();
    }
    }
}


function setNUrl(val)
  {
  if(val=="index")
  val="";
  var url="/unifiedmail/global/addalias.jsp?dm="+val;
 //alert(url)
 window.location=url;
  }



</script>

<script type="text/javascript">
function valData()
{

var ml=document.getElementById('mail').value;
if(ml=="" || ml==null)
{
alert('Email Id must be correct.');
return false;
}

return true;

}
</script>

    
</head>

<body>
  <%
    
    String stt=request.getParameter("status");
     String dm= request.getParameter("dm"); 
     String ml= request.getParameter("nm");
      HttpSession hs=request.getSession(false);
		        String username= (String)hs.getAttribute("id");
		        String password= (String)hs.getAttribute("password");
		        String url= (String)hs.getAttribute("url");
		        String mbase= (String)hs.getAttribute("base");
		        String base="o=domains,"+mbase;
	 
	int mno=0;
	int cno=0;       
     if(dm==null || dm.equalsIgnoreCase(""))
     {
    	if(ml!=null && !(ml.equals("")))
    	{
    	String arr_ml[]=ml.split("@");
    	dm=arr_ml[1];
    	}
    	else
    	{
    	
    	
    	try
		{
int chk_dom=0;
DirContext ctx=LDAPConnection.getConnection(url, base, username, password);

SearchControls constraints = new SearchControls(); 
constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
String attrList[] = {"domainName"}; 
constraints.setReturningAttributes(attrList);
NamingEnumeration results =ctx.search(base,"domainName=*", constraints);
int f=0;
while (results.hasMore()) {
f=1;
    SearchResult si =(SearchResult)results.next();
    String ck=si.getName();
    String dom_ch_arr[]=ck.split("=");
   System.out.println("<br><br><br>trytryr"+dom_ch_arr[1]);
   
        dm=dom_ch_arr[1];
  		chk_dom=1;
  		break;
          
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
 catch(Exception e){System.out.print(e);} 
    	
    	
    	}
     
     }
     else
     {
     try
{


DirContext ctx=LDAPConnection.getConnection(url, base, username, password);

SearchControls constraints = new SearchControls(); 
constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
String attrList[] = {"domainMaxAliasNumber","domainCurrentAliasNumber"}; 
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
        if(id.equalsIgnoreCase("domainMaxAliasNumber"))
        {
        mno=Integer.parseInt(str);
        }
        
         else if(id.equalsIgnoreCase("domainCurrentAliasNumber"))
        {
        cno=Integer.parseInt(str);
        }
        
        

           //out.println("  <br> "+id + ":--- " +str);
           }
    }
    //NoOfUser nof=new NoOfUser();
 

}
if(f==0)
{
System.out.print("<tr class='grey'><td></td><td>Search not found</td></tr>");
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
     
     }
     %>

   <%@include file="header.jsp" %>


    <div class="main pagesize"> <!-- *** mainpage layout *** -->
        <div class="main-wrap">
            
            
          <div class="sublev-nav">	
   	<ul>
<li><a href="/unifiedmail/global/domainlist.jsp">All Domains</a></li>
<li><a  href="/unifiedmail/global/editdomainprofile.jsp?dn=<%=dm %>"><%=dm %></a></li>
<li><a href="/unifiedmail/global/userslist.jsp?dm=<%=dm %>">Users</a></li>
<li><a href="/unifiedmail/global/maillistslist.jsp?dm=<%=dm %>">Mail Lists</a></li>
<li><a href="/unifiedmail/global/mailaliaseslist.jsp?dm=<%=dm %>">Mail Aliases</a></li>
   	</ul>
   	<div class="clr"></div>
   	</div>
            
            <div class="page clear">
                
                
<%
    if(stt!=null && stt.equalsIgnoreCase("succ"))
    {  
     
     %>
      <div class='notification note-success'><a href='#' class='close'></a>
      <p><%=ml %> Mail Alias has been added successfully. To edit this Mail Alias click <a href="/unifiedmail/global/editmailaliasprofile.jsp?ml=<%=ml %>"><%=ml %></a> </p></div>
      <%}
      else if(stt!=null && stt.equalsIgnoreCase("error"))
      {
       %>
                <div id="msg_err" class="notification note-error"><a href='#' class='close'></a>  
                <p>Mail Alias addition has been failed.	</p> </div>
    
    
    <%} 
    int uchk=1;
    if(mno==0)
    {
    uchk=1;
    }
    else if(mno<=cno)
    {
    uchk=0;
    }
    if(uchk==0)
    {
    %>
     <div id="msg_err" class="notification note-error"><a href='#' class='close'></a>  
     <p>Error: You can't create more Mail Alias under domain <%=dm %>. Already exceed max number of account limit (<%=mno %>).	</p></div>
        
    <%} %>



    <div class="content-box">
        <div class="box-body">
            <div class="box-header clear">
                <ul class="tabs clear">
                    
                    <li ><a href="/unifiedmail/global/adduser.jsp?dm=<%=dm %>">Add User</a>
                    <li ><a href="/unifiedmail/global/addmaillist.jsp?dm=<%=dm %>">Add List</a>
                    <li class="active"><a href="/unifiedmail/global/addalias.jsp?dm=<%=dm %>">Add Alias</a>
                </ul>

                <h2>
                    Add Mail Alias under domain:<%=dm %>
                    
                </h2>
            </div>

            <div id="maillist_add" class="box-wrap clear">
   <form name="f_add_dom"  id="register" method="post" action="/unifiedmail/servlet/AddMailAliasServlet" onsubmit="return valData()">    
    

        <div class="form-field clear">
            <h4 class="size-250 fl-space">Mail Alias Address <span class="required">*</span></h4>
            <span class="clean-padding">
               
                <%if(uchk==0)
                            	{
                            	 %>
                                <input name="mail" id="mail" readonly="readonly" size="35" class="text fl-space" required type="text" onblur="chkList(this.value)"/>
                                <%}
                                else
                                {
                                 %>
                                 <input name="mail" id="mail" required type="text" size="35" class="text fl-space" onblur="chkList(this.value)"/>
                                 <%} %>
                                &nbsp;@
                    <select name="domain" id="domain" onchange="setNUrl(this.value)">
                        
                          <%
                                   
		        
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
String attrList[] = {"domainName"}; 
constraints.setReturningAttributes(attrList);
NamingEnumeration results =ctx.search(base,"domainName=*", constraints);
int f=0;
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
  if(dm.equalsIgnoreCase(str))  
  {    
%>
<option selected="selected" value="<%=str %>"><%=str %></option>
<%
}
else
{
%>
<option value="<%=str %>"><%=str %></option>
<%
}
           //out.println("  <br> "+id + ":--- " +str);
           }
    }}
try
{
	LDAPConnection.closeConn( ctx);
}
catch(Exception ec)
{
	ec.printStackTrace();
}                                 
}

		 catch(Exception e){System.out.print(e);}  %>
                        
                    </select>
            </span>
            <div class="ermsg" id="sp1"></div>
        </div>

        

    <div class="form-field clear">
        
            <h4 class="size-250 fl-space">Display Name <span class="required">*</span></h4>
        

        <span class="clean-padding bt-space20">
            
         <input name="dn" id="dn" required type="text" size="35" class="text" />
        </span>
    </div>


<div class="form-field clear">
        
            <h4 class="size-250 fl-space">Account Status	</h4>
        

        <span class="clean-padding bt-space20">
            
        <select name="acc">
                            	<option value="active">Enable</option>
                            	<option value="disabled">Disable</option>
                            	</select>  
        </span>
    </div>
    
    
    <div class="form-field clear">
        
            <h4 class="size-250 fl-space">Display in Corporate Directory</h4>
        

        <span class="clean-padding bt-space20">
            
        <input name="abook" checked="checked" type="checkbox" value="true" />
        </span>
    </div>

    <div class="rule2"></div>
    <div class="form-field clear">
        <h4 class="size-250 fl-space">&nbsp;</h4>
        <span class="clean-padding bt-space20">
            <input type="submit" value="Add" class="button green" />
        </span>
    </div>

    </form>
    </div>
</div>
</div>



            </div>
        </div>
    </div>

    
         <%@include file="footer.jsp" %>
   
    <script type="text/javascript">
        function change_url(domain, baseurl) {
            if ( domain.options[domain.selectedIndex].value != 'none' ) {
                location.href = baseurl + domain.options[domain.selectedIndex].value;
            }
        }
    </script>
        
    <script type="text/javascript" src="/unifiedmail/npjs/jquery-1.4.2.min.js"></script>

    
        <script type="text/javascript" src="/unifiedmail/npjs/jquery.tooltip.js"></script>
    
        <script type="text/javascript" src="/unifiedmail/npjs/jquery.idtabs.js"></script>
    
        <script type="text/javascript" src="/unifiedmail/npjs/jquery.fancybox.js"></script>
    

    

    

    <script type="text/javascript">
    
    

    
    $(document).ready(function() {
        
        $('.menu li').hover(function () {
            $(this).find('ul:first').css({'visibility': 'visible', 'display': 'none'}).slideDown();
        }, function () {
            $(this).find('ul:first').css({visibility: "hidden"});
        });$('.content-box .select-all').click(function () {
            if ($(this).is(':checked'))
                $(this).parent().parent().parent().parent().find(':checkbox').attr('checked', true);
            else
                $(this).parent().parent().parent().parent().find(':checkbox').attr('checked', false);
        });

        /* Tabs */
        $('.content-box .tabs').idTabs();

        
        $('.notification .close').click(function () {
            $(this).parent().fadeOut(300);
            return false;
        });

        
        $("a[title], img[title], span[title], input[title]").tooltip({
            position: "top center",
            offset: [-5, 0],
            predelay: 300,
            delay: 100,
            effect: "fade",
            opacity: 1
        });

        

        $('.onFocusEmpty').focus(function () {
            $(this).val('');
        });

        
        $('.modal-link').fancybox({
            'modal'                 : false,
            'hideOnOverlayClick'    : true,
            'hideOnContentClick'    : false,
            'enableEscapeButton'    : true,
            'showCloseButton'       : true
        });
        $("a[href$='gif']").fancybox();
        $("a[href$='jpg']").fancybox();
        $("a[href$='png']").fancybox();

        
    });
    </script>
    

    
</body>
</html>