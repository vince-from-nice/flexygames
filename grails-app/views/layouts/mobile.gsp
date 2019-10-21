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
    <!--meta name="viewport" content="width=device-width, initial-scale=0.40"-->
    <meta name="viewport" content="width=device-width, initial-scale=0.5, maximum-scale=1">

    <!--  Avoid HTTP caching from clients (and proxies) -->
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
    <meta http-equiv="Pragma" content="no-cache" />
    <meta http-equiv="Expires" content="0" />

    <asset:link rel="shortcut icon" href="flexygames-icon-32x32.png" type="image/png"/>
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

    <g:set var="now" value="${System.currentTimeMillis()}" />
</head>

<body >
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
%{--                    <a class="to_nav" href="#primary_nav" onclick="toggleDisplay('primary_nav');"><g:message code="layout.mainMenu" /></a>--}%
%{--                    <br>--}%
%{--                    <nav id="primary_nav" style="display: none; ">--}%
%{--                        <ul>--}%
%{--                            <li><g:link controller="teams" action="list"><g:message code="mainMenu.teams" /></g:link></li>--}%
%{--                            <li><g:link controller="sessions" action="list"><g:message code="mainMenu.sessions" /></g:link></li>--}%
%{--                            <li><g:link controller="player" action="list"><g:message code="mainMenu.players" /></g:link></li>--}%
%{--                            <li><g:link controller="playgrounds" action="list"><g:message code="mainMenu.playgrounds" /></g:link></li>--}%
%{--                            <li><g:link controller="site" action="stats"><g:message code="mainMenu.stats" /></g:link></li>--}%
%{--                            <li><g:link controller="site" action="tutorial"><g:message code="mainMenu.tutorial" /></g:link></li>--}%
%{--                            <li><g:link controller="site" action="about"><g:message code="mainMenu.about" /></g:link></li>--}%
%{--                            <li><g:link controller="site" action="contact"><g:message code="mainMenu.contact" /></g:link></li>--}%
%{--                        </ul>--}%
%{--                    </nav>--}%
%{--                    <script>--}%
%{--                        document.getElementById('primary_nav').style.display = 'none';--}%
%{--                        alert("gluar0: " + document.getElementById('primary_nav').style.display);--}%
%{--                    </script>--}%
                </td>
                <td style="text-align: right; vertical-align: top; ">
                    <shiro:user>
%{--                        <a class="to_nav" href="#secondary_nav" onclick="toggleDisplay('secondary_nav');"><g:message code="logbox.welcome" /></a>--}%
%{--                        <br>--}%
%{--                        <nav id="secondary_nav" style="display: none; ">--}%
%{--                            <ul>--}%
%{--                                <li class="">--}%
%{--                                    <g:link controller="myself" action="mySessions">--}%
%{--                                        <g:message code="logbox.mySessions" />--}%
%{--                                    </g:link>--}%
%{--                                </li>--}%
%{--                                <li class="">--}%
%{--                                    <g:link controller="myself" action="myStats">--}%
%{--                                        <g:message code="logbox.myStats" />--}%
%{--                                    </g:link>--}%
%{--                                </li>--}%
%{--                                <li class="">--}%
%{--                                    <g:link controller="myself" action="myAccount">--}%
%{--                                        <g:message code="logbox.myAccount" />--}%
%{--                                    </g:link>--}%
%{--                                </li>--}%
%{--                                <li class="">--}%
%{--                                    <g:link controller="auth" action="signOut">--}%
%{--                                        <g:message code="logbox.logout" />--}%
%{--                                    </g:link>--}%
%{--                                </li>--}%
%{--                            </ul>--}%
%{--                        </nav>--}%
%{--                            <ul style="list-style-type: none">--}%
%{--                                <li>--}%
%{--                                </li>--}%
%{--                            </ul>--}%
                    <div style="font-size: large">
                        <g:link controller="myself" action="mySessions">
                            <g:message code="logbox.mySessions" />
                        </g:link>
                        |
                        <g:link controller="myself" action="myStats">
                            <g:message code="logbox.myStats" />
                         </g:link>
                        |
                        <g:link controller="myself" action="myAccount">
                            <g:message code="logbox.myAccount" />
                        </g:link>
                        <br><br>
                        <g:link controller="auth" action="signOut">
                            <g:message code="logbox.logout" />
                        </g:link>
                    </div>
                </shiro:user>
                <shiro:notUser>
                        %{--                        <a class="to_nav" href="#secondary_nav" onclick="toggleDisplay('secondary_nav');"><g:message code="logbox.title" /></a>--}%
%{--                        <br>--}%
%{--                        <nav id="secondary_nav" style="display: none; ">--}%
%{--                            <ul>--}%
%{--                                <li class="">--}%
%{--                                    <g:link controller="auth" action="login">--}%
%{--                                        <g:message code="login" />--}%
%{--                                    </g:link>--}%
%{--                                </li>--}%
%{--                                <li class="">--}%
%{--                                    <g:link controller="player" action="register" style="font-size: 12px">--}%
%{--                                        <g:message code="logbox.newAccount" />--}%
%{--                                    </g:link>--}%
%{--                                </li>--}%
%{--                                <li class="">--}%
%{--                                    <g:link controller="player" action="remindPassword" style="font-size: 12px">--}%
%{--                                        <g:message code="logbox.remindPassword" />--}%
%{--                                    </g:link>--}%
%{--                                </li>--}%
%{--                            </ul>--}%
%{--                        </nav>--}%
                        <div style="font-size: x-large">
                            <g:link controller="auth" action="login">
                                <g:message code="login" />
                            </g:link>
                        </div>
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
