<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link rel="stylesheet" type="text/css" href="css/style.css" />
	<script type="text/javascript" src="JS/jquery-1.4.2.min.js"></script>
	<script src="JS/jquery.autocomplete.js"></script>	
	<script type="text/javascript">
	function hi(id)
	{
	
		var dn=document.getElementById("dn").value;
		$("#"+id).autocomplete("/unifiedmail/servlet/AutoCompServlet?dn="+dn);
	
	}
	
	</script>
</head>
<body>
<form action="">	<div style="width: 300px; margin: 50px auto;">
		<b>Country</b>   : <input type="text" id="country" name="country" class="input_text"/>
	</div>
	<input type="hidden" id="dn" value="np.com">
	<input type="text" id="country1" name="country1" onkeypress="hi(this.name)" onfocus="hi(this.name)"/>
	<input type="text" id="country2" name="country2" onkeyup="hi(this.name)"/>
	<input type="text" id="country3" name="country3" onkeydown="hi(this.name)"/>
	</form>
	
</body>
<script>
	jQuery(function(){
		$("#country").autocomplete("/unifiedmail/servlet/AutoCompServlet?dn=np.com");
	});
</script>
</html>