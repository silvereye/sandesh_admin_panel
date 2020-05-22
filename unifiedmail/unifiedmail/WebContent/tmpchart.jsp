<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
 <%@ page  import="java.awt.*" %>
<%@ page  import="java.io.*" %>
<%@ page  import="org.jfree.chart.*" %>
<%@ page  import="org.jfree.chart.entity.*" %>
<%@ page  import ="org.jfree.data.general.*"%>
<%@ page  import="org.jfree.chart.plot.*,org.jfree.data.category.*,org.jfree.data.general.DefaultPieDataset,org.jfree.data.xy.*,org.jfree.chart.renderer.category.*" %>

<%
String path1=getServletContext().getRealPath("/");
 DefaultCategoryDataset dataset = new DefaultCategoryDataset();
 dataset.setValue(12, "Science", "Nirbhay");
  dataset.setValue(13, "Maths", "Nirbhay");
  dataset.setValue(2, "Science", "Rahul");
  dataset.setValue(1, "Maths", "Rahul");
  dataset.setValue(0, "Science", "Deepak");
  dataset.setValue(0.2, "Maths", "Deepak");
  dataset.setValue(6, "Science", "Vinod");
  dataset.setValue(10, "Maths", "Vinod");
  dataset.setValue(2, "Science", "Chandan");
  dataset.setValue(4, "Maths", "Chandan");
  JFreeChart chart = ChartFactory.createBarChart3D ("Comparison between Students","Students", "Marks",dataset, PlotOrientation.HORIZONTAL, true,true, false);
  chart.setBackgroundPaint(Color.white);
  chart.getTitle().setPaint(Color.blue); 
  CategoryPlot p = chart.getCategoryPlot(); 
  p.setRangeGridlinePaint(Color.red); 

 try {
 final ChartRenderingInfo info = new 
  ChartRenderingInfo(new StandardEntityCollection());

  final File file1 = new File(path1+"dbarchart.png");
  ChartUtilities.saveChartAsPNG(
   file1, chart, 600, 400, info);
  } catch (Exception e) {
  out.println(e);
  }
  String fp=basePath+"dbarchart.png";
%>
<html>
  <head>
  <meta http-equiv="Content-Type" 
  content="text/html; charset=UTF-8">
  <title>JSP Page</title>
  </head>
  <body>
  <a href="/Chart/index.jsp">BACK</a>
  <IMG SRC="<%=fp %>"  WIDTH="600" HEIGHT="400" 
   BORDER="0" >
  </body>
</html>
