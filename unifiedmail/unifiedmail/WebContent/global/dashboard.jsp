<%@ page language="java" import="java.util.*,mypack.*,java.text.*,dbutil.*,java.sql.*" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.regex.*" %>
<%@ page import="javax.naming.directory.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Dashboard | Silvereye Unified E-mail Server</title>
 <noscript><meta http-equiv="refresh" content="0; URL=/unifiedmail/error/nojavascritp2.jsp"></noscript>

    
<link rel="stylesheet" href="/unifiedmail/css/style.css" type="text/css" />

<script type="text/javascript">
function imgSen()
{
//alert("hi")

var no=document.getElementById("hid_sender").value;
if(no=='0')
{
document.getElementById("hid_sender").value='1';
document.getElementById("img_sen").src="/unifiedmail/images/sendrs_list.png";
}
else
{
document.getElementById("hid_sender").value='0';
document.getElementById("img_sen").src="/unifiedmail/images/senders-graff.png";
}
	var dstr=document.getElementById("hid_dstr").value;
	
	
	
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
     // alert(vall);
    	document.getElementById("div_sen").innerHTML = vall; 
    }
    }
    xmlhttp.open("GET","/unifiedmail/global/dashsenderdata.jsp?no="+no+"&dstr="+dstr,true);
   //var xx=document.f.chk.value;
   //alert(xx);
    xmlhttp.send();
}


function imgRec()
{
var no=document.getElementById("hid_receiver").value;
if(no=='0')
{
document.getElementById("hid_receiver").value='1';
document.getElementById("img_rec").src="/unifiedmail/images/sendrs_list.png";
}
else
{
document.getElementById("hid_receiver").value='0';
document.getElementById("img_rec").src="/unifiedmail/images/senders-graff.png";
}
	
	var dstr=document.getElementById("hid_dstr").value;	
	
	
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
     // alert(vall);
    	document.getElementById("div_rec").innerHTML = vall; 
    }
    }
    xmlhttp.open("GET","/unifiedmail/global/dashrecpdata.jsp?no="+no+"&dstr="+dstr,true);
   //var xx=document.f.chk.value;
   //alert(xx);
    xmlhttp.send();
}



function imgQuo()
{
var no=document.getElementById("hid_quota").value;
if(no=='0')
{
document.getElementById("hid_quota").value='1';
document.getElementById("img_quo").src="/unifiedmail/images/sendrs_list.png";
}
else
{
document.getElementById("hid_quota").value='0';
document.getElementById("img_quo").src="/unifiedmail/images/senders-graff.png";
}
	
	
var dstr=document.getElementById("hid_dstr").value;		
	
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
     // alert(vall);
    	document.getElementById("div_quo").innerHTML = vall; 
    }
    }
    xmlhttp.open("GET","/unifiedmail/global/dashquotadata.jsp?no="+no+"&dstr="+dstr,true);
   //var xx=document.f.chk.value;
   //alert(xx);
    xmlhttp.send();
}
</script>
<script type="text/javascript">

 function getSender() {
	var hid_dstr=$("#hid_dstr").val();
 var hid_lstdt=$("#hid_lstdt").val();
	$.ajax({
        type: "GET",
        url: "/unifiedmail/global/dashboard10sender.jsp",
        data: {'hid_dstr':hid_dstr, 'hid_lstdt': hid_lstdt },
        contentType: "application/json",
        success: function (data) {
          $("#div_sen").html(data);
        }
    });
}
 
 function getRecepient() {
	 var hid_dstr=$("#hid_dstr").val();
	 var hid_lstdt=$("#hid_lstdt").val();
		$.ajax({
	        type: "GET",
	        url: "/unifiedmail/global/dashboard10recepient.jsp",
	        data: {'hid_dstr':hid_dstr, 'hid_lstdt': hid_lstdt },
	        contentType: "application/json",
	        success: function (data) {
	          $("#div_rec").html(data);
	        }
	    });
 }
 
 function getLastday() {
	 var hid_dstr=$("#hid_dstr").val();
	 var hid_lstdt=$("#hid_lstdt").val();
		$.ajax({
	        type: "GET",
	        url: "/unifiedmail/global/dashboardlastday.jsp",
	        data: {'hid_dstr':hid_dstr, 'hid_lstdt': hid_lstdt },
	        contentType: "application/json",
	        success: function (data) {
	          $("#div_lstday").html(data);
	        }
	    });
 }
</script>


<script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <script type="text/javascript">
      google.load("visualization", "1", {packages:["corechart"]});
      google.setOnLoadCallback(drawChart);
      function drawChart() {
       var q1=parseInt(document.getElementById("hid_q1").value);
      var q2=parseInt(document.getElementById("hid_q2").value);
      var u1=parseInt(document.getElementById("hid_u1").value);
      var u2=parseInt(document.getElementById("hid_u2").value);
      var m1=parseInt(document.getElementById("hid_m1").value);
      var m2=parseInt(document.getElementById("hid_m2").value);
      var a1=parseInt(document.getElementById("hid_a1").value);
      var a2=parseInt(document.getElementById("hid_a2").value);
      var cdn=document.getElementById("hid_cdn").value;
        var data = google.visualization.arrayToDataTable([
          ['', 'Total', 'Used'],
          ['Quota(GB)',  q1,      q2],
          ['User',  u1,      u2],
          ['List',  m1,      m2],
          ['Alias',  a1,       a2]
          
        ]);

        var options = {
          title: '',
          hAxis: {title: cdn, titleTextStyle: {color: 'red'}}
        };

        var chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));
        chart.draw(data, options);
      }
    </script>
</head>

<body onload="getSender(),getRecepient(),getLastday()">
<%@include file="header.jsp" %>
<%
				HttpSession hs=request.getSession(false);
		       if(hs!=null)
		       {
		        String username= (String)hs.getAttribute("id");
		        String password= (String)hs.getAttribute("password");
		        String url= (String)hs.getAttribute("url");
		        String mbase= (String)hs.getAttribute("base");
		        String base="o=domains,"+mbase;
		        String utype=(String)hs.getAttribute("user_name");
		        
 %>
	

	
	
	
	<form name="dash_frm" action="">
	
	
	
	
	
            <div class="container main-admin">
            	
            	
            	
            	
            	
            <div class="main-leftbar">
                	
                    <div class="dashboard-left-navigation">
                    	<ul>
                        	 <li><a href="/unifiedmail/global/dashboard.jsp">Dashboard</a></li>
        					<li> <a href="/unifiedmail/global/domainlist.jsp">Domains and Accounts</a> </li>
        					 <%
                         if(utype!=null && utype.equalsIgnoreCase("Admin"))
                                {
                         %>
        					<li>	<a href="/unifiedmail/global/adddomain.jsp">Add Domain</a>	</li>
        					<%} %>
                            <li> <a href="/unifiedmail/global/adduser.jsp">Add User</a></li>
                            <li> <a href="/unifiedmail/global/addmaillist.jsp">Add Mail List</a>	</li>
                            <li><a href="/unifiedmail/global/addalias.jsp">Add Mail Alias</a>	</li>
                            <li>	 <a href="/unifiedmail/global/bulkuserupload.jsp">Bulk User Upload</a>	</li>
                          
                            <%
                         if(utype!=null && utype.equalsIgnoreCase("Admin"))
                                {
                         %>
                           <!--  <li>	<a href="/unifiedmail/diagnostics/mailqueue.jsp">Mail Queue</a>	</li> -->
                            <li>	<a href="/unifiedmail/global/services.jsp">Services</a>	</li>
                            <%}
                            else
                            {
                             %>
                             <li> <a href="/unifiedmail/global/log.jsp">Admin Log</a></li>
                            <li>  <a href="/unifiedmail/global/domainreport.jsp">Domain Wise Reports</a></li>
                             <%} %>
                            <li><a href="/unifiedmail/global/advanceusersearch.jsp">Advance Search</a> </li>
                             <li><a href="/unifiedmail/diagnostics/ping.jsp">Ping</a> </li>
                			<li><a href="/unifiedmail/diagnostics/traceroute.jsp">Trace Route</a> </li>
                           <li>  <a href="/unifiedmail/global/userreport.jsp">User Reports</a> </li>
                           <li><a href="/unifiedmail/global/userdetail.jsp">User Details</a></li>
                            <li><a href="/unifiedmail/diagnostics/licence.jsp">License</a> </li>
                              <li>	<a href="/unifiedmail/diagnostics/support.jsp">Support</a> 	</li>
                            <li>	<a href="/unifiedmail/global/changepassword.jsp">Change Password</a>	</li>
                            <li>	<a href="/unifiedmail/servlet/LogoutServlet">Logout</a>	</li>
                        	</ul>
                    	</div>
                         
                <br/>
                        
                        
                	</div>
            	
            	
            	
            	
            	<%
            	
		        int dcnt=0;
		        int ucnt=0;
		        int alscnt=0;
		        int listcnt=0;
		       // int cnt=0;
		        String dstr="";
		        try
{


DirContext ctx=LDAPConnection.getConnection(url, base, username, password);

SearchControls constraints = new SearchControls(); 
constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
String attrList[] = {"domainName"}; 
constraints.setReturningAttributes(attrList);
NamingEnumeration results =ctx.search(base,"domainName=*", constraints);
int f=0;
while (results.hasMore()) {
f=1;
    SearchResult si =(SearchResult)results.next();
    String ck=si.getName();
 //  System.out.println("<br><br><br>"+ck);
    Attributes attrs = si.getAttributes();

    if (attrs == null) {
       out.println("   No attributes");
        continue;
    }
    NamingEnumeration ae = attrs.getAll(); 
    while (ae.hasMoreElements()) {
        Attribute attr =(Attribute)ae.next();
        String id = attr.getID();
        Enumeration vals = attr.getAll();
        while (vals.hasMoreElements())
        {
        dcnt++;
        String str= vals.nextElement().toString();
 		if(dstr.equals(""))
 		{
 		dstr=str;
 		}
 		else
 		{
 		dstr=dstr+","+str;
 		}
 		System.out.println("dom="+dstr);
 		//String sbase="ou=Users,domainName="+str+","+mbase;
 		int no=NoOfUser.uCount(url,username,password,mbase,str);
 		//System.out.println("aaaaaaaaaasrt="+str+" no"+no);
		ucnt=ucnt+(no-1);
		no=NoOfUser.listCount(url,username,password,mbase,str);
		listcnt=listcnt+(no);
		no=NoOfUser.aliasCount(url,username,password,mbase,str);
		alscnt=alscnt+(no);
           //out.println("  <br> "+id + ":--- " +str);
           }
    }}
try
{
	LDAPConnection.closeConn( ctx);
}
catch(Exception ec)
{
	ec.printStackTrace();
}                               
}

		 catch(Exception e){System.out.print(e);}  
            	System.out.println("\nout_dom="+dstr);
            	 %>
            	
                <div class="add-domain-rightbar">
               		
                    	<div class="dashboard-recent-activity">
                        	<div class="total-domain">
                            	<h3>	Total Domain	</h3>
                                <hr class="blue-cut-line" />
                                <span class="total-icons">	<img src="/unifiedmail/images/total-icon.png" alt="" title="" />	</span>
                                <span class="total-icon-nos">	<%=dcnt %>	</span>
                            	</div>
                                <div class="total-domain">
                            	<h3>	Total Users	</h3>
                                <hr class="blue-cut-line" />
                                <span class="total-icons">	<img src="/unifiedmail/images/total-users.png" alt="" title="" />	</span>
                                <span class="total-icon-nos">	<%=ucnt %>	</span>
                            	</div>
                                <div class="total-domain">
                            	<h3>	Total Mail Lists	</h3>
                                <hr class="blue-cut-line" />
                                <span class="total-icons">	<img src="/unifiedmail/images/mailalias.png" alt="" title="" />	</span>
                                <span class="total-icon-nos">	<%=listcnt %></span>
                            	</div>
                                <div class="total-domain">
                            	<h3>	Total Mail Aliases	</h3>
                                <hr class="blue-cut-line" />
                                <span class="total-icons">	<img src="/unifiedmail/images/mailalias1.png" alt="" title="" />	</span>
                                <span class="total-icon-nos">	<%=alscnt %></span>
                            	</div>
                                <div class="clr"></div>
                        	</div>
                    <hr class="dashobard-line" />
                    	
                    	<%
                    	
                                	String lstdt="";    //"20131017";
         DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DATE, -1); 
        String yesdate=""+dateFormat.format(cal.getTime()); 
        String ld_arr[]=yesdate.split("-");
        lstdt=ld_arr[0]+ld_arr[1]+ld_arr[2];  
                    	 %>
                    	 <input  type="hidden" id="hid_dstr" value="<%=dstr %>"/>
                    	 <input  type="hidden" id="hid_lstdt" value="<%=lstdt %>"/>
                        <div class="email-updates-wrap">
                        	<div class="top-ten-sender-wrap" style="height: 318px;">
                            	 <%
                                if(utype!=null && utype.equalsIgnoreCase("Admin"))
                                {
                                 %>
                            	
                            	
                            	<div class="top-ten-heading">
                                	<span class="senders-title">Top 10 Sender Domain</span>
                                    <span class="senders-graff"><a onclick="imgSen()"><img id="img_sen" src="/unifiedmail/images/senders-graff.png" alt="" title="" /></a></span>
                                	<input type="hidden" id="hid_sender" value="0" />
                                	</div>
                                    <div id="div_sen" class="top-ten-seder-list">
                                    <center> <span>Loading...</span></center>	 
                                        	
                                        
	
                                    </div>
                                    <%}
                                    
                                    else if(utype!=null && utype.equalsIgnoreCase("LocalAdmin"))
                                    { 
                         /****** top 10 sender   *****/           
                                    %>
                                    
                            	<div class="top-ten-heading">
                                	<span class="senders-title">Top 10 Sender of Domain</span>
                                    <span class="senders-graff"></span>
                                	</div>
                                     <div id="div_sen" class="top-ten-seder-list">
                                    	 <center> <span>Loading...</span></center>	 
                                        
                                    </div>	 
                                    <%} 
                                
                                    %>
                            	</div>
                            	
                            	<!-- Recepient -->
                            	
                                <div class="top-ten-sender-wrap" style="height: 318px;">
                                
                                 <%
                                if(utype!=null && utype.equalsIgnoreCase("Admin"))
                                {
                                 %>
                                
                            	<div class="top-ten-heading">
                                	<span class="recipients-title">Top 10 Recepient Domain</span>
                                    <span class="senders-graff"><a onclick="imgRec()"><img id="img_rec" src="/unifiedmail/images/senders-graff.png" alt="" title="" /></a></span>
                                	<input type="hidden" id="hid_receiver" value="0" />
                                	</div>
                                    <div class="top-ten-seder-list" id="div_rec">
                                    	 <center> <span>Loading...</span></center>	
                                    </div>
                                    <%}
                                    
                                    else if(utype!=null && utype.equalsIgnoreCase("LocalAdmin"))
                                    { 
                         /****** top 10 recepient   *****/           
                                    %>
                                    <div class="top-ten-heading">
                                	<span class="recipients-title">Top 10 Recepient of Domain</span>
                                    <span class="senders-graff"></span>
                                	</div>
                                    <div id="div_rec" class="top-ten-seder-list" >
                                    	 <center> <span>Loading...</span></center>	
                                    </div>
                                    <%} %>
                                    
                            	</div>
                                
                                <div class="top-ten-sender-wrap no-rite-margin" style="height: 318px;">
                            	<div class="top-ten-heading">
                                	<span class="watch-title">Stats of Last Day</span>
        
                                    </div>
                                    <div id="div_lstday" class="stats-of-hour">
                                     <center> <span>Loading...</span></center>
                                    </div>
                            	</div>
                                 <div class="clr"></div>
                        	</div>
                            
                            <div class="email-updates-wrap">
                        	
                        	<div class="top-ten-sender-wrap">
                        <%
                         if(utype!=null && utype.equalsIgnoreCase("Admin"))
                                {
                         %>
                            	<div class="top-ten-heading">
                                	<span class="sys-info-title">System Information</span>
                                 	</div>
                                 	
                                 	<%
                                 	if(true)
                                 	{
                                 		String s_gw="";
                                 	    String s_ip="";
                              	    String hostnm="";
                              		Process	p = Runtime.getRuntime().exec("uptime"); 	
	BufferedReader stdInput = new BufferedReader(new InputStreamReader(p.getInputStream()));
		String s="";
		String upt="";
		String avg="";
		while ((s = stdInput.readLine()) != null) 
		{
		String arr1[]=s.split(",");
		upt=arr1[0];
		String arr2[]=s.split(":");
		avg=arr2[arr2.length-1];
		}
	
	
	Process	p1 = Runtime.getRuntime().exec("date"); 	
	BufferedReader stdInput1 = new BufferedReader(new InputStreamReader(p1.getInputStream()));
		String s1="";
		String zn="";
		while ((s1 = stdInput1.readLine()) != null) 
		{
		String arr1[]=s1.split(" ");
		zn=arr1[arr1.length-2];
		}	
	
	

  
Process	p_gw = Runtime.getRuntime().exec("/sbin/ip route"); 	
		 stdInput = new BufferedReader(new InputStreamReader(p_gw.getInputStream()));
		
		
	
		while ((s_gw = stdInput.readLine()) != null) 
		{
		if(s_gw.indexOf("default via")>=0)
		{
		//out.print("<br>"+s_gw);
		break;
		}
		}
		if(s_gw!=null)
		{
		String arr_gw[]=s_gw.split(" ");
		s_gw=arr_gw[2];
		//out.print("<br>gw="+arr_gw[2]);
		}
		
		
		
		Process	p_ip = Runtime.getRuntime().exec("/sbin/ifconfig"); 	
		stdInput = new BufferedReader(new InputStreamReader(p_ip.getInputStream()));
		
		
	int ind=-1;
	String otrip="";
		while ((s_ip = stdInput.readLine()) != null) 
		{
			if(otrip=="" && otrip.length()==0)
			{
			if((s_ip.indexOf("inet "))>=0)
			{
				otrip=s_ip;
			}
			}
			
		if((ind=s_ip.indexOf("Bcast"))>=0)
		{
				//out.print("<br><br>"+s_ip);
				break;
		}
		}
		if(ind>=0)
		{int i=s_ip.indexOf(":");
		s_ip=s_ip.substring(i+1,ind);
		
		//out.print("<br>ip="+s_ip);
		}
		else
		{
			String arr[]=otrip.split(" ");
			for(int i=0; i<arr.length; i++)
			{
				if(arr[i].equalsIgnoreCase("inet"))
				{
					s_ip=arr[i+1];
				}
			}
		}
		
		
  
		try
    {
   Process ph = Runtime.getRuntime().exec("/bin/hostname -f"); //live  
		
		BufferedReader stdInputh = new BufferedReader(new InputStreamReader(ph.getInputStream()));
		
		while ((hostnm = stdInputh.readLine()) != null) 
		{
		     //  out.println("<br>"+s);
		     break;
		        
		}
  
   
    }catch(Exception ehs){System.out.println(ehs);} 
   
	
 %>
                                 	
                                 	
                                    <div class="system-information-list">
                                    	<ul>
                                    <li>	Timezone <span style="color:#4a8cf6; font-size:14px;">	<%=zn %>	</span>	</li>
                                        <li>	Uptime  <span style="color:#4a8cf6; font-size:14px;">	<%=upt.trim() %>	</span>	</li>
                                        <li>	Load Avg. <span style="color:#4a8cf6; font-size:14px;">	<%=avg.trim() %>	</span>	</li>  
                                  <!--    <li>	Timezone <span style="color:#4a8cf6; font-size:14px;">		</span>	</li>
                                        <li>	 Uptime  <span style="color:#4a8cf6; font-size:14px;">		</span>	</li>
                                        <li>	Load Avg. <span style="color:#4a8cf6; font-size:14px;">		</span>	</li>   -->
                                        <li>	Host Name <span style="color:#4a8cf6; font-size:14px;">	<%=hostnm %>	</span>	</li>
                                        <li>	Gateway  <span style="color:#4a8cf6; font-size:14px;">	<%=s_gw %>	</span>	</li>
                                        <li>	IP Address<span style="color:#4a8cf6; font-size:14px;">	<%=s_ip %>	</span>	</li>
                                        	</ul>
                                    </div>
                                    
           <%
           }
           }
           else
           {
            %>
            
 <!--            <div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/all.js#xfbml=1";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>



<div class="fb-like-box" data-href="https://www.facebook.com/silvereyeitsolutions?ref=hl" data-width="240" data-height="290" data-colorscheme="light" data-show-faces="false" data-header="false" data-stream="true" data-show-border="false"></div>
            
     --> 
     
     
                                   
                                    <div class="top-ten-heading">
                                	<span class="exceeding-title">User wise Quota(used)>80%</span>
                                    <span class="senders-graff"></span>
                                	
                                	</div>
                                    <div class="top-ten-seder-list exceeding-list" id="div_quo">
                                    	<ul>
                                    	<li>	<span class="sender-title">E-mail</span> <span class="noof-mails"> Quota%		</span>	</li>
                                          
                                          <%
                                          try
                                          {
                                          String baseq="ou=Users,domainName="+dstr+",o=domains,"+mbase;//dc=springbirds,dc=co,dc=in";//"ou=Users,domainName="+arr_dm[i]+",o=domains"+(String)hs.getAttribute("base");
System.out.println("base: "+baseq);
DirContext ctx=LDAPConnection.getConnection(url, baseq, username, password);

String v3="";
String vacc="";

SearchControls constraints = new SearchControls(); 
constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
String attrList[] = {"mail","accountStatus"}; 
constraints.setReturningAttributes(attrList);
NamingEnumeration results =ctx.search(baseq,"mail=*", constraints);

while (results.hasMore()) {

String photo="";
    SearchResult si =(SearchResult)results.next();
    String ck=si.getName();
   System.out.println("<br><br><br>"+ck);
    Attributes attrs = si.getAttributes();


    if (attrs == null) {
       out.println("   No attributes");
        continue;
    }
    
    
    
    NamingEnumeration ae = attrs.getAll(); 
    while (ae.hasMoreElements()) {
        Attribute attr =(Attribute)ae.next();
        String id = attr.getID();
        Enumeration vals = attr.getAll();
        while (vals.hasMoreElements())
        {
        String str= vals.nextElement().toString();
        if(id.equalsIgnoreCase("mail"))
        {
        v3=str;
        }
        else if(id.equalsIgnoreCase("accountStatus"))
        {
        vacc=str;
        }
        


           System.out.println("  <br> "+id + ":--- " +str);
           }
    }
    if(!(vacc.equalsIgnoreCase("active")))
    {
    continue;
    }

if(v3.indexOf("@")>0)
{
                           
                           
                           int per=0;
                            		int used=0;
                            		int tot=0;
                            	Quota q=new Quota();
                            	String s=q.getQuota(v3);
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
         if(per>80)
                        {                  
                                           %>
                                         <li><font color="red">	<span class="sender-title-name"><%=v3 %></span> <span class="noof-mails-present"><%=per %>	</span>	</font></li>
                                        
                                        <%}
                                        else
                                        { %> 
                                    <%--  <li>	<span class="sender-title-name"><%=v3 %></span> <span class="noof-mails-present"><%=per %>	</span>	</li>
                                      --%>               
                                            
                                    
                                    <%}
                                    }
                                    }

}
catch(Exception e){System.out.print(e);
                                    }
                          %>
                          </ul>
                                    </div>
                          <%                
           } %>
                            	</div>
                        	
                                
                                
                                <div class="top-ten-sender-wrap no-rite-margin disk-status">
                                
                                <%
                                if(utype!=null && utype.equalsIgnoreCase("Admin"))
                                {
                                 %>
                            	<div class="top-ten-heading">
                                	<span class="disk-status-title">Disk Status</span>
                                    </div>
                                    <div class="disk-status-graff">
                                      <%@include file="chart.jsp" %>
                                	<!-- <img src="/unifiedmail/images/disk-status.jpg" alt="" title="" /> --> 
                                    </div>
                                    <%}
                                    else if(utype!=null && utype.equalsIgnoreCase("LocalAdmin"))
                                    {
                                    String dm_arr[]=dstr.split(",");
                                    String u1="";
                                     String u2="";
                                      String m1="";
                                       String m2="";
                                        String a1="";
                                         String a2="";
                                         String q1="";
                                         String q2="";
                                         q1=GetMValueAtt.getDomValueAtt(url,username,password,mbase,dstr,"domainMaxQuotaSize");
                                         q2=GetMValueAtt.getDomValueAtt(url,username,password,mbase,dstr,"domainCurrentQuotaSize");
                                         u1=GetMValueAtt.getDomValueAtt(url,username,password,mbase,dstr,"domainMaxUserNumber");
                                         u2=GetMValueAtt.getDomValueAtt(url,username,password,mbase,dstr,"domainCurrentUserNumber");
                                         m1=GetMValueAtt.getDomValueAtt(url,username,password,mbase,dstr,"domainMaxListNumber");
                                         m2=GetMValueAtt.getDomValueAtt(url,username,password,mbase,dstr,"domainCurrentListNumber");
                                         a1=GetMValueAtt.getDomValueAtt(url,username,password,mbase,dstr,"domainMaxAliasNumber");
                                         a2=GetMValueAtt.getDomValueAtt(url,username,password,mbase,dstr,"domainCurrentAliasNumber");
                                         q1=""+(Integer.parseInt(q1)/1024)	;
                                         q2=""+(Integer.parseInt(q2)/1024)	;
                                     %>
                                     <input type="hidden" id="hid_q1" name="hid_q1" value="<%=q1 %>" />
                                     <input type="hidden" id="hid_q2" name="hid_q2" value="<%=q2 %>" />
                                     <input type="hidden" id="hid_u1" name="hid_u1" value="<%=u1 %>" />
                                     <input type="hidden" id="hid_u2" name="hid_u2" value="<%=u2 %>" />
                                     <input type="hidden" id="hid_m1" name="hid_m1" value="<%=m1 %>" />
                                     <input type="hidden" id="hid_m2" name="hid_m2" value="<%=m2 %>" />
                                     <input type="hidden" id="hid_a1" name="hid_a1" value="<%=a1 %>" />
                                     <input type="hidden" id="hid_a2" name="hid_a2" value="<%=a2 %>" />
                                      <input type="hidden" id="hid_cdn" name="hid_cdn" value="<%=dstr %>" />
                                    <div class="top-ten-heading">
                                	<span class="disk-status-title">Domain Activity Status</span>
                                    </div>
                                    <div class="disk-status-graff">
                                     <div id="chart_div" style="height: 250px;"></div>
                                	<!-- <img src="/unifiedmail/images/disk-status.jpg" alt="" title="" /> --> 
                                    </div>
                                    <%} %>
                            	</div>
                                 <div class="clr"></div>
                                
                        	</div>
					</div>
                <div class="clr"></div>
            	</div>
            
       </form>
       <%} %>     
   <%@include file="footer.jsp" %>
</body>
</html>
