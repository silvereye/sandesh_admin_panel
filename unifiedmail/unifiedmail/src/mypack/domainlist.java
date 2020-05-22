package mypack;

import java.util.Enumeration;

import javax.naming.NamingEnumeration;
import javax.naming.directory.Attribute;
import javax.naming.directory.Attributes;
import javax.naming.directory.DirContext;
import javax.naming.directory.SearchControls;
import javax.naming.directory.SearchResult;
import javax.servlet.http.HttpSession;

public class domainlist {
	public static String getDomList(HttpSession hs)
	{
		 String username= (String)hs.getAttribute("id");
	        String password= (String)hs.getAttribute("password");
	        String url= (String)hs.getAttribute("url");
	        String mbase= (String)hs.getAttribute("base");
	        String base="o=domains,"+mbase;
	        String dom="";
	       try
	       {
	        DirContext ctx=LDAPConnection.getConnection(url, base, username, password);

	        SearchControls constraints = new SearchControls(); 
	        constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
	        String attrList[] = {"domainName"}; 
	        constraints.setReturningAttributes(attrList);
	        NamingEnumeration results =ctx.search(base,"domainName=*", constraints);
	        int f=0;
	        int x=0;
	        while (results.hasMore()) {
	        f=1;
	            SearchResult si =(SearchResult)results.next();
	            String ck=si.getName();
	           System.out.println("<br><br><br>"+ck);
	            Attributes attrs = si.getAttributes();

	            if (attrs == null) {
	              // out.println("   No attributes");
	                continue;
	            }
	            
	            x++;
	            NamingEnumeration ae = attrs.getAll(); 
	            while (ae.hasMoreElements()) {
	                Attribute attr =(Attribute)ae.next();
	                String id = attr.getID();
	                Enumeration vals = attr.getAll();
	                while (vals.hasMoreElements())
	                {
	                String str= vals.nextElement().toString();
	                 if(id.equalsIgnoreCase("domainName"))
	                {
	                	 if(dom.equalsIgnoreCase(""))
	                	 {
	                		dom=str; 
	                	 }
	                	 else
	                	 {
	                		 dom=dom+","+str;
	                	 }
	                }
	                
	                   //out.println("  <br> "+id + ":--- " +str);
	                   }
	            }
		   
	}
	        
	        try
	        {
	        	LDAPConnection.closeConn( ctx);
	        }
	        catch(Exception ec)
	        {
	        	ec.printStackTrace();
	        }
	       }
	       catch (Exception e) {
	    	   System.out.println(e);
			// TODO: handle exception
		}
	        return dom;
	}


}
