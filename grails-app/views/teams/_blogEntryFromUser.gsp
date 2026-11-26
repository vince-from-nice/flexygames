<header class="blog-entry-head">
    <h3><g:link controller="teams" action="displayBlogEntry" id="${blogEntry.id}">${blogEntry.title?.encodeAsHTML()}</g:link></h3>
    <p class="small muted">
        <g:message code="team.show.blog.postedBy" />
        <g:link controller="player" action="show" id="${blogEntry.user.id}">${blogEntry.user}</g:link>
        <flexy:humanDate date="${blogEntry.date.time}" />
    </p>
</header>
<div class="blog-entry-body">
    <g:if test="${blogEntry.body.length() > 10000}">
        ${blogEntry.body.substring(0, 10000)}...
        <p><g:link controller="teams" action="displayBlogEntry" id="${blogEntry.id}"><g:message code="clickForDetails" /></g:link></p>
    </g:if>
    <g:else>
        ${blogEntry.body}
    </g:else>
</div>
<footer class="blog-entry-foot small">
    <g:link controller="teams" action="displayBlogEntry" id="${blogEntry.id}">
        <g:message code="team.show.blog.numberOfComments" args="[blogEntry.comments.size()]" />
    </g:link>
    <g:if test="${blogEntry.lastUpdater}">
        <span class="muted">
            <g:message code="team.show.blog.updatedBy" />
            <g:link controller="player" action="show" id="${blogEntry.lastUpdater.id}">${blogEntry.lastUpdater}</g:link>
            <flexy:humanDate date="${blogEntry.lastUpdate.time}" />
        </span>
    </g:if>
</footer>
<g:if test="${teamIsManagedByCurrentUser}">
    <g:form controller="manager" method="post" class="buttons">
        <g:hiddenField name="id" value="${blogEntry.id}" />
        <g:hiddenField name="teamId" value="${teamInstance.id}" />
        <g:actionSubmit class="edit" action="editBlogEntry" value="${message(code:'update')}" />
        <g:actionSubmit class="delete" action="deleteBlogEntry" value="${message(code:'delete')}" onclick="return confirm('${message(code:'team.show.blog.areYouSureToDelete')}')" />
    </g:form>
</g:if>
