<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>





<link rel="stylesheet" href="/unifiedmail/alertify/alertify.core.css" />
	<link rel="stylesheet" href="/unifiedmail/alertify/alertify.default.css" id="toggleCSS" />
	
	<script src="/unifiedmail/alertify/jquery-1.9.1.js"></script>
	<script src="/unifiedmail/alertify/alertify.min.js"></script>
<script type="text/javascript" src="/unifiedmail/js/jquery.js"></script>
<script type="text/javascript">
function menu(id,nm)
{
alert(id)
alert(nm)
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
      alert(xmlhttp.readyState);
    if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
 
   vall=xmlhttp.responseText;
      alert(vall);
     window.location.assign(id);
  //  document.getElementById(""+id).href =id; 
    }
    }
    xmlhttp.open("GET","/unifiedmail/servlet/MenuSessionServlet?path="+id+"&name="+nm,true);
   //var xx=document.f.chk.value;
   //alert(xx);
    xmlhttp.send();
    

}
</script>
<script type="text/javascript">
$(document).ready(function() {
	
$("ul#topnav li").hover(function() { //Hover over event on list item
	$(this).css({ 'background' : '#545454 url(topnav_active.gif) repeat-x'}); //Add background color + image on hovered list item
	$(this).find("span").show(); //Show the subnav
} , function() { //on hover out...
	$(this).css({ 'background' : 'none'}); //Ditch the background
	$(this).find("span").hide(); //Hide the subnav
});
	
});
</script>
<link rel="stylesheet" href="/unifiedmail/css/tooltip.css" type="text/css" />
<link rel="stylesheet" href="/unifiedmail/css/style.css" type="text/css" />
<script type="text/javascript">
function shutDown()
{
/*
var r=confirm("Do you want to SHUTDOWN...!");
if (r==true)
  {
   //document.shutdown_form.submit();
 document.getElementById("myLink_shutdown").href ="/unifiedmail/servlet/ShutdownServlet";
   
  }
else
  {
  //document.f1.submit();
  }
 // alert("This functionality can not work due to demo account....");
*/
alertify.confirm("Do you want to SHUTDOWN...!<br><br>", function (e) {
				if (e) {
					alertify.success("You've clicked OK");
					// document.getElementById("myLink_shutdown").href ="/unifiedmail/servlet/ShutdownServlet";
					window.location="/unifiedmail/servlet/ShutdownServlet";
				} else {
					alertify.error("You've clicked Cancel");
				}
			});

}


function reboot()
{
//alert("This functionality can not work due to demo account....");

/*
var r=confirm("Do you want to RESTART...!");
if (r==true)
  {
   //document.shutdown_form.submit();
 document.getElementById("myLink_restart").href ="/unifiedmail/servlet/RestartServlet";
   
  }
else
  {
  //document.f1.submit();
  }
  */
  alertify.confirm("Do you want to RESTART...!<br><br>", function (e) {
				if (e) {
					alertify.success("You've clicked OK");
					// document.getElementById("myLink_restart").href ="/unifiedmail/servlet/RestartServlet";
					window.location="/unifiedmail/servlet/RestartServlet";
				} else {
					alertify.error("You've clicked Cancel");
				}
			});
}
</script>
</head>

<body>

 <!-- 
<script
   type="text/javascript"
   src="fb-sidelike.js"
   fbpage='silvereyeitsolutions?ref=hl'></script>
  <div id="fb-root"></div>
  <div class="twitter">	<a href="#"><img src="/unifiedmail/images/twitter.jpg" alt="" title="" /></a>	</div>
-->
 <%
  HttpSession hsession=request.getSession(false);
String sessionid= (String)hsession.getAttribute("id");
 String utype_hed=(String)hsession.getAttribute("user_name");
 
  try {
  if(sessionid==null)
{
System.out.println("hii dgfgf");
%>
<script type="text/javascript">
	window.open("/unifiedmail/login/login.jsp?val=ses", "_self", false);
	</script>
<%
}
else
{

%>
 <form action="/unifiedmail/global/search.jsp" method="post" autocomplete="off">
	<div class="wrapper">
    	<div class="header-wrapper">
        	<div class="top-wrapper">
            	<div class="container">
            	<div class="logo">	<a href="/unifiedmail/global/dashboard.jsp"><img src="/unifiedmail/images/logo.png" alt="" title="" /></a>	</div>
                	<div class="top-right-icons">
                    	<ul>
                        	
                            <li>	<a href="/unifiedmail/servlet/LogoutServlet"><img src="/unifiedmail/images/signout.png" style=" width: 19px;" alt="Logout" title="Logout" /></a>	</li>
                        	</ul>
                            	<div class="clr"></div>
                    	</div>
                	<div class="clr"></div>
                </div>
            	</div>
                <div class="dashboard-menu-wrap">
                <div class="container">
                	<div class="dashboard-meenu">
                    	
                            <ul id="topnav">
        <li><a href="/unifiedmail/global/dashboard.jsp">Dashboard</a></li>
        <li>
            <a href="/unifiedmail/global/domainlist.jsp">Domains and Accounts</a>
           
        </li>
         <%
                  if(utype_hed.equalsIgnoreCase("Admin"))
                  {
                   %>
                   <li>
            <a href="/unifiedmail/global/domainadminlist.jsp">Domain Admins</a>
           
        </li>
                   <%} %>
        <li>
            <a >Reports</a>
            <span>
                <a href="/unifiedmail/global/domainreport.jsp">Domain Wise Reports</a> |
                <a href="/unifiedmail/global/advancemailsreport.jsp">Advance Mail Reports</a> |
                <a href="/unifiedmail/global/userreport.jsp">User Reports</a> |
                <a href="/unifiedmail/global/userdetail.jsp">User Details</a> |
                 <a href="/unifiedmail/global/userdetailexl.jsp">Export User Details</a> |
                <a href="/unifiedmail/global/log.jsp">Admin Log</a>
                
            </span>
        </li>
        
        <li><a >Diagnostics</a>
         <span>
           <a href="/unifiedmail/diagnostics/support.jsp">Support</a> |
          <a href="/unifiedmail/diagnostics/licence.jsp">License</a> 
                   
            <%
                  if(utype_hed.equalsIgnoreCase("Admin"))
                  {
                   %>
                |<a href="/unifiedmail/diagnostics/ping.jsp">Ping</a> |
                <a href="/unifiedmail/diagnostics/traceroute.jsp">Trace Route</a> |
                <a href="/unifiedmail/diagnostics/systeminfo.jsp">System Info</a> |
                <!--  <a href="/unifiedmail/diagnostics/mailqueue.jsp">Mail Queue</a> | -->
                  <a href="/unifiedmail/diagnostics/cpumemoryusages.jsp">Memory & CPU usages</a> 
                  | <a id="myLink_restart" style="cursor: pointer;" onclick="reboot()">Reboot</a> |
                   <a id="myLink_shutdown" style="cursor: pointer;" onclick="shutDown()">System Halt</a>
                   <%} %>
            </span>
        </li>
        
         <li><a >&nbsp;Add</a>
         <span>
          <%
                  if(utype_hed.equalsIgnoreCase("Admin"))
                  {
                   %>
                <a href="/unifiedmail/global/adddomain.jsp">Add Domain</a>	|
                <%} %>
                <a href="/unifiedmail/global/adduser.jsp">Add User</a>	|
               	<a href="/unifiedmail/global/addmaillist.jsp">Add Mail List</a>	|
                 <a href="/unifiedmail/global/addalias.jsp">Add Mail Alias</a>	|
                 <a href="/unifiedmail/global/bulkuserupload.jsp">Bulk User Upload</a>
                 <%
                  if(utype_hed.equalsIgnoreCase("Admin"))
                  {
                   %>
                   |
                 <a href="/unifiedmail/diagnostics/welcomemail.jsp">Welcome Mail</a> 
                 <%} %> 	
         </span>
         </li>
    </ul>
                    	</div>
                      
                             <div class="search-wrapp">
                        	<div class="search">
                            	<input name="search" type="text" placeholder="Search User" class="search-input" />
                                <input name="bt" type="submit" value="" class="search-button" />
                                <div class="clr"></div>
                            	</div>
                        	</div>
                        	
                        <div class="clr"></div>
                	</div>
                </div>
        	</div>
        	</form>
<%
}
}catch(Exception sesexp){
        //  System.out.print(seshead);
             %>
             <script type="text/javascript">
	window.open("/unifiedmail/login/login.jsp?val=ses", "_self", false);
	</script>
             
             <%
            } %>
 
  </body>
</html>
