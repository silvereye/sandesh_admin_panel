<%@ page language="java" import="java.util.*,mypack.*,java.text.*,dbutil.*,java.sql.*" pageEncoding="UTF-8"%>
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
    <meta http-equiv="Content-type" content="text/html; charset=utf-8">
      <title>Admin Logs | Silvereye Unified E-mail Server</title>
 <noscript><meta http-equiv="refresh" content="0; URL=/unifiedmail/error/nojavascritp.jsp"></noscript>

    
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/reset.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/screen.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/fancybox.css" />

    <!--[if IE 7]>
        <link rel="stylesheet" type="text/css" href="/iredadmin-pro-ldap/static/default/css/ie7.css">
    <![endif]-->

 <script type="text/javascript">
function printDiv()
{
//alert("hi");
var divToPrint=document.getElementById('div1');
var newWin=window.open('','Print-Window','width=400,height=400,top=100,left=100');
newWin.document.open();
newWin.document.write('<html><head><style>#in {display:none}</style><body onload="window.print()">'+divToPrint.innerHTML+'</body></html>');
newWin.document.close();
//setTimeout(function(){newWin.close();},10);
}

function setMyUrl() {
	var e1 = document.getElementById("domain");
	var domain = e1.options[e1.selectedIndex].value;
	
	var e2 = document.getElementById("admin");
	var admin = e2.options[e2.selectedIndex].value;
	
	var e3 = document.getElementById("event");
	var event = e3.options[e3.selectedIndex].value;
	window.location="/unifiedmail/global/log.jsp?sdm="+domain+"&sadm="+admin+"&msg="+event;
	
}

function showData()
	{
	var cnt=document.getElementById("hidc").value;
		var v=document.getElementById("valtxt").value;
	var e1 = document.getElementById("domain");
	var domain = e1.options[e1.selectedIndex].value;
	
	var e2 = document.getElementById("admin");
	var admin = e2.options[e2.selectedIndex].value;
	
	var e3 = document.getElementById("event");
	var event = e3.options[e3.selectedIndex].value;
	
	var vall=null;
	//var dt=document.f.dt.value;
	//var sel=document.f.filter.value;
//alert(dt+" "+sel)
	
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
   //  alert(xmlhttp.readyState);
    if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
 
   var vall=xmlhttp.responseText;
    // alert(vall);
   
    	document.getElementById("div1").innerHTML = vall; 
    }
    }
xmlhttp.open("GET","/unifiedmail/global/logdata.jsp?domain="+domain+"&admin="+admin+"&event="+event+"&cnt="+cnt+"&val="+v,true);
   //xmlhttp.open("GET","/unifiedmail/global/logdata.jsp?cnt="+cnt,true);
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
var no=parseInt(v);
var no1=parseInt(v1);
//alert(no);
if(no1%45==0)
{
no1=parseInt(no1/15);
}
else
{
no1=parseInt(no1/15);
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
var no=parseInt(v);
//alert(no);
if(no%15==0)
{
no=parseInt(no/15);
}
else
{
no=parseInt(no/15);
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

<body onload="showData()">
     <%@include file="header.jsp" %>
     <%
     String sdm=null;
     String sadm=null;
     String msg=null;
     sdm=request.getParameter("sdm");
     sadm=request.getParameter("sadm");
     msg=request.getParameter("msg");
     if(msg==null || msg.equals("") || msg.equals("all"))
     {
     msg="%";
     }
          
     if(sdm==null || sdm.equals("") || sdm.equals("all"))
     {
     sdm="%";
     }
     if(sadm==null || sadm.equals("") || sadm.equals("all"))
     {
     sadm="%";
     }
     HttpSession hs=request.getSession();
     String utype=null;
     if(hs!=null)
     {
     utype=(String)hs.getAttribute("user_name");
     }
     if(hs!=null && utype!=null)
     {
     
     
      String username= (String)hs.getAttribute("id");
		        String password= (String)hs.getAttribute("password");
		        String url= (String)hs.getAttribute("url");
		        String mbase= (String)hs.getAttribute("base");
		        String base="o=domains,"+mbase;
		         String dstr="";
		         String dm="Global Admin";
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
 		if(dstr.equals(""))
 		{
 		dstr=str;
 		}
 		else
 		{
 		dstr=dstr+","+str;
 		}
 		
 		
           }
    }}
                                    
}

		 catch(Exception e){System.out.print(e);}  
      %>
  <form name="search" method="post" action="">

    <div class="main pagesize"> <!-- *** mainpage layout *** -->
        <div class="main-wrap">
            <div class="page clear">
                
                



<div class="content-box">
    <div class="box-body">
        <div class="box-header clear">
                <h2>
                    Admin Log
                    
                       
                    
                </h2>

           
        </div>


<div class="clear"></div>
<div class="top-space5 bt-space5 left-space5">
    
    Filter:
    <select name="domain" id="domain">
    <%
    if(utype.equalsIgnoreCase("Admin"))
    {
     if(sdm.equalsIgnoreCase("all"))
    {
     %>
        <option value="all" selected="selected">Domains</option>
        <%
        }
        else
        {
     %>
        <option value="all">Domains</option>
        <%
        }
        }
        String arr_dm[]=dstr.split(",");
        for(int i=0;i<arr_dm.length;i++)
        {
          if(sdm.equalsIgnoreCase(arr_dm[i]))
    	{
         %>
         <option value="<%=arr_dm[i] %>" selected="selected"><%=arr_dm[i] %></option>
         <%}
         else
         {
         %>
         <option value="<%=arr_dm[i] %>"><%=arr_dm[i] %></option>
         <%}
         }
         %>
        
    </select>

    
        <select name="admin" id="admin">
                       <%
            if(utype.equalsIgnoreCase("Admin"))
    {
    if(sadm.equalsIgnoreCase("all"))
    {
     %>
         <option value="all" selected="selected">Admins</option>
         <%}
         else 
         {
     %>
         <option value="all">Admins</option>
        <%
        }
        }
        String arr_dm1[]=dstr.split(",");
        for(int i=0;i<arr_dm1.length;i++)
        {
        String val="mail-admin@"+arr_dm1[i];
        if(sadm.equalsIgnoreCase(val))
    	{
         %>
         <option value="<%=val %>" selected="selected"><%=val %></option>
         <%}
         else
         {
         %>
         <option value="<%=val %>"><%=val %></option>
         <%}
         }
         %>
        </select>
    
<%
String all="";
String l="";
String u1="";
String u2="";
String u3="";
String u4="";
String u5="";
String l1="";
String l2="";
String l3="";
String a1="";
String a2="";
String a3="";
String d1="";
String d2="";
String d3="";
if(msg.equalsIgnoreCase("%") || msg.equalsIgnoreCase("all"))
{
all="selected='selected'";
}
else if(msg.equalsIgnoreCase("Login"))
{
l="selected='selected'";
}
else if(msg.equalsIgnoreCase("Active User"))
{
u1="selected='selected'";
}
else if(msg.equalsIgnoreCase("Disable User"))
{
u2="selected='selected'";
}
else if(msg.equalsIgnoreCase("Add User"))
{
u3="selected='selected'";
}
else if(msg.equalsIgnoreCase("Edit User"))
{
u4="selected='selected'";
}
else if(msg.equalsIgnoreCase("Delete User"))
{
u5="selected='selected'";
}
else if(msg.equalsIgnoreCase("Add List"))
{
l1="selected='selected'";
}
else if(msg.equalsIgnoreCase("Edit List"))
{
l2="selected='selected'";
}
else if(msg.equalsIgnoreCase("Delete List"))
{
l3="selected='selected'";
}
else if(msg.equalsIgnoreCase("Add Alias"))
{
a1="selected='selected'";
}
else if(msg.equalsIgnoreCase("Edit Alias"))
{
a2="selected='selected'";
}
else if(msg.equalsIgnoreCase("Delete Alias"))
{
a3="selected='selected'";
}
else if(msg.equalsIgnoreCase("Add Domain"))
{
d1="selected='selected'";
}
else if(msg.equalsIgnoreCase("Edit Domain"))
{
d2="selected='selected'";
}
else if(msg.equalsIgnoreCase("Delete Domain"))
{
d3="selected='selected'";
}

 %>
    <select name="event" id="event">
        
            <option value="all"  <%=all %>>
        Events
    </option>
        
            <option value="Login" <%=l %> >
        Admin login
    </option>
        
            <option value="Active User" <%=u1 %>>
        Activate account
    </option>
        
        <option value="Disable User" <%=u2 %> >
        Disable account
    </option>
        
            <option value="Add User" <%=u3 %>>
        Add account
    </option>
        
        <option value="Edit User" <%=u4 %> >
        Update account
    </option>
            <option value="Delete User" <%=u5 %> >
        Delete account
    </option>
        
            
             <option value="Add List" <%=l1 %>>
        Add list
    </option>
        
        <option value="Edit List" <%=l2 %>>
        Update list
    </option>
            <option value="Delete List" <%=l3 %>>
        Delete list
    </option>
     <option value="Add Alias" <%=a1 %>>
        Add alias
    </option>
        
        <option value="Edit Alias" <%=a2 %>>
        Update alias
    </option>
            <option value="Delete Alias" <%=a3 %>>
        Delete alias
    </option>
    
    <option value="Add Domain" <%=d1 %>>
        Add domain
    </option>
        
        <option value="Edit Domain" <%=d2 %>>
        Update domain
    </option>
            <option value="Delete Domain" <%=d3 %>>
        Delete domain
    </option>
    
    
        
    </select>

    <input type="button" onclick="setMyUrl()" value="Submit" class="button" />
   
</div>

<%
  
            	String sq="SELECT count(*) FROM log where msg like ? and name like ? and domain like ? ORDER BY sn DESC";
            	Connection cnt_con=Crudoperation.createConnection();
            	PreparedStatement cnt_ps=cnt_con.prepareStatement(sq);
            	cnt_ps.setString(1,msg+"%");
            	cnt_ps.setString(2,sadm+"%");
            	cnt_ps.setString(3,sdm+"%");
            	int cnt=0;
            	ResultSet cnt_rs=cnt_ps.executeQuery();
               	if(cnt_rs.next())
            	{
            	cnt=cnt_rs.getInt(1);
            	//out.println("cnt  "+cnt);
            	}
            	
            	 %>
    

<input type="hidden" id="hidc" name="hid_cnt" value="<%=cnt %>"/>


    
    
        
    

   

    <div id="div1">
        
     <table width="100%" class="style1 tablesorter" cellspacing="0">
     <tr >
     <td width="">&nbsp;</td>
     <td width="" style="text-align: center;"><img  src="/unifiedmail/images/myload.GIF"/></td>
     <td width="">&nbsp;</td></tr>
     </table>       
        
    

    
       
</div>

    
        <div class="tab-footer clear f1">
            
                <div class="fl">
                    
                    <input type="button" value="Print" class="button fl-space" onclick="printDiv()"/>
                </div>
            

            
        
    

    
 
    
<%
String fst="<<";
String prv="<";
%>
    <div class="pager fr">
        <span class="pages">
           <input type="button" value="<%=fst %>" class="button fl-space" onclick="start()"/>
        
        </span>

<span class="pages">
        
           
            <input type="button" value="<%=prv %>" class="button fl-space" onclick="startOne()"/>
        
        </span>

        <span class="pages">
        
             <input type="button" id="valtxt" value="1" class="button fl-space" onclick="showData()"/>
           
               
        </span>
        <span class="pages">
        
            <input type="button" value=">" class="button fl-space" onclick="lastOne()"/>
        
        </span>
        
<span class="pages">
        
           
            <input type="button" value=">>" class="button fl-space" onclick="last()"/>
        
        </span>

    </div>
        </div>
    <input type="hidden" name="hid" value="start" />

</div>
</div>


            </div>
        </div>
    </div>

   </form> 
    <%} %>
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
    

    
        <script type="text/javascript" src="/unifiedmail/npjs/jquery.tablesorter.js"></script>
    
    

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