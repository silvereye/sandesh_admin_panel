<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'tmp.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script type="text/javascript" src="http://apis.google.com/js/plusone.js"></script>
<script type="text/javascript" src="http://platform.twitter.com/widgets.js"></script>
  </head>
  
  <body>
   <div style="float: right;">
 <div style="float: left; clear: none; padding: 5px; padding-left: 5.5px; padding-right: 5.5px;">
  <a href="http://twitter.com/share" class="twitter-share-button" data-count="horizontal" data-via="lbenitez">Tweet</a>
 </div>
 <div style="float: left; clear: none; padding: 5px; padding-left: 5.5px; padding-right: 5.5px;">
  <g:plusone></g:plusone>
 </div>
 <div style="float: left; clear: none; padding: 5px; padding-left: 5.5px; padding-right: 5.5px;">
  <iframe src="http://www.facebook.com/plugins/like.php?app_id=166725596724792&amp;href=
<%=request.getRequestURL()%>&amp;send=false&amp;layout=button_count&amp;width=75
&amp;show_faces=false&amp;action=like&amp;colorscheme=light&amp;font&amp;height=21"
 scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:75px; height:21px;" allowTransparency="true"></iframe>
 </div>
</div>
<script
   type="text/javascript"
   src="fb-sidelike.js"
   fbpage='pages/Bharat-Mata-Mandir/546348558738736?ref=hl'></script>
  <div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/all.js#xfbml=1";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>

<div class="fb-like-box" data-href="https://www.facebook.com/pages/Bharat-Mata-Mandir/546348558738736?ref=hl" data-width="292" data-show-faces="true" data-header="true" data-stream="false" data-show-border="true"></div>
 </body>
</html>
