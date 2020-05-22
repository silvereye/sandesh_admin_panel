<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'scroll.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<style type="text/css">

.article {
	padding:16px 0;
	border-top:1px solid #ddd;
}
</style>
<script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
<script type="text/javascript">
$(window).scroll(function(){
      if  ($(window).scrollTop() == $(document).height() - $(window).height()){
           AddMoreContent();
      }
 });    

 function AddMoreContent(){
      $.post('scroll1.jsp?nm=Surya', function(data) {
           //Assuming the returned data is pure HTML
           //alert(data);
           $(data).insertBefore($('#placeHolder'));
      });
 }

</script>
<script src="jquery-1.3.2.min.js"></script>


  </head>
  
  <body>
    <div class="article">
			<h1>Sit Amet</h1>
			<p>Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo.</p>
		</div>

		<div class="article">
			<h1>Consectetuer Adipiscing Elit</h1>
			<p>Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.</p>
		</div>

		<div class="article">
			<h1>Aenean</h1>
			<p>Pellentesque fermentum dolor. Aliquam quam lectus, facilisis auctor, ultrices ut, elementum vulputate, nunc.</p>
			<p>Aliquam tincidunt mauris eu risus.</p>
		</div>

		<div class="article">
			<h1>Vestibulum</h1>
			<p>Praesent dapibus, neque id cursus faucibus, tortor neque egestas augue, eu vulputate magna eros eu erat. Aliquam erat volutpat. Nam dui mi, tincidunt quis, accumsan porttitor, facilisis luctus, metus.</p>
			<p>Phasellus ultrices nulla quis nibh. Quisque a lectus. Donec consectetuer ligula vulputate sem tristique cursus. Nam nulla quam, gravida non, commodo a, sodales sit amet, nisi.</p>
		</div>
		
		<div id="placeHolder"></div>
  </body>
</html>
