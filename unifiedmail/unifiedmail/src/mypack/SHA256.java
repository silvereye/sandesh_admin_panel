package mypack;

import java.io.*;
import java.security.*;

public class SHA256 
{

	public static String encode(String password) throws Exception {
		try
		{
		 
	        MessageDigest md = MessageDigest.getInstance("SHA-256");
	        md.update(password.getBytes());
	 
	        byte byteData[] = md.digest();
	 
	        //convert the byte to hex format method 1
	        StringBuffer sb = new StringBuffer();
	        for (int i = 0; i < byteData.length; i++) {
	         sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
	        }
	 return sb.toString();
	       // out.println("Hex format : " + sb.toString());
	 /*
	        //convert the byte to hex format method 2
	        StringBuffer hexString = new StringBuffer();
	    	for (int i=0;i<byteData.length;i++) {
	    		String hex=Integer.toHexString(0xff & byteData[i]);
	   	     	if(hex.length()==1) hexString.append('0');
	   	     	hexString.append(hex);
	    	}
	    	out.println("Hex format : " + hexString.toString());
	    	*/
		}
		catch (Exception e) {
			// TODO: handle exception
		}
		 return password;
	}
	
	
	public static String encodeMD5(String passwordToHash) throws Exception {
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
		return sb.toString();
	}
	
	
}
