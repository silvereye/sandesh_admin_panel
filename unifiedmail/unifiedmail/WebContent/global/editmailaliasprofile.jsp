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
    <title>Edit Mail Alias Profile | Silvereye Unified E-mail Server</title>
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
    function mypopUp()
    {

     document.getElementById('bkg').style.visibility = 'visible';
      document.getElementById('dlg').style.visibility = 'visible';
    }
    
    function closeDiv()
    {
  
    document.getElementById('bkg').style.visibility = 'hidden';
    document.getElementById('dlg').style.visibility ='hidden';
    }
    
    
    function addLocMail()
    {
    //document.getElementById('bkg').style.visibility = 'hidden';
   // document.getElementById('dlg').style.visibility ='hidden';
    
    var av=document.getElementsByName("local");
 //alert("hi");
 document.getElementById("loc_mail_div").innerHTML="";
 
var fl=0;
 for (e=0;e<av.length;e++) {
  if (av[e].checked==true) {
  var n=av[e].value//.split("-"); 
  if(fl==4)
 {
 alert("Max members limit is 4");
 break;
 }
  if(n!=null)
  {
  fl=fl+1;
  //alert(n)
 document.getElementById("loc_mail_div").innerHTML+="<input type='checkbox' name='frd_mail' value='"+n+"' checked='checked' />"+n+"<br/>";
  fg_hideform('fg_formContainer','fg_backgroundpopup');
 }
 
 }
 }
    }
    
    
    
    </script>
<link rel="STYLESHEET" type="text/css" href="/unifiedmail/popup/popup-contact.css" />
</head>
<body onload="javascript:fg_hideform('fg_formContainer','fg_backgroundpopup');">
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
		        String base="ou=Aliases,domainName="+dn+",o=domains,"+mbase;
		        String acc="";
String cn="";
int book=0;
String serv="";
String frd="";      
try
{


DirContext ctx=LDAPConnection.getConnection(url, base, username, password);

SearchControls constraints = new SearchControls(); 
constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
String attrList[] = {"cn","accountStatus","enabledService","mailForwardingAddress"}; 
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
        else if(id.equalsIgnoreCase("mailForwardingAddress"))
        {
        if(frd.equals(""))
        {
       	frd=str;
       	}
       	else
       	{
       	frd=frd+","+str;
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
 <form action="/unifiedmail/servlet/EditMailAliasServlet" name="f" method="post" onsubmit="return valData()">
    <div class="main pagesize"> <!-- *** mainpage layout *** -->
    
        <div class="main-wrap">
	<div class="sublev-nav">	
   	<ul>
   		<li><a href="/unifiedmail/global/domainlist.jsp">All Domains</a></li>
<li><a href="/unifiedmail/global/editdomainprofile.jsp?dn=<%=dn %>"><%=dn %></a></li>
<li><a href="/unifiedmail/global/userslist.jsp?dm=<%=dn %>">Users</a></li>
<li><a href="/unifiedmail/global/maillistslist.jsp?dm=<%=dn %>">Mail Lists</a></li>
<li><a href="/unifiedmail/global/mailaliaseslist.jsp?dm=<%=dn %>">Mail Aliases</a></li>
 <li><a class="active-subs" href="/unifiedmail/global/editmailaliasprofile.jsp?ml=<%=mail %>" >Profile of Mail Alias: &nbsp;&nbsp;<%=mail %></a></li>
 
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
            <p><%=mail %> Mail Alias has been updated successfully. </p>	</div>
      <%}
      else if(stt!=null && stt.equalsIgnoreCase("error"))
      {
       %>
        <div id="msg_err" class="notification note-error"><a href='#' class='close'></a>
                 <p>Mail alias updation has been failed.	</p></div>
    
    
    <%} %>

        
    


<div class="content-box">
    <div class="box-body">
        
        <div class="box-header clear">
            <ul class="tabs clear">
                  <li class="active"><a href="/unifiedmail/global/editmailaliasprofile.jsp?ml=<%=mail %>" >General</a></li>
                         </ul>

            <h2>Profile of mail alias: <%=mail %></h2>
        </div>

        <div class="box-wrap clear">

            
            <div id="profile_general">
                
   
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


                            

                            
                                <div class="form-field clear">
       
            <h4 class="size-250 fl-space">Add Internal  Members </h4>
        

        <span class="clean-padding bt-space20">
            
        
        
        
    
                                    	 <div class="checklist clear" style=" max-width: 25em;" id="loc_mail_div">
   
   <%
                                 frd=frd.trim(); 
                                 if(frd!=null && !(frd.equals(""))) 
                                 {        
                            	String marr[]=frd.split(",");
                            	System.out.println("mlst   "+frd+"    ln="+marr.length);
                            	 for(int i=0;i< marr.length;i++)
                            {
                            	 %>
                                            	
   
                        
                             <input type="checkbox"  name="frd_mail" value="<%=marr[i] %>" checked="checked"  class="checkbox" />
                  <%=marr[i] %><br/>
                            
                            <%} }%>
                         
                           
            </div>
              <input type="hidden" name="hid_old_list" value="<%=frd %>"/>
             <div class="ermsg" id="sp1" style="width: 340px;">
             <a href='javascript:fg_popup_form("fg_formContainer","fg_form_InnerContainer","fg_backgroundpopup");'>
             <input name="bt1" type="button" value="Add" class="add-row-domain-button" />
             </a>
             </div>
               
        
        
        
        
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
               
            </div>




        
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
<div id='fg_formContainer' style="width: 525px;">
    

    <div id="fg_form_InnerContainer" style="max-height: 400px;    overflow-y: scroll;">
    <table class="style1">
                            <thead>
                            <tr>
                                <th class="checkbox"><input type="checkbox" class="checkbox select-all"></th>
                                <th>Display Name</th>
                                <th>Mail Address</th>
                                
                                <th style="text-align: center;">Account Status</th>
                            </tr>
                            </thead>

                            
                            <tbody>
                                        
                                            	<%
                                            	String lst=GetUsersList.getUsersListNew(url,username,password,mbase,dn,"mail","*");
                                            	String arrlst[]=lst.split("<!nps!>");
                                            	for(int i=0;i< arrlst.length;i++)
                                            	{
                                            	String chk="";
                                            	String arrlst0[]=arrlst[i].split("<#nps#>");

                                          	   %>
                                                 <tr class="odd active">
                                                <% 
                                            	if(frd.indexOf(arrlst0[0])>-1)
                                            	{
                                            	
                                            	 %>
                                               <td class="checkbox">
                                                <input type="checkbox" name="local" checked="checked" value="<%=arrlst0[0] %>"/></td>
                                                 <%
                                                if(arrlst0.length>1) 
                                                 {
                                                %>
                                                <td style="text-align: left;"> <%=arrlst0[1] %></td>
                                                 <td style="text-align: left;"><%=arrlst0[0] %> </td>
                                                <td align="center">
                                             <%if(arrlst0[2].equalsIgnoreCase("active"))
                                             {
                                            	 %>
       										  <img src="/unifiedmail/images/right_mark.png" />
        									 <%}
                                             else
                                             {
                                             %>
                                              <img src="/unifiedmail/images/image1.png" />
                                              <%} %> 
                                            
                                            </td>
                                                 <%}
                                                else
                                                	{%>
                                                <td ></td>
                                                 <td style="text-align: left;"><%=arrlst0[0] %> </td>
                                                 <td align="center"></td>
                                                <%}} 
                                                else
                                                {
                                                %>	 
												<td class="checkbox">
                                                <input type="checkbox" name="local" value="<%=arrlst0[0] %>"/></td>
                                                <%
                                                if(arrlst0.length>1) 
                                                 {
                                                %>
                                                <td style="text-align: left;"> <%=arrlst0[1] %></td>
                                                 <td style="text-align: left;"><%=arrlst0[0] %> </td>
                                                <td align="center">
                                             <%if(arrlst0[2].equalsIgnoreCase("active"))
                                             {
                                            	 %>
       										  <img src="/unifiedmail/images/right_mark.png" />
        									 <%}
                                             else
                                             {
                                             %>
                                              <img src="/unifiedmail/images/image1.png" />
                                              <%} %> 
                                            
                                            </td>
                                                 <%} 
                                                else
                                                {
                                                 %>
                                                 <td ></td>
                                                 <td style="text-align: left;"><%=arrlst0[0] %> </td>
                                                 <td align="center"></td>

                                                	<%}} %>
                                                	
                                                 </tr>
                                                	<%} %>
                                               </tbody> 	
                                                 </table>	
                                                	
                                               
                                   
           </div>
    <div style="margin-bottom: 10px;     margin-top: -7px;">
    <input type="button" value="Add" class="button green" onclick="addLocMail()"/>
    <input type="button" value="Cancel" style="    margin-left: 10px;" class="button green" onclick="fg_hideform('fg_formContainer','fg_backgroundpopup')"/>
    </div>
</div>

<div id='fg_backgroundpopup'></div>
            
            
            
            
    </form>         
            
          
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