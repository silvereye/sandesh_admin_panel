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
var no=document.getElementById('hid_cadd').value;

for(i=1;i<=parseInt(no);i++)
{
var id="cadd"+i;
var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;

    if (document.getElementById(id).value!="" && !filter.test(document.getElementById(id).value)) {
    alert('Please Input a valid email address');
    
    return false;
    }
}

return true;

}



function chkFMail(val,nm)
{

if(document.getElementById("hid_mail").value==val)
{
alert("Email of user can not add in his mail forwarding");
document.getElementById(nm).value="";
}

}




 function addCatchAdd()
{
//document.getElementById("maildiv").innerHTML="";
var no=parseInt(document.f.hid_cadd.value);
no=no+1;
document.f.hid_cadd.value=no;
var name="cadd"+no;
var element = document.createElement("input");
element.setAttribute("type", "email");
element.setAttribute("name", name);
element.setAttribute("id", name);
element.setAttribute("placeholder", "example@silvereye.co");
element.setAttribute("size", "35");
element.setAttribute("class", "text");
 element.setAttribute("onblur", "chkFMail(this.value,this.name)");
 
 
//element.setAttribute("onblur", "makeMail(this.value)");

// var brElement = document.createElement("br");
//  var brElement1 = document.createElement("br");
 
var foo = document.getElementById("fooBar1");
 foo.appendChild(element);
      //    foo.appendChild(brElement );
     //      foo.appendChild(brElement1 );
        
         

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
                HttpSession hs=request.getSession(false);
		        String username= (String)hs.getAttribute("id");
		        String password= (String)hs.getAttribute("password");
		        String url= (String)hs.getAttribute("url");
		        String mbase= (String)hs.getAttribute("base");
		        String base="ou=Users,domainName="+dn+",o=domains,"+mbase;
		        String utype=(String)hs.getAttribute("user_name");
		        String acc="";
String mailfd="";
int fd=0; 
int infd=0;
String serv="";      
try
{


DirContext ctx=LDAPConnection.getConnection(url, base, username, password);

SearchControls constraints = new SearchControls(); 
constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
String attrList[] = {"enabledService","mailForwardingAddress"}; 
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
        if(id.equalsIgnoreCase("mailForwardingAddress"))
        {
        if(str.equalsIgnoreCase(mail))
        {
        infd=1;
        }
        else
        {
        if(mailfd.equalsIgnoreCase(""))
        	{
        	mailfd=str;
        	}
        	else
        	{
        	mailfd=mailfd+","+str;
        	
        	}
        	}
        }
        if(id.equalsIgnoreCase("enabledService"))
        {
        	if(str.equalsIgnoreCase("forward"))
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
                        <li  class="active"><a href="/unifiedmail/global/forwardinguser.jsp?ml=<%=mail %>" >Forwarding</a></li>
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
            <img src="/unifiedmail/images/graph_16.png"
                
                    title="Account activities"
                

                
                    style="padding-left: 5px;" class="vcenter"
                
            />
        </a></h2>
            </div>

        <div class="box-wrap clear">
           <form action="/unifiedmail/servlet/EditForwardingUserProfileServlet" name="f" method="post" onsubmit="return valData()">
   
    
                            	<input type="hidden" name="hid_mail" id="hid_mail" value="<%=mail %>" />
                                 <input type="hidden" name="hid_serv" value="<%=serv %>" /> 
                
                <div class="columns clear">
                    <div class="col2-3 ">
                        <div class="form-field clear">
                            <h4 class="size-250 fl-space">Enable Mail Forwarding</h4>
                            <div class="clear">
                                
                           
                                <input type="hidden" name="hid_dn" value="<%=dn %>" />
                            	<%
                            	if(fd==1)
                            	{
                            	 %>  
                                <input name="acc" checked="checked" type="checkbox" value="yes" class="checkbox"/>
                                <%}
                                else
                                {
                                 %>
                                <input name="acc"  type="checkbox" value="no" class="checkbox"/>
                                
                                <%} %>
                                
                                
                                
                                
                            </div>
                        </div>



<div class="form-field clear">
                            <h4 class="size-250 fl-space">Save a copy in mailbox</h4>
                            <div class="clear">
                                
                           
                               
                            	<%
                            	if(infd==1)
                            	{
                            	 %>  
                                <input name="inbox" checked="checked" type="checkbox" value="yes" class="checkbox"/>
                                <%}
                                else
                                {
                                 %>
                                <input name="inbox"  type="checkbox" value="no" class="checkbox"/>
                                
                                <%} %>
                                
                                
                                
                                
                            </div>
                        </div>



                        
                        <div class="bt-space0">&nbsp;</div>
                        
    <div class="form-field clear">
        <h4 class="size-250 fl-space">Forward Mails to Address</h4>
         <div class="clear">
             
           <%
                            	String arr[]=mailfd.split(",");
                            	 %> 
                            	 <input  type="hidden" id="hid_cadd" name="hid_cadd" value="<%=arr.length %>" />
                                <input name="cadd1" id="cadd1" type="email" value="<%=arr[0] %>" placeholder="example@silvereye.co" size="35" class="text" onblur="chkFMail(this.value,this.name)"/>
                                &nbsp;<img style="cursor: pointer;" alt="" onclick="addCatchAdd()" src="/unifiedmail/images/add_new.png" />
                                                         
                                <div id="fooBar1" class="ermsg">
                            <%
                            for(int i=1;i<arr.length;i++)
                            {
                            int j=i+1;
                            String for_id="cadd"+j;
                            %>
                            <input name="<%=for_id %>" id="<%=for_id %>" type="email" value="<%=arr[i] %>" class="text" onblur="chkFMail(this.value,this.name)" size="35"/>
                          <%
                            }
                             %>
           </div>
        </div>
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