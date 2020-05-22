<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>

<script type="text/javascript"
src="/unifiedmail/js/jquery.js"></script>
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

}


function reboot()
{
//alert("This functionality can not work due to demo account....");


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
}
</script>
</head>

<body>
  <div style="float: left; clear: none; padding: 5px; padding-left: 5.5px; padding-right: 5.5px;">
  <iframe src="http://www.facebook.com/plugins/like.php?app_id=166725596724792&amp;href=
<%=request.getRequestURL()%>&amp;send=false&amp;layout=button_count&amp;width=75
&amp;show_faces=false&amp;action=like&amp;colorscheme=light&amp;font&amp;height=21"
 scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:75px; height:21px;" allowTransparency="true"></iframe>
 </div>

<script
   type="text/javascript"
   src="fb-sidelike.js"
   fbpage='silvereye13122010?ref=hl'></script>
  <div id="fb-root"></div>

<div class="twitter">	<a href="#"><img src="/unifiedmail/images/twitter.jpg" alt="" title="" /></a>	</div>
<div class="facebook"><a href="#"><img src="/unifiedmail/images/facebook.jpg" alt="" title="" /></a>	</div>
 <%
  try {
   HttpSession hsession=request.getSession(false);
String sessionid= (String)hsession.getAttribute("id");
if(sessionid==null)
{
System.out.println("hii dgfgf");
%>
<script type="text/javascript">
	window.open("/unifiedmail/login/login.jsp?val=ses", "_self", false);
	</script>
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
  <form action="/unifiedmail/global/search.jsp" method="post" autocomplete="off">
	<div class="wrapper">
    	<div class="header-wrapper">
        	<div class="top-wrapper">
            	<div class="container">
            	<div class="logo">	<a href="/unifiedmail/global/dashboard.jsp"><img src="/unifiedmail/images/logo.png" alt="" title="" /></a>	</div>
                	<div class="top-right-icons">
                    	<ul>
                        	<li>	<a href="#">Settings</a>	</li>
                            <li>	<a href="/unifiedmail/servlet/LogoutServlet">Logout</a>	</li>
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
        
        <li>
            <a href="#">Reports</a>
            <span>
                <a href="">Web Design</a> |
                <a href="">Development</a> |
                <a href="">Identity</a> |
                <a href="">SEO &amp; Internet Marketing</a> |
                <a href="">Print Design</a>
            </span>
        </li>
        <li><a >Diagnostics</a>
         <span>
                <a href="/unifiedmail/diagnostics/ping.jsp">Ping</a> |
                <a href="/unifiedmail/diagnostics/traceroute.jsp">Trace Route</a> |
                <a href="/unifiedmail/diagnostics/systeminfo.jsp">System Info</a> |
                 <a href="">Queue</a> |
                  <a id="myLink_restart" style="cursor: pointer;" onclick="reboot()">Reboot</a> |
                   <a id="myLink_shutdown" style="cursor: pointer;" onclick="shutDown()">System Halt</a>
            </span>
        </li>
         <li><a href="#"><img src="/unifiedmail/images/add-icon.png" />&nbsp;Add</a>
         <span>
                <a href="/unifiedmail/global/adddomain.jsp">Add Domain</a>	|
                <a href="/unifiedmail/global/adduser.jsp">Add User</a>	|
               	<a href="/unifiedmail/global/addmaillist.jsp">Add Mail List</a>	|
                 <a href="/unifiedmail/global/addalias.jsp">Add Mail Alias</a>	|
                 <a href="/unifiedmail/global/bulkuserupload.jsp">Bulk User Upload</a>	
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
  </body>
</html>
