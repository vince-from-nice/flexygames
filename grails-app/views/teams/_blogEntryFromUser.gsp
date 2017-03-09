<span style="font-size: x-large; font-weight: bold" ><g:link controller="teams" action="displayBlogEntry" id="${blogEntry.id}">${blogEntry.title}</g:link></span>
&nbsp;&nbsp;&nbsp;
<g:message code="team.show.blog.postedBy" />
<g:link controller="player" action="show" id="${blogEntry.user.id}">${blogEntry.user}</g:link>
<flexy:humanDate date="${blogEntry.date.time}" />
<hr style="margin-bottom: 0.7em;">
<g:if test="${blogEntry.body.length() > 10000}">
    <div>
        ${blogEntry.body.substring(0, 10000)}...
    </div>
    <g:link controller="teams" action="displayBlogEntry" id="${blogEntry.id}"><g:message code="clickForDetails" /></g:link>
</g:if>
<g:else>
    ${blogEntry.body}
</g:else>
<br>
<hr>
<span style="float: left">
    <g:link controller="teams" action="displayBlogEntry" id="${blogEntry.id}">
        <g:message code="team.show.blog.numberOfComments" args="[blogEntry.comments.size()]" />
    </g:link>
</span>
<g:if test="${blogEntry.lastUpdater}">
    <span style="font-style: italic; float: right">
        <g:message code="team.show.blog.updatedBy" />
        <g:link controller="player" action="show" id="${blogEntry.lastUpdater.id}">${blogEntry.lastUpdater}</g:link>
        <flexy:humanDate date="${blogEntry.lastUpdate.time}" />
    </span>
</g:if>
<br>
<g:if test="${teamIsManagedByCurrentUser}">
    <g:form controller="manager" method="post">
        <g:hiddenField name="id" value="${blogEntry.id}" />
        <g:hiddenField name="teamId" value="${teamInstance.id}" />
        <div class="buttons" style="text-align: right">
            <g:actionSubmit class="edit" action="editBlogEntry" value="${message(code:'update')}" />
            <g:actionSubmit class="delete" action="deleteBlogEntry" value="${message(code:'delete')}" onclick="return confirm('${message(code:'team.show.blog.areYouSureToDelete')}')" />
        </div>
    </g:form>
</g:if>
