<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="dbutil.Crudoperation"%>
<%@page import="java.sql.Connection"%>
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
function delWlist(id) {
	document.getElementById('action_gif').style.display= 'block';
	var dm=$("#hid_dn").val();
	var mail=$("#hid_mail").val();
	$.ajax({
	    type: "POST",
	    url: "/unifiedmail/servlet/DeleteWBlistUserServlet",
	    data: {"id": id, "mail": mail, "dom": dm, "status":"whitelist_from" },
	    success: function (data) {
	      $("#Wlistdiv").html(data);
	      document.getElementById('action_gif').style.display= 'none'; 	            
	    }
	});

}

function delBlist(id) {
	document.getElementById('action_gif').style.display= 'block';
	var dm=$("#hid_dn").val();
	var mail=$("#hid_mail").val();
	$.ajax({
	    type: "POST",
	    url: "/unifiedmail/servlet/DeleteWBlistUserServlet",
	    data: {"id": id, "mail": mail, "dom": dm, "status":"blacklist_from" },
	    success: function (data) {
	      $("#Blistdiv").html(data);
	      document.getElementById('action_gif').style.display= 'none'; 	            
	    }
	});

}

 function addBSenMail()
{
var val=document.getElementById("add_bs_mail").value;

if(val==null || val=="")
{
alert("Please enter email address.");
}
else
{
if(val.indexOf("@")<=0)
{
alert("Please enter correct email.");
}
else
{
	document.getElementById("add_bs_mail").value="";
	document.getElementById('action_gif').style.display= 'block';
	var dm=$("#hid_dn").val();
	var mail=$("#hid_mail").val();
	$.ajax({
	    type: "POST",
	    url: "/unifiedmail/servlet/AddWBlistUserServlet",
	    data: {"val": val, "mail": mail, "dom": dm, "status":"blacklist_from" },
	    success: function (data) {
	      $("#Blistdiv").html(data);
	      document.getElementById('action_gif').style.display= 'none'; 	            
	    }
	});

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
if(val.indexOf("@")<=0)
{
alert("Please enter correct email.");
}
else
{
document.getElementById("add_ws_mail").value="";


document.getElementById('action_gif').style.display= 'block';
var dm=$("#hid_dn").val();
var mail=$("#hid_mail").val();
$.ajax({
    type: "POST",
    url: "/unifiedmail/servlet/AddWBlistUserServlet",
    data: {"val": val, "mail": mail, "dom": dm, "status":"whitelist_from" },
    success: function (data) {
      $("#Wlistdiv").html(data);
      document.getElementById('action_gif').style.display= 'none';  	            
    }
});
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
 

HttpSession hs=request.getSession(false);

String utype=(String)hs.getAttribute("user_name");		       
                


%>  
  
    
     <div id="action_gif" class="my_notification"
		style="display: none; left: 46%;">Loading...</div>
   
   
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
                        <li class="active"><a href="/unifiedmail/global/whiteblacklistuserNew.jsp?ml=<%=mail %>">White/Blacklist</a></li>
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
            <img src="/unifiedmail/images/graph_16.png"  title="Account activities"   style="padding-left: 5px;" class="vcenter"  />
        </a></h2>
            </div>

        <div class="box-wrap clear">
           <form id="register" action="#" name="f" method="post" onsubmit="return valData()">
   
    
                            	<input type="hidden" name="hid_mail" id="hid_mail" value="<%=mail %>" />
             <input type="hidden" name="hid_dn" id="hid_dn" value="<%=dn %>" />
       <div class="columns clear">
            <div class="col2-3">
                <div class="form-field clear">
        <h4 class="size-250 fl-space" style="width: 150px;">Whitelist</h4>
       
  <span class="clean-padding bt-space20">
            
        
        
        
    
                                    	 <div class="checklist clear" style=" max-width: 424px;     min-height: 8em;" id="Wlistdiv">
                                  <table width="100%">
                                 <%
               Connection pcon1=Crudoperation.createSpamConnection();
               String sql1="select * from userpref where username=? and preference=? ";
            
               try
              {
              PreparedStatement ps=pcon1.prepareStatement(sql1);
              ps.setString(1,mail);
              ps.setString(2,"whitelist_from");
             int flg=0;
               ResultSet rs=ps.executeQuery();
               while(rs.next())
				{
				String val=rs.getString("value");
				String preid=rs.getString("prefid");
				if(flg%2==0)
				{
                %>
			<tr style="background: #e8e8e8;">
			<%}
				else
				{
				%>
			<tr style="background: #fff;">
			<%}
				flg++;
				%>
			<td width="90%" style="padding-left: 4px;"> <%=val %></td>
			<td width="10%" style="    text-align: right;">
			<span style="    margin-right: 4px; cursor: pointer;" id="<%=preid %>" onclick="delWlist(this.id)">
			<img src="/unifiedmail/images/delete-icon.png" style="margin-bottom: -3px;"/></span>
			</td></tr>
			
		 
                
                <%}
              }
               catch(Exception ee){System.out.println(ee);}
               %>
                            </table>	     	 
                                    	 </div>
              <div class="ermsg1" id="sp1" style="width: 340px;">
             <input class="text" type="text" size="42" value="" placeholder="Ex: user@example.com" id="add_ws_mail">
             <input name="bt2" type="button" value="Add" class="add-row-domain-button" onclick="addWSenMail()"/>
             </div>
             </span>
        
    </div>

                <div class="form-field clear">
        <h4 class="size-250 fl-space" style="width: 150px;">Blacklist</h4>
        <span class="clean-padding bt-space20">
            
        
        
        
    
                                    	 <div class="checklist clear" style="max-width: 424px;   min-height: 8em;" id="Blistdiv">
                                    	 
                                    	<table width="100%">
                                 <%
               Connection pcon2=Crudoperation.createSpamConnection();
               String sql2="select * from userpref where username=? and preference=? ";
            
               try
              {
              PreparedStatement ps=pcon2.prepareStatement(sql2);
              ps.setString(1,mail);
              ps.setString(2,"blacklist_from");
              int flg=0;
               ResultSet rs=ps.executeQuery();
               while(rs.next())
				{
				String val=rs.getString("value");
				String preid=rs.getString("prefid");
				if(flg%2==0)
				{
                %>
			<tr style="background: #e8e8e8;">
			<%}
				else
				{
				%>
			<tr style="background: #fff;">
			<%}
				flg++;
				%>
			<td width="90%" style="padding-left: 4px;"> <%=val %></td>
			<td width="10%" style="    text-align: right;">
			<span style="    margin-right: 4px; cursor: pointer;" id="<%=preid %>" onclick="delBlist(this.id)">
			<img src="/unifiedmail/images/delete-icon.png" style="margin-bottom: -3px;"/></span>
			</td></tr>
			
		 
                
                <%}
              }
               catch(Exception ee){System.out.println(ee);}
               %>
                            </table>
                                    	
                                    	
                                    	 </div>
                                    	  <div class="ermsg1" id="sp1" style="width: 340px;">
             <input class="text" type="text" size="42" value="" placeholder="Ex: user@example.com" id="add_bs_mail">
             <input name="bt2" type="button" value="Add" class="add-row-domain-button" onclick="addBSenMail()"/>
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

                    <h4>Format for Whitelist/Blacklist</h4>
                    <ul class="standard clean-padding bt-space10">
                        <li class="bt-space5"><strong>Single user:</strong> <u>user@example.com</u></li>
                        <li class="bt-space5"><strong>Entire domain:</strong> <u>*@example.com</u></li>
                       
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