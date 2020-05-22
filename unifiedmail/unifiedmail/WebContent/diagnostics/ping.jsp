<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">

    <noscript><meta http-equiv="refresh" content="0; URL=/unifiedmail/error/nojavascritp3.jsp"></noscript>
    <title>ping | Silvereye Unified E-mail Server</title>
 
  
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/reset.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/screen.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/fancybox.css" />
<script type="text/javascript">
function isNum1(val)
{
if(val=="")
{}
else
{
var numbers = /^[0-9]+$/;  
if(val.match(numbers))
{
if(val<1 || val>223)
{
alert("Value should be 1 to 223");
val = val.substring(0, val.length - 1)
document.f.ip1.value=val;
}
}
else
{
alert("Value should be numeric...!");
val = val.substring(0, val.length - 1)
document.f.ip1.value=val;

}
document.getElementById("div1").innerHTML=""; 
}
}

function isNum11(val)
{
if(val>123)
{
alert("Value should be 1 to 223");
document.f.ip1.value="123";
}

}




function isNum2(val)
{
if(val=="")
{}
else
{
var numbers = /^[0-9]+$/;  
if(val.match(numbers))
{
if(val<0 || val>255)
{
alert("Value should be 0 to 255");
val = val.substring(0, val.length - 1)
document.f.ip2.value=val;
}
}
else
{
alert("Value should be numeric...!");
val = val.substring(0, val.length - 1)
document.f.ip2.value=val;

}
document.getElementById("div1").innerHTML=""; 
}
}

function isNum22(val)
{
if(val>255)
{
alert("Value should be 0 to 255");
document.f.ip2.value="255";
}



}


function isNum3(val)
{
if(val=="")
{}
else
{
var numbers = /^[0-9]+$/;  
if(val.match(numbers))
{
if(val<0 || val>255)
{
alert("Value should be 0 to 255");
val = val.substring(0, val.length - 1)
document.f.ip3.value=val;
}
}
else
{
alert("Value should be numeric...!");
val = val.substring(0, val.length - 1)
document.f.ip3.value=val;

}
document.getElementById("div1").innerHTML=""; 
}
}

function isNum33(val)
{
if(val>255)
{
alert("Value should be 0 to 255");
document.f.ip3.value="255";
}

}




function isNum4(val)
{
if(val=="")
{}
else
{
var numbers = /^[0-9]+$/;  
if(val.match(numbers))
{
if(val<0 || val>255)
{
alert("Value should be 0 to 255");
val = val.substring(0, val.length - 1)
document.f.ip4.value=val;
}
}
else
{
alert("Value should be numeric...!");
val = val.substring(0, val.length - 1)
document.f.ip4.value=val;

}
document.getElementById("div1").innerHTML=""; 
}
}

function isNum44(val)
{
if(val>255)
{
alert("Value should be 0 to 255");
document.f.ip4.value="255";
}

}



</script>
<script type="text/javascript">
function ping()
{
if(document.f.ip1.value=="" || document.f.ip2.value=="" || document.f.ip3.value=="" || document.f.ip4.value=="")
{
alert("Plz. fill the value of Host.");
}
else
{
var ip=document.f.ip1.value+"."+document.f.ip2.value+"."+document.f.ip3.value+"."+document.f.ip4.value;
var e = document.getElementById("cnt");
   var cnt = e.options[e.selectedIndex].value;
 //  alert(ip+"      "+cnt);
   
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
      //alert(xmlhttp.readyState);
    if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
 
   var vall=xmlhttp.responseText;
     // alert(vall);
   
    	document.getElementById("div1").innerHTML = vall; 
    }
    }
    xmlhttp.open("GET","/unifiedmail/servlet/PingServlet?ip="+ip+"&cnt="+cnt,true);
  
    xmlhttp.send();
      
 }  
}

</script>



 <link media="screen" href="/unifiedmail/wait_jquery/jquery.msg.css" rel="stylesheet" type="text/css">
     <script type="text/javascript" src="/unifiedmail/wait_jquery/jquery_min.js"></script>
    <script type="text/javascript" src="/unifiedmail/wait_jquery/jquery.center.min.js"></script>
    <script type="text/javascript" src="/unifiedmail/wait_jquery/jquery.msg.min.js"></script>
    <script type="text/javascript" charset="utf-8">
      // wrap everything in document ready event
      $( function(){
        
        $( '#bt1' ).bind( 'click', function(){
        if(document.f.ip1.value=="" || document.f.ip2.value=="" || document.f.ip3.value=="" || document.f.ip4.value=="")
		{
		}
		else
		{
		$.noConflict();
          $.msg();
          }
        });
    
                 
      });
      
    </script>
  </head>
  
<body >
<%
 HttpSession ses=request.getSession(false);
 String chid= (String)ses.getAttribute("id");
 if(chid==null)
{
System.out.println("hii dgfgf");
%>
<script type="text/javascript">
	window.open("/unifiedmail/login/login.jsp?val=ses", "_self", false);
	</script>
<%
}
else
{
 %>
	
<%@include file="/global/header.jsp" %>



<div class="main pagesize"> <!-- *** mainpage layout *** -->
        <div class="main-wrap">
             <%
           
String utp=(String)ses.getAttribute("user_name");
          if(ses!=null && !(utp.equalsIgnoreCase("Admin")))
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
        
            
            <div class="page clear">
                



    <div class="content-box">
        <div class="box-body">
            <div class="box-header clear">
                

                <h2>
                   Ping
                </h2>
            </div>

            <div id="maillist_add" class="box-wrap clear">
   <form name="f"  id="register" method="post" action="" >    
    

        <div class="form-field clear">
            <h4 class="size-250 fl-space">Host<span class="required">*</span></h4>
            <span class="clean-padding">
                  
                               <input name="ip1" required type="text" style="width: 40px;" class="text fl-space" onblur="isNum11(this.value)" onkeyup="isNum1(this.value)" />
                              <input name="ip2" required type="text" style="width: 40px;" class="text fl-space"  onblur="isNum22(this.value)" onkeyup="isNum2(this.value)" />
                              <input name="ip3" required type="text" style="width: 40px;" class="text fl-space"  onblur="isNum33(this.value)" onkeyup="isNum3(this.value)" />
                              <input name="ip4" required type="text" style="width: 40px;" class="text fl-space"  onblur="isNum44(this.value)" onkeyup="isNum4(this.value)" />
                           
            </span>
            <div class="ermsg" id="sp1"></div>
        </div>

      

<div class="form-field clear">
        
            <h4 class="size-250 fl-space">Count	</h4>
        

        <span class="clean-padding bt-space20">
            
        <select id="cnt" name="conunt" style="width: 80px;">
                              <option value="3" selected="selected" >3</option>
                              <option value="4">4</option>
                              <option value="5">5</option>
                              <option value="6">6</option>
                              <option value="7">7</option>
                              <option value="8">8</option>
                              <option value="9">9</option>
                              <option value="10">10</option>
                            </select>
        </span>
    </div>
    
    
   

    
    <div class="form-field clear"><br/>
        <h4 class="size-250 fl-space">&nbsp;</h4>
        <span class="clean-padding bt-space20">
           
            <input id="bt1" name="btn3"  type="button" class="button green" value="Ping" onclick="ping()"/>
        </span>
    </div>
    <div class="rule2"></div>
<div id="div1"></div>
    </form>
    </div>
</div>
</div>



            </div>
            <%
            }
             %>
        </div>
    </div>


<%@include file="/global/footer.jsp" %>

<%} %>	
	
	
</body>
</html>
