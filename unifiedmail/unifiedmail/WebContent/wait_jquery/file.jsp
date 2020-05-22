<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'file.jsp' starting page</title>
    
	    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.7.1.js"></script>
    <script type="text/javascript">
    $(function(){
    $('#f').change(function(){
    var f=this.files[0]
    alert(f.size||f.fileSize)
    alert(f.name)
    var sz=f.size
    if(sz>300)
    {
    document.getElementById("f").value="";
    }
    
    var nm=f.name;
    var narr=nm.split(".");
    alert(narr[1]);
    })
    })
    </script>
    <title>Untitled</title>
    </head>
    <body>
    <form>
    <input id="f" name="f" type="file" />
    </form>
    </body>
    </html>



