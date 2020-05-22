

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
    <title>Edit account profile</title>

    
    <link rel="stylesheet" type="text/css" href="/unifiedmail/iredcss/reset.css" ></link>
    <link rel="stylesheet" type="text/css" href="/unifiedmail/iredcss/screen.css" />
    <link rel="stylesheet" type="text/css" href="/unifiedmail/iredcss/fancybox.css" />

    <!--[if IE 7]>
        <link rel="stylesheet" type="text/css" href="/unifiedmail/iredcss/ie7.css">
    <![endif]-->

    
</head>

<body>
   <%@include file="header.jsp" %>
<%
String dn="np.com";
String mail="np@np.com";
 %>

    <div class="main pagesize"> <!-- *** mainpage layout *** -->
    
        <div class="main-wrap">
	<div class="sublev-nav">	
   	<ul>
   		<li><a href="/unifiedmail/global/domainlist.jsp">All Domains</a></li>
<li><a href="/unifiedmail/global/editdomainprofile.jsp?dn=<%=dn %>"><%=dn %></a></li>
<li><a href="/unifiedmail/global/userslist.jsp?dm=<%=dn %>">Users</a></li>
<li><a class="active-subs" href="/unifiedmail/global/edituserprofile.jsp?ml=<%=mail %>" >Profile of User: &nbsp;&nbsp;<%=mail %></a></li>
<li><a href="/unifiedmail/global/maillistslist.jsp?dm=<%=dn %>">Mail Lists</a></li>
<li><a href="/unifiedmail/global/mailaliaseslist.jsp?dm=<%=dn %>">Mail Aliases</a></li>
   	</ul>
   	<div class="clr"></div>
   	</div>


            <div class="page clear">
                
                


    


    <div class="content-box">
        <div class="box-body">
            <div class="box-header clear">
                <ul class="tabs clear">
                    
                        
                            <li class="active"><a href="/iredadmin-pro-ldap/profile/user/general/test1@abc.com">General</a></li>
                        
                    
                        
                            <li ><a href="/iredadmin-pro-ldap/profile/user/forwarding/test1@abc.com">Forwarding</a></li>
                        
                    
                        
                            <li ><a href="/iredadmin-pro-ldap/profile/user/relay/test1@abc.com">Relay</a></li>
                        
                    
                        
                            <li ><a href="/iredadmin-pro-ldap/profile/user/aliases/test1@abc.com">Aliases</a></li>
                        
                    
                        
                            <li ><a href="/iredadmin-pro-ldap/profile/user/throttle/test1@abc.com">Throttling</a></li>
                        
                    
                        
                            <li ><a href="/iredadmin-pro-ldap/profile/user/wblist/test1@abc.com">White/Blacklist</a></li>
                        
                    
                        
                            <li ><a href="/iredadmin-pro-ldap/profile/user/password/test1@abc.com">Password</a></li>
                        
                    
                        
                            <li ><a href="/iredadmin-pro-ldap/profile/user/advanced/test1@abc.com">Advanced</a></li>
                        
                    
                </ul>

                <h2>Profile of user: test1@abc.com <a >
            <img src="/unifiedmail/images/graph_16.png"
                
                    title="Account activities"
                

                
                    style="padding-left: 5px;" class="vcenter"
                
            />
        </a></h2>
            </div>

            <div class="box-wrap clear">
            
<form name="general" method="post" action="/iredadmin-pro-ldap/profile/user/general/test1@abc.com">
    
        
    

    <input type="hidden" name="csrf_token" value="Qu2YhjNXpyXcGC3er98uaknNU2YD4C2V"/>

    
        <div class="columns clear">
            <div class="col2-3">
                
    

    <div class="form-field clear">
        
            <h4 class="size-250 fl-space">Enable this account</h4>
        

        <div class="form-checkbox-item clear fl-space2">
            <input name="accountStatus" value="active" type="checkbox" rel="checkboxhorizont" class="checkbox fl-space" checked />
        </div>
    </div>

                

<div class="form-field clear">
    <h4 class="size-250 fl-space">Mark this user as</h4>
    <div class="form-checkbox-item clear">
        <span class="clean-padding bt-space20"><input class="checkbox" name="domainadmin" value="normal" type="checkbox"  /> Domain admin</span>
        
            <span class="clean-padding bt-space20"><input class="checkbox" name="domainGlobalAdmin" value="global" type="checkbox"  /> Global admin</span>
        
    </div>
</div>

                
    <div class="form-field clear">
        <h4 class="size-250 fl-space">Displayed in Global LDAP Address Book</h4>
        <div class="form-checkbox-item clear">
            <input name="displayedInGlobalAddressBook" checked type="checkbox" rel="checkboxhorizont" class="checkbox" />
        </div>
    </div>

                <div class="bt-space10"></div>
                

    <div class="form-field clear">
        
            <h4 class="size-250 fl-space">Display Name</h4>
        

        <span class="clean-padding bt-space20">
            <input type="text" name="cn" value="testing" size="35" class="text" title="Full name" />
        </span>
    </div>

    
    <div class="form-field clear">
        <h4 class="size-250 fl-space">&nbsp;</h4>
        <span class="clean-padding bt-space20">
            <input type="text" name="first_name" value="test1" size="14" class="text" title="First name" />
            <input type="text" name="last_name" value="test1" size="15" class="text" title="Last name"/>
        </span>
    </div>
    
                <div class="form-field clear">
    
        <h4 class="size-250 fl-space">Preferred language</h4>
    
    <select name="preferredLanguage">
        
            <option value="ru_RU" >Русский</option>
        
            <option value="zh_TW" >繁體中文</option>
        
            <option value="pt_BR" >Portuguese (Brazilian)</option>
        
            <option value="fr_FR" >Français</option>
        
            <option value="zh_CN" >简体中文</option>
        
            <option value="fi_FI" >Finnish (Suomi)</option>
        
            <option value="ko_KR" >Korean</option>
        
            <option value="it_IT" >Italiano</option>
        
            <option value="cs_CZ" >Čeština</option>
        
            <option value="nl_NL" >Netherlands</option>
        
            <option value="sr_LT" >Serbian (Latin)</option>
        
            <option value="en_US" selected>English (US)</option>
        
            <option value="de_DE" >Deutsch (Deutsch)</option>
        
            <option value="es_ES" >Español</option>
        
            <option value="pl_PL" >Polski</option>
        
            <option value="sl_SI" >Slovenian</option>
        
    </select>
</div>
                
    

    
    

    
        
    

    <div class="form-field clear">
        
            <h4 class="size-250 fl-space">Mailbox Quota</h4>
        

        <span class="clean-padding fl-space2">
            <input type="text" name="mailQuota" value="1024" size="10" class="text fl-space" /> <label class="fl-space">MB </label>

            
                
            

            
                
                    
                        
                        <label class="fl-space"><em style="color: black; font-style: normal;">
                            
    

    
        
    

    
        
    

    
        
    

    
        <div class="progress-container" title="0%" style="width: 80px; height: 1.6em;">
            <div class="progress-bar" style="height: 1.6em; width: 0%; background-color: #ACE97C;"></div>
        </div>
    &nbsp;
                            Used&nbsp;0.&nbsp;(0%)
                        </em></label>
                    
                
            
        </span>

        <span><input type="hidden" name="oldMailQuota" value="1024" /></span>
    </div>

                <div class="bt-space10"></div>
                
    <div class="form-field clear">
        <h4 class="size-250 fl-space">User/Employee ID</h4>
        <span class="clean-padding bt-space20"><input type="text" name="employeeNumber" value="" size="35" class="text" /></span>
    </div>
                <div class="form-field clear">
        <h4 class="size-250 fl-space">Job Title/Responsibility</h4>
        <span class="clean-padding bt-space20"><input type="text" name="title" value="" size="35" class="text" /></span>
    </div>

                <div class="bt-space10"></div>
                <div class="form-field clear">
        <h4 class="size-250 fl-space">Mobile</h4>
        <span class="clean-padding bt-space20"><input type="text" name="mobile" value="" size="35" class="text" /></span>
    </div>
                
    <div class="form-field clear">
        <h4 class="size-250 fl-space">Telephone Number</h4>
        <span class="clean-padding bt-space20">
            <input type="text" name="telephoneNumber" value="" size="35" class="text" />
        </span>
    </div>
    <div class="form-field clear">
        <h4 class="size-250 fl-space">&nbsp;</h4>
        <span class="clean-padding bt-space20">
            <input type="text" name="telephoneNumber" value="" size="35" class="text" />
        </span>
    </div>
            </div>
            <div class="col1-3 lastcol">
                <div class="mark_blue bt-space10" style="width:100px;" >
                   <img alt="" width="100px" height="100" src="/unifiedmail/images/avatar.png" /><br/>&nbsp; &nbsp;
                   <a href="/iredadmin-pro-ldap/export/ldif/user/test1@abc.com" target="_blank">Change Photo</a>
                    
                </div>
            </div>
            
        </div><div class="rule"></div>
        <div class="columns clear">
            <div class="col2-3">

            <div class="form-field clear">
            <h4 class="size-250 fl-space">Member of Mail Lists</h4>
            <div class="checklist clear">
                <fieldset>
                        
                            
                            
                            
                            
                            <div class="checklist-item">
                                <span class="fl-space">
                                    <input type="checkbox" name="memberOfGroup" value="test@abc.com"  class="checkbox" />
                                </span>
                                <label>
                                    <a href="/iredadmin-pro-ldap/profile/maillist/general/test@abc.com">Test</a> (test@abc.com)
                                </label>
                            </div>
                            <div class="clear"></div>
                        

                        
                </fieldset>
            </div></div></div><div class="col1-3 lastcol">
                <div class="mark_blue bt-space10">
                    <ul class="standard clean-padding bt-space10">
                        <li class="bt-space5"><a href="/iredadmin-pro-ldap/create/maillist/abc.com">Add mail list</a></li>
                    </ul>
                </div>
            </div>
        </div><div class="rule"></div>
        <div class="columns clear">
            <div class="col2-3">
            <div class="form-field clear">
            <h4 class="size-250 fl-space">Member of Mail Aliases</h4>
            <div class="checklist clear">
                <fieldset>
                        
                            
                            
                            
                            
                            
                            <div class="checklist-item">
                                <span class="fl-space">
                                    
                                        <input type="checkbox" name="memberOfAlias" value="testet@abc.com">
                                    
                                </span>
                                <label><a href="/iredadmin-pro-ldap/profile/alias/general/testet@abc.com">steset</a> (testet@abc.com)</label>
                            </div>
                            <div class="clear"></div>
                        
                </fieldset>
            </div></div></div>

            <div class="col1-3 lastcol">
                <div class="mark_blue bt-space10">
                    <ul class="standard clean-padding bt-space10">
                        <li class="bt-space5"><a href="/iredadmin-pro-ldap/create/alias/abc.com">Add mail alias</a></li>
                    </ul>
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
</div>
</div>
</div>
</form>


            </div>
        </div>
    </div>








 <%@include file="footer.jsp" %>













    
    <script type="text/javascript">
        function change_url(domain, baseurl) {
            if ( domain.options[domain.selectedIndex].value != 'none' ) {
                location.href = baseurl + domain.options[domain.selectedIndex].value;
            }
        }
    </script>
        
    <script type="text/javascript" src="/unifiedmail/iredjs/jquery-1.4.2.min.js"></script>

    
        <script type="text/javascript" src="/unifiedmail/iredjs/jquery.tooltip.js"></script>
    
        <script type="text/javascript" src="/unifiedmail/iredjs/jquery.idtabs.js"></script>
    
        <script type="text/javascript" src="/unifiedmail/iredjs/jquery.fancybox.js"></script>
    

    

    

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