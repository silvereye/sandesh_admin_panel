
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
     <title>Add Mail List Moderators | Silvereye Unified E-mail Server</title>
 <noscript><meta http-equiv="refresh" content="0; URL=/unifiedmail/error/nojavascritp.jsp"></noscript>
    
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/reset.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/screen.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/fancybox.css" />

    <!--[if IE 7]>
        <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/ie7.css">
    <![endif]-->
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
function chkList(val)
{
val=val.trim();
document.getElementById("mail").value=val;
var n = val.indexOf("@");
if(n>=0)
{
alert("Please input email without @")
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
    xmlhttp.open("GET","/unifiedmail/servlet/CheckListMailServlet?mail="+usr+"&dm="+dm,true);
   //var xx=document.f.chk.value;
   //alert(xx);
    xmlhttp.send();
    }
    }
}


function setNUrl(val)
  {
  if(val=="index")
  val="";
  var url="/unifiedmail/global/addmaillist.jsp?dm="+val;
 //alert(url)
 window.location=url;
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

return true;

}


function selectAll() {
    var all = document.getElementById('chkall');
var items = document.getElementsByName('local');
    if(all.checked == true)
	{
 	for (var i = 0; i < items.length; i++) {
            if (items[i].type == 'checkbox')
                items[i].checked = true;
        }

	}
else
	{
 for (var i = 0; i < items.length; i++) {
            if (items[i].type == 'checkbox')
                items[i].checked = false;
        }

	}
}

</script>

    
    
    
    
  <style>
    .blockbkg {
      background-color: black;
      opacity: 90%;
      filter:alpha(opacity=90);
      background-color: rgba(0,0,0,0.90);
      width: 100%;
      min-height: 100%;
      overflow: hidden;
      float: absolute;
      position: fixed;
      top: 0;
      left: 0;
      color: white;
    }
    .cont {
      background-color: white;
      color: black;
      font-size: 16px;
      border: 1px solid gray;
      padding: 20px;
      display:block;
      position: absolute;
      top: 10%;
      left: 35%;
      width: 350px;
      height: 400px;
      overflow-y: scroll;
    }
    .closebtn {
      width: 20px;
      height: 20px;
      padding: 5px;
      margin: 2px;
      float: right;
      top: 0;
      background-image: url(x.png);
      background-repeat: no-repeat;
      background-position:center;
      background-color: lightgray;
      display: block;
    }
    .closebtn:hover {
      cursor: pointer;
    }
   
  </style>

  
    
    <script type="text/javascript">
    function mypopUp()
    {

     document.getElementById('bkg').style.visibility = 'visible';
      document.getElementById('dlg').style.visibility = 'visible';
    }
    
    function closeDiv()
    {
  
    document.getElementById('bkg').style.visibility = 'hidden';
    document.getElementById('dlg').style.visibility ='hidden';
    }
    
    
    function addLocMail()
    {
  //  document.getElementById('bkg').style.visibility = 'hidden';
  //  document.getElementById('dlg').style.visibility ='hidden';
    
    var av=document.getElementsByName("local");
 //alert("hi");
 document.getElementById("loc_mail_div").innerHTML="";
 

 for (e=0;e<av.length;e++) {
  if (av[e].checked==true) {
  var n=av[e].value//.split("-"); 
  
  if(n!=null)
  {
  //alert(n)
 document.getElementById("loc_mail_div").innerHTML+="<input type='checkbox' name='loc_mail' value='"+n+"' checked='checked' />"+n+"<br/>";
 }
 }
 }
 fg_hideform('fg_formContainer','fg_backgroundpopup');
    }
    
    
    
    </script>
    
    <script type="text/javascript">
    
    
  
    
    function addExMailAdd()
{
var val=document.getElementById("add_ex_mail").value;
var dn=document.getElementById("hid_dn").value;
if(val==null || val=="")
{
alert("Please enter external mail.");
}
else
{
if(val.indexOf("@")<0)
{
alert("Please enter correct email.");
}
else if(val.indexOf("@"+dn)>=0)
{
alert("Please enter external email.");
}
else
{
document.getElementById("ex_mail_div").innerHTML+="<input type='checkbox' name='ex_mail' value='"+val+"' checked='checked' />"+val+"<br/>";
document.getElementById("add_ex_mail").value="";
}
}
}
 
    </script>
<link rel="STYLESHEET" type="text/css" href="/unifiedmail/popup/popup-contact.css" />
</head>
<body onload="javascript:fg_hideform('fg_formContainer','fg_backgroundpopup');">
 <%
    String ml=request.getParameter("ml");
   String dm="";
  if( ml!=null && !(ml.equals("")) )
   {
   				String arr[]=ml.split("@");
   				dm=arr[1];
    
    String stt=request.getParameter("status");
    
    String inmod="";
    String exmod=""; 
      HttpSession hs=request.getSession(false);
		        String username= (String)hs.getAttribute("id");
		        String password= (String)hs.getAttribute("password");
		        String url= (String)hs.getAttribute("url");
		        String mbase= (String)hs.getAttribute("base");
		        String base="ou=Groups,domainName="+dm+",o=domains,"+mbase;
	 
	    
     if(dm==null || dm.equalsIgnoreCase(""))
     {
     dm="";
     
     }
     else
     {
     
     try
{


DirContext ctx=LDAPConnection.getConnection(url, base, username, password);

SearchControls constraints = new SearchControls(); 
constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
String attrList[] = {"listAllowedUser"}; 
constraints.setReturningAttributes(attrList);
NamingEnumeration results =ctx.search(base,"mail="+ml, constraints);
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
        if(id.equalsIgnoreCase("listAllowedUser"))
        {
        if(str.indexOf("@"+dm)>=0)
        	{
        	if(inmod==null || inmod.equals(""))
        	{
        	inmod=str;
        	}
        	else
        	{
        	inmod=inmod+","+str;
        	}
        	}
        else
        	{
        	if(exmod==null || exmod.equals(""))
        	{
        	exmod=str;
        	}
        	else
        	{
        	exmod=exmod+","+str;
        	}
        	}
        
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
 <form name="f"  id="register" method="post" action="/unifiedmail/servlet/AddMailListModeratorsServlet" onsubmit="return valData()">
   
        
     
    <div class="main pagesize"> <!-- *** mainpage layout *** -->
        <div class="main-wrap">
            
            
          <div class="sublev-nav">	
   	<ul>
   		<li><a href="/unifiedmail/global/domainlist.jsp">All Domains</a></li>
<li><a href="/unifiedmail/global/editdomainprofile.jsp?dn=<%=dm %>"><%=dm %></a></li>
<li><a href="/unifiedmail/global/userslist.jsp?dm=<%=dm %>">Users</a></li>
<li><a href="/unifiedmail/global/maillistslist.jsp?dm=<%=dm %>">Mail Lists</a></li>
<li><a class="active-subs" href="/unifiedmail/global/editmaillistprofile.jsp?ml=<%=ml %>" >Profile of Mail List: &nbsp;&nbsp;<%=ml %></a></li>
<li><a href="/unifiedmail/global/mailaliaseslist.jsp?dm=<%=dm %>">Mail Aliases</a></li>
   	</ul>
   	<div class="clr"></div>
   	</div>
            
            <div class="page clear">
                
                
<%

    if(stt!=null && stt.equalsIgnoreCase("succ"))
    {  
     
     %>
      <div class='notification note-success'><a href='#' class='close'></a>
      <p><%=ml %> Mail List has been updated successfully. </p></div>
      <%}
      else if(stt!=null && stt.equalsIgnoreCase("error"))
      {
       %>
                <div id="msg_err" class="notification note-error"><a href='#' class='close'></a>  
                <p>Mail List updation has been failed.	</p> </div>
    
    
    <%} 
    %>



    <div class="content-box">
        <div class="box-body">
            <div class="box-header clear">
                <ul class="tabs clear">
              
                  <li><a href="/unifiedmail/global/editmaillistprofile.jsp?ml=<%=ml %>" >General</a></li>
                        <li><a href="/unifiedmail/global/maillistmembers.jsp?ml=<%=ml %>" >Members</a></li>
                       <li><a href="/unifiedmail/global/maillistmoderators.jsp?ml=<%=ml %>">Owners</a></li>
                         <li><a href="/unifiedmail/global/addmaillistmembers.jsp?ml=<%=ml %>">Add Members</a></li>
                        <li   class="active"><a href="/unifiedmail/global/addmaillistmoderators.jsp?ml=<%=ml %>">Add Owners</a></li>
            </ul>  
         

                <h2>
                   Profile of mail list:<%=ml %>
                    
                </h2>
            </div>

            <div id="maillist_add" class="box-wrap clear">
     
    

        
   

    <div class="form-field clear">
 <input type="hidden" id="hid_dn" name="hid_dn" value="<%=dm %>"  />
        <input type="hidden" id="hid_ml" name="hid_ml" value="<%=ml %>"  />
            <h4 class="size-250 fl-space">Add Internal  Moderators </h4>
        

        <span class="clean-padding bt-space20">
            
        
        
        
    
                                    	 <div class="checklist clear" style=" max-width: 25em;" id="loc_mail_div">
   
   <%
                                            	String arrlst1[]=inmod.split(",");
   												Arrays.sort(arrlst1);
                                            	for(int i=0;i< arrlst1.length;i++)
                                            	{
                                            	
                                            	if(arrlst1[i]!= null && !(arrlst1[i].equals("")))
                            	{
                                            	 %>
   
                        
                             <input type="checkbox"  name="loc_mail" value="<%=arrlst1[i] %>" checked="checked"  class="checkbox" />
                  <%=arrlst1[i] %><br/>
                            
                            <%}}%>
                           
                           
            </div>
             <div class="ermsg" id="sp1" style="width: 340px;">
             
              
             
             <a href='javascript:fg_popup_form("fg_formContainer","fg_form_InnerContainer","fg_backgroundpopup");'>
 <input name="bt1" type="button" value="Add" class="add-row-domain-button" />
</a>
             </div>
               
        
        
        
        
        </span>
    </div>


   <div class="bt-space0"> &nbsp;</div>
     
    <div class="form-field clear">
        
            <h4 class="size-250 fl-space">Add External Moderators</h4>
            
            <span class="clean-padding bt-space20">
            
        
        
        
    
                                    	 <div class="checklist clear" style=" max-width: 25em;" id="ex_mail_div">
                                    	 
                                    	 <%
                                
                            	String ex_arr[]=exmod.split(",");
                                    	 Arrays.sort(ex_arr);
                            	System.out.println("ex="+exmod);
                            	 for(int i=0;i<ex_arr.length;i++)
                            	{
                            	if(ex_arr[i]!= null && !(ex_arr[i].equals("")))
                            	{
                            	 %> 
                                    	  <input type="checkbox"  name="ex_mail" value="<%=ex_arr[i] %>" checked="checked"  class="checkbox" />
                  <%=ex_arr[i] %><br/>
                                    	 
                              <%}} %>      	 
                                    	 </div>
                                    	  <div class="ermsg1" id="sp1" style="width: 340px;">
             <input class="text" type="text" size="42" value="" placeholder="Ex: example@gmail.com" id="add_ex_mail">
             <input name="bt2" type="button" value="Add" class="add-row-domain-button" onclick="addExMailAdd()"/>
             </div>
             </span>
            
            
            
        
    </div>
   
   

    <div class="rule2"></div>
    <div class="form-field clear">
        <h4 class="size-250 fl-space">&nbsp;</h4>
        <span class="clean-padding bt-space20">
            <input type="submit" value="Update" class="button green" />
        </span>
    </div>

   
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
<div id='fg_formContainer' style="width: 525px;">
   

    <div id="fg_form_InnerContainer" style="max-height: 400px;    overflow-y: scroll;">
      <table class="style1">
                            <thead>
                            <tr>
                                <th class="checkbox"><input type="checkbox" class="checkbox select-all"  onclick="selectAll()" id="chkall"></th>
                                <th>Display Name</th>
                                <th>Mail Address</th>
                                
                                <th style="text-align: center;">Account Status</th>
                            </tr>
                            </thead>

                            
                            <tbody>
                                            	
                                            	<%
                                            	String lst=GetUsersList.getUsersListNew(url,username,password,mbase,dm,"mail","*");
                                            	String arrlst[]=lst.split("<!nps!>");
                                            	Arrays.sort(arrlst);
                                            	for(int i=0;i< arrlst.length;i++)
                                            	{
                                            	
                                            		String arrlst0[]=arrlst[i].split("<#nps#>");
                                            	
                                            		
                                                 	   %>
                                                        <tr class="odd active">
                                                       <% 
                                                  
                                            //System.out.println("memgp=  "+inmod.indexOf(arrlst[i]));
                                            	if(inmod.indexOf(arrlst0[0])>-1)
                                            	{
                                            	
                                            	 %>
                                                 <td class="checkbox">
                                                <input type="checkbox" name="local" checked="checked" value="<%=arrlst0[0] %>"/></td>
                                                 
                                                <%
                                                if(arrlst0.length>1) 
                                                 {
                                                %>
                                                <td style="text-align: left;"> <%=arrlst0[1] %></td>
                                                 <td style="text-align: left;"><%=arrlst0[0] %> </td>
                                                <td align="center">
                                             <%if(arrlst0[2].equalsIgnoreCase("active"))
                                             {
                                            	 %>
       										  <img src="/unifiedmail/images/right_mark.png" />
        									 <%}
                                             else
                                             {
                                             %>
                                              <img src="/unifiedmail/images/image1.png" />
                                              <%} %> 
                                            
                                            </td>
                                                 <%}
                                                else
                                                	{%>
                                                <td ></td>
                                                 <td style="text-align: left;"><%=arrlst0[0] %> </td>
                                                 <td align="center"></td>
                                                <%}
                                            	}
                                                else
                                                {
                                                %>	 
                                                  <td class="checkbox">
                                                <input type="checkbox" name="local" value="<%=arrlst0[0] %>"/></td>
                                                 <%
                                                if(arrlst0.length>1) 
                                                 {
                                                %>
                                                <td style="text-align: left;"> <%=arrlst0[1] %></td>
                                                 <td style="text-align: left;"><%=arrlst0[0] %> </td>
                                                <td align="center">
                                             <%if(arrlst0[2].equalsIgnoreCase("active"))
                                             {
                                            	 %>
       										  <img src="/unifiedmail/images/right_mark.png" />
        									 <%}
                                             else
                                             {
                                             %>
                                              <img src="/unifiedmail/images/image1.png" />
                                              <%} %> 
                                            
                                            </td>
                                                 <%} 
                                                else
                                                {
                                                 %>
                                                 <td ></td>
                                                 <td style="text-align: left;"><%=arrlst0[0] %> </td>
                                                 <td align="center"></td>
                                                 <%}} %>
                                                </tr>
                                                	<%} %>
                                               </tbody> 	
                                                 </table>
                                                	
                                               
           
            </div>
    <div style="margin-bottom: 10px;     margin-top: -7px;">
    <input type="button" value="Add" class="button green" onclick="addLocMail()"/>	
    <input type="button" value="Cancel" style="    margin-left: 10px;" class="button green" onclick="fg_hideform('fg_formContainer','fg_backgroundpopup')"/>
    </div>
</div>

<div id='fg_backgroundpopup'></div>
  
  
  
  
   </form>
  
  
  
  
  
  
  
  
  
  
  
  
         <%@include file="footer.jsp" %>
   
    
        
   

    
    

    <%} %>
</body>
</html>