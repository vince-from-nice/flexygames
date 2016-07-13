<%@ page import="java.text.DateFormat" %>
    <g:if test="${allBlogEntries.size() > 0}">
        <g:each in="${allBlogEntries}" var="blogEntry" >
            <g:if test="${blogEntry.session}">
                <g:if test="${blogEntry.session.group.competition}">
                    <div class="competitionBlogEntry">
                        <g:if test="${blogEntry.session.name}">
                            <g:link controller="sessions" action="show" id="${blogEntry.session.id}" ><b>${blogEntry.session.name}</b></g:link>
                            <g:message code="on" /> <g:formatDate date="${blogEntry.date}" format="EEEEEEE dd MMMM yyyy (HH:mm)" />
                        </g:if>
                        <g:else>
                            <g:link controller="sessions" action="show" id="${blogEntry.session.id}" ><b><g:message code="competition" />
                            <g:message code="on" /> <g:formatDate date="${blogEntry.date}" format="EEEEEEE dd MMMM yyyy (HH:mm)" /></b></g:link>
                        </g:else>
                        <hr>
                        <g:render template="showSessionBlogEntry" bean="${blogEntry}" var="blogEntry" />
                    </div>
                </g:if>
                <g:else>
                    <div class="trainingBlogEntry">
                        <g:if test="${blogEntry.session.name}">
                            <g:link controller="sessions" action="show" id="${blogEntry.session.id}" ><b>${blogEntry.title}</b></g:link>
                            <g:message code="on" /> <g:formatDate date="${blogEntry.date}" format="EEEEEEE dd MMMM yyyy (HH:mm)" />
                        </g:if>
                        <g:else>
                            <g:link controller="sessions" action="show" id="${blogEntry.session.id}" ><b><g:message code="training" />
                            <g:message code="on" /> <g:formatDate date="${blogEntry.date}" format="EEEEEEE dd MMMM yyyy (HH:mm)" /></b></g:link>
                        </g:else>
                        <hr>
                        <g:render template="showSessionBlogEntry" bean="${blogEntry}" var="blogEntry" />
                    </div>
                </g:else>

            </g:if>
            <g:else>
                <div class="userBlogEntry">
                    <span style="font-size: x-large; font-weight: bold" ><g:link controller="teams" action="displayBlogEntry" id="${blogEntry.id}">${blogEntry.title}</g:link></span>
                    <g:message code="team.show.blog.postedBy" />
                    <g:link controller="player" action="show" id="${blogEntry.user.id}">${blogEntry.user}</g:link>
                    <flexy:humanDate date="${blogEntry.date.time}" />
                    <hr>
                    <g:if test="${blogEntry.body.length() > 10000}">
                        <div>
                            ${blogEntry.body.substring(0, 10000)}...
                        </div>
                        <g:link controller="teams" action="displayBlogEntry" id="${blogEntry.id}"><g:message code="clickForDetails" /></g:link>
                    </g:if>
                    <g:else>
                        ${blogEntry.body}
                    </g:else>
                    <g:if test="${blogEntry.lastUpdater}">
                        <hr>
                        <div style="font-style: italic">
                            <g:message code="team.show.blog.updatedBy" />
                            <g:link controller="player" action="show" id="${blogEntry.lastUpdater.id}">${blogEntry.lastUpdater}</g:link>
                            <flexy:humanDate date="${blogEntry.lastUpdate.time}" />
                        </div>
                    </g:if>
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
                </div>
            </g:else>
        </g:each>
    </g:if>
    <g:else>
        <g:message code="team.show.blog.nothing"/>
    </g:else>
    <div class="pagination">
        <g:paginate id="${params.teamId}" total="${blogEntriesTotal}" />
    </div>
    <br>
    <g:if test="${teamIsManagedByCurrentUser}">
        <g:form controller="manager" method="post" style="text-align: center">
            <g:hiddenField name="teamId" value="${teamInstance.id}" />
            <div class="buttons" style="text-align: center">
                <g:actionSubmit class="create" action="editBlogEntry" value="${message(code:'team.show.blog.create')}" onclick="toggleDisplay('blogEntryCreation'); return false;" />
            </div>
        </g:form>
    </g:if>