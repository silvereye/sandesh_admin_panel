<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>


<!--META-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Login Window | Silvereye Unified E-mail Server</title>
<noscript><meta http-equiv="refresh" content="1; URL=/unifiedmail/error/nojavascritp.jsp"></noscript>
<!--STYLESHEETS-->
<link href="/unifiedmail/login/css/style.css" rel="stylesheet" type="text/css" />
 
<!--SCRIPTS-->
<script type="text/javascript" src="/unifiedmail/login/jquery.js"></script>
<!--Slider-in icons-->
<script type="text/javascript">
$(document).ready(function() {
	$(".username").focus(function() {
		$(".user-icon").css("left","-48px");
	});
	$(".username").blur(function() {
		$(".user-icon").css("left","0px");
	});
	
	$(".password").focus(function() {
		$(".pass-icon").css("left","-48px");
	});
	$(".password").blur(function() {
		$(".pass-icon").css("left","0px");
	});
});
</script>
<script type="text/javascript">
    
 function isCapLockOn(e)

{

    var charKeyCode = e.keyCode ? e.keyCode : e.which; // To work with both MSIE & Netscape

    var shiftKey = e.shiftKey ? e.shiftKey : ((charKeyCode == 16) ? true : false);

     

    // Check both the condition as described above

    if (((charKeyCode >= 65 && charKeyCode <= 90) && !shiftKey)

    || ((charKeyCode >= 97 && charKeyCode <= 122) && shiftKey))

    {

        // Caps lock is on

        document.getElementById('keyStage').innerHTML = "Caps lock : <b>On</b>";

    }

    else

    {

        // Caps lock is off.
document.getElementById('keyStage').innerHTML="";
       // document.getElementById('keyStage').innerHTML = "Caps lock : <b>Off</b>";

    }

}
    </script>
<script language="javascript">
    	
   function msieversion()
   {
      var ua = window.navigator.userAgent
      var msie = ua.indexOf ( "MSIE " )

      if ( msie > 0 )      // If Internet Explorer, return version number
   		if( parseInt (ua.substring (msie+5, ua.indexOf (".", msie )))>9)
   		{
   		alert('hi');
   		  window.location="http://www.w3schools.com";
   		}
      else                 // If another browser, return 0
        alert(0);

   }
  
  
  function fresDiv(){
 //alert("hi");
	document.getElementById("msg").innerHTML="";
}
function chkBrw()
{
//alert("hii")

var nm=navigator.appName;
///lert(nm);

if(nm.indexOf("Microsoft")>=0)
{
//alert("hi")
document.getElementById("wrapper").innerHTML="";
alert("We do not support Internet Explorer,kindly use Chrome or Mozilla to access admin panel.");
}
}
</script>
</head>
<body onload="chkBrw()"  style="background: url("../images/bg.gif") repeat scroll 0 0 rgba(0, 0, 0, 0);">

<!--WRAPPER-->
<div id="wrapper">

	<!--SLIDE-IN ICONS-->
    <div class="user-icon"></div>
    <div class="pass-icon"></div>
    <!--END SLIDE-IN ICONS-->

<!--LOGIN FORM-->
<form name="login-form" class="login-form" action="/unifiedmail/servlet/CheckloginServlet" method="post" autocomplete="off">

	<!--HEADER-->
    <div class="header">
    <!--TITLE--><img src="/unifiedmail/login/images/logo.png" /><!--END TITLE-->
    <!--DESCRIPTION--><center> <span style="font-size:2">Sandesh Enterprise Messaging Solutions</span></center><!--END DESCRIPTION-->
    </div>
    <!--END HEADER-->
	
	<!--CONTENT-->
    <div class="content">
	<!--USERNAME--><input name="id" type="text" required class="input username" value="" placeholder="Admin Id" onfocus="fresDiv()"/><!--END USERNAME-->
    <!--PASSWORD--><input name="pass" id="password" required onkeypress="isCapLockOn(event)" onfocus="fresDiv()" placeholder="Password" type="password" class="input password"  /><!--END PASSWORD-->
    
    <!--msg--> 
    <div id="msg" style="text-align: center;"><%
String val=request.getParameter("val");
if(val!=null && val.equals("notpass"))
{
 %>

 
<b> Username or Password is not correct.</b>
 
 <%}
 else if(val!=null && val.equals("login"))
 {
  %>
 

<b>Login is must</b>
 
  <%}else if(val!=null && val.equals("passch"))
 {
  %>
 

<b>Password has been changed.<br/> Please Login</b>
 
  <%} if(val!=null && val.equals("ses"))
 {
  %>
  

<b>Session expired</b>
 
  <%} %>  </div>  <!--msg-->
    </div>
    <div id="keyStage" style="color:Red;font-size:80%;"></div>
    <!--END CONTENT-->
    
    <!--FOOTER-->
    <div class="footer">
    <!--LOGIN BUTTON--><input type="submit" name="submit" value="Login" class="button" /><!--END LOGIN BUTTON-->
    
    </div>
    <!--END FOOTER-->

</form>
<!--END LOGIN FORM-->

</div>
<!--END WRAPPER-->

<!--GRADIENT--><div class="gradient"></div><!--END GRADIENT-->
   
   
   <div class="myfooter_bg">
		<div class="myfooter">
			
        
			
			
			
			
				
			
			 <!-- START COPYRIGHT AND CONTANT INFO --> 
			<div class="copyright">
				Copyright &copy; 2012 <a href="http://www.silvereye.co/" target="_blank"><span class="white">Silvereye IT Solutions </span> </a>
				</div>
			<div class="contact">
				Contact <a href="mailto:support@silvereye.co">support@silvereye.co</a>
			</div>
			 <!-- END COPYRIGHT AND CONTANT INFO --> 
			
			
		</div>
	</div>  
</body>
</html>