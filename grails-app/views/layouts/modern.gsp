<!doctype html>
<html lang="${org.springframework.context.i18n.LocaleContextHolder.locale.language}">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title><g:layoutTitle default="FlexyGames"/></title>

    <link rel="icon" href="${resource(dir: 'images', file: 'flexygames-icon-32x32.png')}" type="image/png" />
    <link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'flexygames-icon-114x114.png')}" />

    <script src="${resource(dir: 'js', file: 'theme.js')}"></script>
    <script src="${resource(dir: 'js', file: 'forms.js')}" defer></script>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'flexygames-components.css')}" />
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'flexygames-modern.css')}" />

    <script src="${resource(dir: 'js', file: 'application.js')}"></script>
    <script src="${resource(dir: 'js', file: 'flexygames-20160508.js')}"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

    <g:set var="now" value="${System.currentTimeMillis()}" />
    <g:layoutHead/>
</head>

<body onload="${pageProperty(name: 'body.onload')}">
<header class="site-header">
    <div class="container header-bar">
        <a class="brand" href="${createLink(controller: 'site', action: 'home')}">
            <img src="${resource(dir: 'images', file: 'flexygames-logo-274x80.png')}" alt="FlexyGames" width="137" height="40" />
        </a>

        <input type="checkbox" id="nav-toggle" class="nav-toggle" />
        <label for="nav-toggle" class="nav-toggle-label" aria-label="${message(code: 'layout.mainMenu')}">
            <span></span><span></span><span></span>
        </label>

        <nav id="mainNav" class="main-nav" aria-label="${message(code: 'layout.mainMenu')}">
            <g:link controller="site" action="home" class="${controllerName == 'site' && actionName in ['home', null] ? 'active' : ''}"><g:message code="mainMenu.home" /></g:link>
            <g:link controller="teams" action="list" class="${controllerName == 'teams' ? 'active' : ''}"><g:message code="mainMenu.teams" /></g:link>
            <g:link controller="sessions" action="list" class="${controllerName == 'sessions' ? 'active' : ''}"><g:message code="mainMenu.sessions" /></g:link>
            <g:link controller="player" action="list" class="${controllerName == 'player' ? 'active' : ''}"><g:message code="mainMenu.players" /></g:link>
            <g:link controller="playgrounds" action="list" class="${controllerName == 'playgrounds' ? 'active' : ''}"><g:message code="mainMenu.playgrounds" /></g:link>
            <g:link controller="site" action="stats" class="${controllerName == 'site' && actionName == 'stats' ? 'active' : ''}"><g:message code="mainMenu.stats" /></g:link>
            <g:link controller="site" action="tutorial" class="${controllerName == 'site' && actionName == 'tutorial' ? 'active' : ''}"><g:message code="mainMenu.tutorial" /></g:link>
            <g:link controller="site" action="about" class="${controllerName == 'site' && actionName == 'about' ? 'active' : ''}"><g:message code="mainMenu.about" /></g:link>
            <g:link controller="site" action="contact" class="${controllerName == 'site' && actionName == 'contact' ? 'active' : ''}"><g:message code="mainMenu.contact" /></g:link>
        </nav>

        <div class="account">
            <button type="button" id="themeToggle" class="theme-toggle"
                    data-label-auto="${message(code: 'theme.auto')}" data-label-light="${message(code: 'theme.light')}" data-label-dark="${message(code: 'theme.dark')}"
                    aria-label="${message(code: 'theme.auto')}" title="${message(code: 'theme.auto')}">
                <svg class="theme-icon theme-icon-auto" viewBox="0 0 24 24" aria-hidden="true"><circle cx="12" cy="12" r="8.5" fill="none" stroke="currentColor" stroke-width="2"/><path d="M12 3.5a8.5 8.5 0 0 1 0 17z" fill="currentColor"/></svg>
                <svg class="theme-icon theme-icon-light" viewBox="0 0 24 24" aria-hidden="true"><circle cx="12" cy="12" r="4.5" fill="currentColor"/><g stroke="currentColor" stroke-width="2" stroke-linecap="round"><path d="M12 2v2.5M12 19.5V22M2 12h2.5M19.5 12H22M4.9 4.9l1.8 1.8M17.3 17.3l1.8 1.8M4.9 19.1l1.8-1.8M17.3 6.7l1.8-1.8"/></g></svg>
                <svg class="theme-icon theme-icon-dark" viewBox="0 0 24 24" aria-hidden="true"><path d="M20.5 14.5A8.5 8.5 0 0 1 9.5 3.5a8.5 8.5 0 1 0 11 11z" fill="currentColor"/></svg>
            </button>
            <shiro:user>
                <details class="dropdown">
                    <summary><span class="account-greeting"><g:message code="logbox.welcome" /></span> <strong><shiro:principal /></strong></summary>
                    <ul class="dropdown-menu">
                        <li><g:link controller="myself" action="mySessions"><g:message code="logbox.mySessions" /></g:link></li>
                        <li><g:link controller="myself" action="myStats"><g:message code="logbox.myStats" /></g:link></li>
                        <li><g:link controller="myself" action="myAccount"><g:message code="logbox.myAccount" /></g:link></li>
                        <shiro:hasRole name="Administrator">
                            <li><g:link controller="admin" action="index"><g:message code="logbox.adminLink" /></g:link></li>
                        </shiro:hasRole>
                        <li><g:link controller="auth" action="signOut"><g:message code="logbox.logout" /></g:link></li>
                    </ul>
                </details>
            </shiro:user>
            <shiro:notUser>
                <g:link controller="auth" action="login" class="btn btn-ghost"><g:message code="logbox.login" /></g:link>
                <g:link controller="player" action="register" class="btn btn-primary account-register"><g:message code="logbox.newAccount" /></g:link>
            </shiro:notUser>
        </div>
    </div>
</header>

<main id="mainBody" class="container site-main">
    <g:layoutBody />
</main>

<footer class="site-footer">
    <div class="container footer-grid">
        <section>
            <h2 class="footer-title"><g:message code="layout.whoIsOnline" /></h2>
            <g:set var="onlineUsers" value="${grails.web.context.ServletContextHolder.getServletContext().onlineUsers}" />
            <g:if test="${onlineUsers && !onlineUsers.isEmpty()}">
                <p>
                    <g:if test="${onlineUsers.size() < 2}">
                        <g:message code="layout.whoIsOnline.text.onePlayer" args="[onlineUsers.size()]" />
                    </g:if>
                    <g:else>
                        <g:message code="layout.whoIsOnline.text.multiPlayers" args="[onlineUsers.size()]" />
                    </g:else>
                </p>
                <ul class="inline-list">
                    <g:each in="${onlineUsers}" var="user">
                        <g:if test="${user != null}">
                            <li><g:link controller="player" action="show" id="${user.id}">${user}</g:link></li>
                        </g:if>
                        <g:else>
                            <li>${user}</li>
                        </g:else>
                    </g:each>
                </ul>
            </g:if>
            <g:else>
                <p><g:message code="layout.whoIsOnline.text.noPlayer" /></p>
            </g:else>
        </section>

        <shiro:hasRole name="Administrator">
            <section>
                <h2 class="footer-title"><g:message code="layout.adminMenu" /></h2>
                <ul class="inline-list">
                    <g:each var="c" in="${grailsApplication.controllerClasses.sort { it.logicalPropertyName }}">
                        <g:if test="${!(['assets', 'auth', 'dbdoc', 'site', 'sessions', 'stats', 'player', 'teams', 'playgrounds', 'manager', 'myself',
                                         'fileUploader', 'fileUpload', 'download', 'openFileManagerConnector'].contains(c.logicalPropertyName))}">
                            <li><g:link controller="${c.logicalPropertyName}">${c.name}</g:link></li>
                        </g:if>
                    </g:each>
                </ul>
            </section>
        </shiro:hasRole>

        <section class="powered">
            <a href="https://grails.apache.org"><img src="${resource(dir: 'images', file: 'powered/powered-by-grails.gif')}" alt="Grails" /></a>
            <a href="https://groovy-lang.org"><img src="${resource(dir: 'images', file: 'powered/powered-by-groovy.jpg')}" alt="Groovy" /></a>
            <a href="https://tomcat.apache.org"><img src="${resource(dir: 'images', file: 'powered/powered-by-tomcat.jpg')}" alt="Tomcat" /></a>
            <a href="https://www.debian.org"><img src="${resource(dir: 'images', file: 'powered/powered-by-debian.jpg')}" alt="Debian" /></a>
        </section>
    </div>

    <shiro:hasRole name="Administrator">
        <g:set var="rt" value="${java.lang.Runtime.getRuntime()}" />
        <p class="container page-stats">
            <g:if test="${timeBeforeController && timeAfterController}">
                Rendered in ${now - timeBeforeController} ms (controller: ${timeAfterController - timeBeforeController} ms,
                view: ${now - timeAfterController} ms) ·
            </g:if>
            Memory used ${(int) ((rt.totalMemory() - rt.freeMemory()) / 1024)} kB of ${(int) (rt.maxMemory() / 1024)} kB
        </p>
    </shiro:hasRole>
</footer>

<div id="spinner" class="spinner" style="display: none;"><g:message code="spinner.alt" default="Loading&hellip;" /></div>
</body>
</html>
