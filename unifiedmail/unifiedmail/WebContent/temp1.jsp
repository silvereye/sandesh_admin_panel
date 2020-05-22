<%@page import="java.nio.file.Paths"%>
<%@page import="java.nio.file.Files"%>
<%@ page language="java" import="java.util.*,java.io.*,mypack.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'temp1.jsp' starting page</title>
    
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
 <%
 try
 {
	 Files.createDirectories(Paths.get("/root/directory"));
 /* File   dir = new File("/maildir/domains/wii.gov.in/users/npstest" );
	
  // attempt to create the directory here
boolean   successful = dir.mkdirs();
out.print(successful+"<br>");
Process p = Runtime.getRuntime().exec("sudo chmod 770 -R /maildir/domains/wii.gov.in/users/npstest");
	 p = Runtime.getRuntime().exec("sudo chown -R vmail.vmail /maildir/domains/wii.gov.in/users/npstest"); */
 }
 catch(Exception ee)
 {
	 out.print(ee);
 }
 
 %>
   </body>
</html>
