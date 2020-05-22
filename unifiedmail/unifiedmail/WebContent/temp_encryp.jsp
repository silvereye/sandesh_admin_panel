<%@ page language="java" import="java.util.*,java.io.*,Decoder.*,org.apache.commons.codec.binary.*,mypack.*,java.text.*,java.io.*,java.math.*,java.security.*,Decoder.BASE64Encoder"  pageEncoding="UTF-8"%>


<html>
  <head>
    
  </head>
  <body >
<%
//org.pf.security.crypto.CryptoConstants 
  if(true)
  {
  String password = "google@2009";
 
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        md.update(password.getBytes());
 
        byte byteData[] = md.digest();
 
        //convert the byte to hex format method 1
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < byteData.length; i++) {
         sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
        }
 
        out.println("<br>SHA-256 format : " + sb.toString());
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
    	
    	
    	 String hexString=sb.toString();
        String input=sb.toString();
         String base64 = "";
 char[] carr = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f' };
        
    byte barr[] = new byte[32];
        int bcnt = 0;
        for (int i = 0; i < 64; i += 2) {
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
       
out.print("<br>"+ encoder.encode(barr)+"<br>");
    	}
    	
    	
    	
    	if(true)
  {
  String password = "google@2009";
 
        MessageDigest md = MessageDigest.getInstance("SHA-512");
        md.update(password.getBytes());
 
        byte byteData[] = md.digest();
 
        //convert the byte to hex format method 1
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < byteData.length; i++) {
         sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
        }
 
        out.println("<br>SHA-512 format : " + sb.toString());
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
       
out.print("<br>"+ encoder.encode(barr)+"<br>");
    	}
    	
    	
    	
    	
    	if(true)
    	{
    	String passwordToHash = "google@2009";
        //String generatedPassword = null;
        try {
            // Create MessageDigest instance for MD5
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
            out.println("<br>MD5 format : "+sb.toString());
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
       

}

if(true)
{
String passwordToHash = "google@2009";
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
            out.println("<br>MD5 format : "+sb.toString());
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
       
out.print("<br>"+ encoder.encode(barr));
}
 %>
  </body>
</html>