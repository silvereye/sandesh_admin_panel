<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
<%
String name=request.getParameter("name");
String action=request.getParameter("action");
String act="";
String cmmd="";
String act1="";
if(action.equalsIgnoreCase("Start"))
{
	act="-u";
	act1="start";
}
else  if(action.equalsIgnoreCase("Stop"))
{
	act="-d";
	act1="stop";
}
else if(action.equalsIgnoreCase("Restart"))
{
	act="-t";
	act1="restart";
}

String nm="";
if(name.equalsIgnoreCase("POP3") || name.equalsIgnoreCase("IMAP"))
{
	nm="imap";
	cmmd="sudo svc "+act+" /service/"+nm;
	
}
else if(name.equalsIgnoreCase("Anti-Spam") )
{
	nm="spamd";
	cmmd="sudo svc "+act+" /service/"+nm;
	
}
else if(name.equalsIgnoreCase("LDAP") )
{
	nm="ldap";
	cmmd="sudo svc "+act+" /service/"+nm;
}
else if(name.equalsIgnoreCase("Anti-Virus"))
{
	nm="clamd";
	cmmd="sudo svc "+act+" /service/"+nm;
}
else if(name.equalsIgnoreCase("SMTP"))
{
	
	cmmd="sudo /usr/sbin/service postfix "+act1;
}

//cmmd="sudo svc "+act+" /service/"+nm;
System.out.println("cmd>>"+cmmd);
try
{
	Process	p = Runtime.getRuntime().exec(cmmd); 	
}
catch(Exception e)
{
	System.out.print(e.toString());
	e.printStackTrace();
}

%>
</body>
</html>