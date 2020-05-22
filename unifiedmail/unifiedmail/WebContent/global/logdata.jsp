<%@ page language="java" import="java.util.*,java.sql.*,dbutil.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  
  
  <body>
      <table class="style1" cellspacing="0">
        <thead>
        <tr>
            
                <th class="checkbox">SN.</th>
            
            <th>Time</th>
            <th>Admin</th>
            <th>IP Address</th>
            <th>Message</th>
        </tr>
        </thead>

        
        <tbody>
                
                <%
                int cnt=Integer.parseInt(request.getParameter("cnt"));
                if(cnt>0)
                {
               String domain=request.getParameter("domain");
         	String admin=request.getParameter("admin");
         	String event=request.getParameter("event");
         	
     if(event==null || event.equals("") || event.equals("all"))
     {
     event="%";
     }
          
     if(domain==null || domain.equals("") || domain.equals("all"))
     {
     domain="%";
     }
     if(admin==null || admin.equals("") || admin.equals("all"))
     {
     admin="%";
     }
         	
         	
         	
  			String sql="SELECT * FROM log where msg like ? and name like ? and domain like ? ORDER BY sn DESC LIMIT ? , ?";
           Connection con=Crudoperation.createConnection();
	 int no=Integer.parseInt(request.getParameter("val").trim());
	int chk=0;
	        no=(no-1)*15;
	       chk=no;
              // String tm="good";
            //  String sql="SELECT * FROM msgs ms, msgrcpt mt where ms.mail_id=mt.mail_id and ms.sid=? ORDER BY time_num DESC LIMIT ? , ?";
          //  String tmp=id+","+no+",15";
             //String sql="SELECT cnt=count(mail_id) * FROM email_details WHERE cnt=count(mail_id) between 5 and 10";
              try
              {
           //    ResultSet rs=Crudoperation.getData(sql,tmp);
	PreparedStatement ps=con.prepareStatement(sql);
	System.out.println("after ps");
	ps.setString(1,event+"%");
	ps.setString(2,admin+"%");
	ps.setString(3,domain+"%");
	ps.setInt(4,no);
	ps.setInt(5,15);
	System.out.println("after value setting");
	ResultSet rs=ps.executeQuery();
	System.out.println("after exequetqry");
	while(rs.next())
	{
	chk=chk+1;
	 String dstr=rs.getString("ts");
 //String dt=dstr.subSequence(6,8)+"-"+dstr.subSequence(4,6)+"-"+dstr.subSequence(0,4);
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
	String ip=rs.getString("ip");
	String msg=rs.getString("msg");
	if(msg.length()>50)
	{
	msg=msg.substring(0,50)+"......";
	}
	
    
                 %>
                    
                 <tr>
                        
                            <td class="checkbox"><%=chk %></td>
                        
                        <td style="white-space: nowrap;"><%=dstr %></td>
                        <td><%=rs.getString("name") %></td>
                        <td><%=ip %></td>
                        <td class="login_info"><%=msg %></td>
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
