<%@ page language="java" import="java.util.*,mypack.*,java.text.*" pageEncoding="UTF-8"%>
<%
String pathesen = request.getContextPath();
String basePathesen = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+pathesen+"/";
%>

<%@ page  import="java.awt.*" %>
<%@ page  import="java.io.*" %>
<%@ page  import="org.jfree.chart.*" %>
<%@ page  import="org.jfree.chart.entity.*" %>
<%@ page  import ="org.jfree.data.general.*"%>
<%@ page  import="org.jfree.chart.plot.*,org.jfree.data.category.*,org.jfree.data.general.DefaultPieDataset,org.jfree.data.xy.*,org.jfree.chart.renderer.category.*" %>

<html>
 
  
  <body>
   <%
   String lstdt="";   //"20131017";
         DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DATE, -1); 
        String yesdate=""+dateFormat.format(cal.getTime()); 
        String ld_arr[]=yesdate.split("-");
        lstdt=ld_arr[0]+ld_arr[1]+ld_arr[2];  
   	String sen_cnt="";
   	String dstr=request.getParameter("dstr");
                                       	String dm_ar[]=dstr.split(",");
                                    	for(int i=0;i<dm_ar.length;i++)
                                    	{
                                    	if(!dm_ar[i].equals(""))
                                    	{
                                    	if(sen_cnt.equals(""))
                                    	{
                                    	sen_cnt=""+MailCount.sentMailCnt(dm_ar[i],lstdt);
                                    	}
                                    	else
                                    	{
                                    	sen_cnt=sen_cnt+"-"+MailCount.sentMailCnt(dm_ar[i],lstdt);
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
   
   
   
   
   
   
   
   
   
   
   
   String val=request.getParameter("no");
   int no=Integer.parseInt(val);
   
   
   if(no==0)
   {
    %>
    <%
 try {
String pathsen=getServletContext().getRealPath("/");
 DefaultCategoryDataset dataset = new DefaultCategoryDataset();
 for(int i=0;i<cnt_ar.length;i++)
  {                                     	
 dataset.setValue(Integer.parseInt(cnt_ar[i].trim()), "Email", dm_ar[i]);
 if(i==9)
 break;
 }
 
  JFreeChart chart = ChartFactory.createBarChart3D ("","Domains", "Emails",dataset, PlotOrientation.HORIZONTAL, true,true, false);
  chart.setBackgroundPaint(Color.white);
  chart.getTitle().setPaint(Color.blue); 
  CategoryPlot p = chart.getCategoryPlot(); 
  p.setRangeGridlinePaint(Color.red); 


 final ChartRenderingInfo info = new 
  ChartRenderingInfo(new StandardEntityCollection());

  final File file1 = new File(pathsen+"top10senchart.png");
  ChartUtilities.saveChartAsPNG(
   file1, chart, 600, 400, info);
 
  String fp=basePathesen+"top10senchart.png";
%>

 

  <IMG SRC="<%=fp %>"  WIDTH="100%" HEIGHT="287px" 
   BORDER="0" >
   
   
   <%
    } catch (Exception e) {
  out.println(e);
  }
    %>
    <%}
    else
    {
     %>
     <ul>
                                        	<li>	<span class="sender-title">Sender</span> <span class="noof-mails">No. of mails		</span>	</li>
                                            	<%
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
                                        	%>
                                        	</ul>
   <%} %>
  </body>
</html>
