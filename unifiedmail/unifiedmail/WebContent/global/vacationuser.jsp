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
 <noscript><meta http-equiv="refresh" content="0; URL=/unifiedmail/error/nojavascritp2.jsp"></noscript>

    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/reset.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/screen.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/fancybox.css" />

    <!--[if IE 7]>
        <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/ie7.css">
    <![endif]-->

	
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
		<link href='http://fonts.googleapis.com/css?family=Vollkorn' rel='stylesheet' type='text/css' />		
   <script type="text/javascript">
   $(document).ready(function() {

	$('#password').keyup(function(){
		$('#result').html(checkStrength($('#password').val()))
	})	
	
	function checkStrength(password){
    
	//initial strength
    var strength = 0
	
    //if the password length is less than 6, return message.
    if (password.length < 6) { 
		$('#result').removeClass()
		$('#result').addClass('short')
		document.getElementById("hid_ps").value="0";
		return 'Too short' 
	}
    
    //length is ok, lets continue.
	
	//if length is 8 characters or more, increase strength value
	if (password.length > 7) strength += 1
	
	//if password contains both lower and uppercase characters, increase strength value
	if (password.match(/([a-z].*[A-Z])|([A-Z].*[a-z])/))  strength += 1
	
	//if it has numbers and characters, increase strength value
	if (password.match(/([a-zA-Z])/) && password.match(/([0-9])/))  strength += 1 
	
	//if it has one special character, increase strength value
    if (password.match(/([!,%,&,@,#,$,^,*,?,_,~])/))  strength += 1
	
	//if it has two special characters, increase strength value
    if (password.match(/(.*[!,%,&,@,#,$,^,*,?,_,~].*[!,%,&,@,#,$,^,*,?,_,~])/)) strength += 1
	
	//now we have calculated strength value, we can return messages
	
	//if value is less than 2
	if (strength < 2 ) {
		$('#result').removeClass()
		$('#result').addClass('weak')
		document.getElementById("hid_ps").value="0";
		return 'Weak'			
	} else if (strength == 2 ) {
		$('#result').removeClass()
		$('#result').addClass('good')
		document.getElementById("hid_ps").value="1";
		return 'Good'		
	} else {
		$('#result').removeClass()
		$('#result').addClass('strong')
		document.getElementById("hid_ps").value="2";
		return 'Strong'
	}
}
});
   </script>
   <style type="text/css">
   
#result{
	margin-left:5px;
}

#register .short{
	color:#FF0000;
}

#register .weak{
	color:#E66C2C;
}

#register .good{
	color:#2D98F3;
}

#register .strong{
	color:#006400;
}
   </style>
   
	
	
	
	
	
<link rel="stylesheet" href="/unifiedmail/css/tooltip.css" type="text/css" />
<link rel="stylesheet" href="/unifiedmail/css/style.css" type="text/css" />
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
var no=document.getElementById('hid_ps').value;
  if(parseInt(no)<1) {
    alert('Password must be Good or Strong.');

    return false;
    }
return true;

}




function setNCP() {
	document.getElementById("cnp").value="";
	document.getElementById("cnp_msg").innerHTML="";
}


function checkNCP(val) {
	if(val!="")
	{
	var val1=document.getElementById("password").value;
	if(val==val1)
	{
      document.getElementById("cnp_msg1").innerHTML = "<font color='green'>Confirm password is matched..</font>";
	 }
	 else
	 {
	 document.getElementById("cnp_msg1").innerHTML = "<font color='red'>Confirm password is not matched.</font>";
	document.getElementById("cnp").value="";
	 }
	 }
}

function setPath(val)
{

var chk=document.getElementById(val).checked;
if(chk)
{
var ps=document.getElementById("rpass").value;
document.getElementById("password").value=ps;
document.getElementById("cnp").value=ps;
document.getElementById("hid_ps").value="2";
}
else
{
document.getElementById("password").value="";
document.getElementById("cnp").value="";
document.getElementById("hid_ps").value="0";
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
                


%>  
  
    
    
   
   
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
                       <li><a href="/unifiedmail/global/throttlinguser.jsp?ml=<%=mail %>">Throttling</a></li>
                        <li><a href="/unifiedmail/global/whiteblistuser.jsp?ml=<%=mail %>">White/Blacklist</a></li>
                        <li ><a href="/unifiedmail/global/passworduser.jsp?ml=<%=mail %>">Password</a></li>
                        <li  class="active"><a href="/unifiedmail/global/vacationuser.jsp?ml=<%=mail %>">Vacation</a></li>
                        <li ><a href="/unifiedmail/global/filteruser.jsp?ml=<%=mail %>">Filter</a></li>
                        <li><a href="/unifiedmail/global/advanceuser.jsp?ml=<%=mail %>">Advanced</a></li>
                        
                        </ul>


                <h2>Profile of user: <%=mail %> <a href="/unifiedmail/global/usersentmails.jsp?ml=<%=mail %>">
            <img src="/unifiedmail/images/graph_16.png"
                
                    title="Account activities"
                

                
                    style="padding-left: 5px;" class="vcenter"
                
            />
        </a></h2>
            </div>

        <div class="box-wrap clear">
           <form id="register" action="/unifiedmail/servlet/EditPasswordUserProfileServlet" name="f" method="post" onsubmit="return valData()">
   
    
                            	<input type="hidden" name="hid_mail" value="<%=mail %>" />
             
        <div class="columns clear">
            <div class="col3-4">
                
                
          
    
     <div class="form-field clear">
        <h4 class="size-250 fl-space">Comming Soon...</span></h4>
       
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