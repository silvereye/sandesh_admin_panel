package mypack;
import dbutil.*;
import java.sql.*;
public class MailCount {
public static int sentMailCnt(String dm, String dt)
{
	int cnt=0;
	String sq="SELECT count(*) FROM msgs ms, msgrcpt mt where ms.mail_id=mt.mail_id and ( (select email from maddr where id=ms.sid ) like ?) and (ms.content NOT IN (?, ?, ?)) and  ( ms.time_iso like ?) ";
	Connection cnt_con=Crudoperation.createConnection();
	try
	{
	PreparedStatement cnt_ps=cnt_con.prepareStatement(sq);
	cnt_ps.setString(1,"%"+dm);
	cnt_ps.setString(2,"S");
	cnt_ps.setString(3,"Y");
	cnt_ps.setString(4,"V");
	cnt_ps.setString(5,dt+"%");
	ResultSet cnt_rs=cnt_ps.executeQuery();
   	if(cnt_rs.next())
	{
	cnt=cnt_rs.getInt(1);
	System.out.println("cnt  "+cnt);
	}
	}
	catch (Exception e) {
		// TODO: handle exception
	}
	
	return cnt;
}

public static int recMailCnt(String dm, String dt)
{
	int cnt=0;
	String sq="SELECT count(*) FROM msgs ms, msgrcpt mt where ms.mail_id=mt.mail_id and ( (select email from maddr where id=mt.rid ) like ?) and ms.content NOT IN (?, ?, ?)  and  ( ms.time_iso like ?) ";
	try
	{
	Connection cnt_con=Crudoperation.createConnection();
	PreparedStatement cnt_ps=cnt_con.prepareStatement(sq);
	cnt_ps.setString(1,"%"+dm);
	cnt_ps.setString(2,"S");
	cnt_ps.setString(3,"Y");
	cnt_ps.setString(4,"V");
	cnt_ps.setString(5,dt+"%");
	ResultSet cnt_rs=cnt_ps.executeQuery();
   	if(cnt_rs.next())
	{
	cnt=cnt_rs.getInt(1);
	System.out.println("cnt  "+cnt);
	}
	}
	catch (Exception e) {
		// TODO: handle exception
	}
	
	return cnt;
}



public static int spamVMailCnt(String dm, String dt)
{
	int cnt=0;

	try
	{
	String sq="SELECT count(*) FROM msgs ms, msgrcpt mt where ms.mail_id=mt.mail_id and (( (select email from maddr where id=mt.rid ) like ?) or ( (select email from maddr where id=ms.sid ) like ?)) and ms.content NOT IN (?, ?, ?,?,?,?,?) and  ( ms.time_iso like ?)";
	Connection cnt_con=Crudoperation.createConnection();
	PreparedStatement cnt_ps=cnt_con.prepareStatement(sq);
	cnt_ps.setString(1,"%"+dm);
	cnt_ps.setString(2,"%"+dm);
	cnt_ps.setString(3,"B");
	cnt_ps.setString(4,"U");
	cnt_ps.setString(5,"M");
	cnt_ps.setString(6,"H");
	cnt_ps.setString(7,"O");
	cnt_ps.setString(8,"T");
	cnt_ps.setString(9,"C");
	cnt_ps.setString(10,dt+"%");
	ResultSet cnt_rs=cnt_ps.executeQuery();
   	if(cnt_rs.next())
	{
	cnt=cnt_rs.getInt(1);
	System.out.println("cnt  "+cnt);
	}
	}
	catch (Exception e) {
		// TODO: handle exception
	}
	
	return cnt;
}



public static int quarMailCnt(String dm, String dt)
{
	int cnt=0;
	try
	{
		String sq="SELECT count(*) FROM msgs ms, msgrcpt mt where ms.mail_id=mt.mail_id and (( (select email from maddr where id=mt.rid ) like ?) or ( (select email from maddr where id=ms.sid ) like ?)) and ms.quar_type=? and  ( ms.time_iso like ?)";
    	Connection cnt_con=Crudoperation.createConnection();
    	PreparedStatement cnt_ps=cnt_con.prepareStatement(sq);
    	cnt_ps.setString(1,"%"+dm);
    	cnt_ps.setString(2,"%"+dm);
    	cnt_ps.setString(3,"Q");
    	cnt_ps.setString(4,dt+"%");
    	ResultSet cnt_rs=cnt_ps.executeQuery();
       	if(cnt_rs.next())
    	{
    	cnt=cnt_rs.getInt(1);
    	System.out.println("cnt  "+cnt);
    	}
    	
	}
	catch (Exception e) {
		// TODO: handle exception
	}
	
	return cnt;
}


}
