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
    <base href="<%=basePath%>">
    
   <title>Edit Domain Profile | Silvereye Unified E-mail Server</title>
 <noscript><meta http-equiv="refresh" content="0; URL=/unifiedmail/error/nojavascritp2.jsp"></noscript>

    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	 <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/reset.css">
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/screen.css">
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/fancybox.css">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

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

<script type="text/javascript">
function mydel_dom(val)
{
var r=confirm("Do you want to Remove Image");
//alert(r);
if (r==true)
  {
  //alert("hi");
 document.getElementById(""+val).href ="/unifiedmail/servlet/RemoveUserPhotoDomainServlet?ml="+val;
   
  }

}

</script>
<link rel="STYLESHEET" type="text/css" href="/unifiedmail/popup/popup-contact.css" />
</head>
<body onload="javascript:fg_hideform('fg_formContainer','fg_backgroundpopup');">
   
   <%
   String dn=request.getParameter("dn");
  if( dn!=null && !(dn.equals("")) )
   {
   
    
    
    

                HttpSession hs=request.getSession(false);
		        String username= (String)hs.getAttribute("id");
		        String password= (String)hs.getAttribute("password");
		        String url= (String)hs.getAttribute("url");
		        String mbase= (String)hs.getAttribute("base");
		         String utype=(String)hs.getAttribute("user_name");
		        String base="o=domains,"+mbase;
		        String acc="";
		        hs.setAttribute("user_domain",dn);
String cn="";
String des="";
String photo="";
		        
try
{


DirContext ctx=LDAPConnection.getConnection(url, base, username, password);

SearchControls constraints = new SearchControls(); 
constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
String attrList[] = {"cn","accountStatus","description","domainPhoto"}; 
constraints.setReturningAttributes(attrList);
NamingEnumeration results =ctx.search(base,"domainName="+dn, constraints);
int f=0;
int x=0;
while (results.hasMore()) {
f=1;
    SearchResult si =(SearchResult)results.next();
    String ck=si.getName();
 //  System.out.println("<br><br><br>"+ck);
    Attributes attrs = si.getAttributes();

    if (attrs == null) {
      // out.println("   No attributes");
        continue;
    }
    
    try
    {
    	String entry="domainName="+dn+","+base;
 		Attributes	testAttributes = ctx.getAttributes(entry);
 		
 		Attribute jpegPhoto1 = testAttributes.get("cn");
 		cn = jpegPhoto1.get().toString();
  	    
 		jpegPhoto1 = testAttributes.get("accountStatus");
  		acc = jpegPhoto1.get().toString();
  		
  	    jpegPhoto1 = testAttributes.get("description");
  		des = jpegPhoto1.get().toString();
  	    
 	    jpegPhoto1 = testAttributes.get("domainPhoto");
 	    if(jpegPhoto1!=null)
 	    {
 	  //  byte[] jpegBytes1 = (byte[]) jpegPhoto1.get();
 	    photo =jpegPhoto1.get().toString(); //new sun.misc.BASE64Encoder().encode(jpegBytes1); 
 	    }
    }
    catch(Exception e)
    {
    	e.printStackTrace();
    }
   
    
    /* NamingEnumeration ae = attrs.getAll(); 
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
        else if(id.equalsIgnoreCase("accountStatus"))
        {
        acc=str;
        }
         else if(id.equalsIgnoreCase("description"))
        {
        des=str;
        }
        

          
           }
    } */
    //NoOfUser nof=new NoOfUser();
 

}
if(f==0)
{
System.out.print("<tr class='grey'><td></td><td>Search not found</td></tr>");
}

ctx.close();
}
catch(Exception e){System.out.print("<tr class='grey'><td></td><td>"+e+"</td></tr>");}
%>  
       
  
    
    
   
   
    <%@include file="header.jsp" %>
    
    
    
    

   
   <form action="/unifiedmail/servlet/EditDomainProfileServlet" name="f" method="post" onsubmit="return valData()">
   
 
   
   
   <!--end row-one-->
                       
                       
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
                
                                        
                    
                     <li class="active"><a href="/unifiedmail/global/editdomainprofile.jsp?dn=<%=dn %>" >General</a></li>
                        <li><a href="/unifiedmail/global/bccdomain.jsp?dn=<%=dn %>" >BCC</a></li>
                        <li><a href="/unifiedmail/global/relaydomain.jsp?dn=<%=dn %>">Relay</a></li>
                        <li><a href="/unifiedmail/global/catchalldomain.jsp?dn=<%=dn %>">Catch-all</a></li>
                        <li><a href="/unifiedmail/global/aliasesdomain.jsp?dn=<%=dn %>">Aliases</a></li>
                          <li><a href="/unifiedmail/global/whiteblacklistdomain.jsp?dn=<%=dn %>">White/Blacklist</a></li>  
                        <%
                         if(utype!=null && utype.equalsIgnoreCase("Admin"))
                                {
                         %>
                        <li><a href="/unifiedmail/global/throttlingdomain.jsp?dn=<%=dn %>">Throttling</a></li>      
                         <%} %>
                         <li><a href="/unifiedmail/global/disclaimerdomain.jsp?dn=<%=dn %>">Disclaimer</a></li>
                        <li><a href="/unifiedmail/global/advancedomain.jsp?dn=<%=dn %>">Advanced</a></li>
                        
                
            </ul>
            <h2>Profile of domain: <%=dn %>	 <a href="/unifiedmail/global/domainsentmail.jsp?dn=<%=dn %>">
            <img src="/unifiedmail/images/graph_16.png"   title="Domain activities" style="padding-left: 5px;" class="vcenter"   />
        </a></h2>
        </div>

        <div class="box-wrap clear">
             <form action="/unifiedmail/servlet/EditDomainProfileServlet" name="f" method="post" onsubmit="return valData()">
                
        
                
                    <div class="columns clear">
                        <div class="col2-3 ">
                        
                            
    

    <div class="form-field clear">
        
            <h4 class="size-250 fl-space">Enable this domain</h4>
        

        <div class="form-checkbox-item clear fl-space2">
           
        <input type="hidden" name="hid_dn" value="<%=dn %>">
                            	<%
                            	if(acc.equalsIgnoreCase("active"))
                            	{
                            	 %>  
                                <input class="checkbox fl-space" name="acc" checked="checked" type="checkbox" value="active" />
                                <%}
                                else
                                {
                                 %>
                                <input class="checkbox fl-space" name="acc" type="checkbox" value="disabled" />
                                
                                <%} %>
        </div>
    </div>

          
                        

                        

    <div class="form-field clear">
        
            <h4 class="size-250 fl-space">Company/Organization Name</h4>
        

        <span class="clean-padding bt-space20">
           
              <input name="cn" required type="text" class="text" value="<%=cn %>" size="35"/>
        </span>
    </div>
    
    
    <div class="form-field clear">
                            <h4 class="size-250 fl-space">Description</h4>
                           <textarea name="des" rows="6" style="width: 50%"><%=des %></textarea>
                        </div>

    
                        </div>

                        
                        
                        
                        
                        
                         <div class="col1-3 lastcol">
                <div class="mark_blue bt-space10" style="width:100px;" >
                <%
                String src="/unifiedmail/images/dom.png";
                if(photo!= null && !(photo.equals("")))
                {
              
		  
               // src="data:image/jpg;base64,"+photo;
                	src=photo;
                }
                 %>
                   <img alt="" width="100px" height="100" src="<%=src %>" /><br/>
                   <a href='javascript:fg_popup_form("fg_formContainer","fg_form_InnerContainer","fg_backgroundpopup");' >Change Photo</a>
                   <%
                   if(photo!= null && !(photo.equals("")))
                {
                    %>
                   <a title="Remove Image" class="tooltips" id="<%=dn %>"><img src="/unifiedmail/images/delete-icon.png"  name="<%=dn %>" onclick="mydel_dom(this.name)"/>
</a>
                    <%} %>
                </div>
            </div>
                        
                        
                        
                        
                        
                        
                            
                        
                    </div><!-- .columns --><div class="bt-space0">&nbsp;</div>

             


            

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
     <form name="frm" action="/unifiedmail/servlet/EditPhotoDomainServlet" enctype="multipart/form-data" onsubmit="return check_from()" method="post">
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
