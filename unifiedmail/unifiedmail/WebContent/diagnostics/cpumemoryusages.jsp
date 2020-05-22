<%@ page language="java" import="java.util.*,java.io.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">

    <noscript><meta http-equiv="refresh" content="0; URL=/unifiedmail/error/nojavascritp3.jsp"></noscript>
    <title>CPU Memory usages| Silvereye Unified E-mail Server</title>
 
  
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/reset.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/screen.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/fancybox.css" />
<script type='text/javascript' src='https://www.google.com/jsapi'></script>
    <script type='text/javascript'>
      google.load('visualization', '1', {packages:['gauge']});
      google.setOnLoadCallback(drawChart);
      function drawChart() {
       var mem=parseInt(document.getElementById("mem").value);
     //  alert(mem);
       var smem=parseInt(document.getElementById("smem").value);
        
       var nm=parseFloat(document.getElementById("cpu").value);
     //  alert(nm);
        var nm1=100-nm;
     //   alert(nm1);
       var cp=nm1.toFixed(2); 
      
     //  alert(cp);
      
        var data = google.visualization.arrayToDataTable([
          ['Label', 'Value'],
          ['Memory', mem],
           ['Swap Memory', smem],
          ['CPU', cp],
          ]);

        var options = {
          width: 960, height: 420,
          redFrom: 90, redTo: 100,
          yellowFrom:75, yellowTo: 90,
		  greenFrom:60, greenTo: 75,
          minorTicks: 5
        };

        var chart = new google.visualization.Gauge(document.getElementById('chart_div'));
        chart.draw(data, options);
        
        setTimeout(cpuval(),2000);
      }
     
     
     function cpuval()
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
 
   vall=xmlhttp.responseText;
   var arr=vall.split("-");
   //alert(vall);
  document.getElementById("cpu").value = arr[0]; 
  document.getElementById("mem").value = arr[1]; 
  document.getElementById("smem").value = arr[2]; 
  setTimeout(drawChart(),2000);
    }
    }
    xmlhttp.open("GET","/unifiedmail/servlet/UPSServlet",true);
   //var xx=document.f.chk.value;
   //alert(xx);
    xmlhttp.send();
  
     
     } 
  
    </script>
    
    <script type="text/javascript">

/*
function reFresh() {
  location.reload(true)
}

window.setInterval("reFresh()",10000);*/

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
                   Memory and CPU usages
                </h2>
            </div>

            <div id="maillist_add" class="box-wrap clear">
   <form name="f"  id="register" method="post" action="" >    
    

        
  
   <%
  if(true)
  {
  Process p = Runtime.getRuntime().exec("sudo mpstat");  	
		BufferedReader stdInput = new BufferedReader(new InputStreamReader(p.getInputStream()));
		String s="";
		while ((s = stdInput.readLine()) != null) 
		{
		    //  out.println("<br>"+s);
		   if(s.indexOf("all")>=0)
		       {
		       break;
		       }		        
		}
  s=s.trim();
  String arr[]=s.split(" ");
  String cpu=arr[arr.length-1];
  //out.println(cpu);
   %>
  
  <input type="hidden" name="cpu" id="cpu" value="<%=cpu %>"/>
  
  <%}
  if(true)
  {
   Process	p = Runtime.getRuntime().exec("cat /proc/meminfo"); 	
		BufferedReader stdInput = new BufferedReader(new InputStreamReader(p.getInputStream()));
		//String s="User quota STORAGE 0 4194304 0";
		String s="";
	String tmem="";
	String fmem="";
	
		while ((s = stdInput.readLine()) != null) 
		{
		//out.print("<br>"+s);
		if(s.indexOf("MemTotal")>-1)
		{
		String arr[]=s.split(":");
		arr[1]=arr[1].trim();
		String arr1[]=arr[1].split(" ");
		tmem=arr1[0].trim();
		}
		if(s.indexOf("MemFree")>-1)
		{
		String arr[]=s.split(":");
		arr[1]=arr[1].trim();
		String arr1[]=arr[1].split(" ");
		fmem=arr1[0].trim();
		}
		
		}
	int t=Integer.parseInt(tmem);
	int f=Integer.parseInt(fmem);	
	int u=t-f;
	
	double per=(u*100.0)/t;
   %>
   <input type="hidden" name="mem" id="mem" value="<%=per %>"/>
   <%}
   if(true)
   {
    Process	p = Runtime.getRuntime().exec("cat /proc/meminfo"); 	
		BufferedReader stdInput = new BufferedReader(new InputStreamReader(p.getInputStream()));
		//String s="User quota STORAGE 0 4194304 0";
		String s="";
	String tswp="";
	String fswp="";
		while ((s = stdInput.readLine()) != null) 
		{
		//out.print("<br>"+s);
		if(s.indexOf("SwapTotal")>-1)
		{
		String arr[]=s.split(":");
		arr[1]=arr[1].trim();
		String arr1[]=arr[1].split(" ");
		tswp=arr1[0].trim();
		}
		if(s.indexOf("SwapFree")>-1)
		{
		String arr[]=s.split(":");
		arr[1]=arr[1].trim();
		String arr1[]=arr[1].split(" ");
		fswp=arr1[0].trim();
		}
		
		}
	int t=Integer.parseInt(tswp);
	int f=Integer.parseInt(fswp);	
	int u=t-f;
	double per=(u*100.0)/t;
    %>
    <input type="hidden" name="smem" id="smem" value="<%=per %>"/>
    <%} %>

    
   <div id='chart_div'></div>
 
    </form>
    </div>
</div>
</div>



            </div>
            <%} %>
        </div>
    </div>


<%@include file="/global/footer.jsp" %>

	
	
	<%} %>
</body>
</html>
