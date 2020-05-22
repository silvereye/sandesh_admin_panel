<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" import="java.util.*,mypack.*" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.regex.*" %>
<%@ page import="javax.naming.directory.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

    int cnt=0;
        
   			HttpSession hs=request.getSession(false);
		        String username=(String)hs.getAttribute("id");
		        String password=(String)hs.getAttribute("password");
		        String url=(String)hs.getAttribute("url");
		        String base1=(String)hs.getAttribute("base");
		        String utype=(String)hs.getAttribute("user_name");
		     
  String uid=request.getParameter("uid");
  String accst=request.getParameter("accst");
try
{
int f=0;
int x=0;
int icnt=0;

String dom="";
dom=request.getParameter("dm");
System.out.println("dom="+dom);
if(dom.equals("") || dom==null)
{
dom=domainlist.getDomList(hs);
}



System.out.println("list           "+dom); 
String arr_dm[]=dom.split(",");
for(int i=0;i<arr_dm.length;i++)
{
String base="ou=Users,domainName="+arr_dm[i]+",o=domains,"+base1;//dc=springbirds,dc=co,dc=in";//"ou=Users,domainName="+arr_dm[i]+",o=domains"+(String)hs.getAttribute("base");
DirContext ctx=LDAPConnection.getConnection(url, base, username, password);
String v1="";
String v2="";
String v3="";
String qt="";
String dt=" ";
//String init="Mr";
SearchControls constraints = new SearchControls(); 
constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
String attrList[] = {"cn","accountStatus","mail","jpegPhoto"}; 
constraints.setReturningAttributes(attrList);
String filter = "(&(accountStatus="+accst+")(mail="+uid+"))";
NamingEnumeration results =ctx.search(base,filter, constraints);

while (results.hasMore()) {
f=1;
String photo="";
    SearchResult si =(SearchResult)results.next();
    String ck=si.getName();
    String ml=ck.replace("mail=", "");
 //  System.out.println("<br><br><br>"+ck);
    Attributes attrs = si.getAttributes();
String arr[]=ck.split(",");
int l=arr.length;

    if (attrs == null ||  ml.equalsIgnoreCase("@"+arr_dm[i])) {
     //  out.println("   No attributes");
        continue;
    }
    
     String entry="mail="+ml+","+base;
     System.out.println("entry="+entry);
	 Attributes testAttributes = ctx.getAttributes(entry);
	
    Attribute  jpegPhoto1 = testAttributes.get("mail");
    v3 =jpegPhoto1.get().toString();
    try
    {
     jpegPhoto1 = testAttributes.get("expiredDate");
     dt =""+jpegPhoto1.get().toString(); 
    }
    catch(Exception e)
    {
    	dt=" ";
    }
    
     
    	 if(dt.length()>=8)
    	{
    		 SimpleDateFormat format = new SimpleDateFormat("yyyyMMddhhmm'Z'");
    		 SimpleDateFormat format1 = new SimpleDateFormat("dd-MM-yyyy");
    		 Date curDate = new Date();
             Date dte=format.parse(dt); 
             dt=format1.format(dte);
       if(dte.compareTo(curDate)<0) 
       { 


if(v3.indexOf("@")>0)
{


cnt++;



}
        }
    	}

}
ctx.close();

}
}
catch(Exception e){System.out.print(e);

}

%>
<%=cnt %>