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
function mydel_dom(val)
{
/*var r=confirm("Do you want to Delete User: "+val);
//alert(r);
if (r==true)
  {
  //alert("hi");
 document.getElementById(""+val).href ="/unifiedmail/servlet/DelelteUserServlet?ml="+val;
   
  }
  */
if(val.indexOf("postmaster@")==0)
{
alertify.alert("Postmaster can not be deleted.");
}
else
{
alertify.confirm("Do you want to Delete User: "+val+"<br><br>", function (e) {
				if (e) {
					//alertify.success("You've clicked OK");
					window.location="/unifiedmail/servlet/DelelteUserServlet?ml="+val;
					//document.getElementById(""+val).href ="/unifiedmail/servlet/DelelteUserServlet?ml="+val;
				} else {
					alertify.error("You've clicked Cancel");
				}
			});
			
	}		

}





</script>

<script type="text/javascript">
	function userData(u)
	{
	
	//var uid=document.f.uid.value;
	//var ml=uid;
	
	var dm=document.getElementById("hid_dm").value;

	
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
    xmlhttp.open("GET","/unifiedmail/global/userlistdata.jsp?val="+uid+"&no="+no+"&dm="+dm,true);
   //var xx=document.f.chk.value;
   //alert(xx);
    xmlhttp.send();
  
	}
	
	
	
	function userRecord(no)
	{
	//alert(no)

	var dm=document.getElementById("hid_dm").value;
	
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
    xmlhttp.open("GET","/unifiedmail/global/userlistdata.jsp?val="+uid+"&no="+no+"&dm="+dm,true);
   //var xx=document.f.chk.value;
   //alert(xx);
    xmlhttp.send();
	
	}
	
	
checked=false;
function checkedAll (frm1) {
	var aa= document.getElementById('frm1');
	 if (checked == false)
          {
           checked = true
          }
        else
          {
          checked = false
          }
	for (var i =0; i < aa.elements.length; i++) 
	{
	 aa.elements[i].checked = checked;
	}
      }
      
	
	function editData(frm)
{
var chk_arr =  document.getElementsByName("CheckboxGroup1");
var chklength = chk_arr.length;
var str="";
var str1="";
//alert(chklength);
if(chklength<=0)
{
alert("Records are not founds.");
 return false;
}
else
{
var f=0;
for (var i = 0; i < chklength; i++) {  
     if (chk_arr[i].checked==true) {
        
     f=f+1;
   
    }  
  }
  if(f==0)
  {
  alert("Please Select atleast one User.");
  return false;
  }
  else
  {
  if(document.getElementById('action').value=="index")
  {
  alert('Please select action');
   return false;
  }
  else if(document.getElementById('action').value=="common")
  {
  var dn=document.getElementById("hid_dm").value;
  document.f.action = "/unifiedmail/global/editusercommon.jsp?dm="+dn;
   return true;
  }
  else
  {
  document.f.action = "/unifiedmail/servlet/EditUserAtionServlet";
   return true;
  }
  }
  
}
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
   <%@include file="header.jsp" %>
   <div class="container main-admin">
   <%
        String dm=request.getParameter("dm");
        if(dm==null)
        {
        dm="";
        }
         %>
   <div class="sublev-nav">	
   	<ul>
   		<li><a href="/unifiedmail/global/domainlist.jsp">All Domains</a></li>
<li><a href="/unifiedmail/global/editdomainprofile.jsp?dn=<%=dm %>"><%=dm %></a></li>
<li><a class="active-subs" href="/unifiedmail/global/userslist.jsp?dm=<%=dm %>">Users</a></li>
<li><a href="/unifiedmail/global/maillistslist.jsp?dm=<%=dm %>">Mail Lists</a></li>
<li><a href="/unifiedmail/global/mailaliaseslist.jsp?dm=<%=dm %>">Mail Aliases</a></li>
   	</ul>
   	<div class="clr"></div>
   	</div>
   
   
        <form name="f" id="frm1" method="post" action="" onsubmit="return editData(this.form)">
        
  <input type="hidden" name="hid_dm" id="hid_dm" value="<%=dm %>" />
    <div class="add-domain-rightbar fwid">
    
     
    <%
    String stt=request.getParameter("msg");
    if(stt!=null)
    {  
   
     %>
     <div class="main-heading2" id="msg_suc"> Selected account has been <%=stt %>. <span class="close">	<a onclick="removeMsg('msg_suc')" title="click me to remove" style="cursor: pointer;">X</a>	</span>	</div>
      <%}
      %>
    
                	
                	<div class="main-heading">	Users under domain: <%=dm %>	</div>
                    <div class="row-one">
                    	<div class="iconic-btn">	<a href="/unifiedmail/global/addalias.jsp?dm=<%=dm %>"><span><img src="/unifiedmail/images/add-icon.png" /></span>Mail Alias</a>	</div>
                	  <div class="iconic-btn">	<a href="/unifiedmail/global/addmaillist.jsp?dm=<%=dm %>"><span><img src="/unifiedmail/images/add-icon.png" /></span>Mail List</a>	</div>
                    	<div class="iconic-btn">	<a   href="/unifiedmail/global/adduser.jsp?dm=<%=dm %>"><span><img src="/unifiedmail/images/add-icon.png" /></span>User</a>	</div>
                      
                       
                         <div class="clr"></div>
                    	</div><!--end row-one-->
                       <div class="domain-wrapper2" id="div1">
                        
                       
                       
                       
                       
                       
                       
                       
                       
                       </div>
                       
                                
                                <div class="action-wrap">
                                	<div class="action-one">
                                    	<select id="action" name="action" class="action1111">
                                        	<option value="index" >	Choose Action	</option>
                                        	<option value="active">Enable</option>
                                        	<option value="disabled">Disable</option>
                                        	 <option disabled>-----------</option>
                                        	  <option value="common">Common Field Edit</option>
                                        	
                                        </select>
                                        <input name="" type="submit" class="apply" value="Apply" />
                                    	</div>
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
                                
                                        </select>
                                        <label>Per Page</label>
                                    	</div>
                                    	</div>
                                	</div>
                        
                	</div>
                	</form>
                <div class="clr"></div>
  
   </div>
   <%@include file="footer.jsp" %>
  </body>
</html>
