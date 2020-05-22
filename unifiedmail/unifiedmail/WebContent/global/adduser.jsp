<%@ page language="java" import="java.util.*,mypack.*" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.regex.*" %>
<%@ page import="javax.naming.directory.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
    <title>Add User | Silvereye Unified E-mail Server</title>
 <noscript><meta http-equiv="refresh" content="0; URL=/unifiedmail/error/nojavascritp2.jsp"></noscript>
    
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/reset.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/screen.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/fancybox.css" />

    <!--[if IE 7]>
        <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/ie7.css">
    <![endif]-->


<link type="text/css" href="/unifiedmail/dtpic/jquery.datepick.css" rel="stylesheet" />
<link href='css/jquery.iphone.toggle.css' rel='stylesheet' />
<script type="text/javascript" src="/unifiedmail/dtpic/jquery.min.js"></script>
<script type="text/javascript" src="/unifiedmail/dtpic/jquery.datepick.js"></script>
<script type="text/javascript">

$.noConflict();
jQuery(document).ready(function($) {


$(function() {
$('#popupDatepicker').datepick({dateFormat: 'yyyy-mm-dd'});
	$('#popupDatepicker').datepick();
	//$('#inlineDatepicker').datepick({onSelect: showDate});
});

});

function showDate(date) {
	alert('The date chosen is ' + date);
}
</script>

    <script src="/unifiedmail/js/jquery.min.js"></script>
		<link href='https://fonts.googleapis.com/css?family=Vollkorn' rel='stylesheet' type='text/css' />		
   <script type="text/javascript">
   $(document).ready(function() {

	$('#password').keyup(function(){
		$('#result').html(checkStrength($('#password').val()))
	})	
	
	function checkStrength(password){
    
	//initial strength
    var strength = 0
	
    //if the password length is less than 6, return message.
    if (password.length < 6) { 
		$('#result').removeClass()
		$('#result').addClass('short')
		document.getElementById("hid_ps").value="0";
		return 'Too short' 
	}
    
    //length is ok, lets continue.
	
	//if length is 8 characters or more, increase strength value
	if (password.length > 7) strength += 1
	
	//if password contains both lower and uppercase characters, increase strength value
	if (password.match(/([a-z].*[A-Z])|([A-Z].*[a-z])/))  strength += 1
	
	//if it has numbers and characters, increase strength value
	if (password.match(/([a-zA-Z])/) && password.match(/([0-9])/))  strength += 1 
	
	//if it has one special character, increase strength value
    if (password.match(/([!,%,&,@,#,$,^,*,?,_,~])/))  strength += 1
	
	//if it has two special characters, increase strength value
    if (password.match(/(.*[!,%,&,@,#,$,^,*,?,_,~].*[!,%,&,@,#,$,^,*,?,_,~])/)) strength += 1
	
	//now we have calculated strength value, we can return messages
	
	//if value is less than 2
	if (strength < 2 ) {
		$('#result').removeClass()
		$('#result').addClass('weak')
		document.getElementById("hid_ps").value="0";
		return 'Weak'			
	} else if (strength == 2 ) {
		$('#result').removeClass()
		$('#result').addClass('good')
		document.getElementById("hid_ps").value="1";
		return 'Good'		
	} else {
		$('#result').removeClass()
		$('#result').addClass('strong')
		document.getElementById("hid_ps").value="2";
		return 'Strong'
	}
}
});
   </script>
   <style type="text/css">
   
#result{
	margin-left:5px;
}

#register .short{
	color:#FF0000;
}

#register .weak{
	color:#E66C2C;
}

#register .good{
	color:#2D98F3;
}

#register .strong{
	color:#006400;
}
   </style>
   
   
   
   
   
   
   
   
   
  <link rel="stylesheet" href="/unifiedmail/css/tooltip.css" type="text/css" />
<script type="text/javascript">
function removeMsg(id)
{
var element = document.getElementById(id);
element.parentNode.removeChild(element);
//alert(id);
}

</script>
<script type="text/javascript">

function myUpper(mystring) {

var sp = mystring.split(' ');
var wl=0;
var f ,r;
var word = new Array();
for (i = 0 ; i < sp.length ; i ++ ) {
f = sp[i].substring(0,1).toUpperCase();
r = sp[i].substring(1);
word[i] = f+r;
}
newstring = word.join(' ');

return newstring
}



function nmUpper(mystring) {
var nm=myUpper(mystring);
document.getElementById("fn").value=nm;
}



function chkUser(val)
{
val=val.trim();
val=val.toLowerCase();
val=val.replace(" ", "");
//alert(val);
document.getElementById("mail").value=val;
var n = val.indexOf("@");
if(n>=0)
{
alert("Please input value without @")
document.getElementById("mail").value="";
 document.getElementById("sp1").innerHTML="";
}
else if(val!=null && val!="")
{
var dm=document.getElementById("domain").value;
if(dm=='index')
{
alert('Please Select domain.')
document.getElementById("mail").value="";
}
else
{
var usr=val+"@"+dm;
//alert(usr)


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
     if(vall=="0")
     {
      document.getElementById("sp1").innerHTML = "<font color='green'>Email id is correct.</font>";
	 }
	 else if(vall=="1")
	 {
	 document.getElementById("sp1").innerHTML = "<font color='red'>Email id is already exist.</font>";
	document.getElementById("mail").value="";
	 }
	 else
	 {
	 document.getElementById("sp1").innerHTML =vall;
	 }
	 
    }
    }
    xmlhttp.open("GET","/unifiedmail/servlet/CheckAliasMailServlet?mail="+usr+"&dm="+dm,true);
   //var xx=document.f.chk.value;
   //alert(xx);
    xmlhttp.send();
    }
    }
}


function isNum(val,nm,no)
{
if(isNaN(val)===true){
   document.getElementById("sp"+no).innerHTML ="<font color='red'>please input only numeric!</font>";
  document.getElementById(nm).value="";
  var hid=parseInt(document.getElementById("hid_qt").value);
 //alert(hid)
 if(hid!=-1)
 {
 var vl=hid;
 
 	document.getElementById("qt_msg").innerHTML ="Available quota:"+vl+"MB ("+vl/1024+"GB)";
  
 }
}
else if(val!="")
{


 document.getElementById("sp"+no).innerHTML ="";
 var hid=parseInt(document.getElementById("hid_qt").value);
 //alert(hid)
 if(hid!=-1)
 {
 var vl=hid-parseInt(val);
 if(vl>=0)
 	{
 	document.getElementById("qt_msg").innerHTML ="Available quota:"+vl+"MB ("+vl/1024+"GB)";
   }
 	else
 	{
 	  document.getElementById("sp"+no).innerHTML ="<font color='red'>please input valid limit!</font>";
  document.getElementById(nm).value="";
  if(hid!=-1)
 {
 var vl=hid;
 
 	document.getElementById("qt_msg").innerHTML ="Available quota:"+vl+"MB ("+vl/1024+"GB)";
  
 }
 	}
 }
}
else
{
 var hid=parseInt(document.getElementById("hid_qt").value);
if(hid!=-1)
{
document.getElementById("qt_msg").innerHTML ="Available quota:"+hid+"MB ("+hid/1024+"GB)";
}

}
}



function isNumUQT(val,nm,no)
{
if(isNaN(val)===true){
   document.getElementById("sp"+no).innerHTML ="<font color='red'>please input only numeric!</font>";
  document.getElementById(nm).value="";
  }
  }



function setNUrl(val)
  {
  if(val=="index")
  val="";
  var url="/unifiedmail/global/adduser.jsp?dm="+val;
 //alert(url)
 window.location=url;
  }

function setNCP() {
	document.getElementById("cnp").value="";
	document.getElementById("cnp_msg").innerHTML="";
}


function checkNCP(val) {
	if(val!="")
	{
	var val1=document.getElementById("password").value;
	if(val==val1)
	{
      document.getElementById("cnp_msg1").innerHTML = "<font color='green'>Confirm password is matched..</font>";
	 }
	 else
	 {
	 document.getElementById("cnp_msg1").innerHTML = "<font color='red'>Confirm password is not matched.</font>";
	document.getElementById("cnp").value="";
	 }
	 }
}


</script>

<script type="text/javascript">
function valData()
{

var ml=document.getElementById('mail').value;
if(ml=="" || ml==null)
{
alert('Email Id must be correct.');
return false;
}

var e = document.getElementById("domain");
   var dm = e.options[e.selectedIndex].value;

var eml=ml+"@"+dm;
var pattern=/^([a-zA-Z0-9_.-])+@([a-zA-Z0-9_.-])+\.([a-zA-Z])+([a-zA-Z])+/;
    if(pattern.test(eml)){         
		//alert("true");   
    }else{  
    alert("Please enter correct format of email address.") ;
		return false;
    }



var np=document.getElementById('hid_ps').value;

    if(parseInt(np)<1) {
    alert('Password must be Good or Strong.');

    return false;
    }


return true;

}

function setPath(val)
{

var chk=document.getElementById(val).checked;
if(chk)
{
var ps=document.getElementById("rpass").value;
document.getElementById("password").value=ps;
document.getElementById("cnp").value=ps;
document.getElementById("hid_ps").value="2";
}
else
{
document.getElementById("password").value="";
document.getElementById("cnp").value="";
document.getElementById("hid_ps").value="0";
}
}



function fName(sn)
{
var nm=myUpper(sn);
document.getElementById("sn").value=nm;
var fn=document.getElementById("fn").value;
document.getElementById("cn").value=fn+" "+nm;


}
</script>
</head>

<body>
 <%
    
    String stt=request.getParameter("status");
     String dm= request.getParameter("dm"); 
        String ml= request.getParameter("nm"); 
      HttpSession hs=request.getSession(false);
		        String username= (String)hs.getAttribute("id");
		        String password= (String)hs.getAttribute("password");
		        String url= (String)hs.getAttribute("url");
		        String mbase= (String)hs.getAttribute("base");
		        String base="o=domains,"+mbase;
	int totno=0;	        
	 totno=TotalUser.totUser(url,mbase, base, username, password);	        
		        
		        
		        
		        
	String mqt="";
	String cqt="";
	String dqt="";	 
	int mno=0;
	int cno=0;       
     
    if(ml!=null && !(ml.equals("")))
    	{
    	String arr_ml[]=ml.split("@");
    	dm=arr_ml[1];
    	}
    if(dm==null || dm.equals(""))
    	{
    	
    	
    	try
		{
int chk_dom=0;
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
    String dom_ch_arr[]=ck.split("=");
   System.out.println("<br><br><br>trytryr"+dom_ch_arr[1]);
   
        dm=dom_ch_arr[1];
  		chk_dom=1;
  		break;
          
    }
try
{
	LDAPConnection.closeConn( ctx);
}
catch(Exception ec)
{
	ec.printStackTrace();
}                     
}
 catch(Exception e){System.out.print(e);} 
    	
    	
    	}
     
    if(dm!=null && !(dm.equals("")))
     {
     try
{


DirContext ctx=LDAPConnection.getConnection(url, base, username, password);

SearchControls constraints = new SearchControls(); 
constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
String attrList[] = {"domainMaxQuotaSize","domainDefaultUserQuota","domainCurrentQuotaSize","domainMaxUserNumber","domainCurrentUserNumber"}; 
constraints.setReturningAttributes(attrList);
NamingEnumeration results =ctx.search(base,"domainName="+dm, constraints);
int f=0;
int x=0;
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
         if(id.equalsIgnoreCase("domainCurrentQuotaSize"))
        {
        cqt=str;
        }
        else if(id.equalsIgnoreCase("domainMaxQuotaSize"))
        {
        mqt=str;
        }
         else if(id.equalsIgnoreCase("domainDefaultUserQuota"))
        {
        dqt=str;
        }
         else if(id.equalsIgnoreCase("domainMaxUserNumber"))
        {
        mno=Integer.parseInt(str);
        }
        
         else if(id.equalsIgnoreCase("domainCurrentUserNumber"))
        {
        cno=Integer.parseInt(str);
        }
        
        

           //out.println("  <br> "+id + ":--- " +str);
           }
    }
    //NoOfUser nof=new NoOfUser();
 

}
if(f==0)
{
System.out.print("<tr class='grey'><td></td><td>Search not found</td></tr>");
}
try
{
	LDAPConnection.closeConn( ctx);
}
catch(Exception ec)
{
	ec.printStackTrace();
}
}
catch(Exception e){System.out.print("<tr class='grey'><td></td><td>"+e+"</td></tr>");}
     
     }
 %>
     <%@include file="header.jsp" %>

    <div class="main pagesize"> <!-- *** mainpage layout *** -->
        <div class="main-wrap">
        
          <div class="sublev-nav">	
   	<ul>
   		<li><a href="/unifiedmail/global/domainlist.jsp">All Domains</a></li>
<li><a  href="/unifiedmail/global/editdomainprofile.jsp?dn=<%=dm %>"><%=dm %></a></li>
<li><a href="/unifiedmail/global/userslist.jsp?dm=<%=dm %>">Users</a></li>
<li><a href="/unifiedmail/global/maillistslist.jsp?dm=<%=dm %>">Mail Lists</a></li>
<li><a href="/unifiedmail/global/mailaliaseslist.jsp?dm=<%=dm %>">Mail Aliases</a></li>
   	</ul>
   	<div class="clr"></div>
   	</div>
        
            <div class="page clear">
                
                



      <%
      String chk="true";
      if(cqt!=null && mqt!=null && !(cqt.equals("")) && !(mqt.equals("")))
      {
      if(Integer.parseInt(mqt)==0)
      {
       chk="true";
      }
      else  if(Integer.parseInt(cqt)>=Integer.parseInt(mqt))
      {
      chk="false";
      }
      }
    if(stt!=null && stt.equalsIgnoreCase("succ"))
    {  

     %>
      <div class='notification note-success'><a href='#' class='close'></a>
      <p><%=ml %> User has been added successfully. To edit this User click <a href="/unifiedmail/global/edituserprofile.jsp?ml=<%=ml %>"><%=ml %></a> </p></div>
      <%}
      else if(stt!=null && stt.equalsIgnoreCase("error"))
      {
       %>
                <div id="msg_err" class="notification note-error"><a href='#' class='close'></a>  
                <p>User addition has been failed.	</p> </div>
    
    
    <%} 
    int uchk=1;
    if(mno==0)
    {
    uchk=1;
    }
    else if(mno<=cno)
    {
    uchk=0;
    chk="false";
    }
    if(uchk==0)
    {
    %>
     <div id="msg_err" class="notification note-error"><a href='#' class='close'></a>  
     <p>Error: You can't create more user under domain <%=dm %>. Already exceed max number of account limit (<%=mno %>).	</p></div>
        
    <%} %>


    
    <div class="content-box">
        <div class="box-body">
            <div class="box-header clear">
                <ul class="tabs clear">
                    
                    <li class="active"><a href="/unifiedmail/global/adduser.jsp?dm=<%=dm %>">Add User</a>
                    <li><a href="/unifiedmail/global/addmaillist.jsp?dm=<%=dm %>"> Add List</a>
                    <li><a href="/unifiedmail/global/addalias.jsp?dm=<%=dm %>">Add Alias</a>
                </ul>

 

                <h2>
                    Add user under domain: <%=dm %>
                     </h2>
            </div>

            <div id="user_add" class="box-wrap clear">
                 <form name="f_add_dom"  id="register" method="post" action="/unifiedmail/servlet/AddUserServlet" onsubmit="return valData()">
   <%
   // if(totno>=500)
  	if(false)			
   {
       %>
       <center><br/>
             <font color="red" size="5">
             Yours License is expire.Maximum Range of User addition is 500.<br/>
             Plz. Renew the license.
             </font><br/><br/>
             <img src="/unifiedmail/global/images/license_report_pic.png"/>
             </center><br/><br/><br/>
       <%}
       else
       {
        %>
            <input type="hidden" name="hid_chk" value="<%=chk %>" />

                    <div class="columns clear">
                        <div class="col3-4">
                            <div class="form-field clear">
                                <h4 class="size-250 fl-space">Mail Address <span class="required">*</span></h4>
                                <span class="clean-padding">
                                <%if(uchk==0)
                            	{
                            	 %>
                                <input name="mail" size="35" id="mail" readonly="readonly" required type="text" class="text fl-space"  onblur="chkUser(this.value)"/>
                                <%}
                                else
                                {
                                 %>
                                 <input name="mail" size="35" id="mail" required type="text" class="text fl-space"  onblur="chkUser(this.value)"/>
                                 <%} %>
                                   @
                                    <select name="domain" id="domain" onchange="setNUrl(this.value)">
                                        
                                           
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
%>
<option value="<%=str %>"><%=str %></option>
<%
}
           //out.println("  <br> "+id + ":--- " +str);
           }
    }}
ctx.close();                                    
}

		 catch(Exception e){System.out.print(e);}  %>
                                        
                                    </select>
                                </span>
                                <div class="ermsg" id="sp1"></div>
                            </div>
                            
                            
                            <div class="form-field clear">
    
        <h4 class="size-250 fl-space">Initial<span class="required">*</span></h4>
    
    <select name="init" style="width:110px;">
        
         <option value="Mr" >Mr</option>
        <option value="Ms" >Ms</option>
        <option value="Mrs" >Mrs</option>
        <option value="Dr" >Dr</option>
        <option value="Prof" >Prof</option>
        
    </select>
</div>
                            

 <div class="form-field clear">
                                <h4 class="size-250 fl-space">Name <span class="required">*</span></h4>
                                <span class="clean-padding">
                               
                                <input name="fn" size="25" id="fn" placeholder="First Name"  required type="text" class="text fl-space"  onblur="nmUpper(this.value)"/>
                               <input name="sn" size="25" id="sn" placeholder="Last Name" required type="text" class="text fl-space"  onblur="fName(this.value)"/>
                               
                                  
                                </span>
                                <div class="ermsg" id="sp12"></div>
                            </div>

<div class="form-field clear">
        <h4 class="size-250 fl-space">Full Name <span class="required">*</span></h4>
        <span class="clean-padding bt-space20"><input type="text" name="cn" placeholder="Full Name" id="cn" required value="" size="35" title="" class="text" /></span>
    </div>


                        <div class="bt-space5">&nbsp;</div>

                        
    

    
        
    

    

    <div class="form-field clear">
        <h4 class="size-250 fl-space">New password <span class="required">*</span></h4>
        <span class="clean-padding"><input name="np" id="password" required type="password"  onblur="setNCP()" size="35" title="" class="text" /></span>
   		 <input type="hidden" id="hid_ps" name="hid_ps" value="0" />
   		  <div class="ermsg" style="clear: both;float: left; padding: 3px 0 0 250px; width: 427px;" id="result"></div>
</div>


        <div class="form-field clear">
            <h4 class="size-250 fl-space">Confirm new password <span class="required">*</span></h4>
            <span class="clean-padding"><input name="cnp" id="cnp" required type="password"  onblur="checkNCP(this.value)" size="35" title="" class="text" /></span>
        	
        </div>
   
    
                       <div style="clear: both;float: left; padding: 3px 0 0 255px;width: 427px;" id="cnp_msg1"></div> 
    

                        <div class="bt-space5">&nbsp;</div>
<div class="form-field clear">
        <h4 class="size-250 fl-space">Change Password at Next Logon</h4>
        <div class="form-checkbox-item clear">
           
                                <input name="fpc"  type="checkbox" value="FALSE" class="checkbox" />
                               
            
        </div>
    </div>
    
    <div class="form-field clear">
        <h4 class="size-250 fl-space">Expiry date</h4>
        <span class="clean-padding bt-space20"><input id="popupDatepicker" placeholder="yyyy-MM-dd"  name="edt"  type="text" value="" size="35" class="text" /></span>
        
    </div>
    
                        <div class="form-field clear">
    
        <h4 class="size-250 fl-space">Preferred language <span class="required">*</span></h4>
    
    
        
            <select name="prelang">
         <option value="ru_RU" >Ð ÑÑÑÐºÐ¸Ð¹</option>
        
            <option value="zh_TW" >ç¹é«ä¸­æ</option>
        
            <option value="pt_BR" >Portuguese (Brazilian)</option>
        
            <option value="fr_FR" >FranÃ§ais</option>
        
            <option value="zh_CN" >ç®ä½ä¸­æ</option>
        
            <option value="fi_FI" >Finnish (Suomi)</option>
        
            <option value="ko_KR" >Korean</option>
        
            <option value="it_IT" >Italiano</option>
        
            <option value="cs_CZ" >ÄeÅ¡tina</option>
        
            <option value="nl_NL" >Netherlands</option>
        
            <option value="sr_LT" >Serbian (Latin)</option>
        
            <option value="en_US" selected="selected">English (US)</option>
        
            <option value="de_DE" >Deutsch (Deutsch)</option>
        
            <option value="es_ES" >EspaÃ±ol</option>
        
            <option value="pl_PL" >Polski</option>
        
            <option value="sl_SI" >Slovenian</option>
        
    
            
    </select>
</div>
                        
    
<div class="form-field clear">
    
        <h4 class="size-250 fl-space">	Account Status <span class="required">*</span></h4>
    
    <select name="acc" style="width:110px;">
                            	<option value="active">Enable</option>
                            	<option value="disabled">Disable</option>
                            	</select>  
</div>
    
    

    
        
    

    <div class="form-field clear">
        
            <h4 class="size-250 fl-space">Mailbox Quota <span class="required">*</span></h4>
        

        <span class="clean-padding fl-space2">
        <%
                                   if(Integer.parseInt(mqt)==0)
                                   {
                                   %>
                                   
                                   <input name="mq" id="mq" required type="text" value="<%=dqt %>" size="10" class="text fl-space"  onblur="isNumUQT(this.value,this.name,'3')"/>MB
       
        
        <%
        }
        else  if(Integer.parseInt(mqt)-(Integer.parseInt(cqt)+Integer.parseInt(dqt))>=0)
        {
         %>
         <input name="mq" id="mq" required type="text" value="<%=dqt %>" size="10" class="text fl-space"  onblur="isNum(this.value,this.name,'3')"/>MB
        <%}
        else
        {
         %>   
<input name="mq" id="mq" required type="text" value="" size="10" class="text fl-space"  onblur="isNumUQT(this.value,this.name,'3')"/>MB
      
       
           <%} %> 
       </span>

         <div class="ermsg" id="spq">
         
                                  <%if(!(mqt.equalsIgnoreCase("")) && !(cqt.equalsIgnoreCase("")))
                                   { 
                                   if(Integer.parseInt(mqt)==0)
                                   {
                                   %>
                                    <span id="qt_msg">Available quota: Unlimited</span> 
                                    <input type="hidden" id="hid_qt_un" name="hid_qt_un" value="0" />
									<%}
									else
									{ %>
									<input type="hidden" id="hid_qt_un" name="hid_qt_un" value="1" />
                                   <%
        if(Integer.parseInt(mqt)-(Integer.parseInt(cqt)+Integer.parseInt(dqt))>=0)
        {
         %>
                                   <span id="qt_msg">Available quota:<%=Integer.parseInt(mqt)-(Integer.parseInt(cqt)+Integer.parseInt(dqt)) %> MB(<%=(Integer.parseInt(mqt)-(Integer.parseInt(cqt)+Integer.parseInt(dqt)))/1024.0 %>GB)</span>  
                                   <%}
                                   else
                                   {
                                    %>   
                                    <span id="qt_msg">Available quota:<%=Integer.parseInt(mqt)-Integer.parseInt(cqt) %> MB(<%=(Integer.parseInt(mqt)-Integer.parseInt(cqt))/1024.0 %>GB)</span>  
                                  
                                    <%} %>                  
                             <input type="hidden" id="hid_qt" name="hid_qt" value="<%=Integer.parseInt(mqt)-Integer.parseInt(cqt) %>" />
                            <%
                            }
                            }
                            else
                            { %>
                            <input type="hidden" id="hid_qt" name="hid_qt" value="-1" />
                            <%} %>
                                 
                                 </div>
                                 <div class="ermsg" id="sp3"></div>
    </div>

                    </div>
                    <div class="col1-4 lastcol">
                     <div class="mark_blue bt-space10">    
              <h4>Email Address</h4>
              
              <p class="clean-padding clean-padding bt-space10">
              It contains only [a to z] [0 to 9]</br> [- _ and .] characters.
              </p>
</div>
                    
                    
                    
                    
                        <div class="mark_blue bt-space10">
        <h4>Need a random password?</h4>
        <p class="clean-padding clean-padding bt-space10">
        <input type="checkbox" id="setpass" value="1" name="setpass" onclick="setPath(this.id)"/>
<%Random ran=new Random();
        int rno=ran.nextInt(100000);
        int dg=rno%10;
        String x = Integer.toString(rno);
        char c1=(char)(70+dg);
        char c2=(char)(110+dg);
x = x.substring(0, 1) + c1+(char)(80+dg) + x.substring(1, x.length());
x = x.substring(0, x.length()-1) + c2 + x.substring(x.length()-1, x.length());
         out.print(x); %>
         <input type="hidden" name="rpass" id="rpass" value="<%=x %>"/>
</p>
    </div>
              
         
              
              
              
                    </div>
                </div>

                <div class="rule2"></div>
                <div class="form-field clear">
                    <h4 class="size-250 fl-space">&nbsp;</h4>
                    <span>
                        <input type="submit" value="Add" class="button green" />
                    </span>
                </div>
                <%} %>
            </form>
        </div>
    </div>
</div>


            </div>
        </div>
    </div>

    
    
      <%@include file="footer.jsp" %>
   
    
    <script type="text/javascript">
        function change_url(domain, baseurl) {
            if ( domain.options[domain.selectedIndex].value != 'none' ) {
                location.href = baseurl + domain.options[domain.selectedIndex].value;
            }
        }
    </script>
        
    <script type="text/javascript" src="/unifiedmail/npjs/jquery-1.4.2.min.js"></script>

    
        <script type="text/javascript" src="/unifiedmail/npjs/jquery.tooltip.js"></script>
    
        <script type="text/javascript" src="/unifiedmail/npjs/jquery.idtabs.js"></script>
    
        <script type="text/javascript" src="/unifiedmail/npjs/jquery.fancybox.js"></script>
    

    

    

    <script type="text/javascript">
    
    

    
    $(document).ready(function() {
        
        $('.menu li').hover(function () {
            $(this).find('ul:first').css({'visibility': 'visible', 'display': 'none'}).slideDown();
        }, function () {
            $(this).find('ul:first').css({visibility: "hidden"});
        });$('.content-box .select-all').click(function () {
            if ($(this).is(':checked'))
                $(this).parent().parent().parent().parent().find(':checkbox').attr('checked', true);
            else
                $(this).parent().parent().parent().parent().find(':checkbox').attr('checked', false);
        });

        /* Tabs */
        $('.content-box .tabs').idTabs();

        
        $('.notification .close').click(function () {
            $(this).parent().fadeOut(300);
            return false;
        });

        
        $("a[title], img[title], span[title], input[title]").tooltip({
            position: "top center",
            offset: [-5, 0],
            predelay: 300,
            delay: 100,
            effect: "fade",
            opacity: 1
        });

        

        $('.onFocusEmpty').focus(function () {
            $(this).val('');
        });

        
        $('.modal-link').fancybox({
            'modal'                 : false,
            'hideOnOverlayClick'    : true,
            'hideOnContentClick'    : false,
            'enableEscapeButton'    : true,
            'showCloseButton'       : true
        });
        $("a[href$='gif']").fancybox();
        $("a[href$='jpg']").fancybox();
        $("a[href$='png']").fancybox();

        
    });
    </script>
    

    
</body>
</html>