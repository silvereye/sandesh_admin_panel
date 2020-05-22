package mypack;

import java.security.*;
import Decoder.BASE64Encoder;
import java.io.*;
public class Encryption {
public static String MD5(String passwordToHash) throws Exception
{
	//String passwordToHash = "google@2009";
	 MessageDigest md = MessageDigest.getInstance("MD5");
	            //Add password bytes to digest
	            md.update(passwordToHash.getBytes());
	            //Get the hash's bytes
	            byte[] bytes = md.digest();
	            //This bytes[] has bytes in decimal format;
	            //Convert it to hexadecimal format
	            StringBuilder sb = new StringBuilder();
	            for(int i=0; i< bytes.length ;i++)
	            {
	                sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
	            }
	            //Get complete hashed password in hex format
	           // generatedPassword = sb.toString();
	            System.out.println("<br>MD5 format : "+sb.toString());
	       String hexString=sb.toString();
	        String input=sb.toString();
	         String base64 = "";
	 char[] carr = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f' };
	        
	    byte barr[] = new byte[16];
	        int bcnt = 0;
	        for (int i = 0; i < 32; i += 2) {
	            char c1 = input.charAt(i);
	            char c2 = input.charAt(i + 1);
	         

				int i1 = 0;
	            int i2 = 0;

	 char clower = Character.toLowerCase(c1);
	        for (int j = 0; j < carr.length;j++) {
	            if (clower == carr[j]) {
	                i1=j;
	            }
	        }
	        
	        clower = Character.toLowerCase(c2);
	        for (int j = 0; j < carr.length;j++) {
	            if (clower == carr[j]) {
	                i2=j;
	            }
	        }



	            barr[bcnt] = 0;
	            barr[bcnt] |= (byte) ((i1 & 0x0F) << 4);
	            barr[bcnt] |= (byte) (i2 & 0x0F);
	            bcnt++;
	        }

	        BASE64Encoder encoder = new BASE64Encoder();
	       
	System.out.print("<br>"+ encoder.encode(barr));
	return encoder.encode(barr);
}







public static String SHA512(String password) throws Exception
{
	//String passwordToHash = "google@2009";
	MessageDigest md = MessageDigest.getInstance("SHA-512");
    md.update(password.getBytes());

    byte byteData[] = md.digest();

    //convert the byte to hex format method 1
    StringBuffer sb = new StringBuffer();
    for (int i = 0; i < byteData.length; i++) {
     sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
    }
	            //Get complete hashed password in hex format
	           // generatedPassword = sb.toString();
	            //System.out.println("<br>MD5 format : "+sb.toString());
    
	       String hexString=sb.toString();
	        String input=sb.toString();
	         String base64 = "";
	 char[] carr = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f' };
	        
	    byte barr[] = new byte[64];
	        int bcnt = 0;
	        for (int i = 0; i < 128; i += 2) {
	            char c1 = input.charAt(i);
	            char c2 = input.charAt(i + 1);
	         

				int i1 = 0;
	            int i2 = 0;

	 char clower = Character.toLowerCase(c1);
	        for (int j = 0; j < carr.length;j++) {
	            if (clower == carr[j]) {
	                i1=j;
	            }
	        }
	        
	        clower = Character.toLowerCase(c2);
	        for (int j = 0; j < carr.length;j++) {
	            if (clower == carr[j]) {
	                i2=j;
	            }
	        }



	            barr[bcnt] = 0;
	            barr[bcnt] |= (byte) ((i1 & 0x0F) << 4);
	            barr[bcnt] |= (byte) (i2 & 0x0F);
	            bcnt++;
	        }

	        BASE64Encoder encoder = new BASE64Encoder();
	       
	System.out.print("<br>"+ encoder.encode(barr));
	return encoder.encode(barr);
}




public static String puttySSHA512(String password) throws Exception
{
	
	Process p = Runtime.getRuntime().exec("sudo /usr/local/dovecot/bin/doveadm pw -s SSHA -p "+password); //live  
	BufferedReader stdInput = new BufferedReader(new InputStreamReader(p.getInputStream()));
	String s="";
	while ((s = stdInput.readLine()) != null) 
	{
	      System.out.println("<br>"+s);
	       break;
	        
	}
	return s;
}


}
