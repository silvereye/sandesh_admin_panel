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
                long count=0;
                int chk=0;
                if(cnt>0)
                {
               	try
                   {
               		PreparedStatement ps=null;
               		Connection con=Crudoperation.createConnection();
        	        int no=Integer.parseInt(request.getParameter("val").trim());
        	       
        	        no=(no-1)*15;
        	long sid=0;
        	long rid=0;
            String send=request.getParameter("send");
         	String recip=request.getParameter("recip");
         	String sub=request.getParameter("sub");
         	String serchDT=request.getParameter("serchDT");
  			if(send==null)
  				send="";
  			if(recip==null)
  				recip="";
  			if(sub==null)
  				sub="";
  			if(serchDT==null)
  				serchDT="";
         	if(send.length()>0)
         	{
         	String sendid=Crudoperation.getIdToMail("%"+send+"%","SELECT * FROM maddr where email LIKE ?");
  			if(sendid!=null && sendid.length()>0)	
  				sid=Long.parseLong(sendid);
         	}
         	if(recip.length()>0)
         	{
  			String recipid=Crudoperation.getIdToMail("%"+recip+"%","SELECT * FROM maddr where email LIKE ?");
  			if(recipid!=null && recipid.length()>0)	
  				rid=Long.parseLong(recipid);
         	}
  			
         	
  			if(sid >0 && rid >0 && sub.length()>0 && serchDT.length()>0)
  			{
  				String sq="SELECT count(*) FROM msgs ms, msgrcpt mt where ms.mail_id=mt.mail_id and ms.sid=? and  mt.rid=? and ms.subject LIKE ? and ms.time_iso LIKE ? ORDER BY time_num DESC";
            	Connection cnt_con=Crudoperation.createConnection();
            	PreparedStatement cnt_ps=cnt_con.prepareStatement(sq);
            	cnt_ps.setLong(1,sid);
            	cnt_ps.setLong(2,rid);
            	cnt_ps.setString(3,"%"+sub+"%");
            	cnt_ps.setString(4,serchDT+"%");
            	ResultSet cnt_rs=cnt_ps.executeQuery();
               	if(cnt_rs.next())
            	{
            	count=cnt_rs.getLong(1);
            	}
               	
               	String sql="SELECT * FROM msgs ms, msgrcpt mt where ms.mail_id=mt.mail_id and ms.sid=? and  mt.rid=? and ms.subject LIKE ? and ms.time_iso LIKE ? ORDER BY time_num DESC LIMIT ? , ?";
    			ps=con.prepareStatement(sql);
    			ps.setLong(1,sid);
            	ps.setLong(2,rid);
            	ps.setString(3,"%"+sub+"%");
            	ps.setString(4,serchDT+"%");
    			ps.setInt(5,no);
    			ps.setInt(6,15);
               	
  			}
  			else if(sid >0 && rid >0 && sub.length()>0 )
  			{
  				String sq="SELECT count(*) FROM msgs ms, msgrcpt mt where ms.mail_id=mt.mail_id and ms.sid=? and  mt.rid=? and ms.subject LIKE ? ORDER BY time_num DESC";
            	Connection cnt_con=Crudoperation.createConnection();
            	PreparedStatement cnt_ps=cnt_con.prepareStatement(sq);
            	cnt_ps.setLong(1,sid);
            	cnt_ps.setLong(2,rid);
            	cnt_ps.setString(3,"%"+sub+"%");
            	ResultSet cnt_rs=cnt_ps.executeQuery();
               	if(cnt_rs.next())
            	{
            	count=cnt_rs.getLong(1);
            	}
               	
               	String sql="SELECT * FROM msgs ms, msgrcpt mt where ms.mail_id=mt.mail_id and ms.sid=? and  mt.rid=? and ms.subject LIKE ? ORDER BY time_num DESC LIMIT ? , ?";
    			ps=con.prepareStatement(sql);
    			ps.setLong(1,sid);
            	ps.setLong(2,rid);
            	ps.setString(3,"%"+sub+"%");
    			ps.setInt(4,no);
    			ps.setInt(5,15);
               	
  			}
  			else if(sid >0 && rid >0 && serchDT.length()>0)
  			{
  				String sq="SELECT count(*) FROM msgs ms, msgrcpt mt where ms.mail_id=mt.mail_id and ms.sid=? and  mt.rid=? and ms.time_iso LIKE ? ORDER BY time_num DESC";
            	Connection cnt_con=Crudoperation.createConnection();
            	PreparedStatement cnt_ps=cnt_con.prepareStatement(sq);
            	cnt_ps.setLong(1,sid);
            	cnt_ps.setLong(2,rid);
            	cnt_ps.setString(3,serchDT+"%");
            	ResultSet cnt_rs=cnt_ps.executeQuery();
               	if(cnt_rs.next())
            	{
            	count=cnt_rs.getLong(1);
            	}
               	
               	String sql="SELECT * FROM msgs ms, msgrcpt mt where ms.mail_id=mt.mail_id and ms.sid=? and  mt.rid=? and ms.time_iso LIKE ? ORDER BY time_num DESC LIMIT ? , ?";
    			ps=con.prepareStatement(sql);
    			ps.setLong(1,sid);
            	ps.setLong(2,rid);
            	ps.setString(3,serchDT+"%");
    			ps.setInt(4,no);
    			ps.setInt(5,15);
  			}
  			else if(rid >0 && sub.length()>0 && serchDT.length()>0)
  			{
  				String sq="SELECT count(*) FROM msgs ms, msgrcpt mt where ms.mail_id=mt.mail_id and  mt.rid=? and ms.subject LIKE ? and ms.time_iso LIKE ? ORDER BY time_num DESC";
            	Connection cnt_con=Crudoperation.createConnection();
            	PreparedStatement cnt_ps=cnt_con.prepareStatement(sq);
            	cnt_ps.setLong(1,rid);
            	cnt_ps.setString(2,"%"+sub+"%");
            	cnt_ps.setString(3,serchDT+"%");
            	ResultSet cnt_rs=cnt_ps.executeQuery();
               	if(cnt_rs.next())
            	{
            	count=cnt_rs.getLong(1);
            	}

               	String sql="SELECT * FROM msgs ms, msgrcpt mt where ms.mail_id=mt.mail_id and  mt.rid=? and ms.subject LIKE ? and ms.time_iso LIKE ? ORDER BY time_num DESC LIMIT ? , ?";
    			ps=con.prepareStatement(sql);
            	ps.setLong(1,rid);
            	ps.setString(2,"%"+sub+"%");
            	ps.setString(3,serchDT+"%");
    			ps.setInt(4,no);
    			ps.setInt(5,15);
  			}
  			else if(sid >0 && sub.length()>0 && serchDT.length()>0)
  			{
  				String sq="SELECT count(*) FROM msgs ms, msgrcpt mt where ms.mail_id=mt.mail_id and ms.sid=? and  ms.subject LIKE ? and ms.time_iso LIKE ? ORDER BY time_num DESC";
            	Connection cnt_con=Crudoperation.createConnection();
            	PreparedStatement cnt_ps=cnt_con.prepareStatement(sq);
            	cnt_ps.setLong(1,sid);
            	cnt_ps.setString(2,"%"+sub+"%");
            	cnt_ps.setString(3,serchDT+"%");
            	ResultSet cnt_rs=cnt_ps.executeQuery();
               	if(cnt_rs.next())
            	{
            	count=cnt_rs.getLong(1);
            	}
               	
               	String sql="SELECT * FROM msgs ms, msgrcpt mt where ms.mail_id=mt.mail_id and ms.sid=? and ms.subject LIKE ? and ms.time_iso LIKE ? ORDER BY time_num DESC LIMIT ? , ?";
    			ps=con.prepareStatement(sql);
    			ps.setLong(1,sid);
            	ps.setString(2,"%"+sub+"%");
            	ps.setString(3,serchDT+"%");
    			ps.setInt(4,no);
    			ps.setInt(5,15);
  			}
  			else if(sid >0 && rid >0 )
  			{
  				String sq="SELECT count(*) FROM msgs ms, msgrcpt mt where ms.mail_id=mt.mail_id and ms.sid=? and  mt.rid=? ORDER BY time_num DESC";
            	Connection cnt_con=Crudoperation.createConnection();
            	PreparedStatement cnt_ps=cnt_con.prepareStatement(sq);
            	cnt_ps.setLong(1,sid);
            	cnt_ps.setLong(2,rid);
            	ResultSet cnt_rs=cnt_ps.executeQuery();
               	if(cnt_rs.next())
            	{
            	count=cnt_rs.getLong(1);
            	}
               	
               	String sql="SELECT * FROM msgs ms, msgrcpt mt where ms.mail_id=mt.mail_id and ms.sid=? and  mt.rid=? ORDER BY time_num DESC LIMIT ? , ?";
    			ps=con.prepareStatement(sql);
    			ps.setLong(1,sid);
            	ps.setLong(2,rid);
            	ps.setInt(3,no);
    			ps.setInt(4,15);
  			}
  			else if(sid >0 && sub.length()>0 )
  			{
  				String sq="SELECT count(*) FROM msgs ms, msgrcpt mt where ms.mail_id=mt.mail_id and ms.sid=? and  ms.subject LIKE ? ORDER BY time_num DESC";
            	Connection cnt_con=Crudoperation.createConnection();
            	PreparedStatement cnt_ps=cnt_con.prepareStatement(sq);
            	cnt_ps.setLong(1,sid);
            	cnt_ps.setString(2,"%"+sub+"%");
            	ResultSet cnt_rs=cnt_ps.executeQuery();
               	if(cnt_rs.next())
            	{
            	count=cnt_rs.getLong(1);
            	}
               	
               	String sql="SELECT * FROM msgs ms, msgrcpt mt where ms.mail_id=mt.mail_id and ms.sid=? and ms.subject LIKE ? ORDER BY time_num DESC LIMIT ? , ?";
    			ps=con.prepareStatement(sql);
    			ps.setLong(1,sid);
            	ps.setString(2,"%"+sub+"%");
    			ps.setInt(3,no);
    			ps.setInt(4,15);
  			}
  			else if(sid >0 && serchDT.length()>0)
  			{
  				String sq="SELECT count(*) FROM msgs ms, msgrcpt mt where ms.mail_id=mt.mail_id and ms.sid=? and ms.time_iso LIKE ? ORDER BY time_num DESC";
            	Connection cnt_con=Crudoperation.createConnection();
            	PreparedStatement cnt_ps=cnt_con.prepareStatement(sq);
            	cnt_ps.setLong(1,sid);
            	cnt_ps.setString(2,serchDT+"%");
            	ResultSet cnt_rs=cnt_ps.executeQuery();
               	if(cnt_rs.next())
            	{
            	count=cnt_rs.getLong(1);
            	}
               	
               	String sql="SELECT * FROM msgs ms, msgrcpt mt where ms.mail_id=mt.mail_id and ms.sid=? and ms.time_iso LIKE ? ORDER BY time_num DESC LIMIT ? , ?";
    			ps=con.prepareStatement(sql);
    			ps.setLong(1,sid);
            	ps.setString(2,serchDT+"%");
    			ps.setInt(3,no);
    			ps.setInt(4,15);
  			}
  			else if(rid >0 && sub.length()>0)
  			{
  				String sq="SELECT count(*) FROM msgs ms, msgrcpt mt where ms.mail_id=mt.mail_id and  mt.rid=? and ms.subject LIKE ? ORDER BY time_num DESC";
            	Connection cnt_con=Crudoperation.createConnection();
            	PreparedStatement cnt_ps=cnt_con.prepareStatement(sq);
            	cnt_ps.setLong(1,rid);
            	cnt_ps.setString(2,"%"+sub+"%");
            	ResultSet cnt_rs=cnt_ps.executeQuery();
               	if(cnt_rs.next())
            	{
            	count=cnt_rs.getLong(1);
            	}
               	
               	String sql="SELECT * FROM msgs ms, msgrcpt mt where ms.mail_id=mt.mail_id and  mt.rid=? and ms.subject LIKE ? ORDER BY time_num DESC LIMIT ? , ?";
    			ps=con.prepareStatement(sql);
            	ps.setLong(1,rid);
            	ps.setString(2,"%"+sub+"%");
    			ps.setInt(3,no);
    			ps.setInt(4,15);
  			}
  			else if( rid >0 && serchDT.length()>0)
  			{
  				String sq="SELECT count(*) FROM msgs ms, msgrcpt mt where ms.mail_id=mt.mail_id and  mt.rid=? and ms.time_iso LIKE ? ORDER BY time_num DESC";
            	Connection cnt_con=Crudoperation.createConnection();
            	PreparedStatement cnt_ps=cnt_con.prepareStatement(sq);
            	cnt_ps.setLong(1,rid);
            	cnt_ps.setString(2,serchDT+"%");
            	ResultSet cnt_rs=cnt_ps.executeQuery();
               	if(cnt_rs.next())
            	{
            	count=cnt_rs.getLong(1);
            	}
               	
               	String sql="SELECT * FROM msgs ms, msgrcpt mt where ms.mail_id=mt.mail_id and mt.rid=? and ms.time_iso LIKE ? ORDER BY time_num DESC LIMIT ? , ?";
    			ps=con.prepareStatement(sql);
            	ps.setLong(1,rid);
            	ps.setString(2,serchDT+"%");
    			ps.setInt(3,no);
    			ps.setInt(4,15);
  			}
  			else if(sub.length()>0 && serchDT.length()>0)
  			{
  				String sq="SELECT count(*) FROM msgs ms, msgrcpt mt where ms.mail_id=mt.mail_id and  ms.subject LIKE ? and ms.time_iso LIKE ? ORDER BY time_num DESC";
            	Connection cnt_con=Crudoperation.createConnection();
            	PreparedStatement cnt_ps=cnt_con.prepareStatement(sq);
            	cnt_ps.setString(1,"%"+sub+"%");
            	cnt_ps.setString(2,serchDT+"%");
            	ResultSet cnt_rs=cnt_ps.executeQuery();
               	if(cnt_rs.next())
            	{
            	count=cnt_rs.getLong(1);
            	}
               	
               	String sql="SELECT * FROM msgs ms, msgrcpt mt where ms.mail_id=mt.mail_id and ms.subject LIKE ? and ms.time_iso LIKE ? ORDER BY time_num DESC LIMIT ? , ?";
    			ps=con.prepareStatement(sql);
    			ps.setString(1,"%"+sub+"%");
            	ps.setString(2,serchDT+"%");
    			ps.setInt(3,no);
    			ps.setInt(4,15);
  			}
  			else if(sid >0 )
  			{
  				String sq="SELECT count(*) FROM msgs ms, msgrcpt mt where ms.mail_id=mt.mail_id and ms.sid=? ORDER BY time_num DESC";
            	Connection cnt_con=Crudoperation.createConnection();
            	PreparedStatement cnt_ps=cnt_con.prepareStatement(sq);
            	cnt_ps.setLong(1,sid);
            	ResultSet cnt_rs=cnt_ps.executeQuery();
               	if(cnt_rs.next())
            	{
            	count=cnt_rs.getLong(1);
            	}
               	
               	String sql="SELECT * FROM msgs ms, msgrcpt mt where ms.mail_id=mt.mail_id and ms.sid=? ORDER BY time_num DESC LIMIT ? , ?";
    			ps=con.prepareStatement(sql);
    			ps.setLong(1,sid);
    			ps.setInt(2,no);
    			ps.setInt(3,15);
  			}
  			else if( rid >0 )
  			{
  				String sq="SELECT count(*) FROM msgs ms, msgrcpt mt where ms.mail_id=mt.mail_id and mt.rid=? ORDER BY time_num DESC";
            	Connection cnt_con=Crudoperation.createConnection();
            	PreparedStatement cnt_ps=cnt_con.prepareStatement(sq);
            	cnt_ps.setLong(1,rid);
            	ResultSet cnt_rs=cnt_ps.executeQuery();
               	if(cnt_rs.next())
            	{
            	count=cnt_rs.getLong(1);
            	}
               	
               	String sql="SELECT * FROM msgs ms, msgrcpt mt where ms.mail_id=mt.mail_id and mt.rid=? ORDER BY time_num DESC LIMIT ? , ?";
    			ps=con.prepareStatement(sql);
            	ps.setLong(1,rid);
    			ps.setInt(2,no);
    			ps.setInt(3,15);
  			}
  			else if(sub.length()>0 )
  			{
  				String sq="SELECT count(*) FROM msgs ms, msgrcpt mt where ms.mail_id=mt.mail_id and ms.subject LIKE ? ORDER BY time_num DESC";
            	Connection cnt_con=Crudoperation.createConnection();
            	PreparedStatement cnt_ps=cnt_con.prepareStatement(sq);
            	cnt_ps.setString(1,"%"+sub+"%");
            	ResultSet cnt_rs=cnt_ps.executeQuery();
               	if(cnt_rs.next())
            	{
            	count=cnt_rs.getLong(1);
            	}
               	
               	String sql="SELECT * FROM msgs ms, msgrcpt mt where ms.mail_id=mt.mail_id and ms.subject LIKE ? ORDER BY time_num DESC LIMIT ? , ?";
    			ps=con.prepareStatement(sql);
    			ps.setString(1,"%"+sub+"%");
    			ps.setInt(2,no);
    			ps.setInt(3,15);
  			}
  			else if(serchDT.length()>0)
  			{
  				String sq="SELECT count(*) FROM msgs ms, msgrcpt mt where ms.mail_id=mt.mail_id and ms.time_iso LIKE ? ORDER BY time_num DESC";
            	Connection cnt_con=Crudoperation.createConnection();
            	PreparedStatement cnt_ps=cnt_con.prepareStatement(sq);
            	cnt_ps.setString(1,serchDT+"%");
            	ResultSet cnt_rs=cnt_ps.executeQuery();
               	if(cnt_rs.next())
            	{
            	count=cnt_rs.getLong(1);
            	}
               	
               	String sql="SELECT * FROM msgs ms, msgrcpt mt where ms.mail_id=mt.mail_id and ms.time_iso LIKE ? ORDER BY time_num DESC LIMIT ? , ?";
    			ps=con.prepareStatement(sql);
    			ps.setString(1,serchDT+"%");
    			ps.setInt(2,no);
    			ps.setInt(3,15);
  			}
  				
  			

	
	
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
	
	String subj=rs.getString("ms.subject");
	String sub1=rs.getString("ms.subject");
	if(subj.length()>35)
	{
	subj=subj.substring(0,35)+"......";
	}
	
	String rmail=Crudoperation.getMailToId(""+rs.getInt("mt.rid"),"SELECT * FROM maddr where id=?");
	String smail=Crudoperation.getMailToId(""+rs.getInt("ms.sid"),"SELECT * FROM maddr where id=?");
	 String rmail1=rmail;
   if(rmail.length()>30)
	{
	rmail=rmail.substring(0,30)+"......";
	}
   
   String smail1=smail;
   if(smail.length()>30)
	{
	smail=smail.substring(0,30)+"......";
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
       else  if(ctype.equalsIgnoreCase("V"))
       {
       ctit="Virus";
       }
       else if(ctype.equalsIgnoreCase("S"))
       {
       ctit="Spam(kill)";
       }
       else if(ctype.equalsIgnoreCase("Y"))
       {
       ctit="Spammy(tag2)";
       }
                
                 %>
                    <tr> 
                        <td class="vcenter" style="cursor: pointer;" title="<%=smail1 %>"><%=smail %></td>
                         <td class="vcenter" style="cursor: pointer;" title="<%=rmail1 %>"><%=rmail %></td>
                        <td class="vcenter" style="cursor: pointer;" title="<%=sub1 %>"><%=subj %></td>
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
        <input type="hidden" id="hidc" name="hid_cnt" value="<%=count %>"/>
  </body>
</html>
