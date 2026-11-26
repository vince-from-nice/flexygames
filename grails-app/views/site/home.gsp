<html>
<head>
    <meta name="layout" content="modern" />
</head>
<body onload="if (detectBadBrowser()) alert('${message(code: "home.badBrowser")}');">
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <g:if test="${flash.error}">
        <div class="errors">${flash.error}</div>
    </g:if>

    <section class="hero">
        <div>
            <h1><g:message code="home.title" /></h1>
            <p class="lead"><g:message code="home.whatisit.text1" /></p>
            <p><g:message code="home.whatisit.text2" /></p>
            <shiro:notUser>
                <div class="hero-actions">
                    <g:link controller="player" action="register" class="btn btn-primary"><g:message code="logbox.newAccount" /></g:link>
                    <g:link controller="auth" action="login" class="btn btn-ghost"><g:message code="logbox.login" /></g:link>
                </div>
                <p><g:message code="home.whatisit.text3" /></p>
            </shiro:notUser>
            <shiro:user>
                <div class="hero-actions">
                    <g:link controller="myself" action="mySessions" class="btn btn-primary"><g:message code="logbox.mySessions" /></g:link>
                    <g:link controller="sessions" action="list" class="btn btn-ghost"><g:message code="home.sessions.all" /></g:link>
                </div>
            </shiro:user>
        </div>
        <aside class="hero-card">
            <h2><g:message code="home.ownTeam.title" /></h2>
            <p><g:message code="home.whatisit.text4" /></p>
        </aside>
    </section>

    <div class="home-grid">
        <section class="card">
            <div class="section-title">
                <h2><g:message code="home.sessions.title.last" /></h2>
                <g:link controller="sessions" action="list"><g:message code="home.sessions.all" /> &rarr;</g:link>
            </div>
            <p class="muted"><g:message code="home.session.closedXDays" args="[2, 6]" /></p>
            <g:if test="${sessions}">
                <div class="table-wrap">
                <table class="flexyTab">
                    <tr>
                        <th style="text-align: center;"><g:message code="teams" /></th>
                        <th><g:message code="group" /></th>
                        <th><g:message code="date" /></th>
                        <th><g:message code="players" /></th>
                        <th style="text-align: center;"><g:message code="myStatus" /></th>
                        <th><g:message code="lastComment" /></th>
                    </tr>
                    <g:render template="/common/sessionMediumList" model="['sessionInstanceList': sessions]" />
                </table>
                </div>
            </g:if>
            <g:else>
                <p><g:message code="home.sessions.none" /></p>
            </g:else>
        </section>

        <section class="card">
            <h2><g:message code="home.users.title" /></h2>
            <ul class="user-list">
                <g:each in="${users}" var="playerInstance">
                    <li>
                        <span class="avatar"><g:render template="/common/avatar" model="[player: playerInstance]" /></span>
                        <span class="who">
                            <g:link controller="player" action="show" id="${playerInstance.id}" class="name">${fieldValue(bean: playerInstance, field: "username")}</g:link>
                            <span class="teams">
                                <g:each in="${playerInstance.allSubscribedTeams}" var="t" status="i">${i > 0 ? ', ' : ''}<g:link controller="teams" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link></g:each>
                            </span>
                        </span>
                        <span class="when"><flexy:humanDate date="${playerInstance.registrationDate.time}" /></span>
                    </li>
                </g:each>
            </ul>
        </section>
    </div>
</body>
</html>
