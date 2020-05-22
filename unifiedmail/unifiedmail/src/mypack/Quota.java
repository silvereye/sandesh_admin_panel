package mypack;
import java.io.*;
public class Quota {
	public String getQuota(String uid)
	{
		String s="";
		try
		{
		Process p = Runtime.getRuntime().exec("sudo /usr/local/dovecot/bin/doveadm quota get -u "+uid); //live  
		//Process p = Runtime.getRuntime().exec("sudo /usr/bin/doveadm quota get -u "+uid);  	
		BufferedReader stdInput = new BufferedReader(new InputStreamReader(p.getInputStream()));
		
		while ((s = stdInput.readLine()) != null) 
		{
		       // out.println("<br>"+s);
		       break;
		        
		}
		
		
		}catch(Exception e){System.out.print(e.toString());}
		return s;
	}

}
