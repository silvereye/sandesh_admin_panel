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
    <td width="183" align="center">Quota Status</td>
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
//String init="Mr";
SearchControls constraints = new SearchControls(); 
constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
String attrList[] = {"cn","accountStatus","mail","jpegPhoto","givenName","sn"}; 
constraints.setReturningAttributes(attrList);
NamingEnumeration results =ctx.search(base,"mail="+uid, constraints);

while (results.hasMore()) {
f=1;
String photo="";
String fn="";
String sn="";
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
    v3=v3.toLowerCase();
    
    jpegPhoto1 = testAttributes.get("givenName");
    fn =jpegPhoto1.get().toString();
    if(fn.length()>0)
	{
		fn=fn.replaceAll(";", "");
		fn=fn.replaceAll("\"", "");
		fn=fn.replaceAll("'", "");
	}
	else
	{
		fn=" ";
	}
    
    jpegPhoto1 = testAttributes.get("sn");
    sn =jpegPhoto1.get().toString();
    if(sn.length()>0)
	{
		sn=sn.replaceAll(";", "");
		sn=sn.replaceAll("\"", "");
		sn=sn.replaceAll("'", "");
	}
	else
	{
		sn=" ";
	}
    
    
   // jpegPhoto1 = testAttributes.get("initials");
   // init =jpegPhoto1.get().toString();
    /* 	NamingEnumeration ae = attrs.getAll(); 
    	while (ae.hasMoreElements()) {
        Attribute attr =(Attribute)ae.next();
        String id = attr.getID();
        Enumeration vals = attr.getAll();
        while (vals.hasMoreElements())
        {
        String str= vals.nextElement().toString();
       
          if(id.equalsIgnoreCase("cn"))
        {
        v1=str;
        }
        else if(id.equalsIgnoreCase("accountStatus"))
        {
        v2=str;
        }
         else if(id.equalsIgnoreCase("mail"))
        {
        v3=str;
        }
        else if(id.equalsIgnoreCase("initials"))
           {
           init=str;
           } 
        else if(id.equalsIgnoreCase("jpegPhoto"))
        {
        photo=str;
        }

        



           System.out.println("  <br> "+id + ":--- " +str);
           }
    } */

if(v3.indexOf("@")>0)
{

String mylst=v3+";"+v1+";"+v2+";"+photo+";"+fn+";"+sn;
arrlst.add(mylst);




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
String tit="";
String photo="";
   String item = arrlst.get(no);
 String arr[]=item.split(";");
 v3=arr[0];
//init=arr[1];
 v1=arr[1];
 v2=arr[2];
 if(arr.length==4)
 {
 photo=arr[3];
 }

 
if(arr.length==6)
{
	tit=arr[4]+" "+arr[5];
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
    <td width="126" style="cursor: pointer;" title="<%=tit %>"><%=v1 %></td>
    <td width="300" align="left"><a href="/unifiedmail/global/edituserprofile.jsp?ml=<%=v3 %>"><%=v3 %></a></td>
     
    <td width="120" align="center">
    
    
    <%
 
		if(v2.equalsIgnoreCase("active"))
		{
 		
                            		int per=0;
                            		int used=0;
                            		int tot=0;
                            	Quota q=new Quota();
                            	String s=q.getQuota(v3);
                            	s=s.trim();
		if(s!=null && !(s.equals("")))
		{
		String nstr[]=s.split(" ");
		int l1=nstr.length;
		int ct=0;
		for(l1--;true;l1--)
		{
		String ss=nstr[l1].trim();
		if(ss==null || ss.equals(" ") || ss.equals(""))
		{
		continue;
		}
		else
		{
		ct++;
		if(ct==1)
		{
		 per=Integer.parseInt(ss);
		}
		if(ct==2)
		{
		 tot=Integer.parseInt(ss);
		}
		if(ct==3)
		{
		 used=Integer.parseInt(ss);
		break;
		}
		}
		//out.print("<br>"+nstr[i]);
		}
		}
		
		
                            	 %>
    
   
    <table border="1"  style="border-style: inherit; ">
                            <tr height="10px" >
                            <%if(per<80)
                            { 
                            if(per>=10)
                            {%>
                            <td style="background-color: green" bgcolor="green" width="8px" ></td>
                            <%}
                            else
                            { %>
                            <td  style="background-color: white; " bgcolor="white;" width="8px" ></td>
                            <%}
                            if(per>=20)
                            {
                             %>
                              <td style="background-color: green " bgcolor="green" width="8px" ></td>
                              <%}
                              else
                              { %>
                            <td style="background-color: white;" bgcolor="white;" width="8px" ></td>
                            <%} 
                             if(per>=30)
                            {
                             %>
                              <td style="background-color: green"  bgcolor="green" width="8px" ></td>
                              <%}
                              else
                              { %>
                            <td style="background-color: white;" bgcolor="white;" width="8px" ></td>
                            <%} 
                             if(per>=40)
                            {
                             %>
                              <td style="background-color: green"  bgcolor="green" width="8px" ></td>
                              <%}
                              else
                              { %>
                            <td style="background-color: white;" bgcolor="white;" width="8px" ></td>
                            <%} 
                            if(per>=50)
                            {
                             %>
                              <td style="background-color: green"  bgcolor="green" width="8px" ></td>
                              <%}
                              else
                              { %>
                            <td style="background-color: white;"  bgcolor="white;" width="8px" ></td>
                            <%} 
                            if(per>=60)
                            {
                             %>
                              <td style="background-color: green" bgcolor="green" width="8px" ></td>
                              <%}
                              else
                              { %>
                            <td style="background-color: white;"  bgcolor="white;" width="8px" ></td>
                            <%} 
                             if(per>=70)
                            {
                             %>
                              <td style="background-color: green" bgcolor="green" width="8px" ></td>
                              <%}
                              else
                              { %>
                            <td style="background-color: white;" bgcolor="white;" width="8px" ></td>
                            <%} 
                            %>
                           
                            <td style="background-color: white;"  bgcolor="white;" width="8px" ></td>
                            <td  style="background-color: white;" bgcolor="white;" width="8px" ></td>
                            <td  style="background-color: white;" bgcolor="white;" width="8px" ></td>
                            
                            <%}
                            else
                            {
                             %>
                            <td style="background-color: #B2170C"  bgcolor="#B2170C" width="8px" ></td>
                            <td style="background-color: #B2170C" bgcolor="#B2170C" width="8px" ></td>
                            <td style="background-color: #B2170C" bgcolor="#B2170C" width="8px" ></td>
                            <td style="background-color: #B2170C"  bgcolor="#B2170C" width="8px" ></td>
                            <td style="background-color: #B2170C" bgcolor="#B2170C" width="8px" ></td>
                            <td style="background-color: #B2170C" bgcolor="#B2170C" width="8px" ></td>
                            <td style="background-color: #B2170C" bgcolor="#B2170C" width="8px" ></td>
                            <td  style="background-color: #B2170C" bgcolor="#B2170C" width="8px" ></td>
                           <%if(per>=90) 
                           {%>
                            <td style="background-color: #B2170C"  bgcolor="#B2170C" width="8px" ></td>
                            <%}
                            else
                            { %>
                            <td style="background-color: white;"  bgcolor="white;" width="8px" ></td>
                            <%}
                            if(per>=100)
                            {
                             %>
                            <td style="background-color: #B2170C" bgcolor="#B2170C" width="8px" ></td>
                            <%}
                            else
                            { %>
                             <td style="background-color: white;" bgcolor="white;" width="8px" ></td>
                             <%}} %>
                       </tr></table>
 <%
                            	 String usedstr="";
                            	 String totstr="";
                            	 
                            	if((tot/1024/1024)>0) 
    {
   tot=tot/1024/1024;
  totstr=""+tot+"GB";
    } 
    else if((tot/1024)>0) 
    {
     tot=tot/1024;
     totstr=""+tot+"MB";
  } 
    else
    {
    totstr=""+tot+"KB";
   }
      							
      							if((used/1024/1024)>0)
     {
     used=used/1024/1024;
     usedstr=""+used+"GB";
} 
    else   if((used/1024)>0)
     {
     used=used/1024;
       usedstr=""+used+"MB";
       } 
    else
    {
     usedstr=""+used+"KB";
    }
      							
      							                      	 
                 %>           	

 <font class="dlimit">
   <%=usedstr %>/<%=totstr %>&nbsp; <%=per %>% Used
    </font> 
    <%}
    else
    {
     %>
     <font class="dlimit">
   Disabled Account
    </font> 
     <%} %>
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
    </table></td>
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