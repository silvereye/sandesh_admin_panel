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
 
    
  <title>User Search | Silvereye Unified E-mail Server</title>
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

	var pat="";
	var dm=$("#domain").val();
	var fil=$("#filter").val();
	if(fil=="accountStatus")
	{
		pat=$("#accPat").val();
	}
	else{
	pat=$("#sPat").val();
	}
	
	alertify.confirm("Do you want to Delete User: "+val+"<br><br>", function (e) {
				if (e) {
					//alertify.success("You've clicked OK");
					window.location="/unifiedmail/servlet/DelelteUserSearchServlet?ml="+val+"&page=advance&dm="+dm+"&fil="+fil+"&pat="+pat;
					//document.getElementById(""+val).href ="/unifiedmail/servlet/DelelteUserServlet?ml="+val;
				} else {
					alertify.error("You've clicked Cancel");
				}
			});
			
	}		

}





</script>

<script type="text/javascript">

	
	
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
   
   function deleteAll(){
	   document.getElementById("hid_perm").value="del";
	   if(document.f.onsubmit &&   !document.f.onsubmit())
			    {
			        return;
			    }
	  
			 document.f.submit();
}
function editcomfield(frm) {
	document.getElementById("hid_perm").value="edit";
    if(document.f.onsubmit &&  !document.f.onsubmit())
    {
        return;
    }
    
 document.f.submit();
}
	
	function editData(frm)
{
		var ml_val="";
		 var perm=document.getElementById("hid_perm").value;
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
    	 if(chk_arr[i].value.indexOf("postmaster@")==0 && perm=="del")
    		 {
    		 f=-1;
    		 break;
    		 }
    	 else
    		 {
     		f=f+1;
     		if(ml_val=="")
     			{
     			ml_val=chk_arr[i].value;
     			}
     		else
     			{
     			ml_val+=","+chk_arr[i].value;
     			}
    		 }
    }  
  }
if(f==-1)
{
	alertify.alert("Postmaster can not be deleted.");
return false;
}
else if(f==0)
  {
  alert("Please Select atleast one User.");
  return false;
  }
  else
  {
  /* if(document.getElementById('action').value=="index")
  {
  alert('Please select action');
   return false;
  }
  else 
  { */

		var pat="";
		var dm=$("#domain").val();
		var fil=$("#filter").val();
		if(fil=="accountStatus")
		{
			pat=$("#accPat").val();
		}
		else{
		pat=$("#sPat").val();
		}
		
	  
	  if(perm=="edit")
		  {
  			var dn=document.getElementById("hid_dm").value;
  			document.f.action = "/unifiedmail/global/editusercommon.jsp?dm="+dn;
   			return true;
		  }
	  else  if(perm=="del")
	  {
		  alertify.confirm("Do you want to Delete All selected Users<br><br>", function (e) {
				if (e) {
					
					window.location="/unifiedmail/servlet/DelelteSelectedUserSearchServlet?ml_val="+ml_val+"&page=advance&dm="+dm+"&fil="+fil+"&pat="+pat;
					//var dn=document.getElementById("hid_dm").value;
					//window.location="/unifiedmail/servlet/DelelteUserServlet?dm="+dm+"&ml_val="+ml_val;
		 			//return true;
				} else {
					alertify.error("You've clicked Cancel");
					return false;
				}
			});
		  
			
		  }
 // }
 /*  else if(document.getElementById('action').value=="common")
  {
  var dn=document.getElementById("hid_dm").value;
  document.f.action = "/unifiedmail/global/editusercommon.jsp?dm="+dn;
   return true;
  }
  else
  {
  document.f.action = "/unifiedmail/servlet/EditUserAtionServlet";
   return true;
  } */
  }
  
}
}
	</script>

<script type="text/javascript">
function advUserSearch() {
	var spat="";
	document.getElementById("hid_dm").value=$("#domain").val();
	var fil=$("#filter").val();
	document.getElementById("hid_fil").value=fil;
	document.getElementById("hidperpage").value=$("#recordbottum").val();
	if(fil=="accountStatus")
	{
		spat=$("#accPat").val();
		document.getElementById("hid_pat").value=spat;
	}
else{
	spat=$("#sPat").val();
	document.getElementById("hid_pat").value=spat;
}
	if(spat!=null && spat!="")
		{
		document.getElementById("hidc").value=10;
		showData();
		}
	else
		{
		alert("Please input search pattern!");
		}
}

function showData()
	{
	var cnt=document.getElementById("hidc").value;
	var v=document.getElementById("valtxt").value;
	var pat=document.getElementById("hid_pat").value;
	var fil=document.getElementById("hid_fil").value;
	var dm=document.getElementById("hid_dm").value;
	var perpg=document.getElementById("hidperpage").value;
	if(pat!=null && pat!="")
		{
		pat="*"+pat+"*";
		}
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
   // alert(vall);
   document.getElementById('action_gif').style.display= 'none';
   var arr=vall.split("<$nps$>");
   if(arr.length==3)
	   {
	   document.getElementById("div1").innerHTML = arr[0]+arr[2]; 
	   document.getElementById("hidc").value=arr[1];
	   }
   else
	   {
    	document.getElementById("div1").innerHTML = arr[0]; 
	   }
    }
    }
    xmlhttp.open("GET","/unifiedmail/global/advanceusersearchdata.jsp?val="+v+"&dm="+dm+"&cnt="+cnt+"&pat="+pat+"&perpg="+perpg+"&fil="+fil,true);
   //var xx=document.f.chk.value;
   //alert(xx);
    xmlhttp.send();
    

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


function chkFilter(val) {
	if(val=="accountStatus")
		{
		$("#pat1").hide();
		$("#pat2").show();
		}
	else{
		$("#pat2").hide();
		$("#pat1").show();
	}
}
</script>

  </head>
  
  <body onload="advUserSearch()" >
    <div id="action_gif" class="my_notification"
		style="display: none; left: 46%;">Loading...</div>
   <%@include file="header.jsp" %>
   <div class="container main-admin">
   <%
       
        HttpSession hs=request.getSession(false);
		        String username=(String)hs.getAttribute("id");
		        String password=(String)hs.getAttribute("password");
		        String url=(String)hs.getAttribute("url");
		        String base1=(String)hs.getAttribute("base");
		        String base="o=domains,"+base1;
         %>

   
   
        <form name="f" id="frm1" method="post" action="" onsubmit="return editData(this.form)">
        
        
        
        <%
        int cnt=10;
        
         %>
        
        <input type="hidden" id="hid_perm" name="hid_perm" value=""/>
        <input type="hidden" id="hidc" name="hid_cnt" value="<%=cnt %>"/>
  <input type="hidden" name="hid_dm" id="hid_dm" value="" />
  <input type="hidden" name="hid_pat" id="hid_pat" value="" />
  <input type="hidden" name="hid_fil" id="hid_fil" value="" />
  <input type="hidden" id="hidperpage" name="hidperpage" value="10"/>
    <div class="add-domain-rightbar fwid">
    
     
    <%
    String dm="";
    String pat="";
    String fil="";
    if(request.getParameter("dm")!=null)
    	dm=request.getParameter("dm");
    
    if(request.getParameter("pat")!=null)
    	pat=request.getParameter("pat");
    
    if(request.getParameter("fil")!=null)
    	fil=request.getParameter("fil");
    
    String stt=request.getParameter("msg");
    if(stt!=null)
    {  
   
     %>
     <div class="main-heading2" id="msg_suc"> Selected account has been <%=stt %>. <span class="close">	<a onclick="removeMsg('msg_suc')" title="click me to remove" style="cursor: pointer;">X</a>	</span>	</div>
      <%}
      %>
    
                	
                	<div class="main-heading">	
                <span>	Domain <select style="width: 150px;" name="domain" id="domain" >
                                        
                                           
                                <%
                                   
		        
try
{


DirContext ctx=LDAPConnection.getConnection(url, base, username, password);

SearchControls constraints = new SearchControls(); 
constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
String attrList[] = {"domainName"}; 
constraints.setReturningAttributes(attrList);
NamingEnumeration results =ctx.search(base,"domainName=*", constraints);
int f=0;
while (results.hasMore()) {
f=1;
    SearchResult si =(SearchResult)results.next();
    String ck=si.getName();
   System.out.println("<br><br><br>"+ck);
    Attributes attrs = si.getAttributes();

    if (attrs == null) {
       out.println("   No attributes");
        continue;
    }
    NamingEnumeration ae = attrs.getAll(); 
    while (ae.hasMoreElements()) {
        Attribute attr =(Attribute)ae.next();
        String id = attr.getID();
        Enumeration vals = attr.getAll();
        while (vals.hasMoreElements())
        {
        String str= vals.nextElement().toString();
        if(dm.equalsIgnoreCase(str))
        {
        	%>
    		<option selected="selected" value="<%=str %>"><%=str %></option>
    		<%
        }
        else
        {
		   if(id.endsWith("@"+str))  
		  {    
		%>
		<option selected="selected" value="<%=str %>"><%=str %></option>
		<%
		}
		else
		{
		%>
		<option value="<%=str %>"><%=str %></option>
		<%
		}
        }
           //out.println("  <br> "+id + ":--- " +str);
           }
    }}
ctx.close();                                    
}
                             //   "givenName","initials", "sn", "cn","accountStatus","forcePasswordChange","FTPStatus","FTPQuotaMBytes","enabledService","memberOfGroup","mailQuota","jpegPhoto","anniversary","dateOfJoining","dateOfBirth","mobile","homePhone","telephoneNumber","postalAddress","postalCode","preferredLanguage"
		 catch(Exception e){System.out.print(e);}  %>
                                        
                                    </select></span>
                                    
                                    <span style="margin-left: 30px;">
                                    Filter <select style="width: 150px;" name="filter" id="filter" onchange="chkFilter(this.value)">
                                    <%if(fil.equalsIgnoreCase("mail")) 
                                    {
                                    %>
                                     <option value="mail" selected="selected">Email</option>
                                     <%}
                                    else
                                    {
                                    %>
                                    <option value="mail">Email</option>
                                    <%} %>
                                     <%if(fil.equalsIgnoreCase("givenName")) 
                                    {
                                    %>
                                    <option value="givenName" selected="selected"> First Name</option>
                                    <%}
                                    else
                                    {
                                    %>
                                     <option value="givenName"> First Name</option>
                                     <%} %>
                                     <%if(fil.equalsIgnoreCase("sn")) 
                                    {
                                    %>
                                    <option value="sn" selected="selected"> Last Name</option>
                                    <%}
                                    else
                                    {
                                    %>
                                     <option value="sn"> Last Name</option>
                                     <%} %>
                                     <%if(fil.equalsIgnoreCase("cn")) 
                                    {
                                    %>
                                    <option value="cn" selected="selected">Full Name </option>
                                    <%}
                                    else
                                    {
                                    %>
                                    <option value="cn">Full Name </option>
                                    <%} %>
                                    <%if(fil.equalsIgnoreCase("accountStatus")) 
                                    {
                                    %>
                                    <option value="accountStatus" selected="selected">Account Status </option>
                                    <%}
                                    else
                                    {
                                    %>
                                    <option value="accountStatus">Account Status </option>
                                    <%} %>
                                    <%if(fil.equalsIgnoreCase("mobile")) 
                                    {
                                    %>
                                    <option value="mobile" selected="selected">Mobile </option>
                                    <%}
                                    else
                                    {
                                    %>
                                    <option value="mobile">Mobile </option>
                                    <%} %>
                                    <%if(fil.equalsIgnoreCase("homePhone")) 
                                    {
                                    %>
                                    <option value="homePhone" selected="selected">Home Phone </option>
                                    <%}
                                    else
                                    {
                                    %>
                                     <option value="homePhone">Home Phone </option>
                                     <%} %>
                                     <%if(fil.equalsIgnoreCase("postalCode")) 
                                    {
                                    %>
                                    <option value="postalCode" selected="selected"> Postal Code</option>
                                    <%}
                                    else
                                    {
                                    %>
                                    <option value="postalCode"> Postal Code</option>
                                    <%} %>
                                    
                                    </select></span>
                                    <%
                                    String css1="margin-left: 30px;";
                                    String css2="margin-left: 30px; display: none;";
                                    String patval="";
                                    if(pat.equalsIgnoreCase("active") || pat.equalsIgnoreCase("disabled")  )
                                    {
                                    	css1+="  display: none;";
                                    	css2="margin-left: 30px;";
                                    }
                                    else
                                    {
                                    	if(pat.length()>0)
                                    	{
                                    	patval=pat;
                                    	}
                                    	
                                    }
                                    %>
                                    <span id="pat1" style="<%=css1 %>">
                                    Pattern <input type="text" size="22" id="sPat" value="<%=patval %>"/></span>
                                    <span id="pat2" style="<%=css2 %>">
                                    Pattern <select style="width: 150px;" name="accPat" id="accPat" >
                                    <%
                                    if(pat.equalsIgnoreCase("active"))
                                    {
                                    %>
                                    <option value="active" selected="selected">Enable</option>
                            		<option value="disabled">Disable</option>
                            		<%
                                    }
                                    else if(pat.equalsIgnoreCase("disabled") )
                                    {
                            		%>
                            		<option value="active">Enable</option>
                            		<option value="disabled" selected="selected">Disable</option>
                            		<%
                            		}
                            		else
                            		{
                            		%>
                            		<option value="active">Enable</option>
                            		<option value="disabled">Disable</option>
                            		<%} %>
                                    </select>
                                    </span>
                                    <span style="margin-left: 30px;">Show/Page
                                    <select name="recordbottum" id="recordbottum"  class="showtool">
                               
                                  <option value="10" selected="selected">10</option>
                                  <option value="20">20</option>
                                  <option value="50">50</option>
                                 
                                </select>
                                    </span>
                	<div class="row-one">
                    	<div class="iconic-btn" onclick="advUserSearch()">	<a >Search</a>	</div>
                        <div class="clr"></div>
                    	</div>
                		</div>
                   
                       <div class="domain-wrapper2" id="div1">
                        
                       
                       
                       
                       
                       
                       
                       
                       
                       </div>
                       
                                
                                <div class="action-wrap">
                                	<div class="action-one">
                                    	<!-- <select id="action" name="action" class="action1111">
                                        	<option value="index" >	Choose Action	</option>
                                        	<option value="active">Enable</option>
                                        	<option value="disabled">Disable</option>
                                        	 <option disabled>-----------</option>
                                        	  <option value="common">Common Field Edit</option>
                                        	<input name="" type="submit" class="apply" value="Apply" />
                                        </select> -->
                                        
                                        <div class="file-actions">
                        	<ul>
                            	
                                <li onclick="editcomfield(this.form)" style="cursor: pointer;"><a id="myLink" >Edit</a></li>
                                <li onclick="deleteAll()" style="cursor: pointer;"><a id="myLink1" >Delete</a></li>
                            </ul>
                        </div>
                                    	</div>
                                        <div class="actright">
                                        
                                        <div style="    margin-left: -6px;" class="action-two">
                                      <%
String fst="<<";
String prv="<";
%>
  
      
          <input type="button" value="<%=fst %>" style="width: 35px;" class="apply" onclick="start()"/>
         <input type="button" value="<%=prv %>" style="width: 35px;" class="apply" onclick="startOne()"/>
         <input type="button" id="valtxt" style="width: 35px;" value="1" class="apply" onclick="showData()"/>
            <input type="button" value=">" style="width: 35px;" class="apply" onclick="lastOne()"/>
         <input type="button" value=">>" style="width: 35px;" class="apply" onclick="last()"/>
        
    

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
