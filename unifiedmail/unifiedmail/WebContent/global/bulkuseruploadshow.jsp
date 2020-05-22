<%@ page language="java" import="java.util.*,mypack.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'bulkuseruploadshow.jsp' starting page</title>
    
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
  </head>
  
  <body>
     <%@include file="header.jsp" %>
     
     <div class="main pagesize"> <!-- *** mainpage layout *** -->
        <div class="main-wrap">
        
        
        
        
     
      <center>
   <table border="1" style="border-radius: 10px 10px 10px 10px; font-size: 17" width="100%">
   <tr>
   <td width="16%">
   <table width="100%"><tr><td  style="color: #B5C2C3; ">Correct records.</td></tr></table>
   
   </td>
   
   <td width="17%">
   <table width="100%"><tr><td  style="color: #FF77FF">Improper records.</td></tr></table>
   
   </td>
   
   <td width="18%">
   <table width="100%"><tr><td  style="color: #aaddaa">Repeated records.</td></tr></table>
   
   </td>
   
   <td width="17%">
   <table width="100%"><tr><td  style="color: pink">Existing records.</td></tr></table>
   
   </td>
   
   <td width="17%">
   <table width="100%"><tr><td  style="color: #987699">Exceed quota limit.</td></tr></table>
   
   </td>
   
   <td width="17%">
   <table width="100%"><tr><td  style="color: #7CEEDA">Exceed user limit</td></tr></table>
   
   </td>
   </tr>
   
   </table>
   </center>
     
     
      <%
      HttpSession hs=request.getSession();
       String dm=request.getParameter("dm");
     int  dqt=CheckValue.valDomainAtt(hs,dm,"domainDefaultUserQuota");
   String fname=request.getParameter("file");
    String path1=getServletContext().getRealPath("/"); 
    String nwpath=path1+"CsvFile";   
   String fnl=nwpath+"/"+fname;
   String str=CsvFileData.getFileData(fnl);
   if(str.equalsIgnoreCase("empty"))
   {
   out.print("File is empty");
   }
   else
   {
		if(str!=null)
		{
        str=str.trim();
		}
		String a[]=str.split(";");
		if(a.length>50)
		{
		 out.print("Max user limit is 50 at a time.");
		}
		else
		{
    %>
     
     
     
     <div class="add-domain-rightbar fwid">
     <div class="domain-wrapper2" id="div1">
      <table width="100%" border="0" cellpadding="3" cellspacing="0" class="user-under-domain dlist1111">
    <thead style="height: 25px;">
    <tr >
    <td width="30" align="center"><img src="/unifiedmail/global/images/mark.png" title="Action" /></td>
    <td width="150">Domain Name</td>
    <td width="150">Full Name</td>
    <td width="147" align="left">E-mail</td>
    <td width="100" align="center">Quota </td>
    <td width="80" align="center">Password</td>
  </tr>
    </thead>
     <%
    
                 //out.print(k);
        int k=a.length;
		int flg=1;
		String allmail="";
		String uniq_dn="";
		long qt_max=0;
		long usr_max=0;
		long usr_c=0;
		long qt_c=0;
		for(int i=0;i<k;i++)
		{
       String sn="";
       String ftn="";
       String fn="";
        String pass="";
        String mail="";
        String qt=""+dqt;
       
			//out.print("<br>"+i);
			String b[]=a[i].split(",");
			for(int j=0;j<b.length;j++)
			{
				if(j==0)
				{
					ftn=b[j];
					//dm=dm.toLowerCase();
				}else if(j==1)
				{
				sn=b[j];
					fn=ftn+" "+b[j];
				}
				else if(j==2)
				{ 
					mail=b[j];
					mail=mail.toLowerCase();
					mail=mail.trim();
					
				}else if(j==3)
				{
					pass=b[j];
				}
			}
			
			String mcolor="none";
			String domcolor="none";
			String divcolor="#B5C2C3";
			String mailtit="Email id is correct.";
			String outit="Group is correct.";
			String divtit="Record is Correct";
			String idcolor="";
			String idtit="";
			int rep=0;
			int id=0,m=0,am=0,gp=0;
			int inrec=1;
			
			if(dm.equals("") || pass.equals("") || mail.equals("") || qt.equals("") || ftn.equals("") || sn.equals(""))
			{
			inrec=0;
			divcolor="#FF77FF";
			divtit="Improper record";
			}
			else	 
			{
			int qtflg=1;
			/*for(int iq=0;iq<qt.length();iq++)
			{
			int c=(int)(qt.charAt(iq));
			if(c>57 || c<48)
				{
				qtflg=0;
				break;
				}
			}
			*/
			int dom=CheckValue.checkDomain(hs,dm);
			
			if(dom==1 && uniq_dn.equals(""))
			{
			uniq_dn=dm;
			qt_max=CheckValue.valDomainAttLong(hs,dm,"domainMaxQuotaSize");
			qt_c=CheckValue.valDomainAttLong(hs,dm,"domainCurrentQuotaSize");
			usr_max=CheckValue.valDomainAttLong(hs,dm,"domainMaxUserNumber");
			usr_c=CheckValue.valDomainAttLong(hs,dm,"domainCurrentUserNumber");
			}
			if(qtflg==0 || (mail.indexOf("@")<0)|| dom==0 || !(uniq_dn.equals(dm)))
			{
			inrec=0;
			divcolor="#FF77FF";
			divtit="Improper record";
			}
			else
			{
			if(dom==1 && inrec==1)
			{
			qt_c=qt_c+Integer.parseInt(qt);
			usr_c=usr_c+1;
			if(qt_max!=0 && qt_c>qt_max)
			{
			divcolor="#987699";
			divtit="Exceed quota limit";
			usr_c--;
			}
			else if(usr_c> usr_max)
			{
			divcolor="#7CEEDA";
			divtit="Exceed user limit";
			qt_c=qt_c-Integer.parseInt(qt);
			}
			else
			{
			int min=mail.indexOf("@");
			mail=mail.substring(0,min+1)+dm;
		//	CheckUid cu=new  CheckUid();
		     int chk_id=CheckValue.checkUserMail(hs,dm,mail);
			
			if(chk_id==1)
		{
		    divcolor="pink";
			idcolor="red";
			idtit="Mail id is already esixt.";
			divtit="Esixting Records.";
			usr_c--;
			qt_c=qt_c-Integer.parseInt(qt);
		}
			
			
			if(allmail.indexOf(mail)>=0)
			{
			rep=1;
			 divcolor="#aaddaa";
			idcolor="red";
			idtit="Mail id is repeated.";
			divtit="Repeated Records.";
			usr_c--;
			qt_c=qt_c-Integer.parseInt(qt);
			}
			allmail=allmail+","+mail;
			
		
		
		
		
		
	}	
	}
	}
	}	
			
      %>
      <tr style="height: 4px;"><td ></td></tr>
      <tr title="<%=divtit %>" style="background-color: <%=divcolor %>">
    <td  width="30" align="center"><label>
      <%if(divcolor.equalsIgnoreCase("#B5C2C3")) 
      {
      %>
     <img height="18" width="18" src="/unifiedmail/global/images/incorrect.png" title="Correct" />
     <%}
     else
     {
      %>
      <img height="18" width="18" src="/unifiedmail/global/images/correct.png" title="INCorrect" />
      <%} %>
    </label></td>
  
    <td width="150"><%=dm %></td>
    <td width="150"><%=fn %></td>
    <td width="147" title="<%=idtit %>" style="color: <%=idcolor %>" align="left"><%=mail %></td>
    <td width="100" align="center"><%=qt %></td>
   
    <td width="80" align="center"><%=pass %></td>
  </tr>
     
     <%} %>
     </table>
     
     </div>
     
     
     <div class="action-wrap" >
       <div class="action-one">      
                                    <div class="iconic-btn">	<a href="/unifiedmail/servlet/BulkUploadUserServlet?file=<%=fname %>&dm=<%=dm %>">Add Users</a>	</div>
                    	<div class="iconic-btn">	<a   href="/unifiedmail/global/dashboard.jsp">Cancle</a>	</div>
                 <br/><br/><br/>                       
          </div>                             
                                	</div>
     
     
     
     </div>
         <%}
         
         }   
       %>
     </div></div>
 
            <%@include file="footer.jsp" %>
  </body>
</html>
