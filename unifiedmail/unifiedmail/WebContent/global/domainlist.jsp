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
    <base href="<%=basePath%>">
    
    <title>Domain List | Silvereye Unified E-mail Server</title>
 <noscript><meta http-equiv="refresh" content="0; URL=/unifiedmail/error/nojavascritp3.jsp"></noscript>

	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link rel="stylesheet" type="text/css" href="/unifiedmail/css/mytooltip.css" />
<script type="text/javascript">
function mydel_dom(val)
{
/*var r=confirm("Do you want to Delete Domain: "+val);
//alert(r);
if (r==true)
  {
  //alert("hi");
 document.getElementById(""+val).href ="/unifiedmail/servlet/DelelteDomainServlet?dm="+val;
   
  }
*/


alertify.confirm("Do you want to Delete Domain: "+val+"<br><br>", function (e) {
				if (e) {
					//alertify.success("You've clicked OK");
					window.location="/unifiedmail/servlet/DelelteDomainServlet?dm="+val;
					//document.getElementById(""+val).href ="/unifiedmail/servlet/DelelteUserServlet?ml="+val;
				} else {
					alertify.error("You've clicked Cancel");
				}
			});
}

</script>
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
    document.getElementById("hidc").value = vall; 
	document.getElementById("valtxt").value = 1;
	showData();
    }
    }
    xmlhttp.open("GET","/unifiedmail/servlet/CountDomainServlet?val="+uid,true);
   //var xx=document.f.chk.value;
   //alert(xx);
    xmlhttp.send();
  
	}
	
	
	
	function userRecord(no)
	{
	//alert(no)

			document.getElementById("valtxt").value = 1;
	    	document.getElementById("hidperpage").value = no;
	    	showData();
	/* 
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
    xmlhttp.open("GET","/unifiedmail/global/domainlistdata.jsp?val="+uid+"&no="+no,true);
   //var xx=document.f.chk.value;
   //alert(xx);
    xmlhttp.send();
	 */
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
  alert("Please Select atleast one Domain.");
  return false;
  }
  else
  {
  if(document.getElementById('action').value=="index")
  {
  alert('Please select action');
   return false;
  }
  else
  {
  document.f.action = "/unifiedmail/servlet/EditDomainAtionServlet";
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

function start()
{
document.getElementById("valtxt").value="1";
//document.f.hid.value="start";
showData();
}

function lastOne()
{
var v=document.getElementById("valtxt").value;
var v1=document.getElementById("hidc").value;
var per=document.getElementById("hidperpage").value;
var perpg=10;
try
{
	perpg=parseInt(per);
}
catch (e) {
	// TODO: handle exception
}
var no=parseInt(v);
var no1=parseInt(v1);
//alert(no);
if(no1%perpg==0)
{
no1=parseInt(no1/perpg);
}
else
{
no1=parseInt(no1/perpg);
no1=no1+1;
}
if(no<no1)
{
no=no+1;
}
document.getElementById("valtxt").value=no;
//document.f.hid.value="mid";
showData();
}

function last()
{
var v=document.getElementById("hidc").value;
var per=document.getElementById("hidperpage").value;
var perpg=10;
try
{
	perpg=parseInt(per);
}
catch (e) {
	// TODO: handle exception
}
var no=1;
if(parseInt(v)>0)
no=parseInt(v);
//alert(no);
if(no%perpg==0)
{
no=parseInt(no/perpg);
}
else
{
no=parseInt(no/perpg);
no=no+1;
}
//alert(no);
document.getElementById("valtxt").value=no;
//document.f.hid.value="last";
showData();
}

function startOne()
{
var v=document.getElementById("valtxt").value;
//alert(v);


var no=parseInt(v);
if(no>1)
{
no=no-1;
}
document.getElementById("valtxt").value=no;
//document.f.hid.value="mid";
showData();
}

function showData()
{
var cnt=document.getElementById("hidc").value;
var v=document.getElementById("valtxt").value;
//var id=document.getElementById("hid_id").value;

//alert("dm="+dm);
//alert("v="+v);
//alert("cnt="+cnt);
//   var dt=document.f.hid.value;

//alert("hello="+v);

//alert(v+"  "+dt);
var vall=null;
//var dt=document.f.dt.value;
//var sel=document.f.filter.value;
//alert(dt+" "+sel)
document.getElementById('action_gif').style.display= 'block';
var perpg=document.getElementById("recordbottum").value;
//alert(perpg);
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

var vall=xmlhttp.responseText;
 //alert(vall);
document.getElementById('action_gif').style.display= 'none';
	document.getElementById("div1").innerHTML = vall; 
}
}
xmlhttp.open("GET","/unifiedmail/global/domainlistdata.jsp?val="+v+"&cnt="+cnt+"&uid="+uid+"&perpg="+perpg,true);
//var xx=document.f.chk.value;
//alert(xx);
xmlhttp.send();


}
</script>
  </head>
  
  <body onload="showData()">
  <div id="action_gif" class="my_notification"
		style="display: none; left: 46%;">Loading...</div>
   <%@include file="header.jsp" %>
   <%
   HttpSession hs=request.getSession(false);
  
   if(hs!=null)
   {
    %>
   <div class="container main-admin">
   
   
   
   
        <form name="f" id="frm1" method="post" action="" onsubmit="return editData(this.form)">
  
     <%
     String username=(String)hs.getAttribute("id");
     String password=(String)hs.getAttribute("password");
     String url=(String)hs.getAttribute("url");
     String base1=(String)hs.getAttribute("base");
        int cnt=0;
        cnt=NoOfUser.domCount(url,username,password,base1);
        
         %>
        
        <input type="hidden" id="hid_perm" name="hid_perm" value=""/>
        <input type="hidden" id="hidc" name="hid_cnt" value="<%=cnt %>"/>
  		<input type="hidden" id="hidperpage" name="hidperpage" value="10"/>
    <div class="add-domain-rightbar fwid">
    
     
    <%
    
     String utype=(String)hsession.getAttribute("user_name");
    String stt=request.getParameter("msg");
    if(stt!=null)
    {  
   
     %>
     <div class="main-heading2" id="msg_suc">Selected Domains were <%=stt %>. <span class="close">	<a onclick="removeMsg('msg_suc')" title="click me to remove" style="cursor: pointer;">X</a>	</span>	</div>
      <%
      }
      %>
    
                	
                	<div class="main-heading">	All Domain under your Control 
                    <div class="row-one">
                     <%
                  if(utype!=null && utype.equalsIgnoreCase("Admin"))
                  {
                   %>
                    	<div class="iconic-btn">	<a href="/unifiedmail/global/adddomain.jsp">Add Domain</a>	</div>
                    <%} %>
                       
                         <div class="clr"></div>
                    	</div>
                    		</div>
                    	<!--end row-one-->
                       <div class="domain-wrapper2" id="div1">
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       </div>
                       
                                
                                <div class="action-wrap">
                                	<!-- <div class="action-one">
                                    	<select id="action" name="action" class="action1111">
                                        	<option value="index" >	Choose Action	</option>
                                        	<option value="active">Enable</option>
                                        	<option value="disabled">Disable</option>
                                        	
                                        </select>
                                        <input name="" type="submit" class="apply" value="Apply" />
                                    	</div> -->
                                       
                                       <div class="actright">
                                        <div class="action-two">
                      
          <input type="button" value="<<" style="width: 35px;" class="apply" onclick="start()">
         <input type="button" value="<" style="width: 35px;" class="apply" onclick="startOne()">
         <input type="button" id="valtxt" style="width: 35px;" value="1" class="apply" onclick="showData()">
            <input type="button" value=">" style="width: 35px;" class="apply" onclick="lastOne()">
         <input type="button" value=">>" style="width: 35px;" class="apply" onclick="last()">
        
       
                                    	</div>
                                        <div class="action-two nobrd">
                                        <label>	Show	</label>
                    
                                    	<select name="sortbottum" id="sortbottum" onchange="userData(this.value)" class="showtool">
                                        	<option value="all" selected="selected">All</option>
                                  <option value="a">A</option>
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
                                     
                                    	<select name="recordbottum" id="recordbottum" onchange="userRecord(this.value)" class="showtool">
                                        	 
                                  <option value="10" selected="selected">10</option>
                                  <option value="20">20</option>
                                  <option value="50">50</option>
                                  
                                 
                                        </select>
                                       
                                    	</div>
                                    	</div>
                                	</div>
                        
                	</div>
                	</form>
                <div class="clr"></div>
  
   </div>
   <%} %>
   <%@include file="footer.jsp" %>
  </body>
</html>
