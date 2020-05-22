package dbutil;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Crudoperation {
private static Connection con=null;
private static PreparedStatement ps=null;
private static ResultSet rs=null;
private static Statement st=null;


public static Connection createSpamConnection()
{
	try{
		Class.forName("com.mysql.jdbc.Driver");
		
	}
	catch(ClassNotFoundException e)
	{
		System.out.println(e);
	}
try{
		con=DriverManager.getConnection("jdbc:mysql://localhost:3306/spam_db","root","yahoo@9898");
		System.out.println("after connectinon");
	}
	catch(SQLException se)
	{
		System.out.println(se);
	}
return con;	
}

public static Connection createConnection()
{
	try{
		Class.forName("com.mysql.jdbc.Driver");
		System.out.println("driver");
	}
	catch(ClassNotFoundException e)
	{
		System.out.println(e);
	}
try{
		con=DriverManager.getConnection("jdbc:mysql://localhost:3306/amavisd","root","yahoo@9898");//192.168.0.71
		System.out.println("after connectinon");
	}
	catch(SQLException se)
	{
		System.out.println(se);
	}
return con;	
}








public static String getIdToMail(String mail, String sql)
{
	con=createConnection();
	String id="";
	try
	{
	ps=con.prepareStatement(sql);
	System.out.println("after ps");
	ps.setString(1,mail);
	System.out.println("after value setting");
	rs=ps.executeQuery();
	System.out.println("after exequetqry");
	if(rs.next())
	{
	id=rs.getString("id").toString()	;
	}
	if(con!=null)
		con.close();
	}
catch(SQLException e)
{
	System.out.println(e);
	if(con!=null)
		try {
			con.close();
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
}
	return id;
}




public static String getMailToId(String id, String sql)
{
	con=createConnection();
	String mail="";
	try
	{
	ps=con.prepareStatement(sql);
	System.out.println("after ps");
	ps.setInt(1,Integer.parseInt(id));
	System.out.println("after value setting");
	rs=ps.executeQuery();
	System.out.println("after exequetqry");
	if(rs.next())
	{
	mail=rs.getString("email").toString()	;
	}
	if(con!=null)
		con.close();
	}
catch(SQLException e)
{
	System.out.println(e);
	if(con!=null)
		try {
			con.close();
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
}
	return mail;
}


public static ResultSet getData(String sql, String param)
{
	con=createConnection();
	String arr[]=param.split(",");
	String ui=arr[0];
	String upass=arr[1];
	System.out.println(ui+upass);
	try
	{
	ps=con.prepareStatement(sql);
	System.out.println("after ps");
	ps.setString(1,ui);
	ps.setString(2,upass);
	System.out.println("after value setting");
	rs=ps.executeQuery();
	System.out.println("after exequetqry");
	}
	catch(SQLException e)
	{
		System.out.println(e);
	}
	return rs;
}






public static ResultSet singlegetData(String sql, String param)
{
	con=createConnection();
	
	try
	{
	ps=con.prepareStatement(sql);
	
	ps.setString(1,param);
	
	System.out.println("after value setting");
	rs=ps.executeQuery();
	System.out.println("hiiiiiiiiiiii");
	}
	catch(SQLException e)
	{
		System.out.println(e);
	}
	return rs;
}



public static int insertlog(String sql,String data)
{
	String usrarr[]=data.split(",");
	int rw=0;
	con=createConnection();
	try{
		
		ps=con.prepareStatement(sql);
		for(int an=0; an<usrarr.length;an++)
		{
			ps.setString(an+1, usrarr[an]);
			System.out.println("hello");
		}
		rw=ps.executeUpdate();
		System.out.println("after insert");
		if(con!=null)
			con.close();
		}
	catch(SQLException e)
	{
		System.out.println(e);
		if(con!=null)
			try {
				con.close();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
	}
	
	return rw;
	}



public static int insertData(String sql,String data)
{
	String usrarr[]=data.split("-");
	int rw=0;
	con=createConnection();
	try{
		
		ps=con.prepareStatement(sql);
		for(int an=0; an<usrarr.length;an++)
		{
			ps.setString(an+1, usrarr[an]);
			System.out.println("hello");
		}
		rw=ps.executeUpdate();
		System.out.println("after insert");
		}
	catch(SQLException e)
	{
		System.out.println(e);
	}
	return rw;
	}







public static ResultSet getDataStatement(String sql)
{
	con=createConnection();
	try{
	
	st=con.createStatement();
	rs=st.executeQuery(sql);
	
	}
	catch(SQLException e)
	{
		System.out.println(e);
	}
	return rs;
}



public static int updateData(String sql,String data)
{
	int rw=0;
	con=createConnection();
	try{
		String usrarr[]=data.split(",");
		System.out.println("in updatedatas........");
		ps=con.prepareStatement(sql);
		for(int i=0;i<usrarr.length;i++)
		{
			ps.setString(i+1,usrarr[i]);	
		}
		/*
		ps.setString(1,usrarr[0]);
		ps.setString(2,usrarr[1]);
		ps.setString(3,usrarr[2]);
		ps.setString(4,usrarr[3]);
		ps.setString(5,usrarr[4]); */
		rw=ps.executeUpdate();
		System.out.println("rw="+rw);
	}
	catch(SQLException e)
	{
		System.out.println(e);
	}
	return rw;
}



public static int updateSingleData(String sql,String data,String img)
{
	int rw=0;
	con=createConnection();
	try{
		System.out.println("in update");
		System.out.println(data+"         "+img);
		ps=con.prepareStatement(sql);
		ps.setString(1, img);
		ps.setString(2, data);
		rw=ps.executeUpdate();
		System.out.println(rw);
		
	}
	catch(SQLException e)
	{
		System.out.println(e);
	}
	return rw;
}




public static int updateDateData(String sql,String data,java.sql.Date sd,String img)
{
	int rw=0;
	con=createConnection();
	try{
		ps=con.prepareStatement(sql);
		ps.setString(1, img);
		ps.setDate(2, sd);
		ps.setString(3, data);
		rw=ps.executeUpdate();
	}
	catch(SQLException e)
	{
		System.out.println(e);
	}
	return rw;
}


}





