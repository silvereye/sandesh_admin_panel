<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">

    <noscript><meta http-equiv="refresh" content="0; URL=/unifiedmail/error/nojavascritp3.jsp"></noscript>
    <title>Mail Queue | Silvereye Unified E-mail Server</title>
 
  
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/reset.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/screen.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/fancybox.css" />


 <link media="screen" href="/unifiedmail/wait_jquery/jquery.msg.css" rel="stylesheet" type="text/css">
     <script type="text/javascript" src="/unifiedmail/wait_jquery/jquery_min.js"></script>
    <script type="text/javascript" src="/unifiedmail/wait_jquery/jquery.center.min.js"></script>
    <script type="text/javascript" src="/unifiedmail/wait_jquery/jquery.msg.min.js"></script>
    
  </head>
  
<body >

	
<%@include file="/global/header.jsp" %>



<div class="main pagesize"> <!-- *** mainpage layout *** -->
        <div class="main-wrap">
            
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
            
            <div class="page clear">
                



    <div class="content-box">
       
</div>



            </div>
            <%
            }
             %>
        </div>
    </div>


<%@include file="/global/footer.jsp" %>

	
	
	
</body>
</html>
