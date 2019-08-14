<!DOCTYPE html>
<html>
    <head>
        <g:render template="/common/layout" />
        <g:set var="entityName" value="${message(code: 'sessionWatcher.label', default: 'SessionWatcher')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#list-sessionWatcher" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="list-sessionWatcher" class="content scaffold-list" role="main">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <f:table collection="${sessionWatcherList}" />

            <div class="pagination">
                <g:paginate total="${sessionWatcherCount ?: 0}" />
            </div>
        </div>
    </body>
</html>