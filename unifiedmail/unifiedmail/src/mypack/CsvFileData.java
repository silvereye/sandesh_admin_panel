package mypack;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;
import java.util.StringTokenizer;


public class CsvFileData {
	public static String getFileData(String fileName)
	{
		String ms=null;
		int f=0;
		try {
			
			BufferedReader br = new BufferedReader( new FileReader(fileName));
			StringTokenizer st = null;
			while( (fileName = br.readLine()) != null)
			{
			f++;
			System.out.println("cvs row "+f);
			
			//break comma separated line using ","
			st = new StringTokenizer(fileName, ",");
			System.out.println(fileName);
			if(f!=1)
			{
				if(fileName!=null && !(fileName.equals("")))
				{	
			if(ms==null)
			{
			ms=fileName;
			}
			else
				ms=ms+";"+fileName;	
			}
			}
		/*	while(st.hasMoreTokens())
			{
				if(ms!=null)
				{
				ms=ms+st.nextToken()+",";
				}
				else
				{
				ms=st.nextToken()+",";
				}
			//display csv values
		
			/*System.out.println("Line # " + lineNumber +
			", Token # " + tokenNumber
			+ ", Token : "+ st.nextToken());
			}*/
			
			
			}
			
			System.out.println(ms);
			
			}
			catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			}
			if(f==0 || f==1)
			{
				return "empty";
			}
			return ms;
	}

}
