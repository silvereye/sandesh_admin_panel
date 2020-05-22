<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
<link rel="stylesheet" href="/unifiedmail/css/style.css" type="text/css" />
<script type="text/javascript" src="/unifiedmail/js/jquery.min.1.9.js"></script>
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

</head>

<body>
	<div class="wrapper">
    	<div class="header-wrapper">
        	<div class="top-wrapper">
            	<div class="container">
            	<div class="logo">	<a href="/unifiedmail/global/dashboard.jsp"><img src="images/logo.png" alt="" title="" /></a>	</div>
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
            <span>
                <a href="">The Company</a> |
                <a href="">The Team</a> |
                <a href="">Careers</a>
            </span>
        </li>
        <li>
            <a href="#">Admins</a>
            <span>
                <a href="">What We Do</a> |
                <a href="">Our Process</a> |
                <a href="">Testimonials</a>
            </span>
        </li>
        
                <li>
            <a href="/unifiedmail/global/list/list.jsp">Users</a>
            <span>
                <a href="">What We Do</a> |
                <a href="">Our Process</a> |
                <a href="">Testimonials</a>
            </span>
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
        <li><a href="#">Diagnostics</a></li>
         <li><a href="#"><img src="images/add-icon.png" />&nbsp;Add</a>
         <span>
                <a href="/unifiedmail/global/adddomain.jsp">Add Domain</a>	|
                <a href="/unifiedmail/global/adduser.jsp">Add User</a>	|
               	<a href="/unifiedmail/global/addmaillist.jsp">Add Mail List</a>	|
                 <a href="/unifiedmail/global/addmailalias.jsp">Add Mail Alias</a>	
         </span>
         </li>
    </ul>
                    	</div>
                        
                             <div class="search-wrapp">
                        	<div class="search">
                            	<input name="" type="text" placeholder="Search" class="search-input" />
                                <input name="" type="button" class="search-button" />
                                <div class="clr"></div>
                            	</div>
                        	</div>
                        <div class="clr"></div>
                	</div>
                </div>
        	</div>
  </body>
</html>
