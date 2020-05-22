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
    <title>system info | Silvereye Unified E-mail Server</title>
 
  
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/reset.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/screen.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/fancybox.css" />


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

<%
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
		
		
		
		
		
		
	
 %>

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
                   System Info
                </h2>
            </div>

            <div id="maillist_add" class="box-wrap clear">
   <form name="f"  id="register" method="post" action="" >    
    

        <div class="form-field clear">
            <h4 class="size-250 fl-space">System Timezone</h4>
            <span class="clean-padding">
                  
                               <input name="ip1" readonly="readonly" type="text" size="35" value="<%=zn %>" class="text fl-space"  />
                             
            </span>
            <div class="ermsg" id="sp1"></div>
        </div>

      

<div class="form-field clear">
        
            <h4 class="size-250 fl-space">System Uptime	</h4>
        

        <span class="clean-padding bt-space20">
         <input name="ip1" readonly="readonly" type="text" size="35" value="<%=upt.trim() %>" class="text fl-space"  />
                             
        </span>
    </div>
    
    
    
    <div class="form-field clear">
        
            <h4 class="size-250 fl-space">Load Average</h4>
        

        <span class="clean-padding bt-space20">
         <input name="ip1" readonly="readonly" type="text" size="35" value="<%=avg.trim() %>" class="text fl-space"  />
                             
        </span>
    </div>
   

  
    <div class="rule2"></div>
    <%
    String s_gw="";
    String s_ip="";
    String hostnm="";
  
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
    
    
    
    
     <div class="form-field clear">
            <h4 class="size-250 fl-space">Host Name</h4>
            <span class="clean-padding">
                  
                               <input name="ip1" readonly="readonly" type="text" size="35" value="<%=hostnm %>" class="text fl-space"  />
                             
            </span>
            <div class="ermsg" id="sp1"></div>
        </div>

      

<div class="form-field clear">
        
            <h4 class="size-250 fl-space">Gateway	</h4>
        

        <span class="clean-padding bt-space20">
         <input name="ip1" readonly="readonly" type="text" size="35" value="<%=s_gw %>" class="text fl-space"  />
                             
        </span>
    </div>
    
    
    
    <div class="form-field clear">
        
            <h4 class="size-250 fl-space">IP Address</h4>
        

        <span class="clean-padding bt-space20">
         <input name="ip1" readonly="readonly" type="text" size="35" value="<%=s_ip %>" class="text fl-space"  />
                             
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


<%@include file="/global/footer.jsp" %>

	<%} %>
	
	
</body>
</html>
