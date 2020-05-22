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
 <noscript><meta http-equiv="refresh" content="0; URL=/unifiedmail/error/nojavascritp1.jsp"></noscript>

    
    
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
var no=document.getElementById("hid_dalias").value;
//alert(no);
for (i=1;i<= parseInt(no);i++)
{
var num="dalias"+i;
var val=document.getElementById(num).value;
//alert(val);
var n = val.indexOf("@");
if(n>=0)
{
alert("Please enter correct domain, without '@'");
return false;
}

}
return true;

}




 function addCatchAdd()
{
//document.getElementById("maildiv").innerHTML="";
var no=parseInt(document.f.hid_dalias.value);
no=no+1;
document.f.hid_dalias.value=no;
var name="dalias"+no;
var element = document.createElement("input");
element.setAttribute("type", "text");
element.setAttribute("name", name);
element.setAttribute("id", name);
element.setAttribute("class", "text");
element.setAttribute("size", "35");
//element.setAttribute("onblur", "makeMail(this.value)");

 //var brElement = document.createElement("br");
  //var brElement1 = document.createElement("br");
 
var foo = document.getElementById("fooBar1");
 foo.appendChild(element);
         // foo.appendChild(brElement );
        //   foo.appendChild(brElement1 );
        
         

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
		        String utype=(String)hs.getAttribute("user_name");
		        String base="o=domains,"+mbase;
		        String malias="";
String alias="";

		        
try
{


DirContext ctx=LDAPConnection.getConnection(url, base, username, password);

SearchControls constraints = new SearchControls(); 
constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
String attrList[] = {"enabledService","domainAliasName"}; 
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
        if(id.equalsIgnoreCase("enabledService"))
        {
        alias=alias+","+str;
        }
        else if(id.equalsIgnoreCase("domainAliasName"))
        {
        if(malias.equals(""))
        {
        malias=str;
        }
        else
        {
        malias=malias+","+str;
        }
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
                        <li  ><a href="/unifiedmail/global/relaydomain.jsp?dn=<%=dn %>">Relay</a></li>
                        <li><a href="/unifiedmail/global/catchalldomain.jsp?dn=<%=dn %>">Catch-all</a></li>
                        <li  class="active"><a href="/unifiedmail/global/aliasesdomain.jsp?dn=<%=dn %>">Aliases</a></li>  
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
            <img src="/unifiedmail/images/graph_16.png" title="Domain activities" style="padding-left: 5px;" class="vcenter"  />
        </a></h2>
        </div>

        <div class="box-wrap clear">
        
          <form action="/unifiedmail/servlet/EditAliasesDomainServlet" name="f" method="post" onsubmit="return valData()">
         
         
         
                    <div class="columns clear">
                        <div class="col2-3 ">
                            <div class="form-field clear">
                                <h4 class="size-250 fl-space">Enable domain alias</h4>
                               
                                <input type="hidden" name="hid_dn" value="<%=dn %>" />
                            	<%
                            	if(alias.indexOf("domainalias")>=0)
                            	{
                            	 %>  
                                <input name="acc" checked="checked" type="checkbox" value="active" />
                                <%}
                                else
                                {
                                 %>
                                <input name="acc" type="checkbox" value="disabled" />
                                
                                <%} %>
                            </div>

                            
                                
                                    <div class="form-field clear">
                                    
                                        <h4 class="size-250 fl-space">Alias domains</h4>
                                    <div class="clear">

                                       
                                    <%
                            	String arr[]=malias.split(",");
                            	 %> 
                            	 <input  type="hidden" id="hid_dalias" name="hid_dalias" value="<%=arr.length %>" />
                                <input name="dalias1" id="dalias1" type="text" value="<%=arr[0] %>" size="35" class="text"/>
                                &nbsp;<img style="cursor: pointer;" alt="" onclick="addCatchAdd()" src="/unifiedmail/images/add_new.png" />
                                                         
                                <div id="fooBar1" class="ermsg">
                            <%
                            for(int i=1;i<arr.length;i++)
                            {
                            int j=i+1;
                            String for_id="dalias"+j;
                            %>
                            <input name="<%=for_id %>" id="<%=for_id %>" type="text" value="<%=arr[i] %>" size="35" class="text"/>
                          <%
                            }
                             %>
                                    </div>
                                    </div>
                                
                                    
                                
                           
                        </div>
</div>
                        <div class="col1-3 lastcol">
                            <div class="mark_blue bt-space10">
                                <ul class="standard clean-padding bt-space10">
                                    <li class="bt-space5">Emails sent to <em><strong>user@[ALIAS_DOMAIN]</strong></em> will be delivered to <em><strong>user@<%=dn %></strong></em>.</li>
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
