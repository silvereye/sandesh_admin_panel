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



<link type="text/css" href="/unifiedmail/dtpic/jquery.datepick.css" rel="stylesheet" />
<link href='css/jquery.iphone.toggle.css' rel='stylesheet' />
<script type="text/javascript" src="/unifiedmail/dtpic/jquery.min.js"></script>
<script type="text/javascript" src="/unifiedmail/dtpic/jquery.datepick.js"></script>
<script type="text/javascript">

$.noConflict();
jQuery(document).ready(function($) {


$(function() {
$('#popupDatepicker').datepick({dateFormat: 'yyyy-mm-dd'});
	$('#popupDatepicker').datepick();
	//$('#inlineDatepicker').datepick({onSelect: showDate});
});

});

function showDate(date) {
	alert('The date chosen is ' + date);
}
</script>
    
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/reset.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/screen.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/fancybox.css" />

    <!--[if IE 7]>
        <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/ie7.css">
    <![endif]-->

	
	<script src="/unifiedmail/js/jquery.min.js"></script>
		<link href='https://fonts.googleapis.com/css?family=Vollkorn' rel='stylesheet' type='text/css' />		
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
var np=document.getElementById('password').value;
var cnp=document.getElementById('cnp').value;
if(np==null || np=="")
{
return true;
}
if(np!=cnp)
{
alert("Password is not match.");
return false;
}
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
   String dn=request.getParameter("dm");
   
  if( dn!=null && !(dn.equals("")) )
   {
   				
                


%>  
  
    
    
   
   
    <%@include file="header.jsp" %>

 
    
    

    <div class="main pagesize"> <!-- *** mainpage layout *** -->
        <div class="main-wrap">
        
        
        
        <div class="sublev-nav">	
   	<ul>
   		<li><a href="/unifiedmail/global/domainlist.jsp">All Domains</a></li>
<li><a href="/unifiedmail/global/editdomainprofile.jsp?dn=<%=dn %>"><%=dn %></a></li>
<li><a class="active-subs" href="/unifiedmail/global/userslist.jsp?dm=<%=dn %>">Users</a></li>
<li><a href="/unifiedmail/global/maillistslist.jsp?dm=<%=dn %>">Mail Lists</a></li>
<li><a href="/unifiedmail/global/mailaliaseslist.jsp?dm=<%=dn %>">Mail Aliases</a></li>
   	</ul>
   	<div class="clr"></div>
   	</div>
        
        
            <div class="page clear">
                
                



    


    


<div class="content-box">
    <div class="box-body">
        <div class="box-header clear">
               


                <h2>Edit Common Field</h2>
            </div>

        <div class="box-wrap clear">
           <form id="register" action="/unifiedmail/servlet/EditCommonFieldUserServlet" name="f" method="post" onsubmit="return valData()">
   
    
                            	
              <input type="hidden" name="hid_dn" value="<%=dn %>" />  
              
              <%
              String mls="";
              String mail[] = request.getParameterValues("CheckboxGroup1");
		   if (mail != null) 
		   {
		      for (int i = 0; i < mail.length; i++) 
		      {
		    	  if(mls.equals(""))
		    	  {
		    	  mls=mail[i];
		    	  }
		    	  else
		    	  {
		    	  mls=mls+","+mail[i];
		    	  }
		      }
		   }
               %>
              
         <input type="hidden" name="hid_mls" value="<%=mls %>" />           
        <div class="columns clear">
            <div class="col3-4">
                
                
          
    
     <div class="form-field clear">
        <h4 class="size-250 fl-space">New password </h4>
        <span class="clean-padding"><input name="np" id="password"  type="password"  onblur="setNCP()" size="35" title="" class="text" /></span>
   		 <input type="hidden" id="hid_ps" name="hid_ps" value="0" />
   		  <div class="ermsg" style="clear: both;float: left; padding: 3px 0 0 250px; width: 427px;" id="result"></div>
</div>


        <div class="form-field clear">
            <h4 class="size-250 fl-space">Confirm new password </h4>
            <span class="clean-padding"><input name="cnp" id="cnp"  type="password"  onblur="checkNCP(this.value)" size="35" title="" class="text" /></span>
        	
        </div>
   
    
                       <div style="clear: both;float: left; padding: 3px 0 0 255px;width: 427px;" id="cnp_msg1"></div> 
    
    
        
    
            </div>

             <div class="col1-4 lastcol">
                        <div class="mark_blue bt-space10">
        <h4>Need a random password?</h4>
        <p class="clean-padding clean-padding bt-space10">
        <input type="checkbox" id="setpass" value="1" name="setpass" onclick="setPath(this.id)"/>
<%Random ran=new Random();
        int rno=ran.nextInt(100000);
        int dg=rno%10;
        String x = Integer.toString(rno);
        char c1=(char)(70+dg);
        char c2=(char)(110+dg);
x = x.substring(0, 1) + c1+(char)(80+dg) + x.substring(1, x.length());
x = x.substring(0, x.length()-1) + c2 + x.substring(x.length()-1, x.length());
         out.print(x); %>
         <input type="hidden" name="rpass" id="rpass" value="<%=x %>"/>
</p>
    </div>
                    </div>
        </div>

    



<div class="form-field clear">
        
            <h4 class="size-250 fl-space">Account Status</h4>
        

        <div class="form-checkbox-item clear fl-space2">
         
                                <input name="acc" checked="checked" type="checkbox" value="active" class="checkbox" />
                              
             </div>
    </div>

      
      
      
    <div class="form-field clear">
         
            <h4 class="size-250 fl-space">FTP Status</h4>
        

        <div class="form-checkbox-item clear fl-space2">
        
                                <input name="ftp" checked="checked" type="checkbox" value="enabled" class="checkbox" />
                               
             </div>
    </div>
    
    <div class="form-field clear">
        
            <h4 class="size-250 fl-space">Create Profile</h4>
        

        <span class="clean-padding bt-space20">
            
        <select name="cprofile">
        						<option value="index">Select</option>
                            	<option value="TRUE">Enable</option>
                            	<option value="FALSE">Disable</option>
                            	</select>  
        </span>
    </div>
                
                
                <div class="form-field clear">
        <h4 class="size-250 fl-space">Expiry date</h4>
        <span class="clean-padding bt-space20"><input id="popupDatepicker" placeholder="yyyy-MM-dd"  name="edt"  type="text" value="" size="35" class="text" /></span>
        
    </div>
<div class="form-field clear">
        
            <h4 class="size-250 fl-space">Change Password at Next Logon	</h4>
        

        <span class="clean-padding bt-space20">
            
        <select name="fpc">
        						<option value="index">Select</option>
                            	<option value="TRUE">Enable</option>
                            	<option value="FALSE">Disable</option>
                            	</select>  
        </span>
    </div>
                
    <div class="form-field clear">
    
        <h4 class="size-250 fl-space">Preferred language</h4>
    
    <select name="prelang">
        
            <option value="ru_RU" >Ð ÑÑÑÐºÐ¸Ð¹</option>
        
            <option value="zh_TW" >ç¹é«ä¸­æ</option>
        
            <option value="pt_BR" >Portuguese (Brazilian)</option>
        
            <option value="fr_FR">FranÃ§ais</option>
        
            <option value="zh_CN" >ç®ä½ä¸­æ</option>
        
            <option value="fi_FI" >Finnish (Suomi)</option>
        
            <option value="ko_KR" >Korean</option>
        
            <option value="it_IT" >Italiano</option>
        
            <option value="cs_CZ" >ÄeÅ¡tina</option>
        
            <option value="nl_NL" >Netherlands</option>
        
            <option value="sr_LT" >Serbian (Latin)</option>
        
            <option value="en_US" selected="selected" >English (US)</option>
        
            <option value="de_DE" >Deutsch (Deutsch)</option>
        
            <option value="es_ES" >EspaÃ±ol</option>
        
            <option value="pl_PL" >Polski</option>
        
            <option value="sl_SI" >Slovenian</option>
        
    </select>
</div>

                <div class="bt-space10"></div>

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