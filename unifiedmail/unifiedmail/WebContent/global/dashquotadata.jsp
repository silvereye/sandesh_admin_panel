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
  
   	String dstr=request.getParameter("dstr");
                                       
   
   HttpSession hs=request.getSession(false);
		        String username= (String)hs.getAttribute("id");
		        String password= (String)hs.getAttribute("password");
		        String url= (String)hs.getAttribute("url");
		        String mbase= (String)hs.getAttribute("base");
		        String base="o=domains,"+mbase;
   
   
   
   
   
   
   String val=request.getParameter("no");
   int no=Integer.parseInt(val);
   
   
   if(no==0)
   {
    %>
    <%
 try {
String pathsen=getServletContext().getRealPath("/");
 DefaultCategoryDataset dataset = new DefaultCategoryDataset();

                                    	String dm_ar[]=dstr.split(",");
                                    	for(int i=0;i<dm_ar.length;i++)
                                    	{
                                    	String dmper="";
                                    	long per=QuotaDomPer.quotaPer(url,username,password,base,dm_ar[i]);
                                    	if(per==-1)
                                    	{
                                    	dmper="unlimited";
                                    	}
                                    	else
                                    	{
                                    	dmper=""+per;
                                    	
                                    	 
                                        	 
                                    	
 dataset.setValue(Integer.parseInt(dmper.trim()), "Quota used(%)", dm_ar[i]);
 }
 }
 
  JFreeChart chart = ChartFactory.createBarChart3D ("","Domain", "Quota used(%)",dataset, PlotOrientation.HORIZONTAL, true,true, false);
  chart.setBackgroundPaint(Color.white);
  chart.getTitle().setPaint(Color.blue); 
  CategoryPlot p = chart.getCategoryPlot(); 
  p.setRangeGridlinePaint(Color.red); 


 final ChartRenderingInfo info = new 
  ChartRenderingInfo(new StandardEntityCollection());

  final File file1 = new File(pathsen+"domquotachart.png");
  ChartUtilities.saveChartAsPNG(
   file1, chart, 600, 400, info);
 
  String fp=basePathesen+"domquotachart.png";
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
                                    	<li>	<span class="sender-title">E-mail</span> <span class="noof-mails"> Quota%		</span>	</li>
                                            
                                    	<%
                                    	String dm_ar[]=dstr.split(",");
                                    	for(int i=0;i<dm_ar.length;i++)
                                    	{
                                    	String dmper="";
                                    	long per=QuotaDomPer.quotaPer(url,username,password,base,dm_ar[i]);
                                    	if(per==-1)
                                    	{
                                    	dmper="unlimited";
                                    	}
                                    	else
                                    	{
                                    	dmper=""+per;
                                    	
                                    	 %>
                                        		<li>	<span class="sender-title-name"><%=dm_ar[i] %></span> <span class="noof-mails-present"><%=dmper %>	</span>	</li>
                                                	
                                        	<%
                                        	}
                                        	}
                                        	 %>
                                        	</ul>
   <%} %>
  </body>
</html>
