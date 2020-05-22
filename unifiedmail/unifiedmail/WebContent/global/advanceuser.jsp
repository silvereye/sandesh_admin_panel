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
     <title>Edit User Profile | Silvereye Unified E-mail Server</title>
 <noscript><meta http-equiv="refresh" content="0; URL=/unifiedmail/error/nojavascritp3.jsp"></noscript>
    
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/reset.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/screen.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/fancybox.css" />

    <!--[if IE 7]>
        <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/ie7.css">
    <![endif]-->

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


<script type="text/javascript">
function valData()
{


return true;

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

</head>

<body>
   <%
  	HttpSession hs=request.getSession(false);
 String chid= (String)hs.getAttribute("id");
 if(chid==null)
{
System.out.println("hii dgfgf");
%>
<script type="text/javascript">
	window.open("/unifiedmail/login/login.jsp?val=ses", "_self", false);
	</script>
<%
}
else
{
 %>        
   <%
   String mail=request.getParameter("ml");
   String dn="";
  if( mail!=null && !(mail.equals("")) )
   {
   				String arrdn[]=mail.split("@");
   				dn=arrdn[1];
              //  HttpSession hs=request.getSession(false);
		        String username= (String)hs.getAttribute("id");
		        String password= (String)hs.getAttribute("password");
		        String url= (String)hs.getAttribute("url");
		        String mbase= (String)hs.getAttribute("base");
		        String utype=(String)hs.getAttribute("user_name");
		        String base="ou=Users,domainName="+dn+",o=domains,"+mbase;
		        String acc="";
		        String ftpdom=GetMValueAtt.getDomValueAtt(url,username,password,mbase,dn,"domainFTPStatus");
String malias="";
int fd=0; 
String serv="";
String senbcc="";
String recbcc="";
String mta=""; 
String qftp="";
String ftpdb="";
String ftpub="";
String ftpdr="";
String ftpur="";     
try
{


DirContext ctx=LDAPConnection.getConnection(url, base, username, password);

SearchControls constraints = new SearchControls(); 
constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
String attrList[] = {"enabledService","FTPDownloadBandwidth", "FTPUploadBandwidth", "FTPDownloadRatio", "FTPUploadRatio","shadowAddress","userRecipientBccAddress","userSenderBccAddress","mtaTransport"}; 
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
        if(id.equalsIgnoreCase("shadowAddress"))
        {
        if(malias.equalsIgnoreCase(""))
        	{
        	malias=str;
        	}
        	else
        	{
        	malias=malias+"\n"+str;
        	
        	}
        }
        else  if(id.equalsIgnoreCase("enabledService"))
        {
        	if(str.equalsIgnoreCase("shadowaddress"))
        	{
        	fd=1;
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
        else if(id.equalsIgnoreCase("userRecipientBccAddress"))
        {
        recbcc=str;
        }
        else if(id.equalsIgnoreCase("userSenderBccAddress"))
        {
        senbcc=str;
        }
        else if(id.equalsIgnoreCase("mtaTransport"))
        {
        mta=str;
        }
         else if(id.equalsIgnoreCase("FTPUploadBandwidth"))
        {
        ftpub=str;
        }  
        else if(id.equalsIgnoreCase("FTPDownloadBandwidth"))
        {
        ftpdb=str;
        }  
        else if(id.equalsIgnoreCase("FTPDownloadRatio"))
        {
        ftpdr=str;
        }  
        else if(id.equalsIgnoreCase("FTPUploadRatio"))
        {
        ftpur=str;
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
                    
             
                       <li><a href="/unifiedmail/global/edituserprofile.jsp?ml=<%=mail %>" >General</a></li>
                        <li ><a href="/unifiedmail/global/forwardinguser.jsp?ml=<%=mail %>" >Forwarding</a></li>
                         <li><a href="/unifiedmail/global/whiteblacklistuserNew.jsp?ml=<%=mail %>">White/Blacklist</a></li>
                         <li><a href="/unifiedmail/global/passworduser.jsp?ml=<%=mail %>">Password</a></li>
                       <%
                         if(utype!=null && utype.equalsIgnoreCase("Admin"))
                                {
                         %>
						<li><a href="/unifiedmail/global/throttlinguser.jsp?ml=<%=mail %>">Throttling</a></li>
                        <%} %>
                        <li><a href="/unifiedmail/global/whiteblistuser.jsp?ml=<%=mail %>">Control</a></li>
                        <li   class="active"><a href="/unifiedmail/global/advanceuser.jsp?ml=<%=mail %>">Advanced</a></li>
                        
                        </ul>


                <h2>Profile of user: <%=mail %> <a href="/unifiedmail/global/usersentmails.jsp?ml=<%=mail %>">
            <img src="/unifiedmail/images/graph_16.png"
                
                    title="Account activities"
                

                
                    style="padding-left: 5px;" class="vcenter"
                
            />
        </a></h2>
            </div>

        <div class="box-wrap clear">
           <form id="register" action="/unifiedmail/servlet/AdvanceUserServlet" name="f" method="post" onsubmit="return valData()">
   
    
                            	<input type="hidden" name="hid_mail" value="<%=mail %>" />
                                 <input type="hidden" name="hid_serv" value="<%=serv %>" />                                                               
                                
     <div class="columns clear">
            <div class="col2-3">
                <div class="form-field clear">
                    <h4 class="size-250 fl-space">Enable alias account</h4>
                  
                    <input type="hidden" name="hid_dn" value="<%=dn %>" />
                            	<%
                            	if(fd==1)
                            	{
                            	 %>  
                                <input name="acc" checked="checked" type="checkbox" value="yes" />
                                <%}
                                else
                                {
                                 %>
                                <input name="acc" type="checkbox" value="no" />
                                
                                <%} %>
                </div>

                <div class="form-field clear">
                    <h4 class="size-250 fl-space">Email addresses of alias accounts</h4>
                    
                    <textarea name="shadowAddresses" readonly="readonly" rows="6" style="width: 50%" class="textarea"><%=malias %></textarea>
                </div>
            </div><div class="col1-3 lastcol">
                <div class="mark_blue bt-space10">
                    <ul class="standard clean-padding bt-space10">
                        <li class="bt-space5">Emails sent to alias accounts will be delivered to user <strong><%=mail %></strong>.</li>
                        <li class="bt-space5">Email address of alias account must end with domain name(s): <strong><%=dn %></strong>.</li>
                    </ul>
                </div>
            </div>
        </div>




        <div class="columns clear">
            <div class="col2-3 ">
                
    <div class="form-field clear">
        <h4 class="size-250 fl-space">BCC incoming emails to single address</h4>
        <span class="clean-padding">
            <input type="email" name="recbcc" value="<%=recbcc %>" size="35" class="text" />
        </span>
    </div>
                
    <div class="form-field clear">
        <h4 class="size-250 fl-space">BCC outgoing emails to single address</h4>
        <span class="clean-padding">
            <input type="email" name="senbcc" value="<%=senbcc %>"  size="35" class="text" />
        </span>
    </div>
            </div>

            <div class="col1-3 lastcol">
                <div class="mark_blue bt-space10">
                    <ul class="standard clean-padding bt-space10">
                        <li class="bt-space5">Multiple addresses are NOT supported.</li>
                        <li class="bt-space5">Per-domain bcc settings will override per-user bcc settings.</li>
                    </ul>
                </div>
            </div></div>
        

<%
if(ftpdom!=null && ftpdom.equalsIgnoreCase("TRUE"))
{
 %>
<div class="columns clear">
            <div class="col2-3 ">
                
    
         
         
         
         
         <div class="form-field clear">
        <h4 class="size-250 fl-space">FTP Download Bandwidth</h4>
        <span class="clean-padding">
           <%if(utype.equalsIgnoreCase("Admin"))
              {
         		%>
            <input type="text" name="ftpdb" value="<%=ftpdb %>" size="12" class="text" />&nbsp;KB
            <%}
            else
            {
             %>
             <input type="text" disabled="disabled" name="ftpdb" value="<%=ftpdb %>" size="12" class="text" />&nbsp;KB
             <%} %>
        </span>
    </div>
    
    
    <div class="form-field clear">
        <h4 class="size-250 fl-space">FTP Upload Bandwidth</h4>
        <span class="clean-padding">
         <%if(utype.equalsIgnoreCase("Admin"))
              {
         		%>
            <input type="text" name="ftpub" value="<%=ftpub %>" size="12" class="text" />&nbsp;KB
            <%}
            else
            {
             %>
             <input type="text" disabled="disabled" name="ftpub" value="<%=ftpub %>" size="12" class="text" />&nbsp;KB
             <%} %>
        </span>
    </div>
    
    
    <div class="form-field clear">
        <h4 class="size-250 fl-space">FTP Download Ratio</h4>
        <span class="clean-padding">
        <%if(utype.equalsIgnoreCase("Admin"))
              {
         		%>
            <input type="text" name="ftpdr" value="<%=ftpdr %>" size="12" class="text" />
             <%}
            else
            {
             %>
              <input type="text" disabled="disabled" name="ftpdr" value="<%=ftpdr %>" size="12" class="text" />
             <%} %>
        </span>
    </div>
    
    
    <div class="form-field clear">
        <h4 class="size-250 fl-space">FTP Upload Ratio</h4>
        <span class="clean-padding">
        <%if(utype.equalsIgnoreCase("Admin"))
              {
         		%>
            <input type="text" name="ftpur" value="<%=ftpur %>" size="12" class="text" />
             <%}
            else
            {
             %>
              <input type="text" disabled="disabled" name="ftpur" value="<%=ftpur %>" size="12" class="text" />
             <%} %>
        </span>
    </div>
         
         
         
                
    
            </div>

            </div>
<%}
else
{
 %>
 <input type="hidden" name="ftpdb" value="<%=ftpdb %>" />
  <input type="hidden" name="ftpub" value="<%=ftpub %>"  />
    <input type="hidden" name="ftpdr" value="<%=ftpdr %>"  />
       <input type="hidden" name="ftpur" value="<%=ftpur %>"  />
 <%} %>       
        <div class="bt-space0">&nbsp;</div>




         
    <div class="columns clear">
        <div class="col2-3 ">
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
                 <select name="relay" id="relay" onchange="setTextBox(this.value)">
                                
                                
                                
                                <option value="lmtp:127.0.0.1:7025" <%=sel2 %>>Local Delivery Agent </option>
                                <option value="discard" <%=sel3 %>> Discard</option>
                                <option value="other" <%=sel4 %>>Remote SMTP </option>
                                </select>
                                 
                                  <div id="fooBar1" class="ermsg">
                                   <input name="otr"  id="otr" type="text" size="35" class="text" placeholder="Enter FQDN of Remote SMTP" value="<%=otr_val %>" style="visibility: <%=stl %>"/>
                                  </div><!--
                    
                
                    <input type="text" name="mta" value="" size="35" class="text" />
                --></div>
            </div>

            
        </div><div class="col1-3 lastcol">
            <div class="notification note-attention">
                <p>Received emails will be relay to specified server.</p>
            </div>
            

            <div class="mark_blue bt-space10">
                <h4>Sample relay settings</h4>
                <ul class="standard clean-padding bt-space10">
                    

                    <li class="bt-space5"><strong>discard</strong><br /> receive but discard email, useful for mailboxes like noreply@example.com</li>
                    <li class="bt-space5"><strong>smtp:[example.com]:25</strong><br /> forward emails to host example.com through port 25. The [] form is required when you specify an IP address instead of a hostname, or disable MX DNS lookup.</li>
                    
                        <li class="bt-space5">Leave it empty to use <a href='/unifiedmail/global/relaydomain.jsp?dn=<%=dn %>'>domain setting</a>.</li>
                    
                    
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
    
<%} }%>
    
</body>
</html>