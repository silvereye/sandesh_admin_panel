<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Activity Feed Test</title>
    <script language="javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js" type="text/javascript"></script>
<script language="javascript" src="tweet/jquery.tweet.js" type="text/javascript"></script>
<link href="tweet/jquery.tweet.css" media="all" rel="stylesheet" type="text/css"/>
  <script type='text/javascript'>
    jQuery(function($){
        $(".tweet").tweet({
            username: "BMM_Haridwar",
            join_text: "auto",
            avatar_size: 32,
            count: 3,
            auto_join_text_default: "we said,", 
            auto_join_text_ed: "we",
            auto_join_text_ing: "we were",
            auto_join_text_reply: "we replied to",
            auto_join_text_url: "we were checking out",
            loading_text: "loading tweets..."
        });
    });
</script>
  </head>
  <body>
  
  <div class="tweet"></div>
 <div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/all.js#xfbml=1";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>

<div class="fb-like-box" data-href="https://www.facebook.com/pages/Bharat-Mata-Mandir/546348558738736?ref=hl" data-width="292" data-show-faces="false" data-header="false" data-stream="true" data-show-border="true"></div>

 </body>
</html>
