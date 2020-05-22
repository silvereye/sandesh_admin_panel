<%@ page language="java" import="java.util.*,mypack.*" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.regex.*" %>
<%@ page import="javax.naming.directory.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>License | Silvereye Unified E-mail Server</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/reset.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/screen.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/fancybox.css" />
    <style>
.liscence-display {
    background: url("/unifiedmail/diagnostics/liscence.png") no-repeat scroll right bottom rgba(0, 0, 0, 0);
    border: 1px solid #acacac;
    border-radius: 10px;
    min-height: 350px;
    overflow: hidden;
    padding: 1.5%;
}


	
	
	.lisc-info-wrap {
    background: url("/unifiedmail/diagnostics/lisc-shadow.png") no-repeat scroll left bottom rgba(0, 0, 0, 0);
    color: #2162c0;
    font-family: Tahoma,Geneva,sans-serif;
    font-size: 14px;
    font-weight: bold;
    padding: 0 0 30px;
}

.lisc-info-wrap label {
    color: red;
}
</style>
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
int totno=0;


 HttpSession hs=request.getSession();
  String username= (String)hs.getAttribute("id");
		        String password= (String)hs.getAttribute("password");
		        String url= (String)hs.getAttribute("url");
		        String mbase= (String)hs.getAttribute("base");
		        String base="o=domains,"+mbase;
		        String utype=(String)hs.getAttribute("user_name");
		        totno=TotalUser.totUser(url,mbase, base, username, password);






 %>
	
<%@include file="/global/header.jsp" %>



<div class="main pagesize"> <!-- *** mainpage layout *** -->
        <div class="main-wrap">
             <%
           
String utp=(String)ses.getAttribute("user_name");
          if(ses==null )
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
                



    <div  style="background: #ffffff; "  class="content-box">
        <div style="background: url('/unifiedmail/diagnostics/liscence.png')no-repeat scroll right bottom rgba(0, 0, 0, 0);"  class="box-body">
            <div class="box-header clear">
                

                <h2>
                   General License Information
                </h2>
            </div>

            <div id="maillist_add" class="box-wrap clear">
  
  
  
  
  
                	
                    <div class="lisc-info-wrap">
                    	
                    	  <img src="/unifiedmail/diagnostics/lisc1.png" height="69" width="73"><br/>
                    	      Total no. of added users
                    	       <label>
                    	       <font color="green">
                    	       (<%=totno %>)
                    	       </font>
                    	       </label>
                  	      <br/>
                    </div>
                    <%if(utype.equalsIgnoreCase("Admin"))
              { %>
                    <div class="lisc-info-wrap">
                    	
                    	 <img src="/unifiedmail/diagnostics/lisc2.png" height="69" width="73"><br/>
                    	      Your License is <label>(Unlimited)</label>
                    </div>
                    <%}
                    else
                    {
                    String arr[]=username.split(",");
                    String arrdn[]=arr[0].split("@");
   				String dn=arrdn[1];
   				//out.print(dn);
   				String no=GetMValueAtt.getDomValueAtt(url,username,password,mbase,dn,"domainMaxUserNumber");
                     %>
                      <div class="lisc-info-wrap">
                    	
                    	 <img src="/unifiedmail/diagnostics/lisc2.png" height="69" width="73"><br/>
                    	      Your License is <label>(<%=no %>) Users</label>
                    </div>
                     <%} %>
                    <!--
          
   
    
   
     <%
   // if(totno>=500)
    // {
     
     %>
       <img style="top: 40%; left: 40%; position: absolute;" id="fire"  src="/unifiedmail/global/images/expired.jpg"/>  
    
<%//} %>
    
    
    
  
  
  
  
  
  
  
    --></div>
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
