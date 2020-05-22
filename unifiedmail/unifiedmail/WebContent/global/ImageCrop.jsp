<%@ page language="java" import="java.util.*,java.io.*" pageEncoding="UTF-8"%>
<%
String path_n = request.getContextPath();
String basePath_n = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path_n+"/";
%>

<html>
	<head>
<title>Edit User Profile | Silvereye Unified E-mail Server</title>
 <noscript><meta http-equiv="refresh" content="0; URL=/unifiedmail/error/nojavascritp.jsp"></noscript>

		<script src="/unifiedmail/imagecrop/jquery.1.4.2.js"></script>
		<script src="/unifiedmail/imagecrop/jquery.Jcrop.js"></script>
		<link rel="stylesheet" href="/unifiedmail/imagecrop/jquery.Jcrop.css" type="text/css" />
		

		<script language="Javascript">


  
			$(function(){

				$('#cropbox').Jcrop({
					aspectRatio: 1,
					onSelect: updateCoords
				});

			});


			function updateCoords(c)
			{
				$('#x').val(c.x);
				$('#y').val(c.y);
				$('#w').val(c.w);
				$('#h').val(c.h);
			};

			function checkCoords()
			{
				if (parseInt($('#w').val())) return true;
				alert('Please select a crop region then press submit.');
				return false;
			};

		</script>
    
    
    
  <style>
    .blockbkg {
      background-color: black;
      opacity: 90%;
      filter:alpha(opacity=90);
      background-color: rgba(0,0,0,0.90);
      width: 100%;
      min-height: 100%;
      overflow: hidden;
      float: absolute;
      position: fixed;
      top: 0;
      left: 0;
      color: white;
    }
    .cont {
      background-color: white;
      color: black;
      font-size: 16px;
      border: 1px solid gray;
      padding: 20px;
      display:block;
      position: absolute;
      top: 10%;
      left: 35%;
      width: 350px;
      height: 400px;
      overflow-y: auto;
      overflow-x: auto;
    }
    .closebtn {
      width: 20px;
      height: 20px;
      padding: 5px;
      margin: 2px;
      float: right;
      top: 0;
      background-image: url(x.png);
      background-repeat: no-repeat;
      background-position:center;
      background-color: lightgray;
      display: block;
    }
    .closebtn:hover {
      cursor: pointer;
    }
   
  </style>

  
    
    <script type="text/javascript">
    function mypopUp()
    {

     document.getElementById('bkg').style.visibility = 'visible';
      document.getElementById('dlg').style.visibility = 'visible';
    }
    
    function closeDiv()
    {
    var ml=document.getElementById("hid_mail").value;
   var url="/unifiedmail/global/edituserprofile.jsp?ml="+ml+"&status=succ";
 //alert(url)
 window.location=url;
    //document.getElementById('bkg').style.visibility = 'hidden';
   // document.getElementById('dlg').style.visibility ='hidden';
    }
    
    
   
    </script>
    
	</head>

	<body onload="mypopUp()">

	
 <div class="blockbkg" id="bkg" style="visibility: hidden;">
    <div class="cont" id="dlg" style="visibility: hidden;">
      <div class="closebtn" title="Close" id="closebtn"><a onclick="closeDiv()">X</a></div>
      <h1>Crop Image</h1>
      <p>






<div id="outer" >
	<div class="jcExample">
	<div class="article">

		

		<!-- This is the image we're attaching Jcrop to -->
		<%
		String nm=request.getParameter("nm");
		HttpSession hs=request.getSession();
		String mail=(String)hs.getAttribute("user_mail");
		String ur = (request.getRequestURL()).toString();
			  int ur_i=ur.lastIndexOf(":");
			 String ur_prt=ur.substring(0,ur_i);
		  
               String pt=ur_prt+"/photo/"+nm    ;//"basePath_n+"photos/"+nm;
		
		int l=nm.lastIndexOf(".");
		String ext=nm.substring(l+1);
		String ml=nm.substring(0,l);
		System.out.println(ext);
		 %>
		<img src="<%=pt %>" id="cropbox" />

		<!-- This is the form that our event handler fills -->
		<form action="/unifiedmail/servlet/ImageCropServlet" method="get" onsubmit="return checkCoords();">
		<input type="hidden" value="<%=mail %>" id="hid_mail" />
			<input type="hidden" id="x" name="l" />
			<input type="hidden" id="y" name="t" />
			<input type="hidden" id="w" name="w" />
			<input type="hidden" id="h" name="h" />
			<input type="hidden" size="4" id="f" name="f" value="<%=ext %>" />
            <input type="hidden" size="4" id="i" name="i" value="photo/<%=nm %>"/>
			<input type="submit" value="Crop Image" />
			<input type="hidden"  name="hid_mail" value="<%=ml %>" />
		</form>
		</div>
	</div>
	</div>





      </p>
      
    </div>
  </div>
	</body>

</html>
