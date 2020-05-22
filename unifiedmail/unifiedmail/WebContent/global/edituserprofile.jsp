
<%@page import="javax.naming.directory.*"%>
<%@ page language="java" import="java.util.*,mypack.*" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.regex.*" %>

<%@ page import="sun.misc.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
   <title>Edit User Profile | Silvereye Unified E-mail Server</title>
 <noscript><meta http-equiv="refresh" content="0; URL=/unifiedmail/error/nojavascritp.jsp"></noscript>

    
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/reset.css" ></link>
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/screen.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/fancybox.css" />

    <!--[if IE 7]>
        <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/ie7.css">
    <![endif]-->
<link rel="stylesheet" type="text/css" href="/unifiedmail/css/mytooltip.css" />
<script type="text/javascript">
function mydel_dom_usr(val)
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
function mydel_dom(val)
{
var r=confirm("Do you want to Remove Image");
//alert(r);
if (r==true)
  {
  //alert("hi");
 document.getElementById(""+val).href ="/unifiedmail/servlet/RemoveUserPhotoServlet?ml="+val;
   
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
function valData()
{
if(document.f.cn.value=="" || document.f.cn.value==null)
{
alert("Company name / Organization can not empty.");
return false;
}
return true;
}
</script>











<link type="text/css" href="/unifiedmail/dtpic/jquery.datepick.css" rel="stylesheet" />
<link href='css/jquery.iphone.toggle.css' rel='stylesheet' />
<script type="text/javascript" src="/unifiedmail/dtpic/jquery.min.js"></script>
<script type="text/javascript" src="/unifiedmail/dtpic/jquery.datepick.js"></script>
<script type="text/javascript">

$.noConflict();
jQuery(document).ready(function($) {


$(function() {
$('#popupDatepicker').datepick({dateFormat: 'yyyy-mm-dd'});
$('#popupDatepicker1').datepick({dateFormat: 'yyyy-mm-dd'});
$('#popupDatepicker2').datepick({dateFormat: 'yyyy-mm-dd'});
$('#popupDatepicker3').datepick({dateFormat: 'yyyy-mm-dd'});
	$('#popupDatepicker').datepick();
	$('#popupDatepicker1').datepick();
	$('#popupDatepicker2').datepick();
	$('#popupDatepicker3').datepick();
	//$('#inlineDatepicker').datepick({onSelect: showDate});
});

});

function showDate(date) {
	alert('The date chosen is ' + date);
}
</script>


<script type="text/javascript">


function isNum(val,nm,no)
{
if(isNaN(val)===true){
   document.getElementById("sp"+no).innerHTML ="<font color='red'>please input only numeric!</font>";
  document.getElementById(nm).value="";
 
}
else if(val!="")
{
var qt=document.getElementsByName("qt")
var oldqt=document.getElementById("hid_old_qt").value;
//alert(oldqt);
var tp="";
if(qt[0].checked)
{
tp=qt[0].value;
}
else
{
tp=qt[1].value;
}
if(val>=1024 && tp=="MB")
{
alert("PLZ. Select GB First.");
//val=""+val;
//val = val.substring(0, val.length - 1);
document.getElementById(nm).value="";
val=parseInt(oldqt);
//alert(tp)
}
else if(val>100 && tp=="GB")
{
alert("Quota max size should be 100GB..");
document.getElementById(nm).value=100;
 val=val*1024;
}else if(tp=="GB")
{
 val=val*1024;
 }
 document.getElementById("sp"+no).innerHTML ="";
 var hid=parseInt(document.getElementById("hid_qt").value);
 //alert(hid)
 if(hid!=-1)
 {
 //if(val>(parseInt(oldqt)))
 
 var vl=hid-(parseInt(val)-parseInt(oldqt));
 if(vl>=0)
 	{
 	document.getElementById("qt_msg").innerHTML ="Available quota:"+vl+"MB ("+vl/1024+"GB)";
   }
 	else
 	{
 	  document.getElementById("sp"+no).innerHTML ="<font color='red'>please input valid limit!</font>";
 	  document.getElementById("qt_msg").innerHTML ="Available quota:"+hid+"MB ("+hid/1024+"GB)";
  document.getElementById(nm).value="";
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




function setMB(nm,no)
{

//document.getElementById("mb").checked=true;
//document.getElementById("gb").checked=false;  
var qt=document.getElementById(nm).value;
isNum(qt,nm,no);
//alert("PLZ. Select GB First.");
//document.f.quota.value=1;

}

function setGB(nm,no)
{
//alert("gb")
//document.getElementById("mb").checked=false;
document.getElementById("gb").checked=true;  
var qt=document.getElementById(nm).value;

isNum(qt,nm,no);

}

function isfNum(val,nm,no)
{
if(isNaN(val)===true){
   document.getElementById("sp"+no).innerHTML ="<font color='red'>please input only numeric!</font>";
  document.getElementById(nm).value="";
 
}
else if(val!="")
{

 document.getElementById("sp"+no).innerHTML ="";
 
 var qt=document.getElementsByName("fqt")

//alert(oldqt);
var tp="";
if(qt[0].checked)
{
tp=qt[0].value;
}
else
{
tp=qt[1].value;
}
if(val>=1024 && tp=="MB")
{
alert("PLZ. Select GB First.");
//val=""+val;
//val = val.substring(0, val.length - 1);
document.getElementById(nm).value="";

}
else if(val>50 && tp=="GB")
{
alert("Quota max size should be 50GB..");
document.getElementById(nm).value=50;

}
}
}


function setfMB(nm,no)
{

//document.getElementById("mb").checked=true;
//document.getElementById("gb").checked=false;  
var qt=document.getElementById(nm).value;
isfNum(qt,nm,no);
//alert("PLZ. Select GB First.");
//document.f.quota.value=1;

}




function setfGB(nm,no)
{

//document.getElementById("mb").checked=true;
//document.getElementById("gb").checked=false;  
var qt=document.getElementById(nm).value;
isfNum(qt,nm,no);
//alert("PLZ. Select GB First.");
//document.f.quota.value=1;

}
</script>  
<script type="text/javascript">
function check_from()
{
var val=document.getElementById("fl").value;
if(val=="" || val==null)
{
alert("Choose image..");
return false;
}
return true;
}
</script>

<script type="text/javascript" src="/unifiedmail/jqr/npjquery.js"></script>
    <script type="text/javascript">
    $(function(){
    $('#fl').change(function(){
    var f=this.files[0]
    //alert(f.size||f.fileSize)
    var sz=f.size
    if(sz>102400)
    {
    alert("Photo size must be less than 100KB..");
    document.getElementById("fl").value="";
    }
    var nm=f.name;
    var narr=nm.split(".");
    var ex=narr[narr.length-1];
    if(ex=="jpg" || ex=="JPG" || ex=="png" || ex=="PNG" || ex=="JPEG" || ex=="jpeg")
    {
    }
    else
    {
    alert("Image format should be in jpg/png/jpeg.");
    document.getElementById("fl").value="";
    }
    
    })
    })
    </script>
    <script type="text/javascript">
    
function checkNum(nm)
{
var val=document.getElementById(nm).value;
var numbers = /^[0-9]+$/;  
if(val.match(numbers))
{
if(val.length>=14)
{
val = val.substring(0, val.length - 1)
document.getElementById(nm).value=val;
}
}
else
{
val = val.substring(0, val.length - 1)
document.getElementById(nm).value=val;

}
}

function  mobLimit(nm,val,lm)
{
if(val!="")
{
var no=document.getElementById(nm).value;
if(no.length >parseInt(lm))
{
alert("Please enter correct value.");
document.getElementById(nm).value="";
}
}
}
    </script>

<link rel="STYLESHEET" type="text/css" href="/unifiedmail/popup/popup-contact.css" />
</head>
<body onload="javascript:fg_hideform('fg_formContainer','fg_backgroundpopup');">
<%
   String mail=request.getParameter("ml");
   String dn="";
  if( mail!=null && !(mail.equals("")) )
   {
   				String arr[]=mail.split("@");
   				dn=arr[1];
                HttpSession hs=request.getSession(false);
		        String username= (String)hs.getAttribute("id");
		        String password= (String)hs.getAttribute("password");
		        String url= (String)hs.getAttribute("url");
		        String mbase= (String)hs.getAttribute("base");
		        String base="ou=Users,domainName="+dn+",o=domains,"+mbase;
		        String utype=(String)hs.getAttribute("user_name");
		         String ftpdom=GetMValueAtt.getDomValueAtt(url,username,password,mbase,dn,"domainFTPStatus");
		        String acc="";
		        String arr_mail[]=mail.split("@");
		        hs.setAttribute("user_mail",mail);
String init="";	       
String cn="";
String fn="";
String sn="";
String dis="";
int book=0;
String mb="checked";
String gb="";
String quota="";
String fmb="checked";
String fgb="";
String fquota="";
String oldquota="";	
String dob="";
String doj="";
String anni="";
String mob="";
String tel="";
String photo="";
String hmob="";
String postadd="";
String postcode="";
String plang="";
String jpeg="";	  
String serv="";  
String ftp="";  
String fpc="";
String list_maillist="";  
String eno="";
String edt="";
String macAddr="";
String device="";
try
{


DirContext ctx=LDAPConnection.getConnection(url, base, username, password);

SearchControls constraints = new SearchControls(); 
constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
String attrList[] = {"macAddr","device","expiredDate","givenName","initials","employeeNumber", "sn", "cn","accountStatus","forcePasswordChange","FTPStatus","FTPQuotaMBytes","enabledService","memberOfGroup","mailQuota","jpegPhoto","anniversary","dateOfJoining","dateOfBirth","mobile","homePhone","telephoneNumber","postalAddress","postalCode","preferredLanguage"}; 
constraints.setReturningAttributes(attrList);
NamingEnumeration results =ctx.search(base,"mail="+mail, constraints);
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
        if(id.equalsIgnoreCase("cn"))
        {
        cn=str;
        }
        else if(id.equalsIgnoreCase("employeeNumber"))
        {
        	eno=str;
        }
         else	 if(id.equalsIgnoreCase("forcePasswordChange"))
             {
             fpc=str;
             }
        else 	 if(id.equalsIgnoreCase("sn"))
        {
        sn=str;
        }
         else if(id.equalsIgnoreCase("initials"))
        {
        init=str;
        }
         else if(id.equalsIgnoreCase("givenName"))
        {
        fn=str;
        }
        else if(id.equalsIgnoreCase("accountStatus"))
        {
        acc=str;
        }
        else if(id.equalsIgnoreCase("FTPStatus"))
        {
        ftp=str;
        }
        if(id.equalsIgnoreCase("memberOfGroup"))
        {
        	
        	if(list_maillist.equalsIgnoreCase(""))
        	{
        	list_maillist=str;
        	}
        	else
        	{
        	list_maillist=list_maillist+","+str;
        	
        	}
        }
         if(id.equalsIgnoreCase("enabledService"))
        {
        	if(str.equalsIgnoreCase("displayedInGlobalAddressBook"))
        	{
        	book=1;
        	}
        	if(serv.equalsIgnoreCase(""))
        	{
        	serv=str;
        	}
        	else
        	{
        	serv=serv+","+str;
        	
        	}
        }
        else if(id.equalsIgnoreCase("mailQuota"))
        {
       
		 long lg=Long.parseLong(str);
           if((lg>=1024*1024*1024))
           {
           oldquota=""+(lg/1024/1024);
          lg=(lg/1024)/1024/1024;
           quota=""+lg;
            mb="";
            gb="checked";
           }
           else if((lg>=1024*1024))
           {
          lg=(lg/1024)/1024;
           quota=""+lg;
           oldquota=""+lg;
           }
           else
           {
           quota=str;
           oldquota=str;
           }
         }
         else if(id.equalsIgnoreCase("FTPQuotaMBytes"))
        {
        long lg=Long.parseLong(str);
           if((lg>=1024))
           {
              lg=(lg/1024);
           fquota=""+lg;
            fmb="";
            fgb="checked";
           }
           else
           {
           fquota=str;
           
           }
        }  
         else if(id.equalsIgnoreCase("mobile"))
           {
           mob=str;
           } 
            else if(id.equalsIgnoreCase("telephoneNumber"))
           {
           tel=str;
           } 
           else if(id.equalsIgnoreCase("dateOfJoining"))
           {
           String yy="";
           String mm="";
           String dd="";
           
           for(int i=0;i<8;i++)
             {
             char ss=str.charAt(i);
             if(i<=3)
             {
             yy=yy+ss;
             }
             else if(i<=5)
             {
             mm=mm+ss;
             }
             else
             {
             dd=dd+ss;
             }
             }
           doj=""+yy+"-"+mm+"-"+dd;
           } 
           else if(id.equalsIgnoreCase("expiredDate"))
           {
           String yy="";
           String mm="";
           String dd="";
           
           for(int i=0;i<8;i++)
             {
             char ss=str.charAt(i);
             if(i<=3)
             {
             yy=yy+ss;
             }
             else if(i<=5)
             {
             mm=mm+ss;
             }
             else
             {
             dd=dd+ss;
             }
             }
           edt=""+yy+"-"+mm+"-"+dd;
           }
           else if(id.equalsIgnoreCase("dateOfBirth"))
           {
           String yy="";
           String mm="";
           String dd="";
           
           for(int i=0;i<8;i++)
             {
             char ss=str.charAt(i);
             if(i<=3)
             {
             yy=yy+ss;
             }
             else if(i<=5)
             {
             mm=mm+ss;
             }
             else
             {
             dd=dd+ss;
             }
             }
           dob=""+yy+"-"+mm+"-"+dd;
           }
           else if(id.equalsIgnoreCase("anniversary"))
           {
           String yy="";
           String mm="";
           String dd="";
           
           for(int i=0;i<8;i++)
             {
             char ss=str.charAt(i);
             if(i<=3)
             {
             yy=yy+ss;
             }
             else if(i<=5)
             {
             mm=mm+ss;
             }
             else
             {
             dd=dd+ss;
             }
             }
           anni=""+yy+"-"+mm+"-"+dd;
           }
           else if(id.equalsIgnoreCase("jpegPhoto"))
           {
        	 /*   System.out.println();
        	   byte[] jpegBytes1 = (byte[])  vals.nextElement();
        	 
        	   photo = new sun.misc.BASE64Encoder().encode(jpegBytes1); */
        	 
        	   //String entry="mail="+mail+","+base;
        		//Attributes	testAttributes = ctx.getAttributes(entry);
        		
        	   // Attribute jpegPhoto1 =  vals.nextElement();
        	  /*   byte[] jpegBytes1 = (byte[]) vals.nextElement();
        	   photo = new sun.misc.BASE64Encoder().encode(jpegBytes1);  */
           } 
             else if(id.equalsIgnoreCase("homePhone"))
           {
           hmob=str;
           } 
            else if(id.equalsIgnoreCase("postalAddress"))
           {
           postadd=str;
           } 
            else if(id.equalsIgnoreCase("postalCode"))
           {
           postcode=str;
           }
            else if(id.equalsIgnoreCase("macAddr"))
           {
            	macAddr=str;
           }
            else if(id.equalsIgnoreCase("device"))
            {
            	device=str;
            }
            else if(id.equalsIgnoreCase("preferredLanguage"))
            {
            plang=str;
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
else
{
	 String entry="mail="+mail+","+base;
	Attributes	testAttributes = ctx.getAttributes(entry);
	
    Attribute jpegPhoto1 = testAttributes.get("jpegPhoto");
    byte[] jpegBytes1 = (byte[]) jpegPhoto1.get();
   photo = new sun.misc.BASE64Encoder().encode(jpegBytes1); 
}
ctx.close();
}
catch(Exception e){System.out.print("<tr class='grey'><td></td><td>"+e+"</td></tr>");}





//System.out.println("photo="+photo);



  base="o=domains,"+mbase;
	String mqt="";
	String cqt="";
	String dqt="";	        
     if(dn==null || dn.equalsIgnoreCase(""))
     {
     dn="";
     
     }
     else
     {
     try
{


DirContext ctx=LDAPConnection.getConnection(url, base, username, password);

SearchControls constraints = new SearchControls(); 
constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
String attrList[] = {"domainMaxQuotaSize","domainDefaultUserQuota","domainCurrentQuotaSize"}; 
constraints.setReturningAttributes(attrList);
NamingEnumeration results =ctx.search(base,"domainName="+dn, constraints);
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
        

           //out.println("  <br> "+id + ":--- " +str);
           }
    }
    //NoOfUser nof=new NoOfUser();
 

}
if(f==0)
{
System.out.print("<tr class='grey'><td></td><td>Search not found</td></tr>");
}

}
catch(Exception e){System.out.print("<tr class='grey'><td></td><td>"+e+"</td></tr>");}
     
     }

//System.out.println("photo="+photo);
%>  
       
  

   <%@include file="header.jsp" %>

    <div class="main pagesize"> <!-- *** mainpage layout *** -->
    
        <div class="main-wrap">
	<div class="sublev-nav">	
   	<ul>
   		<li><a href="/unifiedmail/global/domainlist.jsp">All Domains</a></li>
<li><a href="/unifiedmail/global/editdomainprofile.jsp?dn=<%=dn %>"><%=dn %></a></li>
<li><a href="/unifiedmail/global/userslist.jsp?dm=<%=dn %>">Users</a></li>
<li><a class="active-subs" href="/unifiedmail/global/edituserprofile.jsp?ml=<%=mail %>" >Profile of User: &nbsp;&nbsp;<%=mail %></a></li>
<li><a href="/unifiedmail/global/maillistslist.jsp?dm=<%=dn %>">Mail Lists</a></li>
<li><a href="/unifiedmail/global/mailaliaseslist.jsp?dm=<%=dn %>">Mail Aliases</a></li>
   	</ul>
   	<div class="clr"></div>
   	</div>


            <div class="page clear">
                
                

<%
    String stt=request.getParameter("status");
    if(stt!=null && stt.equalsIgnoreCase("succ"))
    {  
   // String dn= request.getParameter("nm"); 
     %>
    <div class='notification note-success'><a href='#' class='close'></a>
            <p><%=mail %> user has been updated successfully. </p>	</div>
      <%}
      else if(stt!=null && stt.equalsIgnoreCase("error"))
      {
       %>
        <div id="msg_err" class="notification note-error"><a href='#' class='close'></a>
                 <p>User updation has been failed.	</p></div>
    
    
    <%} %>



    <div class="content-box">
        <div class="box-body">
            <div class="box-header clear">
                <ul class="tabs clear">
                    
             
                       <li class="active"><a href="/unifiedmail/global/edituserprofile.jsp?ml=<%=mail %>" >General</a></li>
                        <li><a href="/unifiedmail/global/forwardinguser.jsp?ml=<%=mail %>" >Forwarding</a></li>
                         <li><a href="/unifiedmail/global/whiteblacklistuserNew.jsp?ml=<%=mail %>">White/Blacklist</a></li>
                        <li><a href="/unifiedmail/global/passworduser.jsp?ml=<%=mail %>">Password</a></li>
                       <%
                         if(utype!=null && utype.equalsIgnoreCase("Admin"))
                                {
                         %>
						<li><a href="/unifiedmail/global/throttlinguser.jsp?ml=<%=mail %>">Throttling</a></li>
                        <%} %>
                        <li><a href="/unifiedmail/global/whiteblistuser.jsp?ml=<%=mail %>">Control</a></li>
                        
                        
                       <li><a href="/unifiedmail/global/advanceuser.jsp?ml=<%=mail %>">Advanced</a></li>
                        
                        </ul>


                <h2>Profile of user: <%=mail %> <a href="/unifiedmail/global/usersentmails.jsp?ml=<%=mail %>">
            <img src="/unifiedmail/images/graph_16.png"   title="Account activities" style="padding-left: 5px;" class="vcenter" />
        </a>
        
        <%if(mail.indexOf("postmaster@")<0)
        {
         %>
              <img src="/unifiedmail/images/delete-icon.png"  name="<%=mail %>" onclick="mydel_dom_usr(this.name)"  title="Delete User" style="padding-left: 5px;" class="vcenter" />
        <%} %>
        
        
        </h2>
            </div>

            <div class="box-wrap clear">
            
<form class="register" action="/unifiedmail/servlet/EditUserProfileServlet" name="f" method="post" onsubmit="return valData()">
    
        
    


    
        <div class="columns clear">
            <div class="col2-3">
                
    

    <div class="form-field clear">
        <input type="hidden" name="hid_mail" value="<%=mail %>" />
        <input type="hidden" name="hid_serv" value="<%=serv %>" /> 
         <input type="hidden" name="hid_dn" value="<%=dn %>" />     
            <h4 class="size-250 fl-space">Account Status</h4>
        

        <div class="form-checkbox-item clear fl-space2">
         <%
                            	if(acc.equalsIgnoreCase("active"))
                            	{
                            	 %>  
                                <input name="acc" checked="checked" type="checkbox" value="<%=acc %>" class="checkbox" />
                                <%}
                                else
                                {
                                 %>
                                <input name="acc" type="checkbox" value="<%=acc %>" class="checkbox"/>
                                
                                <%} %>
             </div>
    </div>

      
     <%
     if(ftpdom!=null && ftpdom.equalsIgnoreCase("TRUE") && utype.equalsIgnoreCase("Admin"))
         {
      %> 
      
    <div class="form-field clear">
         
            <h4 class="size-250 fl-space">FTP Status</h4>
        

        <div class="form-checkbox-item clear fl-space2">
         <%
        
         
                            	if(ftp.equalsIgnoreCase("enabled"))
                            	{
                            	 %>  
                                <input name="ftp" checked="checked" type="checkbox" value="enabled" class="checkbox" />
                                <%}
                                else
                                {
                                 %>
                                <input name="ftp" type="checkbox" value="disabled" class="checkbox"/>
                                
                                <%} %>
             </div>
    </div>
       <%}
       else
       {
       if(ftp.equalsIgnoreCase("enabled"))
                {
                            	 %> 
      
        <input name="ftp" type="hidden" value="enabled" />
        <%
        }
        else
        {
        %>
        <input name="ftp" type="hidden" value="disabled" />
        <%}
         }
        %>         

<div class="form-field clear">
        <h4 class="size-250 fl-space">Change Password at Next Logon</h4>
        <div class="form-checkbox-item clear">
           <%
                            	if(fpc.equalsIgnoreCase("true"))
                            	{
                            	 %>  
                                <input name="fpc" checked="checked" type="checkbox" value="TRUE" class="checkbox" />
                                <%}
                                else
                                {
                                 %>
                                <input name="fpc" type="checkbox" value="FALSE" class="checkbox"/>
                                
                                <%} %>
            
        </div>
    </div>
                
    <div class="form-field clear">
        <h4 class="size-250 fl-space">Display in Corporate Directory</h4>
        <div class="form-checkbox-item clear">
           <%
                            	if(book == 1)
                            	{
                            	 %>  
                                <input name="abook" checked="checked" type="checkbox" value="true" class="checkbox" />
                                <%}
                                else
                                {
                                 %>
                                <input name="abook" type="checkbox" value="false" class="checkbox"/>
                                
                                <%} %>
            
        </div>
    </div>

                <div class="bt-space10"></div>
                
                
                 <div class="form-field clear">
    
        <h4 class="size-250 fl-space">Initial</h4>
    
    <%
   
String mr="selected";
	    String mrs="";
	    String ms="";
	  String dr="";
	  String prof="";
	    if(init!= null && init.equalsIgnoreCase("Ms"))
	    {
	     ms="selected";
	     mr="";
	    }
	    else if(init!= null && init.equalsIgnoreCase("Mrs"))
	    {
	     mrs="selected";
	     mr="";
	    }
	    else if(init!= null && init.equalsIgnoreCase("Dr"))
	    {
	     mr="";
	     dr="selected";
	    }
	    else if(init!= null && init.equalsIgnoreCase("Prof"))
	    {
	     mr="";
	     prof="selected";
	    }
     %>
    
    <select name="init" style="width:110px;">
        
            <option value="Mr" <%=mr %>>Mr</option>
        <option value="Ms" <%=ms %>>Ms</option>
            <option value="Mrs" <%=mrs %>>Mrs</option>
            <option value="Dr" <%=dr %>>Dr</option>
        <option value="Prof" <%=prof %>>Prof</option>
        
    </select>
</div>
                

 <div class="form-field clear">
                                <h4 class="size-250 fl-space">Name </h4>
                                <span class="clean-padding">
                               
                                <input name="fn" size="25" id="fn" value="<%=fn %>" placeholder="First Name" title="First Name"   required type="text" class="text fl-space"  />
                               <input name="sn" size="25" id="sn" value="<%=sn %>" placeholder="Last Name" title="Last Name"  required type="text" class="text fl-space"  />
                               
                                  
                                </span>
                                <div class="ermsg" id="sp12"></div>
                            </div>

     
   
     
    
    <div class="form-field clear">
        
            <h4 class="size-250 fl-space">Display Name</h4>
        

        <span class="clean-padding bt-space20">
            <input type="text" name="cn" value="<%=cn %>" required size="35" class="text" title="Full name" />
        </span>
    </div>

  <div class="form-field clear">
        
            <h4 class="size-250 fl-space">Employee Number</h4>
        

        <span class="clean-padding bt-space20">
            <input type="text" name="eno" value="<%=eno %>"  size="35" class="text" title="Employee Number" />
        </span>
    </div>
  
   <%
                              String ru="";
                              String tw="";
                              String br="";
                              String fr="";
                              String zhcn="";
                              String fi="";
                              String kr="";
                              String it="";
                              String cz="";
                              String nl="";
                              String lt="";
                              String us="";
                              String de="";
                              String es="";
                              String pl="";
                              String si="";
                              if(plang.equalsIgnoreCase("ru_RU"))
                              {
                              ru="selected='selected'";
                              }
                              else if(plang.equalsIgnoreCase("zh_TW"))
                              {
                              tw="selected='selected'";
                              }
                              else
                              if(plang.equalsIgnoreCase("pt_BR"))
                              {
                              br="selected='selected'";
                              }
                              else if(plang.equalsIgnoreCase("fr_FR"))
                              {
                              fr="selected='selected'";
                              }
                              else if(plang.equalsIgnoreCase("zh_CN"))
                              {
                              zhcn="selected='selected'";
                              }
                              else if(plang.equalsIgnoreCase("fi_FI"))
                              {
                              fi="selected='selected'";
                              }
                              else if(plang.equalsIgnoreCase("it_IT"))
                              {
                              it="selected='selected'";
                              }
                              else if(plang.equalsIgnoreCase("ko_KR"))
                              {
                              kr="selected='selected'";
                              }
                              else if(plang.equalsIgnoreCase("nl_NL"))
                              {
                              nl="selected='selected'";
                              }
                              else if(plang.equalsIgnoreCase("sr_LT"))
                              {
                              lt="selected='selected'";
                              }
                              else if(plang.equalsIgnoreCase("de_DE"))
                              {
                              de="selected='selected'";
                              }
                              else if(plang.equalsIgnoreCase("es_ES"))
                              {
                              es="selected='selected'";
                              }
                              else if(plang.equalsIgnoreCase("pl_PL"))
                              {
                              pl="selected='selected'";
                              }
                              else if(plang.equalsIgnoreCase("sl_SI"))
                              {
                              si="selected='selected'";
                              }
                              else
                              {
                              us="selected='selected'";
                              }
                             
                               %>
  
  
    
                <div class="form-field clear">
    
        <h4 class="size-250 fl-space">Preferred language</h4>
    
    <select name="prelang">
        
            <option value="ru_RU" <%=ru %>>Ð ÑÑÑÐºÐ¸Ð¹</option>
        
            <option value="zh_TW" <%=tw %>>ç¹é«ä¸­æ</option>
        
            <option value="pt_BR" <%=br %>>Portuguese (Brazilian)</option>
        
            <option value="fr_FR" <%=fr %>>FranÃ§ais</option>
        
            <option value="zh_CN" <%=zhcn %>>ç®ä½ä¸­æ</option>
        
            <option value="fi_FI" <%=fi %>>Finnish (Suomi)</option>
        
            <option value="ko_KR" <%=kr %>>Korean</option>
        
            <option value="it_IT" <%=it %>>Italiano</option>
        
            <option value="cs_CZ" <%=cz %>>ÄeÅ¡tina</option>
        
            <option value="nl_NL" <%=nl %>>Netherlands</option>
        
            <option value="sr_LT" <%=lt %>>Serbian (Latin)</option>
        
            <option value="en_US" <%=us %>>English (US)</option>
        
            <option value="de_DE" <%=de %>>Deutsch (Deutsch)</option>
        
            <option value="es_ES" <%=es %>>EspaÃ±ol</option>
        
            <option value="pl_PL" <%=pl %>>Polski</option>
        
            <option value="sl_SI" <%=si %>>Slovenian</option>
        
    </select>
</div>
                
    

    
    

    
        
    

    <div class="form-field clear">
        
            <h4 class="size-250 fl-space">Mailbox Quota</h4>
        

        <span class="clean-padding fl-space2">
            <input type="text" id="mq" name="mq" value="<%=quota %>" size="10" required class="text fl-space" onblur="isNum(this.value,this.name,'3')"/> <label class="fl-space"> </label>

         
 <input type="radio" id="mb" name="qt" value="MB"  onclick="setMB('mq','3')"  <%=mb %>  class="radio fl-space" rel="radiogroup2" /><label class="fl">MB&nbsp;</label>
        
 <input type="radio" id="gb" name="qt" value="GB" onclick="setGB('mq','3')" class="radio fl-space" <%=gb %> rel="radiogroup2" /><label class="fl">GB&nbsp;</label>
       </span>
<div class="ermsg" id="sp3"></div>
        <span><input type="hidden" id="hid_old_qt" name="hid_old_qt" value="<%=oldquota %>" /></span>
    </div>
    
    
    
    
    <div class="form-field clear">
        
            <h4 class="size-250 fl-space">FTP Quota</h4>
        

        <span class="clean-padding fl-space2">
            <input type="text" id="fmq" name="fmq" required value="<%=fquota %>" size="10" class="text fl-space" onblur="isfNum(this.value,this.name,'4')"/> <label class="fl-space"> </label>

         
 <input type="radio" id="fmb" name="fqt" value="MB"  onclick="setfMB('fmq','4')"  <%=fmb %>  class="radio fl-space" rel="radiogroup2" /><label class="fl">MB&nbsp;</label>
        
 <input type="radio" id="fgb" name="fqt" value="GB" onclick="setfGB('fmq','4')" class="radio fl-space" <%=fgb %> rel="radiogroup2" /><label class="fl">GB&nbsp;</label>
       </span>
<div class="ermsg" id="sp4"></div>
    
    </div>
    

                <div class="bt-space10"></div>
                
    <div class="form-field clear">
        <h4 class="size-250 fl-space">Date of Birth</h4>
        <span class="clean-padding bt-space20"><input id="popupDatepicker" placeholder="1990-11-07" name="dob"  type="text" value="<%=dob %>" size="35" class="text" /></span>
    <div class="ermsg" id="sp2"></div>
    </div>
                <div class="form-field clear">
        <h4 class="size-250 fl-space">Date of Joinning</h4>
        <span class="clean-padding bt-space20"><input id="popupDatepicker1" placeholder="2013-01-15"  name="doj"  type="text" value="<%=doj %>" size="35" class="text" /></span>
        
    </div>
    
    
    <div class="form-field clear">
        <h4 class="size-250 fl-space">Expiry date</h4>
        <span class="clean-padding bt-space20"><input id="popupDatepicker3" placeholder="yyyy-MM-dd"  name="edt"  type="text" value="<%=edt %>" size="35" class="text" /></span>
        
    </div>
    
 <div class="form-field clear">
        <h4 class="size-250 fl-space">Anniversary</h4>
        <span class="clean-padding bt-space20"><input id="popupDatepicker2" placeholder="2013-01-15"  name="anni"  type="text" value="<%=anni %>" size="35" class="text" /></span>
        
    </div>
                <div class="bt-space10"></div>
                
                             
          <div class="form-field clear">
        <h4 class="size-250 fl-space">Postal Address</h4>
  <textarea  name="padd" rows="4" cols="55"><%=postadd %></textarea>
        
        
    </div>      
                
              
                <div class="form-field clear">
        <h4 class="size-250 fl-space">Postal Code</h4>
        <span class="clean-padding bt-space20"><input  name="pcode" id="pcode"  type="text" value="<%=postcode %>" onkeyup="checkNum(this.name)" size="35" class="text" onblur="mobLimit(this.name,this.value,'6')"/></span>
    </div>
                
                
                
                
                
                <div class="form-field clear">
        <h4 class="size-250 fl-space">Mobile</h4>
        <span class="clean-padding bt-space20"><input name="mobile" id="mobile"  onkeyup="checkNum(this.name)" type="text" value="<%=mob %>" size="35" class="text" onblur="mobLimit(this.name,this.value,'11')"/></span>
    </div>
                
                <div class="form-field clear">
        <h4 class="size-250 fl-space">Home Mobile</h4>
        <span class="clean-padding bt-space20"><input name="hmobile" id="hmobile"  onkeyup="checkNum(this.name)" type="text" value="<%=hmob %>" size="35" class="text" onblur="mobLimit(this.name,this.value,'11')"/></span>
    </div>
                
    <div class="form-field clear">
        <h4 class="size-250 fl-space">Telephone Number</h4>
        <span class="clean-padding bt-space20">
            <input name="tel"  type="text" value="<%=tel %>" id="tel" onkeyup="checkNum(this.name)" size="35" class="text" onblur="mobLimit(this.name,this.value,'13')"/>
        </span>
    </div>
    
    <div class="form-field clear">
        <h4 class="size-250 fl-space">Device Name</h4>
        <span class="clean-padding bt-space20">
            <input name="device"  type="text" value="<%=device %>" id="tel" size="35" class="text" />
        </span>
    </div>
    
    <div class="form-field clear">
        <h4 class="size-250 fl-space">MAC Address</h4>
        <span class="clean-padding bt-space20">
            <input name="macAddr"  type="text" value="<%=macAddr %>" id="tel" size="35" class="text" />
        </span>
    </div>
    
            </div>
            <div class="col1-3 lastcol">
                <div class="mark_blue bt-space10" style="width:100px;" >
                <%
                String src="/unifiedmail/images/avatar.png";
                if(photo!= null && !(photo.equals("")))
                {
                /*  String ur = (request.getRequestURL()).toString();
			  int ur_i=ur.lastIndexOf(":");
			 String ur_prt=ur.substring(0,ur_i); */
		  
                src="data:image/jpg;base64,"+photo;
                }
                 %>
                   <img alt="" width="100px" height="100" src="<%=src %>" /><br/>
                   <a href='javascript:fg_popup_form("fg_formContainer","fg_form_InnerContainer","fg_backgroundpopup");' >Change Photo</a>
                   <%
                   if(photo!= null && !(photo.equals("")))
                {
                    %>
                   <a class="tooltips" id="<%=mail %>"><img src="/unifiedmail/images/delete-icon.png"  name="<%=mail %>" onclick="mydel_dom(this.name)"/>
<span>Remove Image</span></a>
                    <%} %>
                </div>
            </div>
             <div class="col1-3 lastcol">
                <div class="mark_blue bt-space10"  >
                  <ul class="standard clean-padding bt-space10">
                        <li class="bt-space5"> 
                        
                         <%if(!(mqt.equalsIgnoreCase("")) && !(cqt.equalsIgnoreCase("")))
                                   {  if(Integer.parseInt(mqt)==0)
                                   {
                                   %>
                                    <span id="qt_msg">Available quota: Unlimited</span> 
                                    <input type="hidden" id="hid_qt_un" name="hid_qt_un" value="0" />
									<%}
									else
									{ %>
									<input type="hidden" id="hid_qt_un" name="hid_qt_un" value="1" />
                                   <span id="qt_msg">Available quota:<%=Integer.parseInt(mqt)-Integer.parseInt(cqt) %> MB(<%=(Integer.parseInt(mqt)-Integer.parseInt(cqt))/1024.0 %>GB)</span>                       
                             <input type="hidden" id="hid_qt" name="hid_qt" value="<%=Integer.parseInt(mqt)-Integer.parseInt(cqt) %>" />
                            <%
                            }}
                            else
                            { %>
                            <input type="hidden" id="hid_qt" name="hid_qt" value="-1" />
                            <%} %>
                        
                        </li>
                    </ul> 
                </div>
            </div>
            
        </div><div class="rule"></div>
        <div class="columns clear">
            <div class="col2-3">

            <div class="form-field clear">
            <h4 class="size-250 fl-space">Member of Mail Lists</h4>
            <input type="hidden" name="hid_maillist" value="<%=list_maillist %>"/>
            
            <div class="checklist clear">
                <fieldset>
               
        <%
        System.out.println("mlist         "+list_maillist);
          base="ou=Groups,domainName="+dn+",o=domains,"+mbase;
String old_list="";		       
String list_cn="";
String list_mail="";

TreeMap tm_ml = new TreeMap();
try
{


DirContext ctx=LDAPConnection.getConnection(url, base, username, password);

SearchControls constraints = new SearchControls(); 
constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
String attrList[] = {"cn","mail"}; 
constraints.setReturningAttributes(attrList);
NamingEnumeration results =ctx.search(base,"mail=*", constraints);
int f=0;
int x=0;
while (results.hasMore()) {
f=1;
    SearchResult si1 =(SearchResult)results.next();
    String ck=si1.getName();
   System.out.println("<br><br><br>"+ck);
    Attributes attrs = si1.getAttributes();

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
        if(id.equalsIgnoreCase("cn"))
        {
        list_cn=str;
        }
        else if(id.equalsIgnoreCase("mail"))
        {
        list_mail=str;
        }
        
        tm_ml.put(list_mail, list_cn);
           
           
           
           
           //out.println("  <br> "+id + ":--- " +str);
           }
    }
    //NoOfUser nof=new NoOfUser();
 

%>
 
<%


}
if(f==0)
{
System.out.print("<tr class='grey'><td></td><td>Search not found</td></tr>");
}

}
catch(Exception e){System.out.print("<tr class='grey'><td></td><td>"+e+"</td></tr>");}
        
     

// Get a set of the entries
Set set_ml = tm_ml.entrySet();

// Get an iterator
Iterator i_ml = set_ml.iterator();

// Display elements
while(i_ml.hasNext()) {
   Map.Entry me = (Map.Entry)i_ml.next();
   list_mail=me.getKey().toString();
   list_cn=me.getValue().toString();
   %>
   
    <div class="checklist-item">        
 <span class="fl-space">
 <%

 if(list_maillist.indexOf(list_mail)>=0)
 {
 
  %>
 <input type="checkbox" name="mem_list" value="<%=list_mail %>" checked="checked"  class="checkbox" />
 <%}
 else
 {
  %>
 <input type="checkbox" name="mem_list" value="<%=list_mail %>"   class="checkbox" />
 <%} %>
 </span><label><a href="/unifiedmail/global/editmaillistprofile.jsp?ml=<%=list_mail %>"><%=list_cn %></a> (<%=list_mail %>)</label>
  </div>
   <div class="clear"></div>
   
   <%
   list_mail="";
   list_cn="";
}

%>                    
                            
                            
                            
                           
                               
                          
                           
                        

                        
                </fieldset>
                <input type="hidden" value="<%=list_maillist %>" name="hid_old_list"/>
            </div></div></div><div class="col1-3 lastcol">
                <div class="mark_blue bt-space10">
                    <ul class="standard clean-padding bt-space10">
                        <li class="bt-space5"><a href="/unifiedmail/global/addmaillist.jsp?dm=<%=dn %>">Add mail list</a></li>
                    </ul>
                </div>
            </div>
        </div><div class="rule"></div>
        <div class="columns clear">
            <div class="col2-3">
            <div class="form-field clear">
            <h4 class="size-250 fl-space">Member of Mail Aliases</h4>
            <div class="checklist clear">
                <fieldset>
                    
                           
        <%
          base="ou=Aliases,domainName="+dn+",o=domains,"+mbase;
 String old_alias="";		       
String alias_cn="";
String alias_mail="";

try
{


DirContext ctx=LDAPConnection.getConnection(url, base, username, password);

SearchControls constraints = new SearchControls(); 
constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
String attrList[] = {"cn","mail"}; 
constraints.setReturningAttributes(attrList);
NamingEnumeration results =ctx.search(base,"mail=*", constraints);
int f=0;
int x=0;
while (results.hasMore()) {
f=1;
    SearchResult si1 =(SearchResult)results.next();
    String ck=si1.getName();
   System.out.println("<br><br><br>"+ck);
    Attributes attrs = si1.getAttributes();

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
        if(id.equalsIgnoreCase("cn"))
        {
        alias_cn=str;
        }
        else if(id.equalsIgnoreCase("mail"))
        {
        alias_mail=str;
        }
      
           
           
           
           
           //out.println("  <br> "+id + ":--- " +str);
           }
    }
    //NoOfUser nof=new NoOfUser();
 

%>
                    
                    
                    
                    
                    
                    
                        
                            
                            
                            
                            
                            
                            <div class="checklist-item">
                                <span class="fl-space">
                                    <%
                                   
 									int chk_alias=AliasForwording.chkAliasFrd(hs,dn,alias_mail,mail);
 									if(chk_alias==1)
 									{
 									old_alias=old_alias+","+alias_mail;
 									 %>
                                        <input type="checkbox" name="mem_alias" value="<%=alias_mail %>" checked="checked"/>
                                    <%}
                                    else
                                    { %>
                                    	<input type="checkbox" name="mem_alias" value="<%=alias_mail %>" />
                                    <% }%>
                                </span>
                                <label><a href="/unifiedmail/global/editmailaliasprofile.jsp?ml=<%=alias_mail %>"><%=alias_cn %></a> (<%=alias_mail %>)</label>
                            </div>
                           
                            <div class="clear"></div>
                        
                        
                        <%
}
if(f==0)
{
System.out.print("<tr class='grey'><td></td><td>Search not found</td></tr>");
}

}
catch(Exception e){System.out.print("<tr class='grey'><td></td><td>"+e+"</td></tr>");}
        
         %>                    
                          
                        
                        
                </fieldset>
                 <input type="hidden" value="<%=old_alias %>" name="hid_old_alias"/>
            </div></div></div>

            <div class="col1-3 lastcol">
                <div class="mark_blue bt-space10">
                    <ul class="standard clean-padding bt-space10">
                        <li class="bt-space5"><a href="/unifiedmail/global/addalias.jsp?dm=<%=dn %>">Add mail alias</a></li>
                    </ul>
                </div>
            </div>
        </div>

    <div class="rule2"></div>
    <div class="form-field clear">
        <h4 class="size-250 fl-space">&nbsp;</h4>
        <span>
            <input type="submit" value="Save changes" class="button green" />
        </span>
    </div>
    </form>
</div>

</div>
</div>



            </div>
        </div>
    </div>







<script type='text/javascript' src='/unifiedmail/popup/scripts/gen_validatorv31.js'></script>
<script type='text/javascript' src='/unifiedmail/popup/scripts/fg_ajax.js'></script>
<script type='text/javascript' src='/unifiedmail/popup/scripts/fg_moveable_popup.js'></script>
<script type='text/javascript' src='/unifiedmail/popup/scripts/fg_form_submitter.js'></script>
<div id='fg_formContainer'>
    <div id="fg_container_header">
        <div id="fg_box_Title">Change Photo</div>
        <div id="fg_box_Close"><a href="javascript:fg_hideform('fg_formContainer','fg_backgroundpopup');">Close(X)</a></div>
    </div>

    <div id="fg_form_InnerContainer">
     <form name="frm" action="/unifiedmail/servlet/EditPhotoServlet" enctype="multipart/form-data" onsubmit="return check_from()" method="post">
         <br/>
        
            <table>
            <tr><td>Upload Photo &nbsp;</td>
            <td><input id="fl" name="f" required  type="file" class="input-box" /></td></tr>
            </table>	
            <input type="submit" value="Upload" class="button green"/>
            
           
            
            </form>
    </div>
</div>

<div id='fg_backgroundpopup'></div>


 <%@include file="footer.jsp" %>





 <%} %>







    
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