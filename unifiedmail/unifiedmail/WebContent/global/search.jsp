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
    
    <title>Search User | Silvereye Unified E-mail Server</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link rel="stylesheet" type="text/css" href="/unifiedmail/css/mytooltip.css" />
<script type="text/javascript">
function mydel_dom(val)
{
/*var r=confirm("Do you want to Delete User: "+val);
//alert(r);
if (r==true)
  {
  //alert("hi");
 document.getElementById(""+val).href ="/unifiedmail/servlet/DelelteUserServlet?ml="+val;
   
  }
  */
  var search=document.getElementById("hid_search").value;
  var page=document.getElementById("hid_page").value;
if(val.indexOf("postmaster@")==0)
{
alertify.alert("Postmaster can not be deleted.");
}
else
{
alertify.confirm("Do you want to Delete User: "+val+"<br><br>", function (e) {
				if (e) {
					//alertify.success("You've clicked OK");
					window.location="/unifiedmail/servlet/DelelteUserSearchServlet?ml="+val+"&search="+search+"&page="+page;
					//document.getElementById(""+val).href ="/unifiedmail/servlet/DelelteUserServlet?ml="+val;
				} else {
					alertify.error("You've clicked Cancel");
				}
			});
			
	}		

}




checked=false;
function checkedAll (frm1) {
	var aa= document.getElementById('frm1');
	 if (checked == false)
          {
           checked = true
          }
        else
          {
          checked = false
          }
	for (var i =0; i < aa.elements.length; i++) 
	{
	 aa.elements[i].checked = checked;
	}
      }
   
   function deleteAll(){
	   document.getElementById("hid_perm").value="del";
	   if(document.f.onsubmit &&   !document.f.onsubmit())
			    {
			        return;
			    }
	  
			 document.f.submit();
}
function editcomfield(frm) {
	document.getElementById("hid_perm").value="edit";
    if(document.f.onsubmit &&  !document.f.onsubmit())
    {
        return;
    }
    
 document.f.submit();
}
	
	

function editData(frm)
{
	var ml_val="";
	 var perm=document.getElementById("hid_perm").value;
var chk_arr =  document.getElementsByName("CheckboxGroup1");
var chklength = chk_arr.length;
var str="";
var str1="";
//alert(chklength);
if(chklength<=0)
{
alert("Records are not founds.");
return false;
}
else
{
var f=0;
for (var i = 0; i < chklength; i++) {  
 if (chk_arr[i].checked==true) {
	 if(chk_arr[i].value.indexOf("postmaster@")==0 && perm=="del")
		 {
		 f=-1;
		 break;
		 }
	 else
		 {
 		f=f+1;
 		if(ml_val=="")
 			{
 			ml_val=chk_arr[i].value;
 			}
 		else
 			{
 			ml_val+=","+chk_arr[i].value;
 			}
		 }
}  
}
if(f==-1)
{
alertify.alert("Postmaster can not be deleted.");
return false;
}
else if(f==0)
{
alert("Please Select atleast one User.");
return false;
}
else
{

	var search=document.getElementById("hid_search").value;
	  var page=document.getElementById("hid_page").value;
	/* if(document.getElementById('action').value=="index")
{
alert('Please select action');
return false;
}
else 
{ */
 
  if(perm=="edit")
	  {
			//var dn=document.getElementById("hid_dm").value;
			document.f.action = "/unifiedmail/global/editusercommonSearch.jsp";
			return true;
	  }
  else  if(perm=="del")
  {
	  alertify.confirm("Do you want to Delete All selected Users<br><br>", function (e) {
			if (e) {
				
				
				//var dn=document.getElementById("hid_dm").value;
				window.location="/unifiedmail/servlet/DelelteSelectedUserSearchServlet?ml_val="+ml_val+"&search="+search+"&page="+page;
	 			//return true;
			} else {
				alertify.error("You've clicked Cancel");
				return false;
			}
		});
	  
		
	  }
// }
/*  else if(document.getElementById('action').value=="common")
{
var dn=document.getElementById("hid_dm").value;
document.f.action = "/unifiedmail/global/editusercommon.jsp?dm="+dn;
return true;
}
else
{
document.f.action = "/unifiedmail/servlet/EditUserAtionServlet";
return true;
} */
}

}
}


</script>
  </head>
  
  <body>
   <%@include file="header.jsp" %>
   <%
   String search=request.getParameter("search");
		HttpSession hs=request.getSession(false);
   String username=(String)hs.getAttribute("id");
   String password=(String)hs.getAttribute("password");
   String url=(String)hs.getAttribute("url");
   String base1=(String)hs.getAttribute("base");
   %>
   <form name="f" id="frm1" method="post" action="" onsubmit="return editData(this.form)">
     
        <input type="hidden" id="hid_perm" name="hid_perm" value=""/>
        <input type="hidden" id="hid_search" name="hid_search" value="<%=search %>"/>
        <input type="hidden" id="hid_page" name="hid_page" value="search"/>
   <div class="container main-admin">
   <div class="add-domain-rightbar fwid" style="margin-bottom: 40px;">
   	<div class="main-heading">	Search Result	</div>
   
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
   				
				try
				{
				int x=0;
String dom="";
dom=request.getParameter("dm");
System.out.println("dom="+dom);
if(dom==null)
{
dom=domainlist.getDomList(hs);
}


List<String> alst=new ArrayList<String>();
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
String init="";
SearchControls constraints = new SearchControls(); 
constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
String attrList[] = {"cn","accountStatus","mail","jpegPhoto","initials"}; 
constraints.setReturningAttributes(attrList);
NamingEnumeration results =ctx.search(base,"mail=*"+search+"*", constraints);
int f=0;
while (results.hasMore()) {
f=1;
String photo="";
    SearchResult si =(SearchResult)results.next();
    String ck=si.getName();
    String ml=ck.replace("mail=", "");
   //System.out.println("<br><br><br>"+ck);
    Attributes attrs = si.getAttributes();
String arr[]=ck.split(",");
int l=arr.length;

    if (attrs == null) {
       out.println("   No attributes");
        continue;
    }
    NamingEnumeration ae = attrs.getAll(); 
   /*  while (ae.hasMoreElements()) {
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
        else if(id.equalsIgnoreCase("jpegPhoto"))
        {
        photo=str;
        }
		 else if(id.equalsIgnoreCase("jpegPhoto"))
        {
        init=str;
        }


         //  System.out.println("  <br> "+id + ":--- " +str);
           }
    } */

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
   
if(v3.indexOf("@")>0)
{
   x++;
   if(photo==null || photo.length()<=0)
	   photo=" ";
alst.add(v3+"<nps>"+v1+"<nps>"+v2+"<nps>"+photo);


}
}
LDAPConnection.closeConn(ctx);

}
if(x==0)
{
//out.print("Search not found");
%>
<tr><td align="center" colspan="5"><h2>Search not found</h2></td></tr>
<%
}

Collections.sort(alst);
System.out.println(alst);
for(String st:alst)
{
	System.out.println(">>"+st);
	if(st!=null)
	{
		String arr[]=st.split("<nps>");
		System.out.println(arr.length);
		String v1="";
		String v2="";
		String v3="";
		String qt="";
		String photo="";
		v3=arr[0];
		v1=arr[1];
		v2=arr[2];
		photo=arr[3].trim();
		
		%>




		<tr><td></td></tr>

		  <%
		                String src="/unifiedmail/images/user-img.png";
		                if(photo!= null && !(photo.equals("")))
		                {
		               /*  String ur = (request.getRequestURL()).toString();
					  int ur_i=ur.lastIndexOf(":");
					 String ur_prt=ur.substring(0,ur_i); */
				  
		                	src="data:image/jpg;base64,"+photo;
		                }
		                 %>
		    <tr class="grey">
		    <td  width="30" align="center"><label>
		      <input type="checkbox" name="CheckboxGroup1" id="checkbox" value="<%=v3 %>"/>
		    </label></td>
		    <td width="32">	<span class="userpic1111"><img width="32" height="32" src="<%=src %>"/>	</span></td> 
		    <td width="126"><%=v1 %></td>
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
		   








		   
		    <td width="110" align="center"><table width="80%">
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


}
catch(Exception e){System.out.print(e);}
	
	 %>
	 </table>
	 <div class="action-wrap">
                                	<div class="action-one">
                                    	<!-- <select id="action" name="action" class="action1111">
                                        	<option value="index" >	Choose Action	</option>
                                        	<option value="active">Enable</option>
                                        	<option value="disabled">Disable</option>
                                        	 <option disabled>-----------</option>
                                        	  <option value="common">Common Field Edit</option>
                                        	<input name="" type="submit" class="apply" value="Apply" />
                                        </select> -->
                                        
                                        <div class="file-actions">
                        	<ul>
                            	
                                <li onclick="editcomfield(this.form)" style="cursor: pointer;"><a id="myLink" >Edit</a></li>
                                <li onclick="deleteAll()" style="cursor: pointer;"><a id="myLink1" >Delete</a></li>
                            </ul>
                        </div>
                                    	</div></div>
                                    	
	 </div>
	  
	 </div>
	 <br><br>
	 </form>
      <%@include file="footer.jsp" %>
  </body>
</html>
