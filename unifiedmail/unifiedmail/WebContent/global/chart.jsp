 <%@page contentType="text/html"  pageEncoding="UTF-8"%>
<%
String pathc = request.getContextPath();
String basePathc = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+pathc+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page  import="java.awt.*" %>
<%@ page  import="java.io.*" %>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load('current', {'packages':['bar']});
      google.charts.setOnLoadCallback(drawChart);

      function drawChart() {
	  var npdt=document.getElementById('chart_np').value;
	  var arr1=npdt.split("<$nps$>");
	  var data = new google.visualization.DataTable();
	    data.addColumn('string', 'Mounted on');
        data.addColumn('number', 'Total Space(GB)');
		data.addColumn('number', 'Used Space(GB)');
        data.addColumn('number', 'Free Space(GB)');
		
		for(var i=0;i<arr1.length;i++)
		{
			var arr2=arr1[i].split(":");
			 data.addRow([arr2[0], parseInt(arr2[1]),parseInt(arr2[2]),parseInt(arr2[3])]);
		}
		
       /* var data = google.visualization.arrayToDataTable([
          ['Year', 'Sales', 'Expenses', 'Profit'],
          ['2014', 1000, 400, 200],
          ['2015', 1170, 460, 250],
          ['2016', 660, 1120, 300],
          ['2017', 1030, 540, 350]
        ]);*/

        var options = {
          chart: {
            
          },
          bars: 'vertical' // Required for Material Bar Charts.
        };

        var chart = new google.charts.Bar(document.getElementById('chart_div'));

        chart.draw(data, google.charts.Bar.convertOptions(options));
      }
    </script>
<%
String npstr="";
 try {
String path1=getServletContext().getRealPath("/");

 /*
 double freeDiskSpace = FileSystemUtils.freeSpaceKb("C:");
double f=new File("C:").getTotalSpace()/1024/1024/1024;

 double freeDiskSpaceGB = freeDiskSpace / 1024 / 1024;
 double usdes=f-freeDiskSpaceGB;
*/

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


 /* dataset.setValue(t1, "Total Space", nm);
  dataset.setValue(t2, "Used Space", nm);
  dataset.setValue(t3, "Free Space", nm); */
  if(npstr==null || npstr.length()==0)
  {
	  npstr=nm+":"+t1+":"+t2+":"+t3;
  }
  else
  {
	  npstr+="<$nps$>"+nm+":"+t1+":"+t2+":"+t3;
  }
  
  }
  }
  
%>

<html>
  <head>
  <meta http-equiv="Content-Type" 
  content="text/html; charset=UTF-8">
  <title>JSP Page</title>
 
  </head>
  <body>
 
 <% } catch (Exception e) {
 out.println(e);
 } %>
  <input type="hidden" value="<%=npstr %>" id="chart_np">
  <div id="chart_div" style="height: 250px;width:490px;"></div>
  </body>
</html> 