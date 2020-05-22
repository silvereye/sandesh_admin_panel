<%@ page language="java" import="java.util.*,mypack.*" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.regex.*" %>
<%@ page import="javax.naming.directory.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
    <title>Domains and Accounts</title>

    
    <link rel="stylesheet" type="text/css" href="/unifiedmail/iredcss/reset.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/iredcss/screen.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/iredcss/fancybox.css" />

    <!--[if IE 7]>
        <link rel="stylesheet" type="text/css" href="/unifiedmail/iredcss/ie7.css" />
    <![endif]-->

    
</head>

<body>
    <%@include file="header.jsp" %>

    

    <div class="main pagesize"> <!-- *** mainpage layout *** -->
        <div class="main-wrap">
            <div class="page clear">
                
                




    <div class="content-box">
        <div class="box-body">
            <div class="box-header clear">
                
                    <ul class="tabs clear">
                        <li><a href="/iredadmin-pro-ldap/create/domain"> Add domain</a></li>
                    </ul>
                

                <h2>
                    All domains under your control.
                    
                      
                    
                </h2>
            </div>

            <form name="domains" id="list_table" method="post" action="/iredadmin-pro-ldap/domains">
            
        
    

    <input type="hidden" name="csrf_token" value="jd28waDStU7u5y35y88gyJ957WA5N6km"/>
            <table class="style1 tablesorter" cellspacing="0">
                <thead>
                <tr>
                    
                        <th class="checkbox"><input type="checkbox" class="checkbox select-all" /></th>
                    
                    <th>Domain</th>
                    <th>Name</th>
                    <th>Quota</th>
                    <th>Users</th>
                    <th>Lists</th>
                    <th>Aliases</th>
                </tr>
                </thead>

                <tbody>
                
                    
                    
                        
                        
                        
                        
             
  
  
              
<%
int icnt=0;
 int no=5;
 //Integer.parseInt(request.getParameter("no"));
  String uid="*"    ;        ///request.getParameter("val");
                                    HttpSession hs=request.getSession(false);
		        String username= (String)hs.getAttribute("id");
		        String password= (String)hs.getAttribute("password");
		        String url= (String)hs.getAttribute("url");
		        String mbase= (String)hs.getAttribute("base");
		       String base="o=domains,"+mbase;
		        String v1="";
String v2="";
String v3="";
String cqt="";
String dqt="";
String no1="";
String no2="";
String no3="";	        
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
String attrList[] = {"domainName","cn","accountStatus","domainCurrentQuotaSize","domainCurrentAliasNumber","domainCurrentListNumber","domainCurrentUserNumber","domainMaxQuotaSize"}; 
constraints.setReturningAttributes(attrList);
NamingEnumeration results =ctx.search(base,"domainName="+uid, constraints);
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
    
    x++;
     if(no!=0 && x>no)
     {
     break;
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
        v1=str;
        }
        else if(id.equalsIgnoreCase("accountStatus"))
        {
        v2=str;
        }
         else if(id.equalsIgnoreCase("domainName"))
        {
        v3=str;
        }
         else if(id.equalsIgnoreCase("domainCurrentQuotaSize"))
        {
        cqt=str;
        }
        else if(id.equalsIgnoreCase("domainCurrentUserNumber"))
        {
        no1=str;
        }
        else if(id.equalsIgnoreCase("domainCurrentListNumber"))
        {
        no2=str;
        }
        else if(id.equalsIgnoreCase("domainCurrentAliasNumber"))
        {
        no3=str;
        }
        else if(id.equalsIgnoreCase("domainMaxQuotaSize"))
        {
        dqt=str;
        }
     

           //out.println("  <br> "+id + ":--- " +str);
           }
    }
    //NoOfUser nof=new NoOfUser();
            
%>
            
 
                        
                            
                        

                        <tr class="active">
                            
                                <td class="checkbox"><input type="checkbox" name="CheckboxGroup1" id="checkbox" value="<%=v3 %>"/></td>
                            
                            <td class="vcenter">
                                <a href="/iredadmin-pro-ldap/profile/domain/general/abc.com"><img src="/unifiedmail/images/action_edit.png" title="Edit account profile" class="fr-space"/></a>
                                <a href="/iredadmin-pro-ldap/activities/sent/domain/abc.com">
            <img src="/unifiedmail/images/graph_16.png"
                
                    title="Domain activities"
                

                
                    class="fr-space"
                
            />
        </a>
                                
                                    
                                        
    
        
    

    
        <img src="/unifiedmail/images/enabled.png" class="fr-space" title="Account is active." style="vertical-align: middle;"/>
    
                                    
                                
                                <a href="/iredadmin-pro-ldap/profile/domain/general/abc.com" title="Edit account profile"><%=v3 %></a>
                            </td>

                            <td class="vcenter"><%=v1 %></td>

                             <td >
    <%
   
   
    long per=(Long.parseLong(cqt)*100)/(Long.parseLong(dqt));
     %>
    
    
    
    
    
                        	 <table border="1"  style="border-style: ridge; ">
                            <tr height="10px" >
                            <%if(per<80)
                            { 
                            if(per>=10)
                            {%>
                            <td style="background-color: #388909" bgcolor="#388909" width="8px" ></td>
                            <%}
                            else
                            { %>
                            <td  style="background-color: #7DA8ED; " bgcolor="#7DA8ED;" width="8px" ></td>
                            <%}
                            if(per>=20)
                            {
                             %>
                              <td style="background-color: #388909 " bgcolor="#388909" width="8px" ></td>
                              <%}
                              else
                              { %>
                            <td style="background-color: #7DA8ED;" bgcolor="#7DA8ED;" width="8px" ></td>
                            <%} 
                             if(per>=30)
                            {
                             %>
                              <td style="background-color: #388909"  bgcolor="#388909" width="8px" ></td>
                              <%}
                              else
                              { %>
                            <td style="background-color: #7DA8ED;" bgcolor="#7DA8ED;" width="8px" ></td>
                            <%} 
                             if(per>=40)
                            {
                             %>
                              <td style="background-color: #388909"  bgcolor="#388909" width="8px" ></td>
                              <%}
                              else
                              { %>
                            <td style="background-color: #7DA8ED;" bgcolor="#7DA8ED;" width="8px" ></td>
                            <%} 
                            if(per>=50)
                            {
                             %>
                              <td style="background-color: #388909"  bgcolor="#388909" width="8px" ></td>
                              <%}
                              else
                              { %>
                            <td style="background-color: #7DA8ED;"  bgcolor="#7DA8ED;" width="8px" ></td>
                            <%} 
                            if(per>=60)
                            {
                             %>
                              <td style="background-color: #388909" bgcolor="#388909" width="8px" ></td>
                              <%}
                              else
                              { %>
                            <td style="background-color: #7DA8ED;"  bgcolor="#7DA8ED;" width="8px" ></td>
                            <%} 
                             if(per>=70)
                            {
                             %>
                              <td style="background-color: #388909" bgcolor="#388909" width="8px" ></td>
                              <%}
                              else
                              { %>
                            <td style="background-color: #7DA8ED;" bgcolor="#7DA8ED;" width="8px" ></td>
                            <%} 
                            %>
                           
                            <td style="background-color: #7DA8ED;"  bgcolor="#7DA8ED;" width="8px" ></td>
                            <td  style="background-color: #7DA8ED;" bgcolor="#7DA8ED;" width="8px" ></td>
                            <td  style="background-color: #7DA8ED;" bgcolor="#7DA8ED;" width="8px" ></td>
                            
                            <%}
                            else
                            {
                             %>
                            <td style="background-color: #B2170C"  bgcolor="#B2170C" width="8px" ></td>
                            <td style="background-color: #B2170C" bgcolor="#B2170C" width="8px" ></td>
                            <td style="background-color: #B2170C" bgcolor="#B2170C" width="8px" ></td>
                            <td style="background-color: #B2170C"  bgcolor="#B2170C" width="8px" ></td>
                            <td style="background-color: #B2170C" bgcolor="#B2170C" width="8px" ></td>
                            <td style="background-color: #B2170C" bgcolor="#B2170C" width="8px" ></td>
                            <td style="background-color: #B2170C" bgcolor="#B2170C" width="8px" ></td>
                            <td  style="background-color: #B2170C" bgcolor="#B2170C" width="8px" ></td>
                           <%if(per>=90) 
                           {%>
                            <td style="background-color: #B2170C"  bgcolor="#B2170C" width="8px" ></td>
                            <%}
                            else
                            { %>
                            <td style="background-color: #7DA8ED;"  bgcolor="#7DA8ED;" width="8px" ></td>
                            <%}
                            if(per>=100)
                            {
                             %>
                            <td style="background-color: #B2170C" bgcolor="#B2170C" width="8px" ></td>
                            <%}
                            else
                            { %>
                             <td style="background-color: #7DA8ED;" bgcolor="#7DA8ED;" width="8px" ></td>
                             <%}} %>
                       </tr></table>
    
    
    <%
    long used=Long.parseLong(cqt);
    
    String usedstr="";
    if((used/1024)>0)
     {
     used=used/1024;
     usedstr=""+used+"GB ";
} 
    else   if(used >0)
     {
       usedstr=""+used+"MB ";
       } 
    else
     {
      usedstr="0MB ";
    }
   
      							
    
     %>
   <font class="dlimit">
   <%=usedstr %>/<%=Long.parseLong(dqt)/1024 %>GB&nbsp; <%=per %>% Used
    </font> 
    
    
    
    
    
    
    </td>

                            
                            <td class="vcenter"><a href="/unifiedmail/global/list/list.jsp?dm=<%=v3 %>"><%=no1 %></a></td>
    <td class="vcenter"><a href="/unifiedmail/global/list/list.jsp?dm=<%=v3 %>"><%=no2 %></a></td>
    <td  class="vcenter"><a href="/unifiedmail/global/list/list.jsp?dm=<%=v3 %>"><%=no3 %></a></td>
                        </tr>
                    
                        
                        
                        


            
<%
}

if(f==0)
{
out.print("<tr class='grey'><td></td><td>Search not found</td></tr>");
}

}
catch(Exception e){out.print("<tr class='grey'><td></td><td>"+e+"</td></tr>");}
%>  
       
             
                        

                        
                        
                        
                        

                        
                        
                        
                        

                        
                        
                        

                        

                        
                        
                        

                        
                        
                        
                        
                        
                            
                        

                        
                    
                
                </tbody>
            </table>

                <div class="tab-footer clear f1">
                    
                        <div class="fl">
                            <select name="action" class="fl-space">
                                <option>Choose Action</option>
                                <option value="enable">Enable</option>
                                <option value="disable">Disable</option>
                                <option value="delete">Delete</option>
                            </select>
                            <input type="submit" value="Apply" class="button fl-space" />
                        </div>
                    

                    
        
    

    
    

    <div class="pager fr">
        <span class="nav">
                

                
            </span><span class="pages">
        
            
            
                <a href="/iredadmin-pro-ldap/domains/page/1" class="active"><span>1</span></a>
            
        
        </span>

        
        
        <span class="nav">
            

            
        </span>
        
    </div>
                </div>
            </form>
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
    
        
    

    
    <script type="text/javascript" src="/unifiedmail/iredjs/jquery-1.4.2.min.js"></script>

    
        <script type="text/javascript" src="/unifiedmail/iredjs/jquery.tooltip.js"></script>
    
        <script type="text/javascript" src="/unifiedmail/iredjs/jquery.idtabs.js"></script>
    
        <script type="text/javascript" src="/unifiedmail/iredjs/jquery.fancybox.js"></script>
    

    
        <script type="text/javascript" src="/unifiedmail/iredjs/jquery.tablesorter.js"></script>
    

    

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

        
            $(".tablesorter").tablesorter(
                
                    { headers: {
                        
                            0: {sorter: false }
                        
                    }}
                
            );
        

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