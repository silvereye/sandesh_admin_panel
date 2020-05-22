<%@ page language="java" import="java.util.*,mypack.*" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.regex.*" %>
<%@ page import="javax.naming.directory.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
    <title>Edit Domain Profile | Silvereye Unified E-mail Server</title>
 <noscript><meta http-equiv="refresh" content="0; URL=/unifiedmail/error/nojavascritp.jsp"></noscript>

    
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/reset.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/screen.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/fancybox.css" />

    <!--[if IE 7]>
        <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/ie7.css">
    <![endif]-->



<script type="text/javascript">
function removeMsg(id)
{
var element = document.getElementById(id);
element.parentNode.removeChild(element);
//alert(id);
}

</script>
<script type="text/javascript">
function setTextBox(val)
{
//alert(val)
if(val=='other')
	{
	document.getElementById("otr").style.visibility='visible'
	}
	else
	{
	document.getElementById("otr").style.visibility='hidden'
	}
}

function valData()
{
var e = document.getElementById("relay");
   var str = e.options[e.selectedIndex].value;

   
if(str=="index")
{
alert("Please select any value");
return false;
}

if(str=="other")
{
var val=document.getElementById("otr").value;
var n = val.indexOf("@");
if(n>=0)
{
alert("Please enter correct domain, without '@'");
return false;
}
}
return true;

}


function chk_qt(val)
{
var qt=parseInt(val);
if(qt>0)
{
var cqt=parseInt(document.getElementById("hid_cqt").value);
if((cqt/1024)>(qt))
{
alert("Value should be atleast "+(cqt/1024)+"GB");
document.getElementById("mqt").value="";
}

}
else if(qt<0)
{
alert("Please enter correct value");
document.getElementById("mqt").value="";
}
}





function chk_usr(val)
{
var usr=parseInt(val);
if(usr>0)
{
var cusr=parseInt(document.getElementById("hid_cusr").value);
if((cusr)>(usr))
{
alert("Value should be atleast "+cusr);
document.getElementById("musr").value="";
}

}
else if(usr<0)
{
alert("Please enter correct value");
document.getElementById("musr").value="";
}
}






function chk_list(val)
{
var list=parseInt(val);
if(list>0)
{
var clist=parseInt(document.getElementById("hid_clist").value);
if((clist)>(list))
{
alert("Value should be atleast "+clist);
document.getElementById("mlist").value="";
}

}
else if(list<0)
{
alert("Please enter correct value");
document.getElementById("mlist").value="";
}
}






function chk_alias(val)
{
var alias=parseInt(val);
if(alias>0)
{
var calias=parseInt(document.getElementById("hid_calias").value);
if((calias)>(alias))
{
alert("Value should be atleast "+calias);
document.getElementById("malias").value="";
}

}
else if(alias<0)
{
alert("Please enter correct value");
document.getElementById("malias").value="";
}
}

</script>



<script type="text/javascript">
function checkNum(nm)
{
var val=document.getElementById(nm).value;
var numbers = /^[0-9]+$/;  
if(val.match(numbers))
{

}
else
{
val = val.substring(0, val.length - 1)
document.getElementById(nm).value=val;

}
}
</script>
</head>

<body>
 <%
  	HttpSession hs=request.getSession(false);
 String chid= (String)hs.getAttribute("id");
 if(chid==null)
{
System.out.println("hii dgfgf");
%>
<script type="text/javascript">
	window.open("/unifiedmail/login/login.jsp?val=ses", "_self", false);
	</script>
<%
}
else
{
 %>           
 <%@include file="header.jsp" %>
  <%

		       if(hs!=null)
		       {
		        String username= (String)hs.getAttribute("id");
		        String password= (String)hs.getAttribute("password");
		        String url= (String)hs.getAttribute("url");
		        String mbase= (String)hs.getAttribute("base");
		        String base="o=domains,"+mbase;
		        String utype=(String)hs.getAttribute("user_name");
  
   String dn=request.getParameter("dn");
  if( dn!=null && !(dn.equals("")) )
   {
   
    
    
    

               
		        String basedir="";
		        String cqt="";
		        String mqt="0";
		        String dqt="0";
		        String clist="0";
		        String mlist="0";
		        String cuser="0";
		        String muser="0";
		        String calias="0";
		        String malias="0";
		        String maxp="0";
		        String minp="0";
		        int p1=0;
		        int p2=0;
		        String plang="";
		        String serv="";
		        String ftp="";
		        String ftpdom="";


		        
try
{


DirContext ctx=LDAPConnection.getConnection(url, base, username, password);

SearchControls constraints = new SearchControls(); 
constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
String attrList[] = {"domainFTPStatus","accountSetting","domainCurrentAliasNumber","domainDefaultFtpQuota","preferredLanguage","domainCurrentListNumber","domainCurrentQuotaSize","domainCurrentUserNumber","domainMaxAliasNumber","domainMaxListNumber","domainMaxUserNumber","domainMaxQuotaSize","domainDefaultUserQuota","domainDefaultFtpQuota","domainBaseStorage"}; 
constraints.setReturningAttributes(attrList);
NamingEnumeration results =ctx.search(base,"domainName="+dn, constraints);
int f=0;
int x=0;
while (results.hasMore()) {
f=1;
    SearchResult si =(SearchResult)results.next();
    String ck=si.getName();
   System.out.println("<br><br><br>"+ck);
    Attributes attrs = si.getAttributes();

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
        if(id.equalsIgnoreCase("accountSetting"))
        {
        	if(str.indexOf("maxPasswordLength")>=0)
        	{
        	p1=1;
        	maxp=str;
        	}
        	else  if(str.indexOf("minPasswordLength")>=0)
        	{
        	p2=1;
        	minp=str;
        	}
        	
        }
        else if(id.equalsIgnoreCase("domainCurrentAliasNumber"))
        {
        calias=str;
        }
        else if(id.equalsIgnoreCase("domainCurrentUserNumber"))
        {
        cuser=str;
        }
        else if(id.equalsIgnoreCase("domainCurrentListNumber"))
        {
        clist=str;
        }
        else if(id.equalsIgnoreCase("domainMaxAliasNumber"))
        {
        malias=str;
        }
        else if(id.equalsIgnoreCase("domainMaxUserNumber"))
        {
        muser=str;
        }
        else if(id.equalsIgnoreCase("domainMaxListNumber"))
        {
        mlist=str;
        }
        else if(id.equalsIgnoreCase("domainMaxQuotaSize"))
        {
        mqt=str;
        }
         else if(id.equalsIgnoreCase("domainDefaultUserQuota"))
        {
        dqt=str;
        }
         else if(id.equalsIgnoreCase("domainCurrentQuotaSize"))
        {
        cqt=str;
        }
        else if(id.equalsIgnoreCase("preferredLanguage"))
           {
           plang=str;
           }
        else if(id.equalsIgnoreCase("domainBaseStorage"))
           {
           basedir=str;
           }
			 else if(id.equalsIgnoreCase("domainDefaultFtpQuota"))
           {
           ftp=str;
           }
            else if(id.equalsIgnoreCase("domainFTPStatus"))
           {
           ftpdom=str;
           }
           //out.println("  <br> "+id + ":--- " +str);
           }
    }
    //NoOfUser nof=new NoOfUser();
 

}
if(f==0)
{
System.out.print("<tr class='grey'><td></td><td>Search not found</td></tr>");
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
catch(Exception e){System.out.print("<tr class='grey'><td></td><td>"+e+"</td></tr>");}
%>  
       
    
   
   
   

 
    
    

    <div class="main pagesize"> <!-- *** mainpage layout *** -->
        <div class="main-wrap">
        
        
        
        <div class="sublev-nav">	
   	<ul>
   		<li><a href="/unifiedmail/global/domainlist.jsp">All Domains</a></li>
<li><a class="active-subs" href="/unifiedmail/global/editdomainprofile.jsp?dn=<%=dn %>"><%=dn %></a></li>
<li><a href="/unifiedmail/global/userslist.jsp?dm=<%=dn %>">Users</a></li>
<li><a href="/unifiedmail/global/maillistslist.jsp?dm=<%=dn %>">Mail Lists</a></li>
<li><a href="/unifiedmail/global/mailaliaseslist.jsp?dm=<%=dn %>">Mail Aliases</a></li>
   	</ul>
   	<div class="clr"></div>
   	</div>
        
        
            <div class="page clear">
                
                



    <%
    String stt=request.getParameter("status");
    if(stt!=null && stt.equalsIgnoreCase("succ"))
    {  
   // String dn= request.getParameter("nm"); 
     %>
     <div class='notification note-success'><a href='#' class='close'></a>
<p><%=dn %> domain has been updated successfully. </p>	</div>
      <%}
      else if(stt!=null && stt.equalsIgnoreCase("error"))
      {
       %>
 <div id="msg_err" class="notification note-error"><a href='#' class='close'></a>                
<p>Domain updation has been failed.	</p></div>
    
    
    <%} %>



    


<div class="content-box">
    <div class="box-body">
        <div class="box-header clear">
            <ul class="tabs clear">
                
                    
                          
                 <li><a href="/unifiedmail/global/editdomainprofile.jsp?dn=<%=dn %>" >General</a></li>
                        <li><a href="/unifiedmail/global/bccdomain.jsp?dn=<%=dn %>" >BCC</a></li>
                        <li ><a href="/unifiedmail/global/relaydomain.jsp?dn=<%=dn %>">Relay</a></li>
                        <li><a href="/unifiedmail/global/catchalldomain.jsp?dn=<%=dn %>">Catch-all</a></li>
                        <li><a href="/unifiedmail/global/aliasesdomain.jsp?dn=<%=dn %>">Aliases</a></li> 
                        <li class="active"><a href="/unifiedmail/global/whiteblacklistdomain.jsp?dn=<%=dn %>">White/Blacklist</a></li>                       
                         <%
                         if(utype!=null && utype.equalsIgnoreCase("Admin"))
                                {
                         %>
                        <li><a href="/unifiedmail/global/throttlingdomain.jsp?dn=<%=dn %>">Throttling</a></li>      
                         <%} %> 
                         <li><a href="/unifiedmail/global/disclaimerdomain.jsp?dn=<%=dn %>">Disclaimer</a></li>                  
                        <li class="active"><a href="/unifiedmail/global/advancedomain.jsp?dn=<%=dn %>">Advanced</a></li>
                        
                
            </ul>
            <h2>Profile of domain: <%=dn %> <a href="/unifiedmail/global/domainsentmail.jsp?dn=<%=dn %>">
            <img src="/unifiedmail/images/graph_16.png"
                
                    title="Domain activities"
                

                
                    style="padding-left: 5px;" class="vcenter"
                
            />
        </a></h2>
        </div>

        <div class="box-wrap clear">
        
        <form action="/unifiedmail/servlet/EditDomainAdvance" name="f" method="post" onsubmit="return valData()">
        
        
        
                    <div class="columns clear">
                        <div class="col2-3">
                            
             <input type="hidden" name="hid_dn" value="<%=dn %>" />    
             <input type="hidden" name="hid_serv" value="<%=serv %>" />                 
    <div class="form-field clear">
        <a name="domainQuota">&nbsp;</a>
        <h4 class="size-250 fl-space">Domain quota size</h4>
        <span class="clean-padding fl-space">
        <%
        if(utype.equalsIgnoreCase("Admin"))
                  {
         %>
           <input name="mqt" required id="mqt" type="text" class="text fl-space" value="<%=Integer.parseInt(mqt)/1024 %>" onkeyup="checkNum(this.name)"  size="8" class="text" onblur="chk_qt(this.value)"/>
           GB
           <input type="hidden" id="hid_cqt" value="<%=cqt %>"/>
           <%}
           else
           {
            %>
            <input name="mqt" required disabled="disabled" id="mqt" type="text" class="text fl-space" value="<%=Integer.parseInt(mqt)/1024 %>" onkeyup="checkNum(this.name)"  size="8" class="text" onblur="chk_qt(this.value)"/>
           GB
            
            <%} %>
        </span>
    </div>

    
    
    
    
    
    <%
        if(utype.equalsIgnoreCase("Admin"))
                  {
         %>
    <div class="form-field clear">
        <a name="domainQuota">&nbsp;</a>
        <h4 class="size-250 fl-space">FTP Facility</h4>
        <span class="clean-padding fl-space">
        
          <% if(ftpdom.equalsIgnoreCase("TRUE"))
          {
           %>
            <input name="ftpdom" checked="checked" type="checkbox" value="TRUE" />
            <%} 
            else
            {
            %>
             <input name="ftpdom"  type="checkbox" value="TRUE" />
            <%} %>
        </span>
    </div>

     <%} %>                        

                            
                                <div class="bt-space0">&nbsp;</div>
                                <div class="form-field clear">
                                    <a name="accountLimit">&nbsp;</a>
                                    <h4 class="size-250 fl-space">Number of max mail users</h4>
                                    <span class="clean-padding fl-space">
                                     <%
       								if(utype.equalsIgnoreCase("Admin"))
                 					 {
         							%>
                                        <input type="text" required name="musr" size="8" value="<%=muser %>" id="musr" onkeyup="checkNum(this.name)" onblur="chk_usr(this.value)" class="text fl-space" />
                                        <span><%=cuser %> &nbsp; account(s) exist.</span>
                                          <input type="hidden" id="hid_cusr" value="<%=cuser %>"/>
                                          <%}
                                          else
                                          {
                                           %>
                                           <input type="text" disabled="disabled" required name="musr" size="8" value="<%=muser %>" id="musr" onkeyup="checkNum(this.name)" onblur="chk_usr(this.value)" class="text fl-space" />
                                        <span><%=cuser %> &nbsp; account(s) exist.</span>
                                          <input type="hidden" id="hid_cusr" value="<%=cuser %>"/> 
                                           <%} %>
                                    </span>
                                </div>

                                <div class="form-field clear">
                                    <h4 class="size-250 fl-space">Number of max mail lists</h4>
                                    <span class="clean-padding">
                                    <%
       								if(utype.equalsIgnoreCase("Admin"))
                 					 {
         							%>
                                        <input type="text" name="mlist" id="mlist" onkeyup="checkNum(this.name)" size="8" value="<%=mlist %>" onblur="chk_list(this.value)" class="text fl-space" />
                                        <label><%=clist %> &nbsp; account(s) exist.</label>
                                         <input type="hidden" id="hid_clist" value="<%=clist %>"/>
                                         <%}
                                         else
                                         {
                                          %>
                                          <input type="text" disabled="disabled" name="mlist" id="mlist" onkeyup="checkNum(this.name)" size="8" value="<%=mlist %>" onblur="chk_list(this.value)" class="text fl-space" />
                                        <label><%=clist %> &nbsp; account(s) exist.</label>
                                         <input type="hidden" id="hid_clist" value="<%=clist %>"/>
                                          <%} %>
                                    </span>
                                </div>

                                <div class="form-field clear">
                                    <h4 class="size-250 fl-space">Number of max mail aliases</h4>
                                    <span class="clean-padding">
                                    <%
       								if(utype.equalsIgnoreCase("Admin"))
                 					 {
         							%>
                                        <input type="text" required name="malias" id="malias" onkeyup="checkNum(this.name)" size="8" value="<%=malias %>" onblur="chk_alias(this.value)" class="text fl-space" />
                                        <label><%=calias %> &nbsp; account(s) exist.</label>
                                        <input type="hidden" id="hid_calias" value="<%=calias %>"/>
                                        <%}
                                        else
                                        {
                                         %>
                                          <input type="text" disabled="disabled" required name="malias" id="malias" onkeyup="checkNum(this.name)" size="8" value="<%=malias %>" onblur="chk_alias(this.value)" class="text fl-space" />
                                        <label><%=calias %> &nbsp; account(s) exist.</label>
                                        <input type="hidden" id="hid_calias" value="<%=calias %>"/>
                                         <%} %>
                                    </span>
                                </div>
                            

                            <div class="clear bt-space">&nbsp;</div>
							
							<%
                            	if(p2==1)
                            	{
                            	String arr[]=minp.split(":");
                            	minp=arr[1];
                            	}
                            	 %><!--
                            <div class="form-field clear">
                                <h4 class="size-250 fl-space">Minimum password length</h4>
                                <span class="clean-padding">
                                    <input type="text" required name="minp" id="minp" onkeyup="checkNum(this.name)" size="8" value="<%=minp %>" class="text fl-space" />
                                </span>
                            </div>
							
							
                            	 --><%
                            	if(p1==1)
                            	{
                            	String arr[]=maxp.split(":");
                            	maxp=arr[1];
                            	}
                            	 %><!--
                            <div class="form-field clear">
                                <h4 class="size-250 fl-space">Maximum password length</h4>
                                <span class="clean-padding">
                                    <input type="text" required name="maxp" id="maxp" onkeyup="checkNum(this.name)" size="8" value="<%=maxp %>" class="text fl-space" />
                                </span>
                            </div>
                            
                              <div class="clear bt-space">&nbsp;</div>
                            
                              
                             --><div class="form-field clear">
        <h4 class="size-250 fl-space">Default quota of User</h4>
        <span class="clean-padding">
            <input type="text" name="dqt" id="dqt" required onkeyup="checkNum(this.name)" size="8" value="<%=dqt%>"  class="text fl-space" /><label>MB</label>
        </span>
    </div>
                      <% if(ftpdom.equalsIgnoreCase("TRUE"))
          {
           %>       
                             <div class="form-field clear">
        <h4 class="size-250 fl-space">Default quota of FTP</h4>
        <span class="clean-padding">
         
            <input type="text" name="ftp" id="ftp" required onkeyup="checkNum(this.name)" size="8" value="<%=ftp%>"  class="text fl-space" /><label>MB</label>
           
        </span>
    </div>
            <%}
            else
            {
             %>
             <input type="hidden" name="ftp" id="ftp"   value="<%=ftp%>"  />
            
             <%} %>                 
         
         
         
             
             
             <%
                              String ru="";
                              String tw="";
                              String br="";
                              String fr="";
                              String zhcn="";
                              String fi="";
                              String kr="";
                              String it="";
                              String cz="";
                              String nl="";
                              String lt="";
                              String us="";
                              String de="";
                              String es="";
                              String pl="";
                              String si="";
                              if(plang.equalsIgnoreCase("ru_RU"))
                              {
                              ru="selected='selected'";
                              }
                              else if(plang.equalsIgnoreCase("zh_TW"))
                              {
                              tw="selected='selected'";
                              }
                              else
                              if(plang.equalsIgnoreCase("pt_BR"))
                              {
                              br="selected='selected'";
                              }
                              else if(plang.equalsIgnoreCase("fr_FR"))
                              {
                              fr="selected='selected'";
                              }
                              else if(plang.equalsIgnoreCase("zh_CN"))
                              {
                              zhcn="selected='selected'";
                              }
                              else if(plang.equalsIgnoreCase("fi_FI"))
                              {
                              fi="selected='selected'";
                              }
                              else if(plang.equalsIgnoreCase("it_IT"))
                              {
                              it="selected='selected'";
                              }
                              else if(plang.equalsIgnoreCase("ko_KR"))
                              {
                              kr="selected='selected'";
                              }
                              else if(plang.equalsIgnoreCase("nl_NL"))
                              {
                              nl="selected='selected'";
                              }
                              else if(plang.equalsIgnoreCase("sr_LT"))
                              {
                              lt="selected='selected'";
                              }
                              else if(plang.equalsIgnoreCase("de_DE"))
                              {
                              de="selected='selected'";
                              }
                              else if(plang.equalsIgnoreCase("es_ES"))
                              {
                              es="selected='selected'";
                              }
                              else if(plang.equalsIgnoreCase("pl_PL"))
                              {
                              pl="selected='selected'";
                              }
                              else if(plang.equalsIgnoreCase("sl_SI"))
                              {
                              si="selected='selected'";
                              }
                              else
                              {
                              us="selected='selected'";
                              }
                             
                               %>
  
  
             
                            
                            
                <div class="form-field clear">
    
        <h4 class="size-250 fl-space">Default language for new user</h4>
    
    <select name="plang">
        <option value="ru_RU" <%=ru %>>Ð ÑÑÑÐºÐ¸Ð¹</option>
        
            <option value="zh_TW" <%=tw %>>ç¹é«ä¸­æ</option>
        
            <option value="pt_BR" <%=br %>>Portuguese (Brazilian)</option>
        
            <option value="fr_FR" <%=fr %>>FranÃ§ais</option>
        
            <option value="zh_CN" <%=zhcn %>>ç®ä½ä¸­æ</option>
        
            <option value="fi_FI" <%=fi %>>Finnish (Suomi)</option>
        
            <option value="ko_KR" <%=kr %>>Korean</option>
        
            <option value="it_IT" <%=it %>>Italiano</option>
        
            <option value="cs_CZ" <%=cz %>>ÄeÅ¡tina</option>
        
            <option value="nl_NL" <%=nl %>>Netherlands</option>
        
            <option value="sr_LT" <%=lt %>>Serbian (Latin)</option>
        
            <option value="en_US" <%=us %>>English (US)</option>
        
            <option value="de_DE" <%=de %>>Deutsch (Deutsch)</option>
        
            <option value="es_ES" <%=es %>>EspaÃ±ol</option>
        
            <option value="pl_PL" <%=pl %>>Polski</option>
        
            <option value="sl_SI" <%=si %>>Slovenian</option>
        
    </select>
</div>
   
   
  

                        </div>

                        <div class="col1-3 lastcol">
                            <div class="mark_blue bt-space10">
                                <ul class="standard clean-padding bt-space10">
                                    <li class="bt-space5">Set value to 0 for unlimited.</li>
                           </ul>
                            </div>
                        </div>
                    </div>

                    

                    
    
        
    
                        
                        
    
    
    
                

                <div class="rule2"></div>
    <div class="form-field clear">
        <h4 class="size-250 fl-space">&nbsp;</h4>
        <span>
            <input type="submit" value="Save changes" class="button green" />
        </span>
    </div>
        
        
        </form>
        </div>
    </div>
</div>


            </div>
        </div>
    </div>

    <%} %>
       <%@include file="footer.jsp" %>
   
    
    <script type="text/javascript">
        function change_url(domain, baseurl) {
            if ( domain.options[domain.selectedIndex].value != 'none' ) {
                location.href = baseurl + domain.options[domain.selectedIndex].value;
            }
        }
    </script>
        
    <script type="text/javascript" src="/unifiedmail/npjs/jquery-1.4.2.min.js"></script>

    
        <script type="text/javascript" src="/unifiedmail/npjs/jquery.tooltip.js"></script>
    
        <script type="text/javascript" src="/unifiedmail/npjs/jquery.idtabs.js"></script>
    
        <script type="text/javascript" src="/unifiedmail/npjs/jquery.fancybox.js"></script>
    

    

    

    <script type="text/javascript">
    
    

    
    $(document).ready(function() {
        
        $('.menu li').hover(function () {
            $(this).find('ul:first').css({'visibility': 'visible', 'display': 'none'}).slideDown();
        }, function () {
            $(this).find('ul:first').css({visibility: "hidden"});
        });$('.content-box .select-all').click(function () {
            if ($(this).is(':checked'))
                $(this).parent().parent().parent().parent().find(':checkbox').attr('checked', true);
            else
                $(this).parent().parent().parent().parent().find(':checkbox').attr('checked', false);
        });

        /* Tabs */
        $('.content-box .tabs').idTabs();

        
        $('.notification .close').click(function () {
            $(this).parent().fadeOut(300);
            return false;
        });

        
        $("a[title], img[title], span[title], input[title]").tooltip({
            position: "top center",
            offset: [-5, 0],
            predelay: 300,
            delay: 100,
            effect: "fade",
            opacity: 1
        });

        

        $('.onFocusEmpty').focus(function () {
            $(this).val('');
        });

        
        $('.modal-link').fancybox({
            'modal'                 : false,
            'hideOnOverlayClick'    : true,
            'hideOnContentClick'    : false,
            'enableEscapeButton'    : true,
            'showCloseButton'       : true
        });
        $("a[href$='gif']").fancybox();
        $("a[href$='jpg']").fancybox();
        $("a[href$='png']").fancybox();

        
    });
    </script>
    
<%}
}
 %>
    
</body>
</html>

