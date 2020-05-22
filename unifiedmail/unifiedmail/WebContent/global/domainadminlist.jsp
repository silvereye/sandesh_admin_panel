<%@ page language="java" import="java.util.*,mypack.*" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.regex.*" %>
<%@ page import="javax.naming.directory.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
 
    
  <title>User Lists | Silvereye Unified E-mail Server</title>
 <noscript><meta http-equiv="refresh" content="0; URL=/unifiedmail/error/nojavascritp3.jsp"></noscript>
  
	<meta http-equiv="pragma" content="no-cache" />
	<meta http-equiv="cache-control" content="no-cache" />
	<meta http-equiv="expires" content="0" />    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
	<meta http-equiv="description" content="This is my page" />
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" type="text/css" href="/unifiedmail/css/mytooltip.css" />


<script type="text/javascript">
	function userData(u)
	{
	
	//var uid=document.f.uid.value;
	//var ml=uid;
	
	
	
	var uid="";
	if(u=='all' || u==null || u=="")
	{
	//alert('all')
	uid="*";
	}
	else
	{
	uid=u+"*";
	}
	
	
	
	var y=document.f.recordbottum.selectedIndex;
		var no=document.f.recordbottum.options[y].value
	
	//alert(uid+"  "+no);
	
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
      //alert(xmlhttp.readyState);
    if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
 
   vall=xmlhttp.responseText;
     // alert(vall);
    	document.getElementById("div1").innerHTML = vall; 
    }
    }
    xmlhttp.open("GET","/unifiedmail/global/domainadminlistdata.jsp?val="+uid+"&no="+no,true);
   //var xx=document.f.chk.value;
   //alert(xx);
    xmlhttp.send();
  
	}
	
	
	
	function userRecord(no)
	{
	//alert(no)

	
	var i=document.f.sortbottum.selectedIndex;
	var u=document.f.sortbottum.options[i].value;
	var uid="";
	if(u=='all')
	{
	//alert('all')
	uid="*";
	}
	else
	{
	uid=u+"*";
	}
	//alert(uid+"  "+no);

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
      //alert(xmlhttp.readyState);
    if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
 
   vall=xmlhttp.responseText;
     // alert(vall);
    	document.getElementById("div1").innerHTML = vall; 
    }
    }
    xmlhttp.open("GET","/unifiedmail/global/domainadminlistdata.jsp?val="+uid+"&no="+no,true);
   //var xx=document.f.chk.value;
   //alert(xx);
    xmlhttp.send();
	
	}
	

	</script>
	<script type="text/javascript">
function removeMsg(id)
{
var element = document.getElementById(id);
element.parentNode.removeChild(element);
//alert(id);
}

</script>
  </head>
  
  <body onload="userData()">
  <%
 HttpSession ses=request.getSession(false);
 String chid= (String)ses.getAttribute("id");
 if(chid==null)
{
System.out.println("hii dgfgf");
%>
<script type="text/javascript">
	window.open("/unifiedmail/login/login.jsp?val=ses", "_self", false);
	</script>
<%
}
else
{
 %>
   <%@include file="header.jsp" %>
   <div class="container main-admin">
    <%
          
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
   
        <form name="f" id="frm1" method="post" action="" onsubmit="return editData(this.form)">
        
 
    <div class="add-domain-rightbar fwid">
    
     
    <%
    String stt=request.getParameter("msg");
    if(stt!=null)
    {  
   
     %>
     <div class="main-heading2" id="msg_suc"> Selected accounts were <%=stt %>. <span class="close">	<a onclick="removeMsg('msg_suc')" title="click me to remove" style="cursor: pointer;">X</a>	</span>	</div>
      <%}
      %>
    
                	
                	<div class="main-heading">	Domain Admins 	</div>
                    <div class="row-one">
                    	
                         <div class="clr"></div>
                    	</div><!--end row-one-->
                       <div class="domain-wrapper2" id="div1">
                        
                       
                       
                       
                       
                       
                       
                       
                       
                       </div>
                       
                                
                                <div class="action-wrap">
                                	
                                        <div class="actright">
                                        <div class="action-two">
                                        <label>	Show	</label>
                                    	<select name="sortbottum" onchange="userData(this.value)" class="showtool">
                                        	<option value="all" selected="selected">All</option>
                                  <option value="a" >A</option>
                                  <option value="b">B</option>
                                  <option value="c">C</option>
                                  <option value="d">D </option>
                                  <option value="e">E </option>
                                  <option value="f">F </option>
                                  <option value="g">G </option>
                                  <option value="h">H </option>
                                  <option value="i">I </option>
                                  <option value="j">J </option>
                                  <option value="k">K </option>
                                  <option value="l">L </option>
                                  <option value="m">M </option>
                                  <option value="n">N </option>
                                  <option value="o">O </option>
                                  <option value="p">P </option>
                                 <option value="q">Q </option>
                                 <option value="r">R </option>
                                 <option value="s">S </option>
                                 <option value="t">T </option>
                                 <option value="u"> U</option>
                                 <option value="v"> V</option>
                                 <option value="w"> W</option>
                                 <option value="x"> X</option>
                                 <option value="y"> Y</option>
                                 <option value="z"> Z</option>

                                        </select>
                                        
                                    	</div>
                                        <div class="action-two nobrd">
                                        <label>	Show	</label>
                                    	<select name="recordbottum" onchange="userRecord(this.value)" class="showtool">
                                        	 <option value="5">5</option>
                                  <option  value="10" selected="selected">10</option>
                                  <option value="20">20</option>
                                  <option value="50">50</option>
                                  <option value="100">100</option>
                                 <option value="0">All</option>
                                        </select>
                                        <label>Per Page</label>
                                    	</div>
                                    	</div>
                                	</div>
                        
                	</div>
                	</form>
                <div class="clr"></div>
  <%} %>
   </div>
   <%@include file="footer.jsp" %>
   <%} %>
  </body>
</html>
