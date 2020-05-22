<%@ page language="java" import="java.util.*,mypack.*,java.io.*" pageEncoding="UTF-8"%>
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
 <noscript><meta http-equiv="refresh" content="0; URL=/unifiedmail/error/nojavascritp2.jsp"></noscript>

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
function valData()
{

//alert("comming soon");
return true;

}




 function addCatchAdd()
{
//document.getElementById("maildiv").innerHTML="";
var no=parseInt(document.f.hid_cadd.value);
no=no+1;
document.f.hid_cadd.value=no;
var name="cadd"+no;
var element = document.createElement("input");
element.setAttribute("type", "email");
element.setAttribute("name", name);
element.setAttribute("id", name);
element.setAttribute("class", "text");
element.setAttribute("size", "35");
//element.setAttribute("onblur", "makeMail(this.value)");

 var brElement = document.createElement("br");
  var brElement1 = document.createElement("br");
 
var foo = document.getElementById("fooBar1");
 foo.appendChild(element);
          foo.appendChild(brElement );
           foo.appendChild(brElement1 );
        
         

}
 
</script>

<!-- ckeditor -->
<script src="/unifiedmail/js/jquery.min.1.9.js"></script>
	<script src="/unifiedmail/ckeditor/ckeditor.js"></script>
	<script src="/unifiedmail/ckeditor/adapters/jquery.js"></script>
	
	<style>

		#editable
		{
			padding: 10px;
			float: left;
		}

	</style>
	<script>

		CKEDITOR.disableAutoInline = true;
$.noConflict();
		jQuery(document).ready(function($) {
			$( '#editor1' ).ckeditor(); // Use CKEDITOR.replace() if element is <textarea>.
			//$( '#editable' ).ckeditor(); // Use CKEDITOR.inline().
		} );

		

	</script>
<!-- /ckeditor -->
</head>

<body>
 
   <%
   String dn=request.getParameter("dn");
  if( dn!=null && !(dn.equals("")) )
   {
   HttpSession hs=request.getSession(false);
    String utype=(String)hs.getAttribute("user_name");
    
%>  
       
  
    
    
   
   
   
   
    <%@include file="header.jsp" %>

 
    
    

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
<p><%=dn %> disclaimer has been updated successfully. </p>	</div>
      <%}
      else if(stt!=null && stt.equalsIgnoreCase("error"))
      {
       %>
 <div id="msg_err" class="notification note-error"><a href='#' class='close'></a>                
<p>disclaimer updation has been failed.	</p></div>
    
    
    <%} %>



    


<div class="content-box">
    <div class="box-body">
        <div class="box-header clear">
            <ul class="tabs clear">
                
                    
                          
                 <li><a href="/unifiedmail/global/editdomainprofile.jsp?dn=<%=dn %>" >General</a></li>
                        <li><a href="/unifiedmail/global/bccdomain.jsp?dn=<%=dn %>" >BCC</a></li>
                        <li  ><a href="/unifiedmail/global/relaydomain.jsp?dn=<%=dn %>">Relay</a></li>
                        <li ><a href="/unifiedmail/global/catchalldomain.jsp?dn=<%=dn %>">Catch-all</a></li>
                        <li><a href="/unifiedmail/global/aliasesdomain.jsp?dn=<%=dn %>">Aliases</a></li>                      
                        <%
                         if(utype!=null && utype.equalsIgnoreCase("Admin"))
                                {
                         %>
                        <li><a href="/unifiedmail/global/throttlingdomain.jsp?dn=<%=dn %>">Throttling</a></li>      
                         <%} %>
                        <li class="active"><a href="/unifiedmail/global/disclaimerdomain.jsp?dn=<%=dn %>">Disclaimer</a></li>                        
                        <li><a href="/unifiedmail/global/advancedomain.jsp?dn=<%=dn %>">Advanced</a></li>
                        
               
            </ul>
            <h2>Profile of domain: <%=dn %> <a href="/unifiedmail/global/domainsentmail.jsp?dn=<%=dn %>">
            <img src="/unifiedmail/images/graph_16.png"  title="Domain activities"  style="padding-left: 5px;" class="vcenter"   />
        </a></h2>
        </div>

        <div class="box-wrap clear">
        
       <%
       String loc="";
       String rem="";
        
try
          {
          FileInputStream in = new FileInputStream("/maildir/domains/disclaimer/"+dn+".html");
          BufferedReader br = new BufferedReader(new InputStreamReader(in));
          String strLine;
 
          // Read file line by line
          // Processing would be called here
          while((strLine = br.readLine())!= null)
          {
          loc=loc+strLine;
           System.out.println(strLine);
          }
 
          }catch(Exception e){
           System.out.println(e);
          }
          
          try
          {
          FileInputStream in = new FileInputStream("/maildir/domains/disclaimer/"+dn+".txt");
          BufferedReader br = new BufferedReader(new InputStreamReader(in));
          String strLine;
 
          // Read file line by line
          // Processing would be called here
          while((strLine = br.readLine())!= null)
          {
          rem=rem+strLine;
           System.out.println(strLine);
          }
 
          }catch(Exception e){
           System.out.println(e);
          }
          
          
    loc=loc.trim();
   // rem=rem.trim();
     File  f = new File("/maildir/domains/disclaimer/"+dn+".html");
       if(!f.exists())
		{
		loc="<p style='text-align: justify;'>WARNING: Computer viruses can be transmitted via email. The recipient should check this email and any attachments for the presence of viruses. The company accepts no liability for any damage caused by any virus transmitted by this email. E-mail transmission cannot be guaranteed to be secure or error-free as information could be intercepted, corrupted, lost, destroyed, arrive late or incomplete, or contain viruses. The sender therefore does not accept liability for any errors or omissions in the contents of this message, which arise as a result of e-mail transmission.<br /> WARNING: Although the company has taken reasonable precautions to ensure no viruses are present in this email, the company cannot accept responsibility for any loss or damage arising from the use of this email or attachments.</p>"	;   
		}
		
		f=new File("/maildir/domains/disclaimer/"+dn+".txt");
		if(!f.exists())
		{
		rem="WARNING: Computer viruses can be transmitted via email. The recipient should check this email and any attachments for the presence of viruses. The company accepts no liability for any damage caused by any virus transmitted by this email. E-mail transmission cannot be guaranteed to be secure or error-free as information could be intercepted, corrupted, lost, destroyed, arrive late or incomplete, or contain viruses. The sender therefore does not accept liability for any errors or omissions in the contents of this message, which arise as a result of e-mail transmission. WARNING: Although the company has taken reasonable precautions to ensure no viruses are present in this email, the company cannot accept responsibility for any loss or damage arising from the use of this email or attachments.";
		}
  //out.print("<br>local="+loc);
 //   out.print("<br><br><br>remote="+rem);
    

 %>
        
        
        
        
       
         <form action="/unifiedmail/servlet/UploadDesclaimerServlet" name="f" method="post" onsubmit="return valData()">
   
         <input type="hidden" name="hid_dn" value="<%=dn %>"/>
                
                    <div class="columns clear">
                        <div class="col2-3 ">
                        
                        
                        
                        
                         <div class="form-field clear">
        <h4 class="size-250 fl-space">Disclaimer (Html)</h4>
        
            
    </div>
                        
                        
                        
                        
                           <div class="form-field clear" >
       
                          <textarea name="dis_h" id="editor1" ><%=loc %></textarea>
                         
                        </div>
                       
                           <div class="form-field clear" >
                            <br/><h4 class="size-250 fl-space">Disclaimer (Plain Text)</h4><br/>
                          <textarea name="dis_t" id="dis"   style="height: 290px; width:943px !important"><%=rem %></textarea>
                            
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
    
<%} %>
        
  </body>
</html>
