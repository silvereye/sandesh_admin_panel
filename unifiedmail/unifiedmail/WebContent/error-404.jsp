<%@ page isErrorPage="true"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Error-404 | Silvereye Unified E-mail Server</title>
    
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
    <%@include file="global/header.jsp" %>
     <div class="container main-admin">
  
   <div class="sublev-nav">	
   	<ul>
   		<li>Oops! A 404 error happened because the resource could not be found</li>
 	</ul>
   	<div class="clr"></div>
   	</div>
   </div>

  <%@include file="global/footer.jsp" %>
  </body>
</html>
