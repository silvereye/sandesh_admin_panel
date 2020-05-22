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
    <title>Edit Domain Profile | Silvereye Unified E-mail Server</title>
 <noscript><meta http-equiv="refresh" content="0; URL=/unifiedmail/error/nojavascritp3.jsp"></noscript>
 
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/reset.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/screen.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/fancybox.css" />

    <!--[if IE 7]>
        <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/ie7.css">
    <![endif]-->

    <link rel="stylesheet" href="/unifiedmail/css/tooltip.css" type="text/css" />
<link rel="stylesheet" href="/unifiedmail/css/style.css" type="text/css" />
<script type="text/javascript">
function removeMsg(id)
{
var element = document.getElementById(id);
element.parentNode.removeChild(element);
//alert(id);
}

</script>
<script type="text/javascript">
function setTextBox(val)
{
//alert(val)
if(val=='other')
	{
	document.getElementById("otr").style.visibility='visible'
	
	//alert(bmx)
	
	}
	else
	{
	document.getElementById("otr").style.visibility='hidden'
	}
}


</script>
<script type="text/javascript">


function valData()
{
var e = document.getElementById("relay");
   var str = e.options[e.selectedIndex].value;
//alert(str)
 var chk=document.getElementById("bmx").checked;
if(str=="other")
{
/*

if(chk)
{
}
else
	{
	alert("Firstly select Mark as Backup MX");
	//document.getElementById("otr").value="";
	return false;
	}
*/	
//alert("hii")
var val=document.getElementById("otr").value;
var n = val.indexOf("@");

if(n>=0)
{
alert("Please enter correct domain or IP, without '@'");
return false;
}
if(val=="" || val==null)
{
alert("Please enter domain or IP");
return false;
}
}
else
{
if(chk)
	{
	alert("Firstly unselect Mark as Backup MX or select Remote SMTP");
	//document.getElementById("otr").value="";
	return false;
	}
}
return true;

}
</script>

</head>

<body>
 
   <%
   String dn=request.getParameter("dn");
  if( dn!=null && !(dn.equals("")) )
   {
   
    
    
    

                HttpSession hs=request.getSession(false);
		        String username= (String)hs.getAttribute("id");
		        String password= (String)hs.getAttribute("password");
		        String url= (String)hs.getAttribute("url");
		        String mbase= (String)hs.getAttribute("base");
		        String base="o=domains,"+mbase;
		        String mta="";
				String bmx="no";
 String utype=(String)hs.getAttribute("user_name");
		        
try
{


DirContext ctx=LDAPConnection.getConnection(url, base, username, password);

SearchControls constraints = new SearchControls(); 
constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
String attrList[] = {"mtaTransport","domainBackupMX"}; 
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
        if(id.equalsIgnoreCase("mtaTransport"))
        {
        	mta=str;
        }
        else if(id.equalsIgnoreCase("domainBackupMX"))
        {
        	bmx=str;
        }
        
        

          // System.out.println("  <br> "+id + ":--- " +str);
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
%>  
       
  
    
    
   
   
    <%@include file="header.jsp" %>

 
    
    

    <div class="main pagesize"> <!-- *** mainpage layout *** -->
        <div class="main-wrap">
        
        
        
        <div class="sublev-nav">	
   	<ul>
   		<li><a href="/unifiedmail/global/domainlist.jsp">All Domains</a></li>
<li><a class="active-subs" href="/unifiedmail/global/editdomainprofile.jsp?dn=<%=dn %>"><%=dn %></a></li>
<li><a href="/unifiedmail/global/userslist.jsp?dm=<%=dn %>">Users</a></li>
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
<p><%=dn %> domain has been updated successfully. </p>	</div>
      <%}
      else if(stt!=null && stt.equalsIgnoreCase("error"))
      {
       %>
 <div id="msg_err" class="notification note-error"><a href='#' class='close'></a>                
<p>Domain updation has been failed.	</p></div>
    
    
    <%} %>



    


<div class="content-box">
    <div class="box-body">
        <div class="box-header clear">
            <ul class="tabs clear">
                
                    
                          
                 <li><a href="/unifiedmail/global/editdomainprofile.jsp?dn=<%=dn %>" >General</a></li>
                        <li><a href="/unifiedmail/global/bccdomain.jsp?dn=<%=dn %>" >BCC</a></li>
                        <li  class="active"><a href="/unifiedmail/global/relaydomain.jsp?dn=<%=dn %>">Relay</a></li>
                        <li><a href="/unifiedmail/global/catchalldomain.jsp?dn=<%=dn %>">Catch-all</a></li>
                        <li><a href="/unifiedmail/global/aliasesdomain.jsp?dn=<%=dn %>">Aliases</a></li>      
                        <li ><a href="/unifiedmail/global/whiteblacklistdomain.jsp?dn=<%=dn %>">White/Blacklist</a></li>                  
                        <%
                         if(utype!=null && utype.equalsIgnoreCase("Admin"))
                                {
                         %>
                        <li><a href="/unifiedmail/global/throttlingdomain.jsp?dn=<%=dn %>">Throttling</a></li>      
                         <%} %> 
                         <li><a href="/unifiedmail/global/disclaimerdomain.jsp?dn=<%=dn %>">Disclaimer</a></li>                  
                        <li><a href="/unifiedmail/global/advancedomain.jsp?dn=<%=dn %>">Advanced</a></li>
                        
                
            </ul>
            <h2>Profile of domain: <%=dn %> <a href="/unifiedmail/global/domainsentmail.jsp?dn=<%=dn %>">
            <img src="/unifiedmail/images/graph_16.png"
                
                    title="Domain activities"
                

                
                    style="padding-left: 5px;" class="vcenter"
                
            />
        </a></h2>
        </div>

        <div class="box-wrap clear">
        
        <form action="/unifiedmail/servlet/EditRelayDomainServlet" name="f" method="post" onsubmit="return valData()">
      
        
        <div class="columns clear">
        <div class="col2-3 ">
        
        
        <div class="form-field clear">
        <h4 class="size-250 fl-space">Mark as backup MX</h4>
        <div class="form-checkbox-item clear fl-space2">
           
                
               <%
                            	if(bmx.equalsIgnoreCase("yes"))
                            	{
                            	 %>  
                                <input class="checkbox fl-space" id="bmx" name="bmx" checked="checked" type="checkbox" value="yes" />
                                <%}
                                else
                                {
                                 %>
                                <input class="checkbox fl-space" id="bmx" name="bmx" type="checkbox" value="no" />
                                
                                <%} %>     
                
   
            
        </div>
    </div>
        
            <div class="form-field clear">
                <h4 class="size-250 fl-space">Relay/Transport Setting</h4>
                <div class="clear">
                   
                       <%
                         String arr[]=null;
                         String sel1="";
                         String sel2="";
                         String sel3="";
                         String sel4="";
                         String stl="hidden;";
                         String otr_val="";
                         if(!mta.equals(""))
                         {
                         if(mta.equalsIgnoreCase("lmtp:127.0.0.1:7025"))
                         	{
                         	    	sel2="selected='selected'";
                         	}
                         else if(mta.equalsIgnoreCase("discard"))
                         	{
                         	sel3="selected='selected'";
                         	}
                         else
                         	{
                         	sel4="selected='selected'";
                         	stl="visible;";
                         	if(mta.indexOf("[")>=0)
                         		{
                         		otr_val=mta.substring((mta.indexOf("[")+1),mta.indexOf("]"));
                         		}
                         	}
                         }
                         else
                         {
                         sel1="selected='selected'";
                         }
                          %>       
                             
                            	
                            	<input type="hidden" name="hid_dn" value="<%=dn %>" />
                     <select name="relay" id="relay" onchange="setTextBox(this.value)">
                                
                                <option value="lmtp:127.0.0.1:7025" <%=sel2 %>>Local Delivery Agent </option>
                                <option value="discard" <%=sel3 %>> Discard</option>
                                <option value="other" <%=sel4 %>>Remote SMTP </option>
                                </select>
                                 
                                  <div id="fooBar1" class="ermsg">
                                   <input name="otr"  id="otr" type="text" size="35" class="text" placeholder="Enter FQDN of Remote SMTP" value="<%=otr_val %>" style="visibility: <%=stl %>"/>
                                  </div>
                    
                </div>
            </div>

            
            
        </div><div class="col1-3 lastcol">
            <div class="notification note-attention">
                <p>Received emails will be relay to specified server.</p>
            </div>
            
            <div class="notification note-attention">
                <p>Per-user relay setting will override per-domain relay setting you set in this page.</p>
            </div>
            

            <div class="mark_blue bt-space10">
                <h4>Sample relay settings</h4>
                <ul class="standard clean-padding bt-space10">
                    
                        <li class="bt-space5"><strong>Local Delivery Agent</strong><br /> default transport</li>
                    

                    <li class="bt-space5"><strong>Discard</strong><br /> receive but discard email, useful for mailboxes like noreply@example.com</li>
                    <li class="bt-space5"><strong>mx1.example.com</strong><br /> forward emails to host mx1.example.com or IP through port 25. </li>
                    
                     </ul>
            </div>
        </div></div>
                

            
            

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
    
<%} %>
    
</body>
</html>

