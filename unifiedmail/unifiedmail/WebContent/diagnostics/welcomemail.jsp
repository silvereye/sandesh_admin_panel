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
 <title>Welcome mail | Silvereye Unified E-mail Server</title>
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
			//$( '#editor1' ).ckeditor(); // Use CKEDITOR.replace() if element is <textarea>.
			CKEDITOR.replace( 'editor1', {	  
				toolbar: [		// Defines toolbar group without name.																			
				{ name: 'document', groups: [ 'mode', 'document', 'doctools' ], items: [ 'Source' ] },
				{ name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ], items: [ 'Bold', 'Italic', 'Underline' ] },
				{ name: 'paragraph', groups: [ 'list', 'indent', 'blocks', 'align', 'bidi' ], items: [  'NumberedList', 'BulletedList','JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock' ] },
				{ name: 'links', items: [ 'Link', 'Unlink', '' ] },
				{ name: 'insert', items: [ 'Image',  'Table',  'Smiley', 'SpecialChar',  ] },
				{ name: 'styles', items: [ 'Styles', 'Format', 'Font', 'FontSize' ] },
				{ name: 'colors', items: [ 'TextColor', 'BGColor' ] }
				],
				height: 250,
				width: 950,
				enterMode: CKEDITOR.ENTER_BR,
				allowedContent : true
				
			});
			
			
			
		} );

		

	</script>
<!-- /ckeditor -->
</head>

<body>
 
   
   <%
 HttpSession ses=request.getSession(false);
 String chid= (String)ses.getAttribute("id");
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
  
    
    
   
   
   
   
    <%@include file="/global/header.jsp" %>

 
    
    

    <div class="main pagesize"> <!-- *** mainpage layout *** -->
        <div class="main-wrap">
        
        
         <%
          
String utp=(String)ses.getAttribute("user_name");
          if(ses!=null && !(utp.equalsIgnoreCase("Admin")))
          {
           %>  
      
	<div class="sublev-nav">	
   	<ul>
   		<li>Access is Denied.</li>

   	</ul>
   	<div class="clr"></div>
   	</div>
        
        <%}
        else
        {
         %>
        
        
            <div class="page clear">
                
                



    <%
    String stt=request.getParameter("status");
    if(stt!=null && stt.equalsIgnoreCase("succ"))
    {  
   // String dn= request.getParameter("nm"); 
     %>
     <div class='notification note-success'><a href='#' class='close'></a>
<p>Welcome mail's content has been updated successfully. </p>	</div>
      <%}
      else if(stt!=null && stt.equalsIgnoreCase("error"))
      {
       %>
 <div id="msg_err" class="notification note-error"><a href='#' class='close'></a>                
<p>Welcome mail's content updation has been failed.	</p></div>
    
    
    <%} %>



    


<div class="content-box">
    <div class="box-body">
        <div class="box-header clear">
            <ul class="tabs clear">
                
                  
               
            </ul>
            <h2>Content of Welcome Mail</h2>
        </div>

        <div class="box-wrap clear">
        
       <%
       String loc="";
       loc=loc+"<p>Hi Username,</p>";

loc=loc+"<p>We&#39;ve created an e-mail account (id@domain.com) for you! We encourage you to use this account as your primary e-mail address.</p>";

loc=loc+"<p>With your new account, you get:</p>";

loc=loc+"<ul>";
loc=loc+"	<li><strong>Access from anywhere.</strong>&nbsp;Use a Web browser to access your mailbox from any computer that has an Internet connection.</li>";
loc=loc+"	<li><strong>Access to your e-mail accounts.</strong>&nbsp;Use this account to send and receive mail. You can also use other e-mail programs to connect to your mailbox.</li>";
loc=loc+"	<li><strong>Access your mail from your cell phone.</strong>&nbsp;Use your cell phone to access your e-mail.</li>";
loc=loc+"	<li><strong>Chat with friends and family.</strong>&nbsp;Use your account to chat with colleagues, just as you would with any instant messaging service.</li>";
loc=loc+"</ul>";

loc=loc+"<p>To connect:</p>";

loc=loc+"<p style='margin-left:36pt'>1.&nbsp;&nbsp;&nbsp;&nbsp; Go to https://mail.silvereye.in</p>";

loc=loc+"<p style='margin-left:36pt'>2.&nbsp;&nbsp;&nbsp;&nbsp; Use the following credentials to sign in:</p>";

loc=loc+"<p style='margin-left:72pt'>&middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; User ID:&nbsp;<strong>id@domain.com</strong></p>";

loc=loc+"<p style='margin-left:72pt'>&middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Password:&nbsp;<strong>contact administrator</strong></p>";

loc=loc+"<p style='margin-left:36pt'>3.&nbsp;&nbsp;&nbsp;&nbsp; Click Login.</p>";

loc=loc+"<p><strong>Tip:</strong>&nbsp;Add https://mail.silvereye.in to your favourites list to make it easy to sign in.</p>";

loc=loc+"<p>Change your password</p>";

loc=loc+"<div>";
loc=loc+"<hr /></div>";

loc=loc+"<p>We created the temporary password that you use to sign in for the first time, but we recommend that you change this password as soon as possible so you&#39;re the only one who knows your password.</p>";
       
        
try
          {
          FileInputStream in = new FileInputStream("/maildir/domains/welcomemail/content.html");
          BufferedReader br = new BufferedReader(new InputStreamReader(in));
          String strLine;
 
          // Read file line by line
          // Processing would be called here
          int f=0;
          while((strLine = br.readLine())!= null)
          {
          f++;
          if(f==1)
          {
          loc="";
          }
          
          loc=loc+strLine;
           System.out.println(strLine);
          }
 
          }catch(Exception e){
           System.out.println(e);
          }
          
          
          
          
    loc=loc.trim();
    /*
     File  f = new File("/maildir/domains/welcomemail/content.html");
       if(!f.exists())
		{
		loc="<p style='text-align: justify;'>WARNING: Computer viruses can be transmitted via email. The recipient should check this email and any attachments for the presence of viruses. The company accepts no liability for any damage caused by any virus transmitted by this email. E-mail transmission cannot be guaranteed to be secure or error-free as information could be intercepted, corrupted, lost, destroyed, arrive late or incomplete, or contain viruses. The sender therefore does not accept liability for any errors or omissions in the contents of this message, which arise as a result of e-mail transmission.<br /> WARNING: Although the company has taken reasonable precautions to ensure no viruses are present in this email, the company cannot accept responsibility for any loss or damage arising from the use of this email or attachments.</p>"	;   
		}
	*/	
		
  //out.print("<br>local="+loc);
 //   out.print("<br><br><br>remote="+rem);
    

 %>
        
        
        
        
       
         <form action="/unifiedmail/servlet/UploadWelcomemailServlet" name="f" method="post" onsubmit="return valData()">
   
         
                
                    <div class="columns clear">
                        <div class="col2-3 ">
                        
                        
                        
                        
                         <div class="form-field clear">
        <h4 class="size-250 fl-space"></h4>
        
            
    </div>
                        
                        
                        
                        
                           <div class="form-field clear" >
       
                          <textarea name="dis_h" id="editor1" ><%=loc %></textarea>
                         
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
            <%
            }
             %>
        </div>
    </div>

    
       <%@include file="/global/footer.jsp" %>
   <%} %>
    
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
    

        
  </body>
</html>
