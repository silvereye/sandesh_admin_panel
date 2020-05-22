<%@ page language="java" import="java.util.*,java.io.*,java.sql.*,mypack.*" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.regex.*" %>
<%@ page import="javax.naming.directory.*" %>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
HttpSession hs=request.getSession(false);
ModifyAtt ma=new ModifyAtt();
String ou=request.getParameter("ou");
String uid=request.getParameter("uid");
String att=request.getParameter("att");
String val=request.getParameter("val");
ma.modyfyAtt(hs,ou,uid,att,val);
%>
</body>
</html>