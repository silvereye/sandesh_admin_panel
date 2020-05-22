<%@ page language="java" import="java.util.*,mypack.*" pageEncoding="UTF-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	 <script type="text/javascript" src="/unifiedmail/popup/javascripts/top_up-min.js"></script>
    <script type="text/javascript">
      TopUp.addPresets({
        "#images a": {
          fixed: 0,
          group: "images",
          modal: 0,
          title: "Example"
        },
        "#movies": {
          resizable: 0
        }
      });
    </script>
</head>
<body>
<form action="">	<div style="width: 300px; margin: 50px auto;">
		<b>Country</b>   : <input type="text" id="country" name="country" class="input_text"/>
	</div>
	<input type="hidden" id="dn" value="np.com" />
	<input type="text" id="country1" name="country1" onkeypress="hi(this.name)" onfocus="hi(this.name)"/>
	<input type="text" id="country2" name="country2" onkeyup="hi(this.name)"/>
	<input type="text" id="country3" name="country3" onkeydown="hi(this.name)"/>
	</form>
	
			 <a href="/unifiedmail/global/temp.jsp" toptions="effect = clip, layout = quicklook">
              <img src="/unifiedmail/global/images/search.png"/>
            </a>
        
       
</body>

</html>