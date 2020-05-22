<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" import="java.util.*,mypack.*" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.regex.*" %>
<%@ page import="javax.naming.directory.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'userlistdata.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script type="text/javascript">
function mydel_dom()
{
var r=confirm("Do you want to Domain: ");
if (r==true)
  {
  
 //document.getElementById("myLink_restart").href ="/unifiedmail/servlet/RestartServlet";
   
  }

}

</script>
  </head>
  
  <body>

    <table width="100%" border="0" cellpadding="3" cellspacing="0" class="user-under-domain dlist1111">
    <thead>
    <tr>
    <td width="30" align="center"><input type="checkbox" name="checkall" value="checkbox" id="CheckboxGroup1_0" onclick='checkedAll(frm1);'/></td>
    <td width="50"></td>
    <td width="220">Display Name</td>
    <td width="147" align="left">E-mail</td>
    <td width="183" align="center">Expiry date</td>
    <td width="80" align="center">Status</td>
  </tr>
    </thead>
    <%
     int cnt=Integer.parseInt(request.getParameter("cnt"));
                if(cnt>0)
                {
    ArrayList<String> arrlst=new ArrayList();
    
				HttpSession hs=request.getSession(false);
		        String username=(String)hs.getAttribute("id");
		        String password=(String)hs.getAttribute("password");
		        String url=(String)hs.getAttribute("url");
		        String base1=(String)hs.getAttribute("base");
		        String utype=(String)hs.getAttribute("user_name");
		         int no=Integer.parseInt(request.getParameter("val").trim());
		         int perpg=Integer.parseInt(request.getParameter("perpg").trim());
	int chk=0;
	        no=(no-1)*perpg;
	        int lt=no+perpg;

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
	
    Attribute jpegPhoto1 = testAttributes.get("jpegPhoto");
    if(jpegPhoto1!=null)
    {
    byte[] jpegBytes1 = (byte[]) jpegPhoto1.get();
    photo = new sun.misc.BASE64Encoder().encode(jpegBytes1);
    }
    jpegPhoto1 = testAttributes.get("cn");
    v1 =jpegPhoto1.get().toString();
    
    jpegPhoto1 = testAttributes.get("accountStatus");
    v2 =jpegPhoto1.get().toString();
    
    jpegPhoto1 = testAttributes.get("mail");
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

String mylst=v3+";"+v1+";"+v2+";"+photo+";"+dt;
arrlst.add(mylst);




}
        }
    	}

}
ctx.close();
if(f==0)
{
//out.print("Search not found");
%>
<tr><td colspan="5" align="center"><h4>Search not found</h4></td></tr>
<%
}

}
}
catch(Exception e){System.out.print(e);

}
	Collections.sort(arrlst);
	for (int i=0; no < arrlst.size() && no<lt; no++,i++)
	{
	//String mylst=v3+";"+init+";"+v1+";"+v2+";"+photo;
	String v1="";
String v2="";
String v3="";
String qt="";
//String init="Mr";
String photo="";
   String item = arrlst.get(no);
 String arr[]=item.split(";");
 v3=arr[0];
//init=arr[1];
 v1=arr[1];
 v2=arr[2];
 if(arr.length>=4)
 {
 photo=arr[3];
 }



if(i!=0)
{
%>




<tr><td></td></tr>
<%}
 %>
  <%
 /*  if(init==null && init.equalsIgnoreCase(""))
  {
  init ="Mr";
  }
   */
                String src="/unifiedmail/images/user-img.png";
                if(photo!= null && !(photo.equals("")))
                {
               /*  String ur = (request.getRequestURL()).toString();
			  int ur_i=ur.lastIndexOf(":");
			 String ur_prt=ur.substring(0,ur_i);
		  
                src=ur_prt+"/photo/"+v3+".jpg"; */
                	src="data:image/jpg;base64,"+photo;
                }
                 %>
    <tr class="grey">
    <td  width="30" align="center"><label>
      
      <input type="checkbox" name="CheckboxGroup1" id="checkbox" value="<%=v3 %>"/>
    </label></td>
    <td width="32">	<span class="userpic1111"><img width="32" height="32" src="<%=src %>" />	</span></td> 
    <td width="126"><%=v1 %></td>
    <td width="300" align="left"><a href="/unifiedmail/global/edituserprofile.jsp?ml=<%=v3 %>"><%=v3 %></a></td>
     
    <td width="120" align="center">
    <%=arr[4] %>
    </td>
   
    <td width="120" align="center"><table width="60%">
      <tr>
       <%
		if(v2.equalsIgnoreCase("active"))
		{
 		%>
         <td>
         <a class="tooltips" ><img src="/unifiedmail/images/right_mark.png" />
<span>Enabled</span></a>
         </td>
         <%}
         else
         { %>
        <td>
        <a class="tooltips" ><img  src="/unifiedmail/images/image1.png" />
<span>Disabled</span></a>
        </td>
       <%} %>
       <td>
       <a class="tooltips" href="/unifiedmail/global/usersentmails.jsp?ml=<%=v3 %>"><img src="/unifiedmail/images/flow_mark.png" />
<span>Account activity</span></a>
       </td>
        <td>
        <%
        
         %>
        <a class="tooltips" id="<%=v3 %>"><img src="/unifiedmail/images/delete-icon.png"  name="<%=v3 %>" onclick="mydel_dom(this.name)"/>
<span>Delete</span></a>

        </td>
      </tr>
    </table>
    
    </td>
  </tr>




 
 <%
}

}
else
{
%>
<tr>
				<td colspan="6" align="center">
					Search not found
				</td>
			</tr>
<%
}

	 %>
	 </table>
  </body>
</html>
