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
    <title>Bulk User Upload | Silvereye Unified E-mail Server</title>
 <noscript><meta http-equiv="refresh" content="0; URL=/unifiedmail/error/nojavascritp3.jsp"></noscript>
 
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/reset.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/screen.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/fancybox.css" />

    <!--[if IE 7]>
        <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/ie7.css">
    <![endif]-->

    <link rel="stylesheet" href="/unifiedmail/css/tooltip.css" type="text/css" />
<link rel="stylesheet" href="/unifiedmail/css/style.css" type="text/css" />
<script type="text/javascript" src="/unifiedmail/jqr/npjquery.js"></script>
    <script type="text/javascript">
    
    $(function(){
    $('#f').change(function(){
    var f=this.files[0]
  // alert(f.size||f.fileSize)
    var sz=f.size
    if(sz>102400)
    {
    alert("File size must be less than 100KB..");
    document.getElementById("f").value="";
    }
    var nm=f.name;
    var narr=nm.split(".");
    var ex=narr[narr.length-1];
    if(ex=="csv" || ex=="CSV")
    {
    }
    else
    {
    alert("File must be csv only..");
    document.getElementById("f").value="";
    }
    
    })
    })
    </script>
    
<script type="text/javascript">
function getInf(val)
{
if(val=="no")
{
var e = document.getElementById("domain");
   var str = e.options[e.selectedIndex].text;
   val=str;
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
    
	 document.getElementById("sp1").innerHTML =vall;
	
	 
    }
    }
    xmlhttp.open("GET","/unifiedmail/global/bulkuserinfo.jsp?dm="+val,true);
   //var xx=document.f.chk.value;
   //alert(xx);
    xmlhttp.send();
    }
</script>
<link rel="STYLESHEET" type="text/css" href="/unifiedmail/popup/popup-contact.css" />
</head>
<body onload="javascript:fg_hideform('fg_formContainer','fg_backgroundpopup');getInf('no')">
 
    
    
   
   
    <%@include file="header.jsp" %>

 <%
  				HttpSession hs=request.getSession(false);
		        String username= (String)hs.getAttribute("id");
		        String password= (String)hs.getAttribute("password");
		        String url= (String)hs.getAttribute("url");
		        String mbase= (String)hs.getAttribute("base");
		        String base="o=domains,"+mbase;
  %>
    
    

    <div class="main pagesize"> <!-- *** mainpage layout *** -->
        <div class="main-wrap">
        
        
        
     
        
        
            <div class="page clear">
                
                




    


<div class="content-box">
    <div class="box-body">
        <div class="box-header clear">
            
            <h2>Bulk User Upload </h2>
        </div>

        <div class="box-wrap clear">
        
        <form name="frm" action="/unifiedmail/servlet/UploadCsvServlet" enctype="multipart/form-data" method="post">
        
        <div class="columns clear">
        <div class="col2-3 ">
        
        
        
        
        
        
        <div class="form-field clear">
                                <h4 class="size-250 fl-space">Select Domain <span class="required">*</span></h4>
                                <span class="clean-padding">
                                
                                    <select name="domain" id="domain" onchange="getInf(this.value)">
                                        
                                           
                                <%
                                   
		        
try
{
/*Hashtable env = new Hashtable();
env.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
env.put(Context.PROVIDER_URL, "ldap://192.168.1.16:389"); // LDAP host and base

// LDAP authentication options
env.put(Context.SECURITY_AUTHENTICATION, "simple");
env.put(Context.SECURITY_PRINCIPAL, username);
env.put(Context.SECURITY_CREDENTIALS, password);*/

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
  
%>
<option value="<%=str %>"><%=str %></option>
<%

           //out.println("  <br> "+id + ":--- " +str);
           }
    }}
                                    
}

		 catch(Exception e){System.out.print(e);}  %>
                                        
                                    </select>
                                </span>
                                <div class="ermsg" id="sp1"></div>
                            </div>
        
        
        
        
        
        
        
        
        <div class="form-field clear">
        <h4 class="size-250 fl-space">Format of CSV File</h4>
        <div class="form-checkbox-item clear fl-space2">
           
                
               <a href='javascript:fg_popup_form("fg_formContainer","fg_form_InnerContainer","fg_backgroundpopup");'>
                                <img title="Plz.Click me" height="25" width="30" style="border: thin inset" src="/unifiedmail/global/images/csv.png" />
                </a>             
   
           
        </div>
    </div>
        
            <div class="form-field clear">
                <h4 class="size-250 fl-space">Upload CSV File</h4>
                <div class="clear">
                   
                      
                    
                                 
                                
                                   <input id="f" name="f" required type="file" size="35" class="text" />
                         
                    
                </div>
            </div>

            
            
        </div><div class="col1-3 lastcol">
            <div class="notification note-attention">
                <p>You can add user in bulk.</p>
            </div>
            <div class="notification note-attention" style="height: 200">
                <p>For Downloading CSV format. 
                <a href="/unifiedmail/global/images/records.csv">
                Click here</a></p>
            </div>
           
            

            <div class="mark_blue bt-space10">
                <h4>Hints for Bulk User Addition</h4>
                <ul class="standard clean-padding bt-space10">
                    <li class="bt-space5">File should be csv file.</li>
                    <li class="bt-space5"> All columns have only value of attribute.</li>
                    <li class="bt-space5">One row should have data of only one user.</li>
                    <li class="bt-space5">CSV File should contain users of only one domain at a time and file should contains maximum 50 records at a time.</li>
                    <li class="bt-space5">Columns should follow order : First name, Last name, Email id, Password</li>
                   
                    
                     </ul>
            </div>
        </div></div>
                

            
            

                <div class="rule2"></div>
    <div class="form-field clear">
        <h4 class="size-250 fl-space">&nbsp;</h4>
        <span>
            <input type="submit" value="Upload" class="button green" />
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
<div id='fg_formContainer' style="width: auto; left: 27%;">
    <div id="fg_container_header">
        <div id="fg_box_Title">CSV Format</div>
        <div id="fg_box_Close"><a href="javascript:fg_hideform('fg_formContainer','fg_backgroundpopup');">Close(X)</a></div>
    </div>

    <div id="fg_form_InnerContainer">
<img src="/unifiedmail/global/images/csv_img.png"/>
    </div>
</div>
   <div id='fg_backgroundpopup'></div>
       <%@include file="footer.jsp" %>
   
    
   
    

    
</body>
</html>

