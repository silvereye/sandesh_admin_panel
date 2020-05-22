<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
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
      <title>User Report | Silvereye Unified E-mail Server</title>
 <noscript><meta http-equiv="refresh" content="0; URL=/unifiedmail/error/nojavascritp.jsp"></noscript>

    
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/reset.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/screen.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/fancybox.css" />

    <!--[if IE 7]>
        <link rel="stylesheet" type="text/css" href="/iredadmin-pro-ldap/static/default/css/ie7.css">
    <![endif]-->

 <script type="text/javascript">


function tkAction(nm,act)
	{
	//alert(nm);
	//alert(act);
 	
	var vall=null;
	 document.getElementById('action_gif').style.display= 'block';
	
	if (window.XMLHttpRequest)
    {// code for IE7+, Firefox, Chrome, Opera, Safari
    xmlhttp=new XMLHttpRequest();
    }
    else
    {// code for IE6, IE5
    xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
    xmlhttp.onreadystatechange=function()
    {
  
    if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
 
    var vall=xmlhttp.responseText;
   // alert(vall);
    document.getElementById('action_gif').style.display= 'none';
    location.reload();
    	//document.getElementById("div1").innerHTML = vall; 
    }
    }
xmlhttp.open("GET","/unifiedmail/global/servicesdata.jsp?name="+nm+"&action="+act,true);
xmlhttp.send();
    

	}

</script>
</head>

<body >
     <%@include file="header.jsp" %>
     <%
     HttpSession hsser=request.getSession(false);
      String utypeA=(String)hsser.getAttribute("user_name");
      if(utypeA.equalsIgnoreCase("Admin"))
      {
     %>
      <div id="action_gif" class="my_notification"
		style="display: none; left: 46%;">Loading...</div>
  <form name="search" method="post" action="">

    <div class="main pagesize"> <!-- *** mainpage layout *** -->
        <div class="main-wrap">
            <div class="page clear">
                
                



<div class="content-box">
    <div class="box-body">
        <div class="box-header clear">
                <h2>
                   Services
                    
                       
                    
                </h2>

           
        </div>


<div class="clear"></div>



    <div id="div1">
        
    <table class="style1" cellspacing="0">
        <thead>
        <tr>
            
               
            
            <th style="width: 400px;">Name</th> <!-- <th style="width: 400px;">Status</th> -->
            <th align="center" colspan="4">Actions</th>
            
        </tr>
        </thead>
        <tbody>
        
        <tr>
         <td>LDAP</td>
         <%
         String ldap_st_clr="#737272";
         String ldap_sp_clr="#737272";
         String cmmd1="sudo svstat /service/ldap";
         try
         {
         	String ss="";
        	Process	p = Runtime.getRuntime().exec(cmmd1);
         	BufferedReader stdInput = new BufferedReader(new InputStreamReader(p.getInputStream()));
    		while ((ss = stdInput.readLine()) != null) 
    		{
    		if(ss.contains("up") && ss.contains("pid"))
    		{
    			 ldap_st_clr="#07c74b";
    	         ldap_sp_clr="#737272";
    			 break;
    		}
    		else if(ss.contains("down") && !ss.contains("pid"))
    		{
    			ldap_st_clr="#737272";
   	         	ldap_sp_clr="#f35b54";
   			 	break;
    		}
    		}
         }
         catch(Exception e)
         {
         	out.print(e.toString());
         	e.printStackTrace();
         }
         
         %>
                        <!-- <td></td> -->
                        <td><input type="button" onclick="tkAction('LDAP',this.name)" name="Start" value="Start" style="background: none repeat scroll 0 0 <%=ldap_st_clr %>;    color: #fff; cursor: pointer;"/></td>
                        <td><input type="button" onclick="tkAction('LDAP',this.name)" name="Stop" value="Stop" style="background: none repeat scroll 0 0 <%=ldap_sp_clr %>;    color: #fff; cursor: pointer;"/></td>
                        <td><input type="button" onclick="tkAction('LDAP',this.name)" name="Restart" value="Restart" style="background: none repeat scroll 0 0 #737272;    color: #fff; cursor: pointer;"/></td>
                        <td></td>
                       
        </tr>
         <tr>
         <td>IMAP/POP3</td>
                       <%
         String imap_st_clr="#737272";
         String imap_sp_clr="#737272";
      
         String cmmd2="sudo svstat /service/imap";
         try
         {
         	String ss="";
        	Process	p = Runtime.getRuntime().exec(cmmd2);
         	BufferedReader stdInput = new BufferedReader(new InputStreamReader(p.getInputStream()));
    		while ((ss = stdInput.readLine()) != null) 
    		{
    		if(ss.contains("up") && ss.contains("pid"))
    		{
    			imap_st_clr="#07c74b";
    			imap_sp_clr="#737272";
    			 break;
    		}
    		else if(ss.contains("down") && !ss.contains("pid"))
    		{
    			imap_st_clr="#737272";
    			imap_sp_clr="#f35b54";
   			 	break;
    		}
    		}
         }
         catch(Exception e)
         {
         	out.print(e.toString());
         	e.printStackTrace();
         }
         
         %>
                        <!-- <td></td> -->
                       <td><input type="button" onclick="tkAction('IMAP',this.name)" name="Start" value="Start" style="background: none repeat scroll 0 0 <%=imap_st_clr %>;    color: #fff; cursor: pointer;"/></td>
                        <td><input type="button" onclick="tkAction('IMAP',this.name)" name="Stop" value="Stop" style="background: none repeat scroll 0 0 <%=imap_sp_clr %>;    color: #fff; cursor: pointer;"/></td>
                        <td><input type="button" onclick="tkAction('IMAP',this.name)" name="Restart" value="Restart" style="background: none repeat scroll 0 0 #737272;    color: #fff; cursor: pointer;"/></td>
                        <td></td>
                       
        </tr>
         
        <!--  <tr>
         <td>SMTP</td> -->
                       <%
        /*  String smtp_st_clr="#737272";
         String smtp_sp_clr="#737272";
   
         //String cmmd3="sudo lsof -i :25 | grep LISTEN";
         String cmmd3="sudo ps -ef | grep -v grep | grep postfix | wc -l";
         try
         {
         	String ss="";
        	Process	p = Runtime.getRuntime().exec(cmmd3);
        	System.out.println("p>>."+p);
         	BufferedReader stdInput = new BufferedReader(new InputStreamReader(p.getInputStream()));
         	boolean chk=true;
         
         	System.out.println("ppppp>>."+p.getInputStream().available());
    		while ((ss = stdInput.readLine()) != null) 
    		{
    			System.out.println(">>."+ss);
    			smtp_st_clr="#07c74b";
    			smtp_sp_clr="#737272";
    			chk=false;
    		}
    	 if(chk)
    		{
    			smtp_st_clr="#737272";
    			smtp_sp_clr="#f35b54";
    		}
         }
         catch(Exception e)
         {
         	out.print(e.toString());
         	e.printStackTrace();
         }
          */
         %>
                        <!-- <td></td> -->
          <%--              <td><input type="button" onclick="tkAction('SMTP',this.name)" name="Start" value="Start" style="background: none repeat scroll 0 0 <%=smtp_st_clr %>;    color: #fff; cursor: pointer;"/></td>
                        <td><input type="button" onclick="tkAction('SMTP',this.name)" name="Stop" value="Stop" style="background: none repeat scroll 0 0 <%=smtp_sp_clr %>;    color: #fff; cursor: pointer;"/></td>
                        <td><input type="button" onclick="tkAction('SMTP',this.name)" name="Restart" value="Restart" style="background: none repeat scroll 0 0 #737272;    color: #fff; cursor: pointer;"/></td>
                        <td></td>
                       
        </tr> --%>
        
         <tr>
         <td>Anti-Spam</td>
         <%
         String spam_st_clr="#737272";
         String spam_sp_clr="#737272";
         String cmmd4="sudo svstat /service/spamd";
         try
         {
         	String ss="";
        	Process	p = Runtime.getRuntime().exec(cmmd4);
        	//System.out.println(p);
         	BufferedReader stdInput = new BufferedReader(new InputStreamReader(p.getInputStream()));
    		while ((ss = stdInput.readLine()) != null) 
    		{
    		if(ss.contains("up") && ss.contains("pid"))
    		{
    			spam_st_clr="#07c74b";
    			spam_sp_clr="#737272";
    			 break;
    		}
    		else if(ss.contains("down") && !ss.contains("pid"))
    		{
    			spam_st_clr="#737272";
    			spam_sp_clr="#f35b54";
   			 	break;
    		}
    		}
         }
         catch(Exception e)
         {
         	out.print(e.toString());
         	e.printStackTrace();
         }
         
         %>
                       <!--  <td></td> -->
                       <td><input type="button" onclick="tkAction('Anti-Spam',this.name)" name="Start" value="Start" style="background: none repeat scroll 0 0 <%=spam_st_clr %>;    color: #fff; cursor: pointer;"/></td>
                        <td><input type="button" onclick="tkAction('Anti-Spam',this.name)" name="Stop" value="Stop" style="background: none repeat scroll 0 0 <%=spam_sp_clr %>;    color: #fff; cursor: pointer;"/></td>
                        <td><input type="button" onclick="tkAction('Anti-Spam',this.name)" name="Restart" value="Restart" style="background: none repeat scroll 0 0 #737272;    color: #fff; cursor: pointer;"/></td>
                        <td></td>
                       
        </tr>
        <tr>
         <td>Anti-Virus</td>
          <%
         String virus_st_clr="#737272";
         String virus_sp_clr="#737272";
         String cmmd5="sudo svstat /service/clamd";
         try
         {
         	String ss="";
        	Process	p = Runtime.getRuntime().exec(cmmd5);
         	BufferedReader stdInput = new BufferedReader(new InputStreamReader(p.getInputStream()));
    		while ((ss = stdInput.readLine()) != null) 
    		{
    		if(ss.contains("up") && ss.contains("pid"))
    		{
    			virus_st_clr="#07c74b";
    			virus_sp_clr="#737272";
    			 break;
    		}
    		else if(ss.contains("down") && !ss.contains("pid"))
    		{
    			virus_st_clr="#737272";
    			virus_sp_clr="#f35b54";
   			 	break;
    		}
    		}
         }
         catch(Exception e)
         {
         	out.print(e.toString());
         	e.printStackTrace();
         }
         
         %>
                       <!--  <td></td> -->
                       <td><input type="button" onclick="tkAction('Anti-Virus',this.name)" name="Start" value="Start" style="background: none repeat scroll 0 0 <%=virus_st_clr %>;    color: #fff; cursor: pointer;"/></td>
                        <td><input type="button" onclick="tkAction('Anti-Virus',this.name)" name="Stop" value="Stop" style="background: none repeat scroll 0 0 <%=virus_sp_clr %>;    color: #fff; cursor: pointer;"/></td>
                        <td><input type="button" onclick="tkAction('Anti-Virus',this.name)" name="Restart" value="Restart" style="background: none repeat scroll 0 0 #737272;    color: #fff; cursor: pointer;"/></td>
                        <td></td>
                       
        </tr>
</tbody>
</table>
    
       
</div>

    
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
    <%}%>
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