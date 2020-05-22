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
    <title>Edit Mail List Profile | Silvereye Unified E-mail Server</title>
 <noscript><meta http-equiv="refresh" content="0; URL=/unifiedmail/error/nojavascritp1.jsp"></noscript>


    
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/reset.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/screen.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/fancybox.css" />
<link rel="stylesheet" type="text/css" href="/unifiedmail/css/mytooltip.css" />
    <!--[if IE 7]>
        <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/ie7.css">
    <![endif]-->

    
</head>

<body>
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
		        String base="ou=Groups,domainName="+dn+",o=domains,"+mbase;
		        String acc="";
String cn="";
int book=0;
String serv="";
String apolicy="public";      
try
{


DirContext ctx=LDAPConnection.getConnection(url, base, username, password);

SearchControls constraints = new SearchControls(); 
constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
String attrList[] = {"cn","accountStatus","enabledService","accessPolicy"}; 
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
        else if(id.equalsIgnoreCase("accountStatus"))
        {
        acc=str;
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
        else if(id.equalsIgnoreCase("accessPolicy"))
        {
       	apolicy=str;
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
ctx.close();
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
<li><a href="/unifiedmail/global/maillistslist.jsp?dm=<%=dn %>">Mail Lists</a></li>
<li><a class="active-subs" href="/unifiedmail/global/editmaillistprofile.jsp?ml=<%=mail %>" >Profile of Mail List: &nbsp;&nbsp;<%=mail %></a></li>
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
            <p><%=mail %> Mail list has been updated successfully. </p>	</div>
      <%}
      else if(stt!=null && stt.equalsIgnoreCase("error"))
      {
       %>
        <div id="msg_err" class="notification note-error"><a href='#' class='close'></a>
                 <p>Mail list updation has been failed.	</p></div>
    
    
    <%} %>

        
    


<div class="content-box">
    <div class="box-body">
        
        <div class="box-header clear">
            <ul class="tabs clear">
                  <li class="active"><a href="/unifiedmail/global/editmaillistprofile.jsp?ml=<%=mail %>" >General </a></li>
                        <li ><a class="tooltips" href="/unifiedmail/global/maillistmembers.jsp?ml=<%=mail %>" >Members <span>View Members</span></a></li>
                       <li  ><a class="tooltips" href="/unifiedmail/global/maillistmoderators.jsp?ml=<%=mail %>">Owners<span>View Owners</span></a></li>
                         <li  ><a class="tooltips" href="/unifiedmail/global/addmaillistmembers.jsp?ml=<%=mail %>">Add Members<span>Add Members</span></a></li>
                        <li  ><a class="tooltips" href="/unifiedmail/global/addmaillistmoderators.jsp?ml=<%=mail %>">Add Owners<span>Add Owners</span></a></li>
            </ul>

            <h2>Profile of mail list: <%=mail %></h2> 
        </div>

        <div class="box-wrap clear">

            
            <div id="profile_general">
                
   <form action="/unifiedmail/servlet/EditMailListServlet" name="f" method="post" onsubmit="return valData()">
   	<input type="hidden" name="hid_mail" value="<%=mail %>" />
                                 <input type="hidden" name="hid_serv" value="<%=serv %>" /> 

   

                    <div class="columns clear">
                        <div class="col2-3">
               
           
    <div class="form-field clear">
        
            <h4 class="size-250 fl-space">Display Name</h4>
        

        <span class="clean-padding bt-space20">
           
             <input name="cn" required type="text" value="<%=cn %>"  size="35" class="text"  />
        </span>
    </div>
    
    
                              	<%
                              	String acc1="";
                              	String acc2="";
                            	if(acc.equalsIgnoreCase("active"))
                            	{
                            	acc1="selected='selected'";
                            	 }
                                else
                                {
                                acc2="selected='selected'";
                                } 
                                %>
                              
     <div class="form-field clear">
        
            <h4 class="size-250 fl-space">Account Status</h4>
        

        <span class="clean-padding bt-space20">
           <select name="acc">
                            	<option <%=acc1 %>  value="active">Enable</option>
                            	<option <%=acc2 %> value="disabled">Disable</option>
                            	</select>  
        </span>
    </div>
               
          <div class="bt-space20"></div>
          
                            
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
                                <input name="abook" type="checkbox" value="false" class="checkbox" />
                                
                                <%} %>
                                
                                
                                <input type="hidden" name="hid_dn" value="<%=dn %>" />
        </div>
    </div>
                            


                            <div class="bt-space20"></div>


                            

                            
                            	<%
                            	System.out.println("apolicy= "+apolicy);
                            	String red1="";
                            	String red2="";
                            	String red3="";
                            	String red4="";
                            	String red5="";
                            	String red6="";
                          		if(apolicy.equals("domain"))
                            	{
                            	red2="checked='checked'";
                            	}
                            	else if(apolicy.equals("subDomain"))
                            	{
                            	red3="checked='checked'";
                            	}
                            	else if(apolicy.equals("membersOnly"))
                            	{
                            	red4="checked='checked'";
                            	}
                            	else if(apolicy.equals("allowedOnly"))
                            	{
                            	red5="checked='checked'";
                            	}
                            	else if(apolicy.equals("membersAndModeratorsOnly"))
                            	{
                            	red6="checked='checked'";
                            	}
                            	else
                            	{
                            	red1="checked='checked'";
                            	}
                            	
                            	 %>
                            <div class="form-field clear">
                                
                                    <h4 class="size-250 fl-space">Who can send email to this list</h4>
                                
                                <span class="clean-padding">
                                    <input type="radio" name="apolicy" <%=red1 %> value="public"  /> Unrestricted.&nbsp;Everyone can send mail to this address
                                </span>
                            </div>
                            
                            <div class="form-field clear">
                                
                                    <h4 class="size-250 fl-space">&nbsp;</h4>
                                
                                <span class="clean-padding">
                                    <input type="radio" name="apolicy" <%=red2 %> value="domain"  /> Users under domain <strong><%=dn %></strong>
                                </span>
                            </div>
                            
                            <div class="form-field clear">
                                
                                    <h4 class="size-250 fl-space">&nbsp;</h4>
                                
                                <span class="clean-padding">
                                    <input type="radio" name="apolicy" <%=red3 %> value="subdomain"  />Users under domain <strong><%=dn %></strong> and its sub-domains
                                </span>
                            </div>
                            
                            <div class="form-field clear">
                                
                                    <h4 class="size-250 fl-space">&nbsp;</h4>
                                
                                <span class="clean-padding">
                                    <input type="radio" name="apolicy" <%=red4 %> value="membersOnly"  /> <a href="/unifiedmail/global/maillistmembers.jsp?ml=<%=mail %>">Members.</a> Only members can post messages.
                                </span>
                            </div>
                            
                            <div class="form-field clear">
                                
                                    <h4 class="size-250 fl-space">&nbsp;</h4>
                                
                                <span class="clean-padding">
                                    <input type="radio" name="apolicy" <%=red5 %> value="allowedOnly"  /> <a href="/unifiedmail/global/maillistmoderators.jsp?ml=<%=mail %>">Announcement-only.</a> Only owners can post messages.
                                </span>
                            </div>
                            
                            <div class="form-field clear" style="width: 725px;">
                                
                                    <h4 class="size-250 fl-space">&nbsp;</h4>
                                
                                <span class="clean-padding">
                                    <input type="radio" name="apolicy" <%=red6 %> value="membersAndModeratorsOnly"  /> <a href='/unifiedmail/global/maillistmembers.jsp?ml=<%=mail %>'>Members</a> and <a href='/unifiedmail/global/maillistmoderators.jsp?ml=<%=mail %>'>Announcement-only.</a> Only members and owners can post messages.
                                </span>
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