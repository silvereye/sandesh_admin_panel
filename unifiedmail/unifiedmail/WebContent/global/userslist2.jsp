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
 
    
  <title>User Lists | Silvereye Unified E-mail Server</title>
 <noscript><meta http-equiv="refresh" content="0; URL=/unifiedmail/error/nojavascritp3.jsp"></noscript>
  
	<meta http-equiv="pragma" content="no-cache" />
	<meta http-equiv="cache-control" content="no-cache" />
	<meta http-equiv="expires" content="0" />    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
	<meta http-equiv="description" content="This is my page" />
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" type="text/css" href="/unifiedmail/css/mytooltip.css" />
	<link rel="stylesheet" href="/unifiedmail/css/style.css" type="text/css" />
	
	<script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
<script type="text/javascript">
$(window).scroll(function(){
      if  ($(window).scrollTop() == $(document).height() - $(window).height()){
           AddMoreContent();
      }
 });    

 function AddMoreContent(){
 document.getElementById("loading").style.visibility= 'visible' ;
 var dm=document.getElementById("hid_dm").value;
 var no=document.getElementById("hidno").value;
 document.getElementById("hidno").value=parseInt(no)+5;
      $.post("/unifiedmail/global/userlistdata2.jsp?no="+no+"&dm="+dm, function(data) {
           //Assuming the returned data is pure HTML
          // alert(data);
          document.getElementById("loading").style.visibility= 'hidden' ;
           $(data).insertBefore($('#placeHolder'));
      });
 }


</script>
	
	
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
if(val.indexOf("postmaster@")==0)
{
alertify.alert("Postmaster can not be deleted.");
}
else
{
alertify.confirm("Do you want to Delete User: "+val+"<br><br>", function (e) {
				if (e) {
					//alertify.success("You've clicked OK");
					window.location="/unifiedmail/servlet/DelelteUserServlet?ml="+val;
					//document.getElementById(""+val).href ="/unifiedmail/servlet/DelelteUserServlet?ml="+val;
				} else {
					alertify.error("You've clicked Cancel");
				}
			});
			
	}		

}





</script>

<script type="text/javascript">
	function userData(u)
	{
	
	//var uid=document.f.uid.value;
	//var ml=uid;
	
	var dm=document.getElementById("hid_dm").value;

	
	var uid="";
	if(u=='all' || u==null || u=="")
	{
	//alert('all')
	uid="*";
	}
	else
	{
	uid=u+"*";
	}
	
	
	
	var y=document.f.recordbottum.selectedIndex;
		var no=document.f.recordbottum.options[y].value
	
	//alert(uid+"  "+no);
	
	if (window.XMLHttpRequest)
    {// code for IE7+, Firefox, Chrome, Opera, Safari
    xmlhttp=new XMLHttpRequest();
    }
    else
    {// code for IE6, IE5
    xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
    xmlhttp.onreadystatechange=function()
    {
      //alert(xmlhttp.readyState);
    if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
 
   vall=xmlhttp.responseText;
     // alert(vall);
    	document.getElementById("div1").innerHTML = vall; 
    }
    }
    xmlhttp.open("GET","/unifiedmail/global/userlistdata.jsp?val="+uid+"&no="+no+"&dm="+dm,true);
   //var xx=document.f.chk.value;
   //alert(xx);
    xmlhttp.send();
  
	}
	
	
	
	function userRecord(no)
	{
	//alert(no)

	var dm=document.getElementById("hid_dm").value;
	
	var i=document.f.sortbottum.selectedIndex;
	var u=document.f.sortbottum.options[i].value;
	var uid="";
	if(u=='all')
	{
	//alert('all')
	uid="*";
	}
	else
	{
	uid=u+"*";
	}
	//alert(uid+"  "+no);

	if (window.XMLHttpRequest)
    {// code for IE7+, Firefox, Chrome, Opera, Safari
    xmlhttp=new XMLHttpRequest();
    }
    else
    {// code for IE6, IE5
    xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
    xmlhttp.onreadystatechange=function()
    {
      //alert(xmlhttp.readyState);
    if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
 
   vall=xmlhttp.responseText;
     // alert(vall);
    	document.getElementById("div1").innerHTML = vall; 
    }
    }
    xmlhttp.open("GET","/unifiedmail/global/userlistdata.jsp?val="+uid+"&no="+no+"&dm="+dm,true);
   //var xx=document.f.chk.value;
   //alert(xx);
    xmlhttp.send();
	
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
      
	
	function editData(frm)
{
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
        
     f=f+1;
   
    }  
  }
  if(f==0)
  {
  alert("Please Select atleast one User.");
  return false;
  }
  else
  {
  if(document.getElementById('action').value=="index")
  {
  alert('Please select action');
   return false;
  }
  else if(document.getElementById('action').value=="common")
  {
  var dn=document.getElementById("hid_dm").value;
  document.f.action = "/unifiedmail/global/editusercommon.jsp?dm="+dn;
   return true;
  }
  else
  {
  document.f.action = "/unifiedmail/servlet/EditUserAtionServlet";
   return true;
  }
  }
  
}
}
	</script>
	<script type="text/javascript">
function removeMsg(id)
{
var element = document.getElementById(id);
element.parentNode.removeChild(element);
//alert(id);
}

</script>
  </head>
  
  <body onload="">
   <%@include file="header.jsp" %>
   <div class="container main-admin">
   <%
        String dm=request.getParameter("dm");
        if(dm==null)
        {
        dm="";
        }
         %>
   <div class="sublev-nav">	
   	<ul>
   		<li><a href="/unifiedmail/global/domainlist.jsp">All Domains</a></li>
<li><a href="/unifiedmail/global/editdomainprofile.jsp?dn=<%=dm %>"><%=dm %></a></li>
<li><a class="active-subs" href="/unifiedmail/global/userslist.jsp?dm=<%=dm %>">Users</a></li>
<li><a href="/unifiedmail/global/maillistslist.jsp?dm=<%=dm %>">Mail Lists</a></li>
<li><a href="/unifiedmail/global/mailaliaseslist.jsp?dm=<%=dm %>">Mail Aliases</a></li>
   	</ul>
   	<div class="clr"></div>
   	</div>
   
   
        <form name="f" id="frm1" method="post" action="" onsubmit="return editData(this.form)">
        
  <input type="hidden" name="hid_dm" id="hid_dm" value="<%=dm %>" />
   <input type="hidden" name="hid_no" id="hidno" value="5" />
    <div class="add-domain-rightbar fwid">
    
     
    <%
    String stt=request.getParameter("msg");
    if(stt!=null)
    {  
   
     %>
     <div class="main-heading2" id="msg_suc"> Selected account has been <%=stt %>. <span class="close">	<a onclick="removeMsg('msg_suc')" title="click me to remove" style="cursor: pointer;">X</a>	</span>	</div>
      <%}
      %>
    
                	
                	<div class="main-heading">	Users under domain: <%=dm %>	</div>
                    <div class="row-one">
                    	<div class="iconic-btn">	<a href="/unifiedmail/global/addalias.jsp?dm=<%=dm %>"><span><img src="/unifiedmail/images/add-icon.png" /></span>Mail Alias</a>	</div>
                	  <div class="iconic-btn">	<a href="/unifiedmail/global/addmaillist.jsp?dm=<%=dm %>"><span><img src="/unifiedmail/images/add-icon.png" /></span>Mail List</a>	</div>
                    	<div class="iconic-btn">	<a   href="/unifiedmail/global/adduser.jsp?dm=<%=dm %>"><span><img src="/unifiedmail/images/add-icon.png" /></span>User</a>	</div>
                      
                       
                         <div class="clr"></div>
                    	</div><!--end row-one-->
                       <div class="domain-wrapper2" id="div1">
                        
                       
                       
                       
                       
                       
                       
                       
                       
                       
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
    <tbody>
    <%
    ArrayList<String> arrlst=new ArrayList();
    
				HttpSession hs=request.getSession(false);
		        String username=(String)hs.getAttribute("id");
		        String password=(String)hs.getAttribute("password");
		        String url=(String)hs.getAttribute("url");
		        String base1=(String)hs.getAttribute("base");
		        String utype=(String)hs.getAttribute("user_name");
		         //int no=Integer.parseInt(request.getParameter("no"));
  //String uid=request.getParameter("val");
try
{
int f=0;
int x=0;
int icnt=0;

String dom="";
dom=dm;
System.out.println("dom="+dom);
if(dom.equals("") || dom==null)
{
dom=domainlist.getDomList(hs);
}



System.out.println("np list           "+dom); 
String arr_dm[]=dom.split(",");
for(int i=0;i<arr_dm.length;i++)
{
String base="ou=Users,domainName="+arr_dm[i]+",o=domains,"+base1;//dc=springbirds,dc=co,dc=in";//"ou=Users,domainName="+arr_dm[i]+",o=domains"+(String)hs.getAttribute("base");
DirContext ctx=LDAPConnection.getConnection(url, base, username, password);
String v1="";
String v2="";
String v3="";
String qt="";
String init="Mr";
SearchControls constraints = new SearchControls(); 
constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
String attrList[] = {"cn","accountStatus","mail","jpegPhoto","initials"}; 
constraints.setReturningAttributes(attrList);
NamingEnumeration results =ctx.search(base,"mail=*", constraints);

while (results.hasMore()) {
f=1;
String photo="";
    SearchResult si =(SearchResult)results.next();
    String ck=si.getName();
   System.out.println("<br><br><br>"+ck);
    Attributes attrs = si.getAttributes();
String arr[]=ck.split(",");
int l=arr.length;

    if (attrs == null) {
       out.println("   No attributes");
        continue;
    }
    
    
    
    	NamingEnumeration ae = attrs.getAll(); 
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
    }

if(v3.indexOf("@")>0)
{

String mylst=v3+";"+init+";"+v1+";"+v2+";"+photo;
arrlst.add(mylst);




}
}
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
%>
<tr><td colspan="5" align="center"><h4><%=e %></h4></td></tr>
<%
}
	Collections.sort(arrlst);
	for (int i = 0; i < arrlst.size() && i<10; i++)
	{
	//String mylst=v3+";"+init+";"+v1+";"+v2+";"+photo;
	String v1="";
String v2="";
String v3="";
String qt="";
String init="Mr";
String photo="";
   String item = arrlst.get(i);
 String arr[]=item.split(";");
 v3=arr[0];
init=arr[1];
 v1=arr[2];
 v2=arr[3];
 if(arr.length==5)
 {
 photo=arr[4];
 }



if(i!=0)
{
%>




<tr><td></td></tr>
<%}
 %>
  <%
  if(init==null && init.equalsIgnoreCase(""))
  {
  init ="Mr";
  }
  
                String src="/unifiedmail/images/user-img.png";
                if(photo!= null && !(photo.equals("")))
                {
                String ur = (request.getRequestURL()).toString();
			  int ur_i=ur.lastIndexOf(":");
			 String ur_prt=ur.substring(0,ur_i);
		  
                src=ur_prt+"/photo/"+v3+".jpg";
                }
                 %>
    <tr class="grey">
    <td  width="30" align="center"><label>
      
      <input type="checkbox" name="CheckboxGroup1" id="checkbox" value="<%=v3 %>"/>
    </label></td>
    <td width="32">	<span class="userpic1111"><img width="32" height="32" src="<%=src %>" />	</span></td> 
    <td width="126"><%=init %>.&nbsp;<%=v1 %></td>
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



	 %>
	
	
	
	
	
	
	<tr id="placeHolder"></tr>
	
                       
       </tbody>               
                       
                       
        </table>               
                       
                     
                       
                       
                       
                       
                       
                       
                       
                       </div>
                       <div id="loading" style="visibility:hidden; text-align: center;">
  <p><img  src="/unifiedmail/images/myload.GIF"/></p>
</div>          
               
                                
                                <div class="action-wrap">
                                	<div class="action-one">
                                    	<select id="action" name="action" class="action1111">
                                        	<option value="index" >	Choose Action	</option>
                                        	<option value="active">Enable</option>
                                        	<option value="disabled">Disable</option>
                                        	 <option disabled>-----------</option>
                                        	  <option value="common">Common Field Edit</option>
                                        	
                                        </select>
                                        <input name="" type="submit" class="apply" value="Apply" />
                                    	</div>
                                        <br/> <br/>
                                	</div>
                        
                	</div>
                	</form>
                <div class="clr"></div>
  
   </div>
   <%@include file="footer.jsp" %>
   
  </body>
</html>
