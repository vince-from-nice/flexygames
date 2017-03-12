<%@ page import="java.text.DateFormat" %>
    <g:if test="${allBlogEntries.size() > 0}">
        <g:each in="${stickyUserBlogEntries}" var="blogEntry" >
            <div class="userBlogEntry">
                <g:render template="blogEntryFromUser" bean="${blogEntry}" var="blogEntry" />
            </div>
        </g:each>
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
                        <g:render template="blogEntryFromSession" bean="${blogEntry}" var="blogEntry" />
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
                        <g:render template="blogEntryFromSession" bean="${blogEntry}" var="blogEntry" />
                    </div>
                </g:else>
            </g:if>
            <g:else>
                <div class="userBlogEntry">
                    <g:render template="blogEntryFromUser" bean="${blogEntry}" var="blogEntry" />
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
        <g:form controller="manager" action="editBlogEntry" method="post" style="text-align: center">
            <g:hiddenField name="teamId" value="${teamInstance.id}" />
            <div class="buttons" style="text-align: center">
                <g:actionSubmit class="create" action="editBlogEntry" value="${message(code:'team.show.blog.create')}" />
            </div>
        </g:form>
    </g:if>