<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
     <title>Add Domain | Silvereye Unified E-mail Server</title>
 <noscript><meta http-equiv="refresh" content="0; URL=/unifiedmail/error/nojavascritp1.jsp"></noscript>
    
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/reset.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/screen.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/fancybox.css" />

    <!--[if IE 7]>
        <link rel="stylesheet" type="text/css" href="/unifiedmail/iredcss/ie7.css">
    <![endif]-->

    <link rel="stylesheet" href="/unifiedmail/css/tooltip.css" type="text/css" />
<script type="text/javascript">
function removeMsg(id)
{
var element = document.getElementById(id);
element.parentNode.removeChild(element);
//alert(id);
}

</script>
<script type="text/javascript">
function chkDom(val)
{
if(val!=null && val!="")
{
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
     //alert(vall);
     if(vall=="0")
     {
      document.getElementById("sp1").innerHTML = "<font color='green'>Domain Name is correct.</font>";
	 }
	 else if(vall=="1")
	 {
	 document.getElementById("sp1").innerHTML = "<font color='red'>Domain Name is already exist.</font>";
	 document.getElementById("dn").value="";
	 }
	 else
	 {
	  document.getElementById("sp1").innerHTML =vall;
	 }
	 
    }
    }
    xmlhttp.open("GET","/unifiedmail/servlet/CheckDomainServlet?dom="+val,true);
   //var xx=document.f.chk.value;
   //alert(xx);
    xmlhttp.send();
    }
    else
    {
	  document.getElementById("sp1").innerHTML ="";

    }
}


function isNum(val,nm,no)
{
if(isNaN(val)===true){
   document.getElementById("sp"+no).innerHTML ="<font color='red'>please input only numeric!</font>";
  document.getElementById(nm).value="";
 
}
else
{
 document.getElementById("sp"+no).innerHTML ="";
}
}


</script>



<script type="text/javascript">

function valData()
{

var nname=document.getElementById("dn").value;
 
var arr = new Array(
'.com','.net','.org','.biz','.coop','.info','.museum','.name',
'.pro','.edu','.gov','.int','.mil','.ac','.ad','.ae','.af','.ag',
'.ai','.al','.am','.an','.ao','.aq','.ar','.as','.at','.au','.aw',
'.az','.ba','.bb','.bd','.be','.bf','.bg','.bh','.bi','.bj','.bm',
'.bn','.bo','.br','.bs','.bt','.bv','.bw','.by','.bz','.ca','.cc',
'.cd','.cf','.cg','.ch','.ci','.ck','.cl','.cm','.cn','.co','.cr',
'.cu','.cv','.cx','.cy','.cz','.de','.dj','.dk','.dm','.do','.dz',
'.ec','.ee','.eg','.eh','.er','.es','.et','.fi','.fj','.fk','.fm',
'.fo','.fr','.ga','.gd','.ge','.gf','.gg','.gh','.gi','.gl','.gm',
'.gn','.gp','.gq','.gr','.gs','.gt','.gu','.gv','.gy','.hk','.hm',
'.hn','.hr','.ht','.hu','.id','.ie','.il','.im','.in','.io','.iq',
'.ir','.is','.it','.je','.jm','.jo','.jp','.ke','.kg','.kh','.ki',
'.km','.kn','.kp','.kr','.kw','.ky','.kz','.la','.lb','.lc','.li',
'.lk','.lr','.ls','.lt','.lu','.lv','.ly','.ma','.mc','.md','.mg',
'.mh','.mk','.ml','.mm','.mn','.mo','.mp','.mq','.mr','.ms','.mt',
'.mu','.mv','.mw','.mx','.my','.mz','.na','.nc','.ne','.nf','.ng',
'.ni','.nl','.no','.np','.nr','.nu','.nz','.om','.pa','.pe','.pf',
'.pg','.ph','.pk','.pl','.pm','.pn','.pr','.ps','.pt','.pw','.py',
'.qa','.re','.ro','.rw','.ru','.sa','.sb','.sc','.sd','.se','.sg',
'.sh','.si','.sj','.sk','.sl','.sm','.sn','.so','.sr','.st','.sv',
'.sy','.sz','.tc','.td','.tf','.tg','.th','.tj','.tk','.tm','.tn',
'.to','.tp','.tr','.tt','.tv','.tw','.tz','.ua','.ug','.uk','.um',
'.us','.uy','.uz','.va','.vc','.ve','.vg','.vi','.vn','.vu','.ws',
'.wf','.ye','.yt','.yu','.za','.zm','.zw');

var mai = nname;
var val = true;

var dot = mai.lastIndexOf(".");
var dname = mai.substring(0,dot);
var ext = mai.substring(dot,mai.length);
//alert(ext);
	
if(dot>2 && dot<57)
{
	/*for(var i=0; i<arr.length; i++)
	{
	  if(ext == arr[i])
	  {
	 	val = true;
		break;
	  }	
	  else
	  {
	 	val = false;
	  }
	}
	if(val == false)
	{
	  	 alert("Your domain extension "+ext+" is not correct");
		 return false;
	}
	else*/
	{
		for(var j=0; j<dname.length; j++)
		{
		  var dh = dname.charAt(j);
		  var hh = dh.charCodeAt(0);
		  if((hh > 47 && hh<59) || (hh > 64 && hh<91) || (hh > 96 && hh<123) || hh==45 || hh==46)
		  {
			 if((j==0 || j==dname.length-1) && hh == 45)	
		  	 {
		 	  	 alert("Domain name should not begin are end with '-'");
			      return false;
		 	 }
		  }
		else	{
		  	 alert("Your domain name should not have special characters");
			 return false;
		  }
		}
	}
}
else
{
 alert("Your Domain name is too short/long");
 return false;
}	

return true;
}


function setPath(val)
{

var chk=document.getElementById(val).checked;
if(chk)
{
var ps=document.getElementById("rpass").value;
document.getElementById("admin_pass").value=ps;
document.getElementById("post_pass").value=ps;
//document.getElementById("hid_ps").value="2";
}
else
{
document.getElementById("admin_pass").value="";
document.getElementById("post_pass").value="";
//document.getElementById("hid_ps").value="0";
}
}

</script>



    
</head>

<body>
  
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
                            
      <%@include file="header.jsp" %>

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
                
                
  <%
    String stt=request.getParameter("status");
    if(stt!=null && stt.equalsIgnoreCase("succ"))
    {  
    String dn= request.getParameter("nm"); 
     %>
      <div class='notification note-success'><a href='#' class='close'></a>
<p><%=dn %> domain has been added successfully. To edit this Domain click <a href="/unifiedmail/global/editdomainprofile.jsp?dn=<%=dn %>"><%=dn %></a></p>
<p>postmaster@<%=dn %> account has been created successfully. To edit Postmaster click <a href="/unifiedmail/global/edituserprofile.jsp?ml=postmaster@<%=dn %>">postmaster@<%=dn %></a></p> 
<p>mail-admin@<%=dn %> domain admin account has been created successfully. To edit Domain Admin click <a href="/unifiedmail/global/editdomainadminprofile.jsp?ml=mail-admin@<%=dn %>">mail-admin@<%=dn %></a></p>  
</div>
      <%}
      else if(stt!=null && stt.equalsIgnoreCase("error"))
      {
       %>
                 <div id="msg_err" class="notification note-error"><a href='#' class='close'></a>
                 <p>Domain addition has been failed.	</p>
                 </div>
    
    
    <%} %>



    <div class="content-box">
        <div class="box-body">
            <div class="box-header clear">
                <h2>Add domain</h2>
            </div>

            <div id="domain_add" class="box-wrap clear">
        
      <form name="f_add_dom" method="post" action="/unifiedmail/servlet/AddDomainServlet" onsubmit="return valData()">

            
        
    <div class="columns clear">
                        <div class="col3-4">

 
            <div class="form-field clear">
        <h4 class="size-250 fl-space">Domain Name <span class="required">*</span></h4>
        <span class="clean-padding bt-space20">
            <input type="text" name="dn" id="dn" required value="" size="35" class="text" placeholder="Ex. silvereye.co"  onblur="chkDom(this.value)" />
        </span>
        <div class="ermsg" id="sp1"></div>
    </div>
            

    <div class="form-field clear">
        
            <h4 class="size-250 fl-space">Company/Organization Name<span class="required">*</span></h4>
        

        <span class="clean-padding bt-space20">
            <input type="text" name="cn" value="" required size="35" class="text"  />
        </span>
    </div>
<div class="form-field clear">
        <h4 class="size-250 fl-space">FTP Facility</h4>
        <span class="clean-padding">
     <input name="ftpdom"  type="checkbox" value="TRUE" />
           </span>
       
    </div>  
   
            
    <div class="form-field clear">
        <h4 class="size-250 fl-space">Domain quota size<span class="required">*</span></h4>
        <span class="clean-padding">
            <input type="text" name="mq" required id="mq" size="8" value="" class="text fl-space" onblur="isNum(this.value,this.name,'3')"/><label>GB</label>
        </span>
         <div id="sp3" class="ermsg"></div>
    </div>

            <div class="form-field clear">
    
        <h4 class="size-250 fl-space">Default language<span class="required">*</span></h4>
    
     <select name="prelang">
         <option value="ru_RU" >Ð ÑÑÑÐºÐ¸Ð¹</option>
        
            <option value="zh_TW" >ç¹é«ä¸­æ</option>
        
            <option value="pt_BR" >Portuguese (Brazilian)</option>
        
            <option value="fr_FR" >FranÃ§ais</option>
        
            <option value="zh_CN" >ç®ä½ä¸­æ</option>
        
            <option value="fi_FI" >Finnish (Suomi)</option>
        
            <option value="ko_KR" >Korean</option>
        
            <option value="it_IT" >Italiano</option>
        
            <option value="cs_CZ" >ÄeÅ¡tina</option>
        
            <option value="nl_NL" >Netherlands</option>
        
            <option value="sr_LT" >Serbian (Latin)</option>
        
            <option value="en_US" selected="selected">English (US)</option>
        
            <option value="de_DE" >Deutsch (Deutsch)</option>
        
            <option value="es_ES" >EspaÃ±ol</option>
        
            <option value="pl_PL" >Polski</option>
        
            <option value="sl_SI" >Slovenian</option>
        
    </select>
 
                               <div class="clr"></div>
                            
                               
                            	</div>
                            	
                            	
                            	
                            	 <div class="form-field clear">
        <h4 class="size-250 fl-space">Password of Postmaster<span class="required">*</span></h4>
        <span class="clean-padding">
            <input type="password" name="post_pass" required id="post_pass" size="35" value="" class="text fl-space" />
        </span>
         <div id="sp3" class="ermsg"></div>
    </div>
    
    
     <div class="form-field clear">
        <h4 class="size-250 fl-space">Password of Domain Admin<span class="required">*</span></h4>
        <span class="clean-padding">
            <input type="password" name="admin_pass" required id="admin_pass" size="35" value="" class="text fl-space" />
        </span>
         <div id="sp3" class="ermsg"></div>
    </div>
        
        
        
        <div class="form-field clear">
        <h4 class="size-250 fl-space">Directory of mailbox storage<span class="required">*</span></h4>
        <span class="clean-padding">
            <input type="text" name="dir" required id="dir" size="35" value="/maildir/domains/" class="text fl-space" />
        </span>
         <div id="sp4" class="ermsg"></div>
    </div>
        
                              
            
            </div>
             <div class="col1-4 lastcol">
                        <div class="mark_blue bt-space10">
        <h4>Domain Name</h4>
        <p class="clean-padding clean-padding bt-space10">It contains only [a to z] [0 to 9]<br/> [- and .] characters.</p>
   
        <h4>Domain quota size</h4>
        <p class="clean-padding clean-padding bt-space10">Set value to 0 for unlimited quota size.</p>
   </div>
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
            
            
            
            
                                
                              	
                            <div class="rule2"></div>
    <div class="form-field clear">
        <h4 class="size-250 fl-space">&nbsp;</h4>
        <span>
            <input type="submit" value="Add" class="button green" />
        </span>
    </div>
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








 <%@include file="footer.jsp" %>

  <%} %>
    
</body>
</html>