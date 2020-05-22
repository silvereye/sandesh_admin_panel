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
 <title>Support | Silvereye Unified E-mail Server</title>
 <noscript><meta http-equiv="refresh" content="0; URL=/unifiedmail/error/nojavascritp2.jsp"></noscript>

    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/reset.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/screen.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/fancybox.css" />

    <!--[if IE 7]>
        <link rel="stylesheet" type="text/css" href="/unifiedmail/npcss/ie7.css">
    <![endif]-->


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
 
    
  
    
    
   
   
   
   
    <%@include file="/global/header.jsp" %>

 
    
    

    <div class="main pagesize"> <!-- *** mainpage layout *** -->
        <div class="main-wrap">
        
        
        
      
        
        
            <div class="page clear">
                
                



    <%
    String stt=request.getParameter("status");
    if(stt!=null && stt.equalsIgnoreCase("succ"))
    {  
   // String dn= request.getParameter("nm"); 
     %>
     <div class='notification note-success'><a href='#' class='close'></a>
<p> Mail has been sent successfully. </p>	</div>
      <%}
      else if(stt!=null && !stt.equalsIgnoreCase("succ"))
      {
       %>
 <div id="msg_err" class="notification note-error"><a href='#' class='close'></a>                
<p>Sending mail has been failed.	</p></div>
    
    
    <%} %>



    


<div class="content-box">
    <div class="box-body">
        <div class="box-header clear">
            
            <h2>Support</h2>
        </div>

        <div class="box-wrap clear">
        
      
        
        
        
       
         <form action="/unifiedmail/servlet/SupportServlet" name="f" method="post" >
   
        
                
                    <div class="columns clear">
                       <div class="col3-4">  
                        <div class="form-field clear">
        <h4 class="size-250 fl-space">Name </h4>
        <span class="clean-padding bt-space20"><input type="text" name="nm" placeholder="Name" id="nm" required value="" size="35" title="" class="text" /></span>
    </div>
    
    
    <div class="form-field clear">
        <h4 class="size-250 fl-space">Contact Number </h4>
        <span class="clean-padding bt-space20"><input type="text" name="cno" placeholder="Name" id="cno" required value="" size="35" title="" class="text" /></span>
    </div>
    
    
    <div class="form-field clear">
        <h4 class="size-250 fl-space">Issue </h4>
        <span class="clean-padding bt-space20">
        <select style="width: 212px;" name="issue">
                              <option value="Web Mail Access" selected="selected">Web Mail Access</option>
                              <option value="Mail Sending Issue">Mail Sending Issue</option>
                              <option value="Email not coming from other">Email not coming from other</option>
                            </select>
        </span>
    </div>
    
    
    
    <div class="form-field clear">
        <h4 class="size-250 fl-space">Company Name</h4>
        <span class="clean-padding bt-space20"><input type="text" name="compname" placeholder="Name" id="compname" required value="" size="35" title="" class="text" /></span>
    </div>
    
    
    <div class="form-field clear">
        <h4 class="size-250 fl-space">Priority </h4>
        <span class="clean-padding bt-space20">
       <select style="width: 212px;" name="pri">
                              <option value="Low" selected="selected">Low</option>
                              <option value="Critical">Critical</option>
                              <option value="High">High</option>
                            </select>
        </span>
    </div>
    <div class="form-field clear">
        <h4 class="size-250 fl-space">Disclaimer </h4>
        
            
    </div>
                        
                        
                        
                        
                           <div class="form-field clear" >
       
                          <textarea name="desc" id="editor1" ></textarea>
                         
                        </div>
    
                   </div>     
				</div>

            
            

                <div class="rule2"></div>
    <div class="form-field clear">
        <h4 class="size-250 fl-space">&nbsp;</h4>
        <span>
            <input type="submit" value="Send" class="button green" />
        </span>
    </div>
        
        
        
        
        
        
        
        
         
        </form>
        </div>
    </div>
</div>


            </div>
        </div>
    </div>

    
       <%@include file="/global/footer.jsp" %>
   
    
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
