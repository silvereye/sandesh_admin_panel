 <%@page contentType="text/html"  pageEncoding="UTF-8"%>
<%
String pathc = request.getContextPath();
String basePathc = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+pathc+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page  import="java.awt.*" %>
<%@ page  import="java.io.*" %>
<%@ page  import="org.jfree.chart.*" %>
<%@ page  import="org.jfree.chart.entity.*" %>
<%@ page  import ="org.jfree.data.general.*"%>
<%@ page  import="org.jfree.chart.plot.*,org.jfree.data.category.*,org.jfree.data.general.DefaultPieDataset,org.jfree.data.xy.*,org.jfree.chart.renderer.category.*" %>

<%
 try {
String path1=getServletContext().getRealPath("/");

 /*
 double freeDiskSpace = FileSystemUtils.freeSpaceKb("C:");
double f=new File("C:").getTotalSpace()/1024/1024/1024;

 double freeDiskSpaceGB = freeDiskSpace / 1024 / 1024;
 double usdes=f-freeDiskSpaceGB;
*/
DefaultCategoryDataset dataset=  dataset = new DefaultCategoryDataset();
 JFreeChart chart=null;
 Process p1 = Runtime.getRuntime().exec("df -hT"); 
 BufferedReader stdInput = new BufferedReader(new InputStreamReader(p1.getInputStream()));
		//String s="User quota STORAGE 0 4194304 0";
		String s="";
		
		while ((s = stdInput.readLine()) != null) 
		{
		/*
String allstr="/dev/sda6 ext3 28G 22.4G 3.4G 33% /-/dev/sda6 tmpf 28G 22.4G 3.4G 33% c-/dev/sda6 ext3 40G 39.5G 512M 33% d-/dev/sda6 ext4 28G 22.4G 3.4G 33% f";
String strarr[]=allstr.split("-");
for(int i=0;i< strarr.length;i++)

{*/
if(s.indexOf("ext")>-1 || s.indexOf("ocfs2")>-1 || s.indexOf("xfs")>-1)
{
int cnnt=0;
String tot="";
String use="";
String avl="";
String nm="";		     
String str=s.trim();
//out.print("str  "+str);
String arr[]=str.split(" ");
for(int z=0;z<arr.length;z++)
{
if(arr[z].length()>0)
{
cnnt++;
if(cnnt==3)
tot=arr[z];
if(cnnt==4)
use=arr[z];
if(cnnt==5)
avl=arr[z];
if(cnnt==7)
nm=arr[z];
}}
//System.out.print("mnt  "+nm);
//System.out.println("lst "+tot.charAt(tot.length()-1));
String st=""+tot.charAt(tot.length()-1);
String su=""+use.charAt(use.length()-1);
String sa=""+avl.charAt(avl.length()-1);
float t1=Float.parseFloat(tot.substring(0,tot.length()-1));
float t2=Float.parseFloat(use.substring(0,use.length()-1));
float t3=Float.parseFloat(avl.substring(0,avl.length()-1));
if(st.equalsIgnoreCase("M"))
{
t1=t1/1024;
}
else if(st.equalsIgnoreCase("T"))
{
t1=t1*1024;
}
else if(st.equalsIgnoreCase("K"))
{
t1=t1/1024/1024;
}

if(su.equalsIgnoreCase("M"))
{
t2=t2/1024;
}
else if(su.equalsIgnoreCase("T"))
{
t2=t2*1024;
}
else if(su.equalsIgnoreCase("K"))
{
t2=t2/1024/1024;
}


if(sa.equalsIgnoreCase("M"))
{
t3=t3/1024;
}
else if(sa.equalsIgnoreCase("T"))
{
t3=t3*1024;
}
else if(sa.equalsIgnoreCase("K"))
{
t3=t3/1024/1024;
}


 dataset.setValue(t1, "Total Space", nm);
  dataset.setValue(t2, "Used Space", nm);
  dataset.setValue(t3, "Free Space", nm);
  
  }
  }
  
   chart = ChartFactory.createBarChart3D ("","Mounted on", "GB",dataset, PlotOrientation.VERTICAL, true,true, false);

 chart.setBackgroundPaint(Color.white);
  chart.getTitle().setPaint(Color.blue); 
  CategoryPlot p = chart.getCategoryPlot(); 
  p.setRangeGridlinePaint(Color.red); 

 
 final ChartRenderingInfo info = new ChartRenderingInfo
 (new StandardEntityCollection());

 final File file1 = new File(path1+"dbarchart.png");
 ChartUtilities.saveChartAsPNG(file1, chart, 600, 400, info);
 
 String fp=basePathc+"dbarchart.png";
%>

<html>
  <head>
  <meta http-equiv="Content-Type" 
  content="text/html; charset=UTF-8">
  <title>JSP Page</title>
 
  </head>
  <body>
  <IMG SRC="<%=fp %>" WIDTH="100%" HEIGHT="250px" BORDER="0" />
 <% } catch (Exception e) {
 out.println(e);
 } %>
  </body>
</html> 