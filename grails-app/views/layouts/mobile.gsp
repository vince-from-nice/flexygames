<!doctype html>

<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->

<head>
    <title><g:layoutTitle default="FlexyGames"/></title>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=0.40">

    <!--  Avoid HTTP caching from clients (and proxies) -->
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
    <meta http-equiv="Pragma" content="no-cache" />
    <meta http-equiv="Expires" content="0" />

    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'flexygames-icon-32x32.png')}" type="image/png">
    <link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'flexygames-icon-32x32.png')}">
    <link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'flexygames-icon-114x114.png')}">

    <link rel="stylesheet" href="${resource(dir: 'css', file: 'main-20160208.css')}">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'mobile-20160208.css')}">
    <link rel="stylesheet" href="${resource(dir:'css',file:'flexygames-v6.css')}" />
    <link rel="stylesheet" href="https://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
    <link rel="stylesheet" href="${resource(dir:'css',file:'mobilemenu.css')}" />

    <script src="https://code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="https://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
    <g:javascript library="mobilemenu"/>
    <g:javascript library="application"/>
    <!--g:javascript library="flexygames" /-->
    <script type="text/javascript" src="${resource(dir:'js',file:'flexygames-20160508.js')}"></script>

    <g:layoutHead/>
    <r:layoutResources />
</head>

<body onload="${pageProperty(name:'body.onload')}; ">
<div data-role="page">
    <div data-role="header" style="background-color: white">
        <table style="width: 100%; margin: 0px; padding: 0px">
            <tr>
                <td style="text-align: left; vertical-align: top">
                    <a href="${createLink(controller:'site', action:'home')}">
                        <img src="${resource(dir:'images',file:'flexygames-logo-274x80.png')}" alt="Grails" border="0" />
                    </a>
                </td>
                <td style="text-align: center; vertical-align: top">
                    <div id='cssmenu'>
                        <ul>
                            <li class='has-sub'>
                                <a href='#' style="font-size: x-large;">&nbsp;<br><g:message code="layout.mainMenu" /><br>&nbsp;</a>
                                <ul>
                                    <li><g:link controller="site" action="home"><g:message code="mainMenu.home" /></g:link></li>
                                    <li><g:link controller="teams" action="list"><g:message code="mainMenu.teams" /></g:link></li>
                                    <li><g:link controller="sessions" action="list"><g:message code="mainMenu.sessions" /></g:link></li>
                                    <li><g:link controller="player" action="list"><g:message code="mainMenu.players" /></g:link></li>
                                    <li><g:link controller="playgrounds" action="list"><g:message code="mainMenu.playgrounds" /></g:link></li>
                                    <li><g:link controller="site" action="stats"><g:message code="mainMenu.stats" /></g:link></li>
                                    <li><g:link controller="site" action="tutorial"><g:message code="mainMenu.tutorial" /></g:link></li>
                                    <li><g:link controller="site" action="about"><g:message code="mainMenu.about" /></g:link></li>
                                    <li><g:link controller="site" action="contact"><g:message code="mainMenu.contact" /></g:link></li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </td>
                <td style="text-align: right; vertical-align: top; ">
                    <shiro:user>
                        <div id='cssmenu'>
                        <ul>
                            <li class='has-sub'>
                                <a href='#' style="font-size: x-large">&nbsp;<br><g:message code="logbox.welcome" /> <shiro:principal /><br>&nbsp;</a>
                        <ul>
                            <li class="">
                                <g:link controller="myself" action="mySessions">
                                    <g:message code="logbox.mySessions" />
                                </g:link>
                            </li>
                            <li class="">
                                <g:link controller="myself" action="myStats">
                                    <g:message code="logbox.myStats" />
                                </g:link>
                            </li>
                            <li class="">
                                <g:link controller="myself" action="myAccount">
                                    <g:message code="logbox.myAccount" />
                                </g:link>
                            </li>
                            <li class="">
                                <g:link controller="auth" action="signOut">
                                    <g:message code="logbox.logout" />
                                </g:link>
                            </li>
                        </ul>
                        </li>
                    </ul>
                    </shiro:user>
                    <shiro:notUser>
                        <div id='cssmenu'>
                        <ul>
                            <li class='has-sub' style="font-size: x-large"><a href='#'>&nbsp;<br><g:message code="logbox.title" /><br>&nbsp;</a>
                        <ul>
                            <li class="">
                                <g:link controller="auth" action="login">
                                    <g:message code="login" />
                                </g:link>
                            </li>
                            <li class="">
                                <g:link controller="player" action="register" style="font-size: 12px">
                                    <g:message code="logbox.newAccount" />
                                </g:link>
                            </li>
                            <li class="">
                                <g:link controller="player" action="remindPassword" style="font-size: 12px">
                                    <g:message code="logbox.remindPassword" />
                                </g:link>
                            </li>
                        </ul>
                        </li>
                    </ul>
                    </shiro:notUser>
                </td>
            </tr>
        </table>
    </div>
    <div data-role="content">
        <g:layoutBody />
    </div>
    <div data-role="footer">
        <g:render template="/layouts/footer" />
    </div>
</div>
</body>

</html>
