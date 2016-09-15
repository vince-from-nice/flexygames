<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <g:render template="/common/layout" />
    <ckeditor:resources/>
</head>
<body>
    <h1>
        <g:message code="management.blogEntry.title" />
        <g:link controller="teams" action="show" id="${team.id}">${team}</g:link>
    </h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <g:form controller="manager" method="post" style="text-align: left">
        <g:hiddenField name="id" value="${blogEntry?.id}" />
        <g:hiddenField name="teamId" value="${team.id}" />
        <g:message code="title" /> : <g:textField name="title" size="64" value="${blogEntry?.title}" />
        <br>
        <br>
        <ckeditor:editor name="body" height="400px" width="90%">${blogEntry?.body}</ckeditor:editor>
        <br>
        <g:checkBox name="sticky" value="${blogEntry?.sticky}" />
        <label><g:message code="management.blogEntry.sticky" /></label>
        <br>
        <br>
        <g:if test="${blogEntry}" >
            <div class="buttons">
                <g:actionSubmit class="create" action="saveBlogEntry" value="${message(code:'update')}" />
            </div>
        </g:if>
        <g:else>
            <g:checkBox name="mailAllMembers" checked="false" />
            <label><g:message code="management.blogEntry.mailAllMembers" /></label>
            <br>
            <br>
            <div class="buttons">
                <g:actionSubmit class="create" action="saveBlogEntry" value="${message(code:'create')}" />
            </div>
        </g:else>
    </g:form>
</body>
</html>