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
 <noscript><meta http-equiv="refresh" content="0; URL=/unifiedmail/error/nojavascritp3.jsp"></noscript>

    
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/reset.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/screen.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/fancybox.css" />

    <!--[if IE 7]>
        <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/ie7.css">
    <![endif]-->

    <script type="text/javascript">
    function valInData(frm)
{
var chk_arr =  document.getElementsByName("in_mail");
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
var chk_arr =  document.getElementsByName("ex_mail");
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
 
 function npCount() {
	 var inno=document.getElementById("inno").value;
	 var exno=document.getElementById("exno").value;
	 var txt=inno+" Internal Members and "+ exno+" External Members";
	 document.getElementById('np_count').innerHTML= txt;
}
 
    </script>
</head>

<body>
    <%
   String ml=request.getParameter("ml");
   String dn="";
  if( ml!=null && !(ml.equals("")) )
   {
   				String arr[]=ml.split("@");
   				dn=arr[1];
                HttpSession hs=request.getSession(false);
		        String username= (String)hs.getAttribute("id");
		        String password= (String)hs.getAttribute("password");
		        String url= (String)hs.getAttribute("url");
		        String mbase= (String)hs.getAttribute("base");
		       





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
                        <li class="active"><a href="/unifiedmail/global/maillistmembers.jsp?ml=<%=ml %>" >Members</a></li>
                       <li><a href="/unifiedmail/global/maillistmoderators.jsp?ml=<%=ml %>">Owners</a></li>
                         <li><a href="/unifiedmail/global/addmaillistmembers.jsp?ml=<%=ml %>">Add Members</a></li>
                        <li><a href="/unifiedmail/global/addmaillistmoderators.jsp?ml=<%=ml %>">Add Owners</a></li>
            </ul>

            <h2>Profile of mail list: <%=ml %></h2>
        </div>

        <div class="box-wrap clear">

            
            <div id="members" class="columns clear">
                <p>Messages sent to mail list will be delivered to its members.</p>
<p><span><a onclick="npCount()" style="cursor: pointer;">Click here to know count of Members</a></span>:&nbsp;&nbsp; <span style="font-weight: bold;" id="np_count"></span></p>
                
                <div id="internal" class="col2-3">
                    <h4>Internal Members </h4>
                    <form name="internal_members" id="internal_members" method="post" action="/unifiedmail/servlet/InMaillistMemServlet" onsubmit="return valInData(this.form)">
                        
        <input type="hidden" name="hid_inmaillist" value="<%=ml %>"/>
    


                        
                        <table class="style1">
                            <thead>
                            <tr>
                                <th class="checkbox"><input type="checkbox" class="checkbox select-all" /></th>
                                <th>Display Name</th>
                                <th>Mail Address</th>
                                <th>Quota</th>
                                <th style="text-align: center;">Account Status</th>
                            </tr>
                            </thead>

                            
                            <tbody>
                            
                             <%
                             String lst=GetUsersList.getUsersList(url,username,password,mbase,dn,"mail","*");
                             String arrlst1[]=lst.split(",");
                             Arrays.sort(arrlst1);
                                            	long inno=0;
                                            	for(int i=0;i< arrlst1.length;i++)
                                            	{
                                            	String chk="";
                                            	chk=GetUsersList.getUsersListMem(url,username,password,mbase,dn,"mail",arrlst1[i],ml);
                                            	
                                            System.out.println("memgp=  "+chk.indexOf(ml));
                                            	if(chk.indexOf(ml)>-1)
                                            	{
                                            		inno++; 
                                            	String det=GetUsersDetail.getUsersDet(url,username,password,mbase,dn,"mail",arrlst1[i]);
                              					 String det_arr[]=det.split(","); 
                               					 String v1=det_arr[0];
                                 				 String v2=det_arr[1];
                                  				 String v3=det_arr[2];
                                  				 
                                  				 
                              %>   
                                    
                                        
                                    

                                    <tr class="odd active">
                                        <td class="checkbox"><input type="checkbox" name="in_mail" value="<%=v1 %>" class="checkbox" /></td>
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
                                               
                                            
                                            </td></tr>
                                
                                    
                                    
                                    
                                   <%}} %> 

                                    

                                   
                                        
                                        
                                        
                                    

                                    
                                  
                            
                            </tbody>
                        </table>
<input type="hidden" id="inno" value="<%=inno %>"/>
                        
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
                    <h4>External Members</h4>
                    
                  
                    
                    <form name="external_members" method="post" action="/unifiedmail/servlet/ExMaillistMemServlet" onsubmit="return valExData(this.form)">
                        
        <input type="hidden" name="hid_exmaillist" value="<%=ml %>"/>
    

    
                        <table class="style1">
                            <thead>
                            <tr>
                                <th class="checkbox"><input type="checkbox" class="checkbox select-all" /></th>
                                <th>Mail Address</th>
                            </tr>
                            </thead>

                            <tbody>
                                
                                      <%
                   long exno=0;
                                String ex_mail=GetExternalList.getExternalList(url,username,password,mbase,dn,"memberOfGroup",ml) ;
                            	String ex_arr[]=ex_mail.split(",");
                            	 Arrays.sort(ex_arr);
                            	System.out.println("ex="+ex_mail);
                            	 for(int i=0;i<ex_arr.length;i++)
                            	{
                            	if(ex_arr[i]!= null && !(ex_arr[i].equals("")))
                            	{
                            		exno++;
                            		%> 
                                    <tr>
                                        <td class="checkbox"><input type="checkbox" name="ex_mail" value="<%=ex_arr[i] %>" class="checkbox" /></td>
                                        <td><%=ex_arr[i] %></td>
                                    </tr>
                                    <%} }%>
                                
                            </tbody>
                        </table>
<input type="hidden" id="exno" value="<%=exno %>"/>
                        
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