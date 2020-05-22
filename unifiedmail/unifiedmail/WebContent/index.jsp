<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<meta charset="utf-8">
	<title>jQuery Adapter &mdash; CKEditor Sample</title>
	<script src="/unifiedmail/ckeditor/jquery.min.js"></script>
	<script src="/unifiedmail/ckeditor/ckeditor.js"></script>
	<script src="/unifiedmail/ckeditor/adapters/jquery.js"></script>
	<link href="/unifiedmail/ckeditor/samples/sample.css" rel="stylesheet">
	<style>

		#editable
		{
			padding: 10px;
			float: left;
		}

	</style>
	<script>

		CKEDITOR.disableAutoInline = true;

		$( document ).ready( function() {
			$( '#editor1' ).ckeditor(); // Use CKEDITOR.replace() if element is <textarea>.
			$( '#editable' ).ckeditor(); // Use CKEDITOR.inline().
		} );

		

	</script>
</head>
<body>
	<h2 class="samples">Framed Example</h2>

		<textarea cols="60" id="editor1" name="editor1" rows="10">
		</textarea>
</body>
</html>
