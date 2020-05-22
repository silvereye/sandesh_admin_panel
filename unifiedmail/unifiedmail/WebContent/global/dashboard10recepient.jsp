<%@page import="dbutil.*"%>
<%@page import="java.sql.*"%>
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
String lstdt=request.getParameter("hid_lstdt"); 
String dstr=request.getParameter("hid_dstr"); 
HttpSession hs_aj=request.getSession(false);
if(hs_aj!=null)
{
 
 String utype=(String)hs_aj.getAttribute("user_name");
%>

 <%
                                if(utype!=null && utype.equalsIgnoreCase("Admin"))
                                {
                                 %>
                                
                            	
                                    
                                    	<ul>
                                        	<li>	<span class="sender-title">Recepients</span> <span class="noof-mails">No. of mails		</span>	</li>
                                            	<%
                                        	if(true)
                                        	{
                                        	String sen_cnt="";
                                       	String dm_ar[]=dstr.split(",");
                                    	for(int i=0;i<dm_ar.length;i++)
                                    	{
                                    	if(!dm_ar[i].equals(""))
                                    	{
                                    	if(sen_cnt.equals(""))
                                    	{
                                    	sen_cnt=""+MailCount.recMailCnt(dm_ar[i],lstdt);
                                    	}
                                    	else
                                    	{
                                    	sen_cnt=sen_cnt+"-"+MailCount.recMailCnt(dm_ar[i],lstdt);
                                    	}
                                        }	
                                        	}
                                        	
                                        	String cnt_ar[]=sen_cnt.split("-");
                                        	for(int i=0;i<cnt_ar.length;i++)
                                        	{
                                        	for(int j=i+1;j<cnt_ar.length;j++)
                                        		{
                                        		if(Integer.parseInt(cnt_ar[i])<Integer.parseInt(cnt_ar[j]))
                                        		{
                                        		String t1=cnt_ar[i];
                                        		cnt_ar[i]=cnt_ar[j];
                                        		cnt_ar[j]=t1;
                                        		t1=dm_ar[i];
                                        		dm_ar[i]=dm_ar[j];
                                        		dm_ar[j]=t1;
                                        		}
                                        		}
                                        	
                                        	}
                                        	
                                        	
                                        	
                                        for(int i=0;i<cnt_ar.length;i++)
                                        	{
                                        	
                                        	 %>
                                            	<li>	<span class="sender-title-name"><%=dm_ar[i]  %></span> <span class="noof-mails-present"><%=cnt_ar[i] %>		</span>	</li>
                                                	
                                        	<%
                                        	if(i==9)
                                        	{
                                        	break;
                                        	}
                                        	}
                                        	} %></ul>
                                   
                                    <%}
                                    
                                    else if(utype!=null && utype.equalsIgnoreCase("LocalAdmin"))
                                    { 
                         /****** top 10 recepient   *****/           
                                    %>
                                 
                             
                                    	<ul>
                                        	<li>	<span class="sender-title">Recepients</span> <span class="noof-mails">No. of mails		</span>	</li>
                                           
                                           
                                           <%
    int div_flg=0;
   String dn=dstr;
  			String sql="SELECT * FROM msgs ms, msgrcpt mt where ms.mail_id=mt.mail_id and ( (select email from maddr where id=mt.rid ) like ?) and ms.content NOT IN (?, ?, ?) and  ( ms.time_iso like ?) ";
           Connection con=Crudoperation.createConnection();
	  try
              {
           //    ResultSet rs=Crudoperation.getData(sql,tmp);
	PreparedStatement ps=con.prepareStatement(sql);
	System.out.println("after ps");
	ps.setString(1,"%"+dn);
	ps.setString(2,"V");
	ps.setString(3,"S");
	ps.setString(4,"Y");
	ps.setString(5,lstdt+"%");
	System.out.println("after value setting");
	ResultSet rs=ps.executeQuery();
	System.out.println("after exequetqry");
	 String str=null;
	while(rs.next())
	{
	
	
	if(str==null)
		{
		str=""+rs.getInt("mt.rid");
		}
		else
		{
		str=str+","+rs.getInt("mt.rid");
		}
	
	
	
	}
	
	
	
	if(str!=null)
{
		String arrstr[]=str.split(",");
		
		ArrayList<String> al1 = new ArrayList<String>();
		ArrayList<Integer> al2 = new ArrayList<Integer>();
		for(int i=0;i<arrstr.length;i++)
		{
		String ns=arrstr[i];
		if(al1.indexOf(ns)<0 && (ns!=null && !(ns.equals(""))))
		{
		al1.add(ns);
		}
		}
	

		for (int i = 0; i < al1.size(); i++)
		{
   		String item = al1.get(i);
		int cnt=0;
		for(int j=0;j<arrstr.length;j++)
		{
		if(arrstr[j].equals(item))
			{
			cnt++;
			}
		}
		al2.add(cnt);
		}

for (int i = 0; i < al2.size(); i++)
		{
		for(int j=0;j<al2.size()-i-1;j++)
		{
		int a=al2.get(j);
		int b=al2.get(j+1);
		if(a>b)
		{
		 Collections.swap(al1, j, j+1);
		 Collections.swap(al2, j, j+1);
		}
		}
		}
	
   %>
 
   <%
   for (int i = al1.size()-1,c=0; i >=0 ; i--)
		{
		div_flg=1;
		c++;
		//out.println("<tr><td> "+ al1.get(i) + "</td><th> : </th><th>" + al2.get(i)+"</th></tr>");
		String mid=Crudoperation.getMailToId(""+al1.get(i),"SELECT * FROM maddr where id=?");
		%>
		 <li>	<span class="sender-title-name"><%=mid %></span> <span class="noof-mails-present"><%=al2.get(i) %>		</span>	</li>
                                                
                     
		<%
		if(c==10)
			{
			break;
			}
		}
   }
   }
   catch(SQLException ee){out.print(ee);}
    if(div_flg==0)
   {
   out.print("Records not found.");
   }
	
	
    %>
                                           
                                            	
                                    
                                    </ul>
                                  
                                    <%} %>
                                    

<%} %>
</body>

</html>