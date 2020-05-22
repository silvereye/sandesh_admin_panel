<%@ page language="java" import="java.util.*,java.io.*,java.sql.*,dbutil.*" pageEncoding="ISO-8859-1"%>
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
 <script type="text/javascript">


function hi()
	{
	//alert(nm);
	//alert(act);
 	
	var vall=null;
	var ou=document.getElementById("ou").value;
	var uid=document.getElementById("uid").value;
	var att=document.getElementById("att").value;
	var val=document.getElementById("val").value;
	
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
  
    if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
 
    var vall=xmlhttp.responseText;
   alert("success");
   
    	//document.getElementById("div1").innerHTML = vall; 
    }
    }
xmlhttp.open("GET","/managemail/dashboard/test2.jsp?ou="+ou+"&uid="+uid+"&att="+att+"&val="+val,true);
xmlhttp.send();
    

	}

</script>
</head>
<body>
<input type="text" id="ou" /><br>
<input type="text" id="uid" /><br>
<input type="text" id="att" /><br>
<input type="text" id="val" /><br>
<input type="button" value="test" onclick="hi()">
</body>
</html>