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

    <!--[if IE 7]>
        <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/ie7.css">
    <![endif]-->

     <script type="text/javascript">
    function valInData(frm)
{
var chk_arr =  document.getElementsByName("mail");
var chklength = chk_arr.length;
var str="";
var str1="";
//alert(chklength);
if(chklength<=0)
{
alert("Records are not founds.");
 return false;
}
else
{
var f=0;
for (var i = 0; i < chklength; i++) {  
     if (chk_arr[i].checked==true) {
        
     f=f+1;
   
    }  
  }
  if(f==0)
  {
  alert("Please Select atleast one record.");
  return false;
  }
  
  
}
return true;
}




 function valExData(frm)
{
var chk_arr =  document.getElementsByName("mail");
var chklength = chk_arr.length;
var str="";
var str1="";
//alert(chklength);
if(chklength<=0)
{
alert("Records are not founds.");
 return false;
}
else
{
var f=0;
for (var i = 0; i < chklength; i++) {  
     if (chk_arr[i].checked==true) {
        
     f=f+1;
   
    }  
  }
  if(f==0)
  {
  alert("Please Select atleast one record.");
  return false;
  }
  
  
}
return true;
}
    </script>
</head>

<body>
    <%
   String ml=request.getParameter("ml");
   String dn="";
   String inmod="";
    String exmod=""; 
  if( ml!=null && !(ml.equals("")) )
   {
   				String arr[]=ml.split("@");
   				dn=arr[1];
                HttpSession hs=request.getSession(false);
		        String username= (String)hs.getAttribute("id");
		        String password= (String)hs.getAttribute("password");
		        String url= (String)hs.getAttribute("url");
		        String mbase= (String)hs.getAttribute("base");
		        String base="ou=Groups,domainName="+dn+",o=domains,"+mbase;
		        DirContext ctx=LDAPConnection.getConnection(url, base, username, password);
try
{
SearchControls constraints = new SearchControls(); 
constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
String attrList[] = {"listAllowedUser"}; 
constraints.setReturningAttributes(attrList);
NamingEnumeration results =ctx.search(base,"mail="+ml, constraints);
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
        if(id.equalsIgnoreCase("listAllowedUser"))
        {
        if(str.indexOf("@"+dn)>=0)
        	{
        	if(inmod==null || inmod.equals(""))
        	{
        	inmod=str;
        	}
        	else
        	{
        	inmod=inmod+","+str;
        	}
        	}
        else
        	{
        	if(exmod==null || exmod.equals(""))
        	{
        	exmod=str;
        	}
        	else
        	{
        	exmod=exmod+","+str;
        	}
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
<li><a class="active-subs" href="/unifiedmail/global/editmaillistprofile.jsp?ml=<%=ml %>" >Profile of Mail List: &nbsp;&nbsp;<%=ml %></a></li>
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
            <p><%=ml %> Mail list has been updated successfully. </p>	</div>
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
                  <li><a href="/unifiedmail/global/editmaillistprofile.jsp?ml=<%=ml %>" >General</a></li>
                        <li><a href="/unifiedmail/global/maillistmembers.jsp?ml=<%=ml %>" >Members</a></li>
                       <li  class="active"><a href="/unifiedmail/global/maillistmoderators.jsp?ml=<%=ml %>">Owners</a></li>
                         <li><a href="/unifiedmail/global/addmaillistmembers.jsp?ml=<%=ml %>">Add Members</a></li>
                        <li><a href="/unifiedmail/global/addmaillistmoderators.jsp?ml=<%=ml %>">Add Owners</a></li>
            </ul>

            <h2>Profile of mail list: <%=ml %></h2>
        </div>

        <div class="box-wrap clear">

            
            <div id="members" class="columns clear">
              

                
                <div id="internal" class="col2-3">
                    <h4>Internal Moderators</h4>
                    <form name="internal_members" id="internal_members" method="post" action="/unifiedmail/servlet/MaillistModServlet" onsubmit="return valInData(this.form)">
                        
        <input type="hidden" name="hid_maillist" value="<%=ml %>"/>


                       
                        <table class="style1">
                            <thead>
                            <tr>
                                <th class="checkbox"><input type="checkbox" class="checkbox select-all" /></th>
                                <th>Display Name</th>
                                <th>Mail Address</th>
                                <th>Quota</th>
                                <th style="text-align: center;" >Account Status</th>
                            </tr>
                            </thead>

                            
                            <tbody>
                            
                                <%
                                String arr1[]=inmod.split(",");
                                Arrays.sort(arr1);
                                for(int i=0;i<arr1.length; i++)
                                {
                                String det=GetUsersDetail.getUsersDet(url,username,password,mbase,dn,"mail",arr1[i]);
                               String det_arr[]=det.split(","); 
                                if(det_arr!=null && det_arr.length >2)
                                {
                                String v1=det_arr[0];
                                 String v2=det_arr[1];
                                  String v3=det_arr[2];
                                 %>
                                    
                                    
                                    
                                    

                                    

                                    
                                        
                                        
                                        
                                    

                                    
                                    

                                    <tr class="odd active">
                                        <td class="checkbox"><input type="checkbox" name="mail" value="<%=v1 %>" class="checkbox" /></td>
                                        <td>
                                            <%=v2 %>
    									</td>
                                        <td><a title="Edit User" href="/unifiedmail/global/edituserprofile.jsp?ml=<%=v1 %>"><em><%=v1 %></em></a></td>
										  <td>
                                            
                                              












<%
if(v3.equalsIgnoreCase("active"))
											{
                            		int per=0;
                            		int used=0;
                            		int tot=0;
                            	Quota q=new Quota();
                            	String s=q.getQuota(v1);
                            	s=s.trim();
		if(s!=null && !(s.equals("")))
		{
		String nstr[]=s.split(" ");
		int l1=nstr.length;
		int ct=0;
		for(l1--;true;l1--)
		{
		String ss=nstr[l1].trim();
		if(ss==null || ss.equals(" ") || ss.equals(""))
		{
		continue;
		}
		else
		{
		ct++;
		if(ct==1)
		{
		 per=Integer.parseInt(ss);
		}
		if(ct==2)
		{
		 tot=Integer.parseInt(ss);
		}
		if(ct==3)
		{
		 used=Integer.parseInt(ss);
		break;
		}
		}
		//out.print("<br>"+nstr[i]);
		}
		}
		
		
                            	 %>
    
   
    
 <%
                            	 String usedstr="";
                            	 String totstr="";
                            	 
                            	if((tot/1024/1024)>0) 
    {
   tot=tot/1024/1024;
  totstr=""+tot+"GB";
    } 
    else if((tot/1024)>0) 
    {
     tot=tot/1024;
     totstr=""+tot+"MB";
  } 
    else
    {
    totstr=""+tot+"KB";
   }
      							
      							if((used/1024/1024)>0)
     {
     used=used/1024/1024;
     usedstr=""+used+"GB";
} 
    else   if((used/1024)>0)
     {
     used=used/1024;
       usedstr=""+used+"MB";
       } 
    else
    {
     usedstr=""+used+"KB";
    }
      							
      							                      	 
                 %>           	

 <font class="dlimit">
   <%=usedstr %>/<%=totstr %>&nbsp; <%=per %>% Used
    </font> 




<%}
else
{
 %>
<font class="dlimit">
  Disabled Account
    </font> 
<%} %>











                                            
                                            </td>
                                              <td align="center">
                                             <%
											if(v3.equalsIgnoreCase("active"))
											{
 											%>
       										  <img title="Enable" src="/unifiedmail/images/right_mark.png" />
        									 <%}
        									 else
         									{ %>
       										 <img title="Disable" src="/unifiedmail/images/image1.png" />
       										<%} %>
                                               
                                            
                                            </td>
                                            </tr>
                                
                                    
                                    
                                    
                                    
<%}} %>
                                    

                                    
                                        
                                        
                                        
                                    

                                    
                                    

                                   
                                
                            
                            </tbody>
                        </table>

                        
                        <div class="tab-footer clear f1">
                            <div class="fl">
                                <select name="action" class="fl-space">
                                    <option value="delete">Remove from list</option>
                                </select>
                                <input type="submit" value="Apply" class="button fl-space" />
                            </div>
                        </div>
                        
                    </form>

                </div>

                
                <div class="col1-3 lastcol">
                    <h4>External Moderators</h4>
                    <form name="internal_members" id="internal_members" method="post" action="/unifiedmail/servlet/MaillistModServlet" onsubmit="return valExData(this.form)">
                        
        <input type="hidden" name="hid_maillist" value="<%=ml %>"/>


    

                        <table class="style1">
                            <thead>
                            <tr>
                                <th class="checkbox"><input type="checkbox" class="checkbox select-all" /></th>
                                <th>Mail Address</th>
                            </tr>
                            </thead>

                            <tbody>
                                <%
                                String arr2[]=exmod.split(",");
                                Arrays.sort(arr2);
                                for(int i=0;i<arr2.length;i++)
                                {
                                if(arr2[i]!= null && !(arr2[i].equals("")))
                            	{
                                 %>
                                    
                                    <tr>
                                        <td class="checkbox"><input type="checkbox" name="mail" value="<%=arr2[i] %>" class="checkbox" /></td>
                                        <td><%=arr2[i] %></td>
                                    </tr>
                                   <%}} %> 
                                
                            </tbody>
                        </table>

                        
                        <div class="tab-footer clear f1">
                            <div class="fl">
                                <select name="action" class="fl-space">
                                    
                                    <option value="delete">Remove from list</option>
                                </select>
                                <input type="submit" value="Apply" class="button fl-space" />
                            </div>
                        </div>
                        
                    </form>
                </div>

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