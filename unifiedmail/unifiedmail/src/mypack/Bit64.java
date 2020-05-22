package mypack;



import org.apache.commons.codec.binary.Base64;
public class Bit64 {
	 public static String base64Encode(String stringToEncode){
		  byte [] stringToEncodeBytes = stringToEncode.getBytes();
		  return Base64.encodeBase64String(stringToEncodeBytes);
		 }
		 
		 public static String base64Decode(String stringToDecode){
		  byte [] decodedBytes = Base64.decodeBase64(stringToDecode);
		  return new String(decodedBytes);
		 }
}
