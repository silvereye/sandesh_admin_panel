<%@ page language="java" import="java.util.*,mypack.*" pageEncoding="UTF-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	
</head>
<body>
<%
int ld_sen=0;
int ld_rec=0;
int ld_spm=0;
int ld_qua=0;
String lstdt=request.getParameter("hid_lstdt"); 
String dstr=request.getParameter("hid_dstr"); 
HttpSession hs_aj=request.getSession(false);
if(hs_aj!=null)
{
 
 String utype=(String)hs_aj.getAttribute("user_name");
%>
	<%
                                	
        if(true)
        {
        String dm_ar[]=dstr.split(",");
                                    	for(int i=0;i<dm_ar.length;i++)
                                    	{
                                    	if(!dm_ar[i].equals(""))
                                    	{
                                    	ld_sen=ld_sen+MailCount.sentMailCnt(dm_ar[i],lstdt);
                                    	ld_rec=ld_rec+MailCount.recMailCnt(dm_ar[i],lstdt);
                                    	ld_spm=ld_spm+MailCount.spamVMailCnt(dm_ar[i],lstdt);
                                    	ld_qua=ld_qua+MailCount.quarMailCnt(dm_ar[i],lstdt);
                                    	}
                                    	}
        
        }
                                	 %>
                                	 
                                	 <ul>
                                        	<li>	<span class="sent">Sent</span> <span class="amount-received"><%=ld_sen %>		</span>	</li>
                                            <li>	<span class="received">Received</span> <span class="amount-received"><%=ld_rec %>	</span>	</li>
                                            <li>	<span class="virus">Spam/Virus</span> <span class="amount-received"><%=ld_spm %>		</span>	</li>
                                            <li>	<span class="quarentied">Quarantine</span> <span class="amount-received"><%=ld_qua %>		</span>	</li>
                                            
                                                                                           	</ul>
     	<%} %>
</body>

</html>