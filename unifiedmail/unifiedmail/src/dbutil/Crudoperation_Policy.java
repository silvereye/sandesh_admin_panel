package dbutil;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Crudoperation_Policy {
	private static Connection con=null;
	private static PreparedStatement ps=null;
	private static ResultSet rs=null;
	private static Statement st=null;
	
	
	public static Connection createPolicyConnection()
	{
		try{
			Class.forName("com.mysql.jdbc.Driver");
			
		}
		catch(ClassNotFoundException e)
		{
			System.out.println(e);
		}
	try{
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/policyd","root","yahoo@9898");//192.168.0.71
			System.out.println("after connectinon");
		}
		catch(SQLException se)
		{
			System.out.println(se);
		}
	return con;	
	}
	
	
	
	
	
	public static int insertPolicy(String nm, String dsc, int pty)
	{
		int rw=0;
		con=createPolicyConnection();
		try{
			String sql="INSERT INTO policies(Name,Priority,Description,Disabled) values(?,?,?,?)";
			ps=con.prepareStatement(sql);
			
				ps.setString(1, nm);
				ps.setInt(2,pty);
				ps.setString(3, dsc);
				ps.setInt(4, 1);
				//System.out.println("hello");
			
			rw=ps.executeUpdate();
			System.out.println("after insert");
			}
		catch(SQLException e)
		{
			System.out.println(e);
		}
		return rw;
	}
	
	
	
	
	
	
	public static int insertPolicyGroups(String nm)
	{
		int rw=0;
		con=createPolicyConnection();
		try{
			String sql="INSERT INTO policy_groups(Name,Disabled) values(?,?)";
			ps=con.prepareStatement(sql);
			
				ps.setString(1, nm);
				ps.setInt(2,0);
				
				//System.out.println("hello");
			
			rw=ps.executeUpdate();
			System.out.println("after insert");
			}
		catch(SQLException e)
		{
			System.out.println(e);
		}
		return rw;
	}
	
	
	
	
	
	public static int getPGID(String nm)
	{
		con=createPolicyConnection();
		int id=0;
		try
		{
		String sql="select ID from policy_groups where name=?";
		ps=con.prepareStatement(sql);
		
		ps.setString(1,nm);
		
		System.out.println("after value setting");
		rs=ps.executeQuery();
		if(rs.next())
		{
			id=rs.getInt("id");
		}
		System.out.println("hiiiiiiiiiiii");
		}
		catch(SQLException e)
		{
			System.out.println(e);
		}
		return id;
	}
	

	
	
	
	
	public static int getPID(String nm)
	{
		con=createPolicyConnection();
		int id=0;
		try
		{
		String sql="select ID from policies where name=?";
		ps=con.prepareStatement(sql);
		
		ps.setString(1,nm);
		
		System.out.println("after value setting");
		rs=ps.executeQuery();
		if(rs.next())
		{
			id=rs.getInt("id");
		}
		System.out.println("hiiiiiiiiiiii");
		}
		catch(SQLException e)
		{
			System.out.println(e);
		}
		return id;
	}
	
	
	
	public static String getSingleData(String sql, int id)
	{
		con=createPolicyConnection();
		String vl="";
		try
		{
		
		ps=con.prepareStatement(sql);
		
		ps.setInt(1,id);
		
		System.out.println("after value setting");
		rs=ps.executeQuery();
		if(rs.next())
		{
			vl=rs.getString(1);
		}
		System.out.println("hiiiiiiiiiiii");
		}
		catch(SQLException e)
		{
			System.out.println(e);
		}
		return vl;
	}
	
	
	
	
	
	
	public static int insertPolicyGroupsMembers(String nm, int gid)
	{
		int rw=0;
		con=createPolicyConnection();
		try{
			String sql="INSERT INTO policy_group_members(PolicyGroupID,Member,Disabled) values(?,?,?)";
			ps=con.prepareStatement(sql);
			ps.setInt(1,gid);
				ps.setString(2, nm);
				ps.setInt(3,0);
				
				//System.out.println("hello");
			
			rw=ps.executeUpdate();
			System.out.println("after insert");
			}
		catch(SQLException e)
		{
			System.out.println(e);
		}
		return rw;
	}
	
	
	
	
	
	
	public static int insertPolicyMembers(int pid,String sou, String dis)
	{
		int rw=0;
		con=createPolicyConnection();
		try{
			String sql="INSERT INTO policy_members(PolicyID,Source,Destination,Disabled) values(?,?,?,?)";
			ps=con.prepareStatement(sql);
			ps.setInt(1,pid);
				ps.setString(2, sou);
				ps.setString(3, dis);
				ps.setInt(4,0);
				
				//System.out.println("hello");
			
			rw=ps.executeUpdate();
			System.out.println("after insert");
			}
		catch(SQLException e)
		{
			System.out.println(e);
		}
		return rw;
	}
	
	
	
	
	
	public static int getQtID(int pid,String track)
	{
		con=createPolicyConnection();
		int id=0;
		try
		{
		String sql="select ID from quotas where PolicyID=? and track=?";
		ps=con.prepareStatement(sql);
		
		ps.setInt(1, pid);
		ps.setString(2,track);
		
		System.out.println("after value setting");
		rs=ps.executeQuery();
		if(rs.next())
		{
			id=rs.getInt("id");
		}
		System.out.println("hiiiiiiiiiiii");
		}
		catch(SQLException e)
		{
			System.out.println(e);
		}
		return id;
	}
	
	
	
	

	public static ResultSet singlegetData(String sql, int id)
	{
		con=createPolicyConnection();
		
		try
		{
		ps=con.prepareStatement(sql);
		
		ps.setInt(1,id);
		
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

	public static ResultSet singlegetData(String sql, int id,String tp)
	{
		con=createPolicyConnection();
		
		try
		{
		ps=con.prepareStatement(sql);
		
		ps.setInt(1,id);
		ps.setString(2,tp);
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
	
	
	
	
	public static int updateData(String sql,int data,int id)
	{
		int rw=0;
		con=createPolicyConnection();
		try{
			ps=con.prepareStatement(sql);
			ps.setInt(1, data);
			ps.setInt(2, id);
			
			rw=ps.executeUpdate();
		}
		catch(SQLException e)
		{
			System.out.println(e);
		}
		return rw;
	}

	

}
