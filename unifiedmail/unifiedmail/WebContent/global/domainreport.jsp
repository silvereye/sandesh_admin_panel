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
      <title>Domain wise reporting | Silvereye Unified E-mail Server</title>
 <noscript><meta http-equiv="refresh" content="0; URL=/unifiedmail/error/nojavascritp.jsp"></noscript>

    
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/reset.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/screen.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/fancybox.css" />

    <!--[if IE 7]>
        <link rel="stylesheet" type="text/css" href="/iredadmin-pro-ldap/static/default/css/ie7.css">
    <![endif]-->

 
</head>

<body onload="showData()">
     <%@include file="header.jsp" %>
     <%
    
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
                   Domain wise reporting
                    
                       
                    
                </h2>

           
        </div>


<div class="clear"></div>


    <table class="style1" cellspacing="0">
        <thead>
        <tr>
            
                <th class="checkbox">SN.</th>
            
            <th>Domain</th>
            <th align="center" colspan="4">Activity</th>
            
        </tr>
        </thead>

        
        <tbody>
        <%
        String arr[]=dstr.split(",");
        for(int i=0;i<arr.length;i++)
        {
         %>

     <tr>
                        
                            <td class="checkbox"><%=i+1 %></td>
                        
                        <td style="white-space: nowrap;"><%=arr[i] %></td>
                        <td><a href="/unifiedmail/global/domainsentmail.jsp?dn=<%=arr[i] %>">Sent Mails</a></td>
                        <td><a href="/unifiedmail/global/domainreceivedmails.jsp?dn=<%=arr[i] %>">Received Mails</a></td>
                        <td><a href="/unifiedmail/global/domainspamvirusmails.jsp?dn=<%=arr[i] %>">Spam/Virus</a></td>
                        <td><a href="/unifiedmail/global/domainquarantmails.jsp?dn=<%=arr[i] %>">Quarantined Mails</a></td>
                        
                    </tr>
                    <%} %>
                    
                    </tbody>
                    </table>
        
    

   

    
        <div class="tab-footer clear f1">
            
                <div class="fl">
                    
                   
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