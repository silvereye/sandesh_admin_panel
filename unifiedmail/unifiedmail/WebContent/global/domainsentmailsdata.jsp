<%@ page language="java" import="java.util.*,java.sql.*,dbutil.*"  pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  
  
  <body>
    <table class="style1 tablesorter" cellspacing="0">
            <thead>
            <tr>
                
                   
                
                
                <th>Sender</th>
                <th>Recipient</th>
                <th>Subject</th>
                <th>IP</th>
                <th>Date</th>
                 <th>Type</th>
            </tr>
            </thead>

            <tbody>
                
                <%
                int cnt=Integer.parseInt(request.getParameter("cnt"));
                if(cnt>0)
                {
              String dn=request.getParameter("dn");
  			String sql="SELECT * FROM msgs ms, msgrcpt mt where ms.mail_id=mt.mail_id and ( (select email from maddr where id=ms.sid ) like ?) and ms.content NOT IN (?, ?, ?) ORDER BY time_num DESC LIMIT ? , ?";
           Connection con=Crudoperation.createConnection();
	 int no=Integer.parseInt(request.getParameter("val").trim());
	int chk=0;
	        no=(no-1)*15;
              // String tm="good";
            //  String sql="SELECT * FROM msgs ms, msgrcpt mt where ms.mail_id=mt.mail_id and ms.sid=? ORDER BY time_num DESC LIMIT ? , ?";
          //  String tmp=id+","+no+",15";
             //String sql="SELECT cnt=count(mail_id) * FROM email_details WHERE cnt=count(mail_id) between 5 and 10";
              try
              {
           //    ResultSet rs=Crudoperation.getData(sql,tmp);
	PreparedStatement ps=con.prepareStatement(sql);
	System.out.println("after ps");
	ps.setString(1,"%"+dn);
	ps.setString(2,"V");
	ps.setString(3,"S");
	ps.setString(4,"Y");
	ps.setInt(5,no);
	ps.setInt(6,15);
	System.out.println("after value setting");
	ResultSet rs=ps.executeQuery();
	System.out.println("after exequetqry");
	while(rs.next())
	{
	chk=chk+1;
	 String dstr=rs.getString("ms.time_iso");
 String dt=dstr.subSequence(6,8)+"-"+dstr.subSequence(4,6)+"-"+dstr.subSequence(0,4);
 /* String smail=rs.getString("from_addr");
  String sid="";
  int ind=smail.indexOf("<");
  if(ind<0)
  {
  sid=smail;
  }
  else
  {
  sid=smail.substring(ind+1,smail.length()-1);
  }
	*/
	String ip=rs.getString("client_addr");
	
	String sub=rs.getString("ms.subject");
	String sub1=rs.getString("ms.subject");
	if(sub.length()>35)
	{
	sub=sub.substring(0,35)+"......";
	}
	String rmail=Crudoperation.getMailToId(""+rs.getInt("mt.rid"),"SELECT * FROM maddr where id=?");
	String smail=Crudoperation.getMailToId(""+rs.getInt("ms.sid"),"SELECT * FROM maddr where id=?");
   String smail1=smail;
   String rmail1=rmail;
   if(smail.length()>30)
	{
	smail=smail.substring(0,30)+"......";
	}
   
    if(rmail.length()>30)
	{
	rmail=rmail.substring(0,30)+"......";
	}
   
   
     String ctype=rs.getString("ms.content");   
     String ctit="";
     
       if(ctype.equalsIgnoreCase("B"))
       {
       ctit="Banned";
       }
       else if(ctype.equalsIgnoreCase("U"))
       {
       ctit="Unchecked";
       }
       else if(ctype.equalsIgnoreCase("M"))
       {
       ctit="Bad MIME";
       }
       else if(ctype.equalsIgnoreCase("H"))
       {
       ctit="Bad Header";
       }
       else if(ctype.equalsIgnoreCase("O"))
       {
       ctit="Oversized";
       }
       else if(ctype.equalsIgnoreCase("T"))
       {
       ctit="MTA Error";
       }
       else if(ctype.equalsIgnoreCase("C"))
       {
       ctit="Clean";
       }
                
                 %>
                    <tr> 
                       <td class="vcenter" style="cursor: pointer;" title="<%=smail1 %>"><%=smail %></td>
                        <td class="vcenter" style="cursor: pointer;" title="<%=rmail1 %>"><%=rmail %></td>
                        <td class="vcenter" style="cursor: pointer;" title="<%=sub1 %>"><%=sub %></td>
                        <td class="vcenter"><%=ip %></td>
                        <td class="vcenter"><%=dt %></td>	
                        <td class="vcenter" >
                        <a class="tooltips" href="#"><%=ctype %>
<span><%=ctit %></span></a>
                        </td>
                    </tr>
                     
                
                <%
                }
	}
	catch(SQLException e)
	{
		System.out.println(e);
	}
          System.out.println("chk        "+chk);
          
              if(chk==0)
               {  %>
               <tr><td>Search not found</td></tr>
               <%} 
               }
               else
               {
               %>
                <tr><td>Search not found</td></tr>
               <%} %>
            </tbody>
          <!--    <thead>
            <tr>
               
                <th>Content Type:</th>
                <td colspan="5" style="color:black;">
                B/U/M/H/O/T/C => Banned/Unchecked/Bad-mime/Bad-header/Oversized/Mta-err/Clean
                </td>

            </tr> 
            </thead>-->
        </table>
  </body>
</html>
