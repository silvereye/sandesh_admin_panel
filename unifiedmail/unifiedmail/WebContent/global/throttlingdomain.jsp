<%@ page language="java" import="java.util.*,mypack.*,dbutil.*,java.sql.*" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.regex.*" %>
<%@ page import="javax.naming.directory.*" %>
<%@page import="java.sql.ResultSet"%>
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
    
function checkNum(nm)
{
var val=document.getElementById(nm).value;
var numbers = /^[0-9]+$/;  
if(val.match(numbers))
{
/*
if(val.length>=3)
{
val = val.substring(0, val.length - 1)
document.getElementById(nm).value=val;
}
*/
}
else
{
val = val.substring(0, val.length - 1)
document.getElementById(nm).value=val;

}
}


function checkVal(nm,val)
{
var vl=parseInt(val);
if(vl>=60)
{
alert("Value should be less than 60.");
document.getElementById(nm).value="";
}
if(vl==0)
{
alert("Value should not be 0.");
document.getElementById(nm).value="";
}
}



function valData()
{


var inputElements = document.getElementsByName('out_acc');
for(var i=0; inputElements[i]; ++i){
      if(inputElements[i].checked){
        var out_ml=parseInt(document.getElementById("out_max").value)
if(out_ml==0)
{
alert("Number of max outgoing emails should be greater than 0.");
return false;
}  
      }
}

var inputElements1 = document.getElementsByName('in_acc');
for(var j=0; inputElements1[j]; ++j){
      if(inputElements1[j].checked){
        var in_max=parseInt(document.getElementById("in_max").value)
if(in_max==0)
{
alert("Number of max incoming emails should be greater than 0.");
return false;
}  
      }
}

/*

var inputElements11 = document.getElementsByName('in_acc');
for(var i=0; inputElements1[i]; ++i){
      if(inputElements1[i].checked){
         var in_ml=parseInt(document.getElementById("in_max").value)
if(in_ml==0)
{
alert("Number of max incoming emails should be greater than 0.");
return false;
} 
      }
}

*/
if (document.getElementById('out4').checked) 
{
 var val1=document.getElementById("out_time_val").value
 if(val1=="" || val1==null)
 {
 alert("Value of custom outgoin mail should not be empty.");
 return false;
 }
}


if (document.getElementById('in4').checked) {
   var val2=document.getElementById("in_time_val").value
  if(val2=="" || val2==null)
 {
 alert("Value of custom incoming mail should not be empty.");
 return false;
 }
}

return true;
}
</script>
</head>

<body>
 
 <% 
  HttpSession hs=request.getSession(false);
	 String utype=(String)hs.getAttribute("user_name");
	
	 
  String dn=request.getParameter("dn"); 
  if( dn!=null && !(dn.equals("")) ) 
   { 
    
%>
  
    
    
   
   
   
   
  <%@include file="header.jsp"%>

 
    
    

    <div class="main pagesize"> <!-- *** mainpage layout *** -->
        <div class="main-wrap">
        <%
       

          if(hs!=null && !(utype.equalsIgnoreCase("Admin")))
          {
           %>  
      
	<div class="sublev-nav">	
   	<ul>
   		<li>Access is Denied.</li>

   	</ul>
   	<div class="clr"></div>
   	</div>
        
        <%}
        else
        {
         %>
        
        
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
                        <li  ><a href="/unifiedmail/global/aliasesdomain.jsp?dn=<%=dn %>">Aliases</a></li> 
                        <li ><a href="/unifiedmail/global/whiteblacklistdomain.jsp?dn=<%=dn %>">White/Blacklist</a></li>  
                         <%
                         if(utype!=null && utype.equalsIgnoreCase("Admin"))
                                {
                         %>
                         <li class="active"><a href="/unifiedmail/global/throttlingdomain.jsp?dn=<%=dn %>">Throttling</a></li>      
                         <%} %>                     
                       
                        <li><a href="/unifiedmail/global/disclaimerdomain.jsp?dn=<%=dn %>">Disclaimer</a></li>                    
                        <li><a href="/unifiedmail/global/advancedomain.jsp?dn=<%=dn %>">Advanced</a></li>
                        
                
            </ul>
            <h2>Profile of domain: <%=dn %> <a href="/unifiedmail/global/domainsentmail.jsp?dn=<%=dn %>">
            <img src="/unifiedmail/images/graph_16.png"
                
                    title="Domain activities"
                

                
                    style="padding-left: 5px;" class="vcenter"
                
            />
        </a></h2>
        </div>

        <div class="box-wrap clear">
        
          <form action="/unifiedmail/servlet/EditThrottlingDomainServlet" name="f" method="post" onsubmit="return valData()">
         <input type="hidden" name="hid_dn" value="<%=dn %>" />
         
      <%
      
       /*** out going ***/
       String outnm=dn+" Outbound";
	   
      int outpid=Crudoperation_Policy.getPID(outnm);
      
     
      int outqid=Crudoperation_Policy.getQtID(outpid,"Sender:@domain");
      int out_dis=1;
      int out_max=0;
      long out_time=0;
      int outqidlmt=0;
      
      
     
      
      
      if(outqid!=0)
      {
       String sql_d="select Disabled from policies where ID=?";
      out_dis=Integer.parseInt( Crudoperation_Policy.getSingleData(sql_d, outpid));
      
      String sql="select * from quotas where id=?";
      ResultSet rs= Crudoperation_Policy.singlegetData(sql,outqid);
      if(rs.next())
      {
           out_time=rs.getLong("Period");
      }
      
      String sql1="select * from quotas_limits where QuotasID=? and type=?";
      ResultSet rs1= Crudoperation_Policy.singlegetData(sql1,outqid,"MessageCount");
      if(rs1.next())
      {
      outqidlmt=rs1.getInt("id");
      out_max=rs1.getInt("CounterLimit");
      }
      }
       %> 
       <input type="hidden" name="hid_outpid" value="<%=outpid %>"/> 
        <input type="hidden" name="hid_outqid" value="<%=outqid %>"/> 
        <input type="hidden" name="hid_outqidlmt" value="<%=outqidlmt %>"/> 
         
         
         
     
<%
/*** in coming ***/
String innm=dn+" Inbound";
      int inpid=Crudoperation_Policy.getPID(innm);
      int inqid=Crudoperation_Policy.getQtID(inpid,"Recipient:@domain");
       int in_dis=1;
      int in_max=0;
      long in_time=0;
      int inqidlmt=0;
      
     
      
      
      if(inqid!=0)
      {
      
       String sql_d1="select Disabled from policies where ID=?";
      in_dis=Integer.parseInt( Crudoperation_Policy.getSingleData(sql_d1, inpid));
      
      
      
      String sql="select * from quotas where id=?";
      ResultSet rs= Crudoperation_Policy.singlegetData(sql,inqid);
      if(rs.next())
      {
      in_time=rs.getLong("Period");
      }
      
      String sql1="select * from quotas_limits where QuotasID=? and type=?";
      ResultSet rs1= Crudoperation_Policy.singlegetData(sql1,inqid,"MessageCount");
      if(rs1.next())
      {
      inqidlmt=rs1.getInt("id");
      in_max=rs1.getInt("CounterLimit");
      }
      }
 %>
                
        <input type="hidden" name="hid_inpid" value="<%=inpid %>"/> 
        <input type="hidden" name="hid_inqid" value="<%=inqid %>"/> 
        <input type="hidden" name="hid_inqidlmt" value="<%=inqidlmt %>"/>         
                
                

                      <div class="columns clear">
                        <div class="col2-3 ">
                            
                            

    
    

    <div class="form-field clear">
        <h4 class="size-250 fl-space">Enable sender throttling</h4>
        <%
        if(out_dis==0)
        {
         %>
        <input type="checkbox" name="out_acc" value="0" checked="checked"/>
        <%
        }
        else
        {
         %>
         <input type="checkbox" name="out_acc" value="1" />
         <%} %>
    </div>
                            

 
                            
    

    <div class="form-field clear">
        <h4 class="size-250 fl-space">Number of max outgoing emails</h4>
        <input type="text" name="out_max" id="out_max" onkeyup="checkNum(this.name)" required  size="15" value="<%=out_max %>" />
    </div>
    
                            
    
    

    <div class="form-field clear">
        <h4 class="size-250 fl-space">Time Unit</h4>
        <%
        String o_min="";
        String o_day="";
        String o_hrs="";
        String o_cus="";
        String o_cus_val="";
        if(out_time==60)
        {
        o_min="checked='checked'";
        }
        else if(out_time==3600)
        {
        o_hrs="checked='checked'";
        }
        else if(out_time==86400)
        {
        o_day="checked='checked'";
        }
        else 
        {
       
        if(out_time>0)
        { o_cus="checked='checked'";
        o_cus_val=""+out_time;
        }
        else
        {
        o_min="checked='checked'";
        o_cus_val="";
        }
        }
      
        
         %>
            <input type="radio" <%=o_min %> id="out1"  name="out_time" value="60"  class="radio fl-space"/><label class="fl">1 Minute&nbsp;</label>
     
            <input type="radio" <%=o_hrs %> id="out2"  name="out_time" value="3600"  class="radio fl-space"/><label class="fl">1 Hour&nbsp;</label>
        
            <input type="radio" <%=o_day %> id="out3"  name="out_time" value="86400"  class="radio fl-space"/><label >1 Day&nbsp;</label>
        
    </div>

    <div class="form-field clear">
        <h4 class="size-250 fl-space">&nbsp;</h4>
        
        
        
            
        
        <input type="radio" <%=o_cus %> id="out4"  name="out_time"  value="0" />Custom: 
        <input type="text" size="10" name="out_time_val" id="out_time_val" onblur="checkVal(this.name,this.value)" onkeyup="checkNum(this.name)"  value="<%=o_cus_val %>" style="vertical-align: middle;"/>&nbsp;Seconds
    </div>
                            <div class="rule">&nbsp;</div>
                            
                            

    
    

    <div class="form-field clear">
        <h4 class="size-250 fl-space">Enable recipient throttling</h4>
        <%
        if(in_dis==0)
        {
         %>
        <input type="checkbox" name="in_acc" value="0" checked="checked"/>
        <%
        }
        else
        {
         %>
         <input type="checkbox" name="in_acc" value="1" />
         <%} %>
    </div>
                            
    
        
    

    <div class="form-field clear">
        <h4 class="size-250 fl-space">Number of max incoming emails</h4>
         <input type="text" name="in_max" id="in_max" onkeyup="checkNum(this.name)" required size="15" value="<%=in_max %>" />
    </div>
                            
    
    

    <div class="form-field clear">
        <h4 class="size-250 fl-space">Time Unit</h4>
        
           <%
        String i_min="";
        String i_day="";
        String i_hrs="";
        String i_cus="";
        String i_cus_val="";
        if(in_time==60)
        {
        i_min="checked='checked'";
        }
        else if(in_time==3600)
        {
        i_hrs="checked='checked'";
        }
        else if(in_time==86400)
        {
        i_day="checked='checked'";
        }
        else 
        {
        
        if(in_time>0)
        {
        i_cus_val=""+in_time;
        i_cus="checked='checked'";
        }
        else
        {
        i_cus_val="";
        i_min="checked='checked'";
        }
      }
      
        
         %>
            <input type="radio" <%=i_min %>  name="in_time" value="60"  class="radio fl-space"/><label class="fl">1 Minute&nbsp;</label>
     
            <input type="radio" <%=i_hrs %> name="in_time" value="3600"  class="radio fl-space"/><label class="fl">1 Hour&nbsp;</label>
        
            <input type="radio" <%=i_day %> name="in_time" value="86400"  class="radio fl-space"/><label >1 Day&nbsp;</label>
        
    </div>

    <div class="form-field clear">
        <h4 class="size-250 fl-space">&nbsp;</h4>
        
        
        
            
        
        <input type="radio" id="in" <%=i_cus %> name="in_time"  value="0" />Custom: 
        <input type="text" size="10" name="in_time_val" id="in_time_val" onblur="checkVal(this.name,this.value)" onkeyup="checkNum(this.name)"  value="<%=i_cus_val %>" style="vertical-align: middle;"/>&nbsp;Seconds
    </div>
                        </div><div class="col1-3 lastcol">
                            <div class="mark_blue bt-space10">
                                <ul class="standard clean-padding bt-space10">
                                    <li class="bt-space5">Per-user sender throttling has higher priority.</li>
                                  
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
            
            <%} %>
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
    
<%}

 %>
         
         
  </body>
</html>
