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
 <noscript><meta http-equiv="refresh" content="0; URL=/unifiedmail/error/nojavascritp1.jsp"></noscript>
 
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/reset.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/screen.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/fancybox.css" />

    <!--[if IE 7]>
        <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/ie7.css">
    <![endif]-->

	
<script type="text/javascript">
 function addBSenMail()
{
var val=document.getElementById("add_bs_mail").value;

if(val==null || val=="")
{
alert("Please enter email address.");
}
else
{
if(val.indexOf("@")<0)
{
alert("Please enter correct email.");
}
else
{
document.getElementById("bsen_div").innerHTML+="<input type='checkbox' name='bs_mail' value='"+val+"' checked='checked' />"+val+"<br/>";
document.getElementById("add_bs_mail").value="";
}
}
}




 function addBRecMail()
{
var val=document.getElementById("add_br_mail").value;

if(val==null || val=="")
{
alert("Please enter email address.");
}
else
{
if(val.indexOf("@")<0)
{
alert("Please enter correct email.");
}
else
{
document.getElementById("brec_div").innerHTML+="<input type='checkbox' name='br_mail' value='"+val+"' checked='checked' />"+val+"<br/>";
document.getElementById("add_br_mail").value="";
}
}
}




function addWSenMail()
{
var val=document.getElementById("add_ws_mail").value;

if(val==null || val=="")
{
alert("Please enter email address.");
}
else
{
if(val.indexOf("@")<0)
{
alert("Please enter correct email.");
}
else
{
document.getElementById("wsen_div").innerHTML+="<input type='checkbox' name='ws_mail' value='"+val+"' checked='checked' />"+val+"<br/>";
document.getElementById("add_ws_mail").value="";
}
}
}
 
 
 
 
 
function addWRecMail()
{
var val=document.getElementById("add_wr_mail").value;

if(val==null || val=="")
{
alert("Please enter email address.");
}
else
{
if(val.indexOf("@")<0)
{
alert("Please enter correct email.");
}
else
{
document.getElementById("wrec_div").innerHTML+="<input type='checkbox' name='wr_mail' value='"+val+"' checked='checked' />"+val+"<br/>";
document.getElementById("add_wr_mail").value="";
}
}
}
 
 
 
 
 
 
    </script>



</head>

<body>
  <%
   String mail=request.getParameter("ml");
   String dn="";
  if( mail!=null && !(mail.equals("")) )
   {
   				String arrdn[]=mail.split("@");
   				dn=arrdn[1];
String bsen="";
String wsen="";
String brec="";
String wrec="";

HttpSession hs=request.getSession(false);
		        String username= (String)hs.getAttribute("id");
		        String password= (String)hs.getAttribute("password");
		        String url= (String)hs.getAttribute("url");
		        String mbase= (String)hs.getAttribute("base");
		        
		        
		        String utype=(String)hs.getAttribute("user_name");
		        
		        
		        String base="ou=Users,domainName="+dn+",o=domains,"+mbase;
		        String acc="";
String mailfd="";
int fd=0; 
String serv="";      
try
{


DirContext ctx=LDAPConnection.getConnection(url, base, username, password);

SearchControls constraints = new SearchControls(); 
constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
String attrList[] = {"amavisBlacklistSender","amavisWhitelistSender","mailBlacklistRecipient","mailWhitelistRecipient"}; 
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
        if(id.equalsIgnoreCase("amavisBlacklistSender"))
        {
        if(bsen.equalsIgnoreCase(""))
        	{
        	bsen=str;
        	}
        	else
        	{
        	bsen=bsen+","+str;
        	
        	}
        }
        else  if(id.equalsIgnoreCase("amavisWhitelistSender"))
        {
        if(wsen.equalsIgnoreCase(""))
        	{
        	wsen=str;
        	}
        	else
        	{
        	wsen=wsen+","+str;
        	
        	}
        }
      else  if(id.equalsIgnoreCase("mailWhitelistRecipient"))
        {
        if(wrec.equalsIgnoreCase(""))
        	{
        	wrec=str;
        	}
        	else
        	{
        	wrec=wrec+","+str;
        	
        	}
        }
        else  if(id.equalsIgnoreCase("mailBlacklistRecipient"))
        {
        if(brec.equalsIgnoreCase(""))
        	{
        	brec=str;
        	}
        	else
        	{
        	brec=brec+","+str;
        	
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
                        <li  class="active"><a href="/unifiedmail/global/whiteblistuser.jsp?ml=<%=mail %>">Control</a></li>
                       
                         <li><a href="/unifiedmail/global/advanceuser.jsp?ml=<%=mail %>">Advanced</a></li>
                        
                        </ul>


                <h2>Profile of user: <%=mail %> <a href="/unifiedmail/global/usersentmails.jsp?ml=<%=mail %>">
            <img src="/unifiedmail/images/graph_16.png"  title="Account activities"   style="padding-left: 5px;" class="vcenter"  />
        </a></h2>
            </div>

        <div class="box-wrap clear">
           <form id="register" action="/unifiedmail/servlet/EditWBListUserServlet" name="f" method="post" onsubmit="return valData()">
   
    
                            	<input type="hidden" name="hid_mail" value="<%=mail %>" />
             <input type="hidden" name="hid_dn" value="<%=dn %>" />
       <div class="columns clear">
            <div class="col2-3">
                <div class="form-field clear">
        <h4 class="size-250 fl-space">Whitelist Senders</h4>
       
  <span class="clean-padding bt-space20">
            
        
        
        
    
                                    	 <div class="checklist clear" style=" max-width: 25em;" id="wsen_div">
                                    	  <%
                               String ws_arr[]=wsen.split(",");
                            	
                            	 for(int i=0;i<ws_arr.length;i++)
                            	{
                            	if(ws_arr[i]!= null && !(ws_arr[i].equals("")))
                            	{
                            	 %> 
                                    	  <input type="checkbox"  name="ws_mail" value="<%=ws_arr[i] %>" checked="checked"  class="checkbox" />
                  <%=ws_arr[i] %><br/>
                                    	 
                              <%}} %> 
                                    		 
                                    	 </div>
                                    	  <div class="ermsg1" id="sp1" style="width: 340px;">
             <input class="text" type="text" size="42" value="" placeholder="Ex: user@example.com" id="add_ws_mail">
             <input name="bt2" type="button" value="Add" class="add-row-domain-button" onclick="addWSenMail()"/>
             </div>
             </span>
        
    </div>

                <div class="form-field clear">
        <h4 class="size-250 fl-space">Blacklist Senders</h4>
        <span class="clean-padding bt-space20">
            
        
        
        
    
                                    	 <div class="checklist clear" style=" max-width: 25em;" id="bsen_div">
                                    	 
                                    		  <%
                               String bs_arr[]=bsen.split(",");
                            	
                            	 for(int i=0;i<bs_arr.length;i++)
                            	{
                            	if(bs_arr[i]!= null && !(bs_arr[i].equals("")))
                            	{
                            	 %> 
                                    	  <input type="checkbox"  name="bs_mail" value="<%=bs_arr[i] %>" checked="checked"  class="checkbox" />
                  <%=bs_arr[i] %><br/>
                                    	 
                              <%}} %> 
                                    	 </div>
                                    	  <div class="ermsg1" id="sp1" style="width: 340px;">
             <input class="text" type="text" size="42" value="" placeholder="Ex: user@example.com" id="add_bs_mail">
             <input name="bt2" type="button" value="Add" class="add-row-domain-button" onclick="addBSenMail()"/>
             </div>
             </span>
    </div>

        
        
        
        
        
        
        
        
        
        <div class="form-field clear">
        <h4 class="size-250 fl-space">Whitelist Recipients
        </h4>
       
  <span class="clean-padding bt-space20">
            
        
        
        
    
                                    	 <div class="checklist clear" style=" max-width: 25em;" id="wrec_div">
                                    	  <%
                               String wr_arr[]=wrec.split(",");
                            	
                            	 for(int i=0;i<wr_arr.length;i++)
                            	{
                            	if(wr_arr[i]!= null && !(wr_arr[i].equals("")))
                            	{
                            	 %> 
                                    	  <input type="checkbox"  name="wr_mail" value="<%=wr_arr[i] %>" checked="checked"  class="checkbox" />
                  <%=wr_arr[i] %><br/>
                                    	 
                              <%}} %> 
                                    		 
                                    	 </div>
                                    	  <div class="ermsg1" id="sp3" style="width: 340px;">
             <input class="text" type="text" size="42" value="" placeholder="Ex: user@example.com" id="add_wr_mail">
             <input name="bt2" type="button" value="Add" class="add-row-domain-button" onclick="addWRecMail()"/>
             </div>
             </span>
        
    </div>   
    
    
    
    
    
    
    
    
    
    
    
    <div class="form-field clear">
        <h4 class="size-250 fl-space">Blacklist Recipients
        </h4>
       
  <span class="clean-padding bt-space20">
            
        
        
        
    
                                    	 <div class="checklist clear" style=" max-width: 25em;" id="brec_div">
                                    	  <%
                               String br_arr[]=brec.split(",");
                            	
                            	 for(int i=0;i<br_arr.length;i++)
                            	{
                            	if(br_arr[i]!= null && !(br_arr[i].equals("")))
                            	{
                            	 %> 
                                    	  <input type="checkbox"  name="br_mail" value="<%=br_arr[i] %>" checked="checked"  class="checkbox" />
                  <%=br_arr[i] %><br/>
                                    	 
                              <%}} %> 
                                    		 
                                    	 </div>
                                    	  <div class="ermsg1" id="sp4" style="width: 340px;">
             <input class="text" type="text" size="42" value="" placeholder="Ex: user@example.com" id="add_br_mail">
             <input name="bt2" type="button" value="Add" class="add-row-domain-button" onclick="addBRecMail()"/>
             </div>
             </span>
        
    </div>
    
    
    
    
        
                
            </div>

           
                
 <div class="col1-3 lastcol">
                <div class="mark_blue bt-space10">
                    <ul class="standard clean-padding bt-space10">
                        <li class="bt-space5">This is per-user white/blacklist.</li>
                        <li class="bt-space5">Whitelist has higher priority than blacklist.</li>
                    </ul>

                    <h4>Format of sender and recipient</h4>
                    <ul class="standard clean-padding bt-space10">
                        <li class="bt-space5"><strong>Single user:</strong> <u>user@example.com</u></li>
                        <li class="bt-space5"><strong>Entire domain:</strong> <u>@example.com</u></li>
                        <li class="bt-space5"><strong>Domain and its sub-domains:</strong> <u>@.example.com</u></li>
                        <li class="bt-space5"><strong>All accounts:</strong> <u>@.(Input Only @ with dot sign)</u></li>
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
</div>
</div>
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