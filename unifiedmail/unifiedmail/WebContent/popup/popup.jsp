<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

      <link rel="STYLESHEET" type="text/css" href="popup-contact.css">
</head>
<body onload="javascript:fg_hideform('fg_formContainer','fg_backgroundpopup');">
<p>
This is an example page showing how to add the popup contact form to your website.
Click on the button below to open the popup.
</p>
<p>
<a href='javascript:fg_popup_form("fg_formContainer","fg_form_InnerContainer","fg_backgroundpopup");'
><img border='0' src='contact-us-button.png' width='213' height='39' /></a>
</p>

<script type='text/javascript' src='scripts/gen_validatorv31.js'></script>
<script type='text/javascript' src='scripts/fg_ajax.js'></script>
<script type='text/javascript' src='scripts/fg_moveable_popup.js'></script>
<script type='text/javascript' src='scripts/fg_form_submitter.js'></script>
<div id='fg_formContainer'>
    <div id="fg_container_header">
        <div id="fg_box_Title">Contact us</div>
        <div id="fg_box_Close"><a href="javascript:fg_hideform('fg_formContainer','fg_backgroundpopup');">Close(X)</a></div>
    </div>

    <div id="fg_form_InnerContainer">
    <form id='contactus' action='javascript:fg_submit_form()' method='post' accept-charset='UTF-8'>

    <input type='hidden' name='submitted' id='submitted' value='1'/>
    <input type='hidden' name='id873c8b857c7e12945ad2' value='26a7e5cd755d60893d2f44e0d1edac5e'/>
    <input type='text'  class='spmhidip' name='spb5f5d0682cfcd9c46425dc163ea8309c' />
    <div class='short_explanation'>* required fields</div>
    <div id='fg_server_errors' class='error'></div>
    <div class='container'>
        <label for='name' >Your Full Name*: </label><br/>
        <input type='text' name='name' id='name' value='' maxlength="50" /><br/>
        <span id='contactus_name_errorloc' class='error'></span>
    </div>
    <div class='container'>
    <label for='email' >Email Address*:</label><br/>
        <input type='text' name='email' id='email' value='' maxlength="50" /><br/>
        <span id='contactus_email_errorloc' class='error'></span>
    </div>
    <div class='container'>
        <label for='message' >Message:</label><br/>
        <span id='contactus_message_errorloc' class='error'></span>
        <textarea rows="10" cols="50" name='message' id='message'></textarea>
    </div>

    <div class='container'>
        <input type='submit' name='Submit' value='Submit' />
    </div>
    </form>
    </div>
</div>

<div id='fg_backgroundpopup'></div>

<div id='fg_submit_success_message'>
    <h2>Thanks!</h2>
    <p>
    Thanks for contacting us. We will get in touch with you soon!
    <p>
        <a href="javascript:fg_hideform('fg_formContainer','fg_backgroundpopup');">Close this window</a>
    <p>
    </p>
</div>

</body>
</html>