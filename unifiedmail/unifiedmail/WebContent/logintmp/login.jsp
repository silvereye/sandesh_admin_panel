<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>Login Window | Silvereye Unified E-mail Server</title>
<noscript><meta http-equiv="refresh" content="1; URL=/unifiedmail/error/nojavascritp.jsp"></noscript>
 <link rel="stylesheet" type="text/css" href="/unifiedmail/nlogin/css/style.css" />
         <link rel="stylesheet" type="text/css" href="/unifiedmail/login/css/stylus.css" />
		<script src="js/cufon-yui.js" type="text/javascript"></script>
		<script src="js/ChunkFive_400.font.js" type="text/javascript"></script>
		<script type="text/javascript">
			Cufon.replace('h1',{ textShadow: '1px 1px #fff'});
			Cufon.replace('h2',{ textShadow: '1px 1px #fff'});
			Cufon.replace('h3',{ textShadow: '1px 1px #000'});
			Cufon.replace('.back');
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



</head>

<body>

	
    	<div class="header-wrapper">
        	<div class="header-in">
            	<div class="mail-logo-wrap">
                    <div class="co-name">SILVEREYE UNIFIED E-MAIL SERVER</div>
                    <div class="clr"></div>
                </div>
            </div>
        </div>
       
        
        
        <div class="wrapper">
			
			<div class="content">
				<div id="form_wrapper" class="form_wrapper">
					
		
					  <form class="login active" action="/unifiedmail/servlet/CheckloginServlet" method="post">
						<h3>Login</h3>
						<div>
							<label>Username:</label>
							 <input type="text" name="id"   value="Manager" />
							<span class="error">This is an error</span>
						</div>
						<div>
							<label>Password:</label>
							<input name="pass" id="password"  onkeypress="isCapLockOn(event)"  placeholder="password" type="password"  />
                       
							<span class="error" id="keyStage" style="visibility: visible;"></span>
						</div>
						<div class="bottom">
							
							 <input name="" type="submit"  value="Login" />
							 <%
String val=request.getParameter("val");
if(val!=null && val.equals("notpass"))
{
 %>

 <div><table><tr><td><img src="images/gif.gif" width="24" height="24"></img>
 </td><td>
<b> Login Failed!!!!!</b></td></tr></table></div>
 
 <%}
 else if(val!=null && val.equals("login"))
 {
  %>
 
<div><table><tr><td><img src="images/gif.gif" width="24" height="24"></img>
</td><td>
<b>Login is must!!!!!</b></td></tr></table></div>
 
  <%} if(val!=null && val.equals("ses"))
 {
  %>
  
<div><table><tr><td><img src="images/gif.gif" width="24" height="24"></img>
</td><td>
<b>Session expired!!!!!</b></td></tr></table></div>
 
  <%} %>            
							<div class="clear"></div>
						</div>
					</form>
					
				</div>
				<div class="clear"></div>
			</div>
		</div>
        
        <div class="footer-wrapper">
  <div class="footer-in">
        	<div class="foot-left">© Copyright Silvereye IT Solutions</div>
            <div class="foot-right"><a href="#"><img src="login/images/develop.png" /></a></div>
            <div class="clr"></div>
          </div>
        </div>
 
    
    
    <!-- The JavaScript -->
		<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
	
</body>
</html>
