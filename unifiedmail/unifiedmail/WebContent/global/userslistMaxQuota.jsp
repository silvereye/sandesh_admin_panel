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
    	document.getElementById("hidc").value = vall; 
    	document.getElementById("valtxt").value = 1;
    	showData();
    }
    }
    xmlhttp.open("GET","/unifiedmail/servlet/CountUserServlet?val="+uid+"&dm="+dm,true);
   //var xx=document.f.chk.value;
   //alert(xx);
    xmlhttp.send();
  
	}
	
	function userRecord(no) {

		var dm=document.getElementById("hid_dm").value;
		var u=document.getElementById("sortbottum").value;
		
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
	    	document.getElementById("hidc").value = vall; 
	    	document.getElementById("valtxt").value = 1;
	    	document.getElementById("hidperpage").value = no;
	    	showData();
	    }
	    }
	    xmlhttp.open("GET","/unifiedmail/servlet/CountUserServlet?val="+uid+"&dm="+dm,true);
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
					
					
					var dn=document.getElementById("hid_dm").value;
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
function removeMsg(id)
{
var element = document.getElementById(id);
element.parentNode.removeChild(element);
//alert(id);
}

</script>
<script type="text/javascript">
function showData()
	{
	var cnt=document.getElementById("hidc").value;
	var v=document.getElementById("valtxt").value;
	//var id=document.getElementById("hid_id").value;
	var dm=document.getElementById("hid_dm").value;
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
    xmlhttp.open("GET","/unifiedmail/global/userlistdata1.jsp?val="+v+"&dm="+dm+"&cnt="+cnt+"&uid="+uid+"&perpg="+perpg,true);
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

</script>

  </head>
  
  <body >
    <div id="action_gif" class="my_notification"
		style="display: none; left: 46%;">Loading...</div>
   <%@include file="header.jsp" %>
   <div class="container main-admin">
   <%
        String dm=request.getParameter("dm");
        if(dm==null)
        {
        dm="";
        }
        HttpSession hs=request.getSession(false);
		        String username=(String)hs.getAttribute("id");
		        String password=(String)hs.getAttribute("password");
		        String url=(String)hs.getAttribute("url");
		        String base1=(String)hs.getAttribute("base");
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
        
        
        
        
        
        <input type="hidden" id="hid_perm" name="hid_perm" value=""/>
       
  <input type="hidden" name="hid_dm" id="hid_dm" value="<%=dm %>" />
  <input type="hidden" id="hidperpage" name="hidperpage" value="10"/>
    <div class="add-domain-rightbar fwid">
    
     
    <%
    
    String stt=request.getParameter("msg");
    if(stt!=null)
    {  
   
     %>
     <div class="main-heading2" id="msg_suc"> Selected account has been <%=stt %>. <span class="close">	<a onclick="removeMsg('msg_suc')" title="click me to remove" style="cursor: pointer;">X</a>	</span>	</div>
      <%}
      %>
    
                	
                	<div class="main-heading">	Quota Max used Users under domain: <%=dm %>
                	<div class="row-one">
                    	<div class="iconic-btn">	<a href="/unifiedmail/global/addalias.jsp?dm=<%=dm %>">Add Alias</a>	</div>
                	  <div class="iconic-btn">	<a href="/unifiedmail/global/addmaillist.jsp?dm=<%=dm %>">Add List</a>	</div>
                    	<div class="iconic-btn">	<a href="/unifiedmail/global/adduser.jsp?dm=<%=dm %>">Add User</a>	</div>
                      
                       
                         <div class="clr"></div>
                    	</div>
                		</div>
                   
                       <div class="domain-wrapper2" id="div1">
                        
                        <table width="100%" border="0" cellpadding="3" cellspacing="0" class="user-under-domain dlist1111">
    <thead>
    <tr>
    <td width="30" align="center"><input type="checkbox" name="checkall" value="checkbox" id="CheckboxGroup1_0" onclick='checkedAll(frm1);'/></td>
    <td width="220">Display Name</td>
    <td width="147" align="left">E-mail</td>
    <td width="183" align="center">Quota Status</td>
    <td width="80" align="center">Status</td>
  </tr>
    </thead>
                       
                       
                       <%
                                          try
                                          {
                                          String baseq="ou=Users,domainName="+dm+",o=domains,"+base1;//dc=springbirds,dc=co,dc=in";//"ou=Users,domainName="+arr_dm[i]+",o=domains"+(String)hs.getAttribute("base");
System.out.println("base: "+baseq);
DirContext ctx=LDAPConnection.getConnection(url, baseq, username, password);

String v3="";
String v2="";
String v1="";

SearchControls constraints = new SearchControls(); 
constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
String attrList[] = {"mail","accountStatus","cn"}; 
constraints.setReturningAttributes(attrList);
NamingEnumeration results =ctx.search(baseq,"mail=*", constraints);

while (results.hasMore()) {

String photo="";
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
        if(id.equalsIgnoreCase("mail"))
        {
        v3=str;
        }
        else if(id.equalsIgnoreCase("accountStatus"))
        {
        v2=str;
        }
        else if(id.equalsIgnoreCase("cn"))
        {
        v1=str;
        }
        


           System.out.println("  <br> "+id + ":--- " +str);
           }
    }
    if(!(v2.equalsIgnoreCase("active")))
    {
    continue;
    }

if(v3.indexOf("@")>0)
{
                           
                           
                           int per=0;
                            		int used=0;
                            		int tot=0;
                            	Quota q=new Quota();
                            	String s=q.getQuota(v3);
                            	s=s.trim();
		if(s!=null && !(s.equals("")))
		{
		String nstr[]=s.split(" ");
		int l1=nstr.length;
		int ct=0;
		for(l1--;true;l1--)
		{
		String ss=nstr[l1].trim();
		if(ss==null || ss.equals(" ") || ss.equals(""))
		{
		continue;
		}
		else
		{
		ct++;
		if(ct==1)
		{
		 per=Integer.parseInt(ss);
		}
		if(ct==2)
		{
		 tot=Integer.parseInt(ss);
		}
		if(ct==3)
		{
		 used=Integer.parseInt(ss);
		break;
		}
		}
		//out.print("<br>"+nstr[i]);
		}
		}
         if(per>80)
                        {                  
                                           %>
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         <tr class="grey">
    <td  width="30" align="center"><label>
      
      <input type="checkbox" name="CheckboxGroup1" id="checkbox" value="<%=v3 %>"/>
    </label></td>
     
    <td width="126"><%=v1 %></td>
    <td width="300" align="left"><a target="_blank" href="/unifiedmail/global/edituserprofile.jsp?ml=<%=v3 %>"><%=v3 %></a></td>
     
    <td width="120" align="center">
    
    
    <%
 
		if(v2.equalsIgnoreCase("active"))
		{
 		
                            		
		
		
                            	 %>
    
   
    <table border="1"  style="border-style: inherit; ">
                            <tr height="10px" >
                            <%if(per<80)
                            { 
                            if(per>=10)
                            {%>
                            <td style="background-color: green" bgcolor="green" width="8px" ></td>
                            <%}
                            else
                            { %>
                            <td  style="background-color: white; " bgcolor="white;" width="8px" ></td>
                            <%}
                            if(per>=20)
                            {
                             %>
                              <td style="background-color: green " bgcolor="green" width="8px" ></td>
                              <%}
                              else
                              { %>
                            <td style="background-color: white;" bgcolor="white;" width="8px" ></td>
                            <%} 
                             if(per>=30)
                            {
                             %>
                              <td style="background-color: green"  bgcolor="green" width="8px" ></td>
                              <%}
                              else
                              { %>
                            <td style="background-color: white;" bgcolor="white;" width="8px" ></td>
                            <%} 
                             if(per>=40)
                            {
                             %>
                              <td style="background-color: green"  bgcolor="green" width="8px" ></td>
                              <%}
                              else
                              { %>
                            <td style="background-color: white;" bgcolor="white;" width="8px" ></td>
                            <%} 
                            if(per>=50)
                            {
                             %>
                              <td style="background-color: green"  bgcolor="green" width="8px" ></td>
                              <%}
                              else
                              { %>
                            <td style="background-color: white;"  bgcolor="white;" width="8px" ></td>
                            <%} 
                            if(per>=60)
                            {
                             %>
                              <td style="background-color: green" bgcolor="green" width="8px" ></td>
                              <%}
                              else
                              { %>
                            <td style="background-color: white;"  bgcolor="white;" width="8px" ></td>
                            <%} 
                             if(per>=70)
                            {
                             %>
                              <td style="background-color: green" bgcolor="green" width="8px" ></td>
                              <%}
                              else
                              { %>
                            <td style="background-color: white;" bgcolor="white;" width="8px" ></td>
                            <%} 
                            %>
                           
                            <td style="background-color: white;"  bgcolor="white;" width="8px" ></td>
                            <td  style="background-color: white;" bgcolor="white;" width="8px" ></td>
                            <td  style="background-color: white;" bgcolor="white;" width="8px" ></td>
                            
                            <%}
                            else
                            {
                             %>
                            <td style="background-color: #B2170C"  bgcolor="#B2170C" width="8px" ></td>
                            <td style="background-color: #B2170C" bgcolor="#B2170C" width="8px" ></td>
                            <td style="background-color: #B2170C" bgcolor="#B2170C" width="8px" ></td>
                            <td style="background-color: #B2170C"  bgcolor="#B2170C" width="8px" ></td>
                            <td style="background-color: #B2170C" bgcolor="#B2170C" width="8px" ></td>
                            <td style="background-color: #B2170C" bgcolor="#B2170C" width="8px" ></td>
                            <td style="background-color: #B2170C" bgcolor="#B2170C" width="8px" ></td>
                            <td  style="background-color: #B2170C" bgcolor="#B2170C" width="8px" ></td>
                           <%if(per>=90) 
                           {%>
                            <td style="background-color: #B2170C"  bgcolor="#B2170C" width="8px" ></td>
                            <%}
                            else
                            { %>
                            <td style="background-color: white;"  bgcolor="white;" width="8px" ></td>
                            <%}
                            if(per>=100)
                            {
                             %>
                            <td style="background-color: #B2170C" bgcolor="#B2170C" width="8px" ></td>
                            <%}
                            else
                            { %>
                             <td style="background-color: white;" bgcolor="white;" width="8px" ></td>
                             <%}} %>
                       </tr></table>
 <%
                            	 String usedstr="";
                            	 String totstr="";
                            	 
                            	if((tot/1024/1024)>0) 
    {
   tot=tot/1024/1024;
  totstr=""+tot+"GB";
    } 
    else if((tot/1024)>0) 
    {
     tot=tot/1024;
     totstr=""+tot+"MB";
  } 
    else
    {
    totstr=""+tot+"KB";
   }
      							
      							if((used/1024/1024)>0)
     {
     used=used/1024/1024;
     usedstr=""+used+"GB";
} 
    else   if((used/1024)>0)
     {
     used=used/1024;
       usedstr=""+used+"MB";
       } 
    else
    {
     usedstr=""+used+"KB";
    }
      							
      							                      	 
                 %>           	

 <font class="dlimit">
   <%=usedstr %>/<%=totstr %>&nbsp; <%=per %>% Used
    </font> 
    <%}
    else
    {
     %>
     <font class="dlimit">
   Disabled Account
    </font> 
     <%} %>
</td>
   
    <td width="120" align="center"><table width="60%">
      <tr>
       <%
		if(v2.equalsIgnoreCase("active"))
		{
 		%>
         <td>
         <a class="tooltips" ><img src="/unifiedmail/images/right_mark.png" />
<span>Enabled</span></a>
         </td>
         <%}
         else
         { %>
        <td>
        <a class="tooltips" ><img  src="/unifiedmail/images/image1.png" />
<span>Disabled</span></a>
        </td>
       <%} %>
       <td>
       <a class="tooltips" href="/unifiedmail/global/usersentmails.jsp?ml=<%=v3 %>"><img src="/unifiedmail/images/flow_mark.png" />
<span>Account activity</span></a>
       </td>
        <td>
        <%
        
         %>
        <a class="tooltips" id="<%=v3 %>"><img src="/unifiedmail/images/delete-icon.png"  name="<%=v3 %>" onclick="mydel_dom(this.name)"/>
<span>Delete</span></a>

        </td>
      </tr>
    </table></td>
  </tr>
    <tr><td></td></tr>                                     
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                        <%}
                                        else
                                        { %> 
                                    <%--  <li>	<span class="sender-title-name"><%=v3 %></span> <span class="noof-mails-present"><%=per %>	</span>	</li>
                                      --%>               
                                            
                                    
                                    <%}
                                    }
                                    }

LDAPConnection.closeConn(ctx);
}
catch(Exception e){System.out.print(e);
                                    }
                          %>
                       
                       
                       
                       </table>
                       
                       
                       </div>
                       
                                
                               
                        
                	</div>
                	</form>
                <div class="clr"></div>
  
   </div>
   <br>  <br>  
   <%@include file="footer.jsp" %>
  </body>
</html>
