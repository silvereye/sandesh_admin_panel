<%@ page language="java" import="java.util.*,mypack.*" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.regex.*" %>
<%@ page import="javax.naming.directory.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		
		
		<link rel="stylesheet" href="/unifiedmail/css/style.css" type="text/css" />
		<style type="text/css" title="currentStyle">
			@import "css/demo_page.css";
			@import "css/demo_table.css";
		</style>
		<script type="text/javascript" language="javascript" src="js/jquery.js"></script>
		<script type="text/javascript" language="javascript" src="js/jquery.dataTables.js"></script>
		<script type="text/javascript" charset="utf-8">
			$(document).ready(function() {
				$('#example').dataTable( {
					"fnDrawCallback": function ( oSettings ) {
						var that = this;

						/* Need to redo the counters if filtered or sorted */
						if ( oSettings.bSorted || oSettings.bFiltered )
						{
							this.$('td:first-child', {"filter":"applied"}).each( function (i) {
								that.fnUpdate( i+1, this.parentNode, 0, false, false );
							} );
						}
					},
					"aoColumnDefs": [
						{ "bSortable": false, "aTargets": [ 0 ] }
					],
					"aaSorting": [[ 1, 'asc' ]]
				} );
			} );
		</script>
	</head>
	<body id="dt_example">
	 <%@include file="/header.jsp" %>
		<div id="container">
			
		
			
			
			<div id="demo">
<table cellpadding="0" cellspacing="0" border="0" class="display" id="example">
	<thead>
		<tr>
			<th>Index</th>
			<th>Rendering engine</th>
			<th>Browser</th>
			<th>Platform(s)</th>
		
		</tr>
	</thead>
	<tbody>
	<%
				HttpSession hs=request.getSession(false);
		        String username=(String)hs.getAttribute("id");
		        String password=(String)hs.getAttribute("password");
		        String url=(String)hs.getAttribute("url");
		        String base1=(String)hs.getAttribute("base");
try
{
String dom="";
dom=request.getParameter("dm");
System.out.println("dom="+dom);
if(dom==null)
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
SearchControls constraints = new SearchControls(); 
constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
String attrList[] = {"cn","accountStatus","mail","jpegPhoto"}; 
constraints.setReturningAttributes(attrList);
NamingEnumeration results =ctx.search(base,"mail=*", constraints);
int f=0;
while (results.hasMore()) {
f=1;
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
        else if(id.equalsIgnoreCase("jpegPhoto"))
        {
        //v3=str;
        }



           System.out.println("  <br> "+id + ":--- " +str);
           }
    }

if(v3.indexOf("@")>0)
{
%>


			<td class="centerC"></td>
			<td><%=v1 %></td>
			<td>
			<a href="/unifiedmail/global/edituserprofile.jsp?ml=<%=v3 %>">
			<%=v3 %></a></td>
			<td><%=v2 %></td>
			
		</tr>



<%
}
}
if(f==0)
{
out.print("Search not found");
}

}
}
catch(Exception e){System.out.print(e);}
	
	 %>


	
	</tbody>
	<tfoot>
		<tr>
			<th>Index</th>
			<th>Rendering engine</th>
			<th>Browser</th>
			<th>Platform(s)</th>
			
		</tr>
	</tfoot>
</table>
			</div>
			
			
			
			
		</div>
	</body>
</html>