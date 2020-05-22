<%@ page language="java" import="java.util.*,java.sql.*,dbutil.*"  pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
    <title> Mails Report | Silvereye Unified E-mail Server</title>
 <noscript><meta http-equiv="refresh" content="0; URL=/unifiedmail/error/nojavascritp.jsp"></noscript>

    
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/reset.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/screen.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/fancybox.css" />
<link rel="stylesheet" type="text/css" href="/unifiedmail/css/mytooltip.css" />

    <!--[if IE 7]>
        <link rel="stylesheet" type="text/css" href="/unifiedmail/css/ie7.css">
    <![endif]-->

    <script type="text/javascript">
function printDiv()
{
//alert("hi");
var divToPrint=document.getElementById('div1');
var newWin=window.open('','Print-Window','width=400,height=400,top=100,left=100');
newWin.document.open();
newWin.document.write('<html><head><style>#in {display:none}</style><body onload="window.print()">'+divToPrint.innerHTML+'</body></html>');
newWin.document.close();
//setTimeout(function(){newWin.close();},10);
}


function showData()
	{
	var cnt=document.getElementById("hidc").value;
	var v=document.getElementById("valtxt").value;
	//var id=document.getElementById("hid_id").value;
	//var ml=document.getElementById("hid_ml").value;
 //   var dt=document.f.hid.value;
var recip=(document.getElementById("recip").value).trim();
var send=(document.getElementById("send").value).trim();
var sub=(document.getElementById("sub").value).trim();
var year=(document.getElementById("year").value).trim();
var month=(document.getElementById("month").value).trim();
var day=(document.getElementById("day").value).trim();

var serchDT="";
var chk=false;
if(!send)
	{
	
	}
else
	{

	chk=true;
	}
	
if(!recip)
{

}
else
{

chk=true;
}

if(!sub)
{

}
else
{

chk=true;
}

if(!year)
{

}
else
{

chk=true;
}

if(!month)
{

}
else
{

chk=true;
}

if(!day)
{

}
else
{

chk=true;
}

if(chk)
	{
	if(day!="")
		{
		if(month==null || month=="" || year==null || year=="")
			{
			alert("Please Fill both field- YYYY and MM also");
			chk=false;
			}
		else
			{
			serchDT=year+month+day;
			}
		}
	else if(month!="")
		{
		if( year==null || year=="")
			{
			alert("Please Fill field- YYYY also");
			chk=false;
			}
		else
		{
		serchDT=year+month;
		}
		}
	if(serchDT=="" && year !="")
		{
			serchDT=year;
		}
	
	if(chk)
		{


		
		var vall=null;
		//var dt=document.f.dt.value;
		//var sel=document.f.filter.value;
	//alert(dt+" "+sel)
		
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
	   
	    	document.getElementById("div1").innerHTML = vall; 
	    }
	    }
	    xmlhttp.open("GET","/unifiedmail/global/advancemailsreportdata.jsp?val="+v+"&send="+send+"&recip="+recip+"&sub="+sub+"&serchDT="+serchDT+"&cnt="+cnt,true);
	   //var xx=document.f.chk.value;
	   //alert(xx);
	    xmlhttp.send(); 
		
		
		
		
		}
	
	}
else
	{
	alert("Please fill atleast on search pattern!")
	}
	//alert("hello="+v);
	
	//alert(v+"  "+dt);
	
    

	}

function start()
{
document.getElementById("valtxt").value="1";
//document.f.hid.value="start";
showData();
}

function lastOne()
{
var v=document.getElementById("valtxt").value;
var v1=document.getElementById("hidc").value;
var no=parseInt(v);
var no1=parseInt(v1);
//alert(no);
if(no1%45==0)
{
no1=parseInt(no1/15);
}
else
{
no1=parseInt(no1/15);
no1=no1+1;
}
if(no<no1)
{
no=no+1;
}
document.getElementById("valtxt").value=no;
//document.f.hid.value="mid";
showData();
}

function last()
{
var v=document.getElementById("hidc").value;
var no=parseInt(v);
//alert(no);
if(no%15==0)
{
no=parseInt(no/15);
}
else
{
no=parseInt(no/15);
no=no+1;
}
//alert(no);
document.getElementById("valtxt").value=no;
//document.f.hid.value="last";
showData();
}

function startOne()
{
var v=document.getElementById("valtxt").value;
//alert(v);


var no=parseInt(v);
if(no>1)
{
no=no-1;
}
document.getElementById("valtxt").value=no;
//document.f.hid.value="mid";
showData();
}

</script>
</head>

<body >
     <%@include file="header.jsp" %>
      
      <form name="search" method="post" action="">

    <div class="main pagesize"> <!-- *** mainpage layout *** -->
        <div class="main-wrap">
        
        <div class="sublev-nav" style="padding: 7px 0px 7px 7px;">	
  <strong> Sender:</strong><input type="text" id="send"/>
          
 <strong> Recipient:</strong><input type="text" id="recip"/>
  <strong> Subject:</strong><input type="text" id="sub"/>   
   <strong> Date:</strong><input type="text" style="width:40px;" placeholder="YYYY" id="year"/>  
   <input type="text" style="width:40px;"placeholder="MM" id="month"/>  <input type="text" id="day" style="width:40px;" placeholder="DD"/>  
   <input type="button" value="Search" class="button" onclick="showData()"/><br>
    Searching For Full Year use YYYY<br>
    Searching For Specific month use YYYY and MM<br>
    Searching For Specific Date use YYYY and MM and DD<br>
      

   
   	<div class="clr"></div>
   	</div>
        
        
        
            <div class="page clear">
                
                



<div class="content-box">
    <div class="box-body">
        
<div id="div1">
      <input type="hidden" id="hidc" name="hid_cnt" value="1"/>  
     <table width="100%" class="style1 tablesorter" cellspacing="0">
     <tr >
     <td width="">&nbsp;</td>
     <td width="" style="text-align: center;"><img  src="/unifiedmail/images/myload.GIF"/></td>
     <td width="">&nbsp;</td></tr>
     </table>       
        
    

    
       
</div>
        <div class="tab-footer clear f1">
            
                <div class="fl">
                    
                    <input type="button" value="Print" class="button fl-space" onclick="printDiv()"/>
                </div>
            

            
        
    

    
 
    
<%
String fst="<<";
String prv="<";
%>
    <div class="pager fr">
        <span class="pages">
           <input type="button" value="<%=fst %>" class="button fl-space" onclick="start()"/>
        
        </span>

<span class="pages">
        
           
            <input type="button" value="<%=prv %>" class="button fl-space" onclick="startOne()"/>
        
        </span>

        <span class="pages">
        
             <input type="button" id="valtxt" value="1" class="button fl-space" onclick="showData()"/>
           
               
        </span>
        <span class="pages">
        
            <input type="button" value=">" class="button fl-space" onclick="lastOne()"/>
        
        </span>
        
<span class="pages">
        
           
            <input type="button" value=">>" class="button fl-space" onclick="last()"/>
        
        </span>

    </div>
        </div>
<input type="hidden" name="hid" value="start"/>
   
</div></div>

            </div>
        </div>
    </div>
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

        
            $(".tablesorter").tablesorter(
                
                    { headers: {
                        
                            0: {sorter: false }
                        
                    }}
                
            );
        

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