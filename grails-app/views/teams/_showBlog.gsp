    <g:if test="${allBlogEntries.size() > 0}">
        <g:each in="${allBlogEntries}" var="blogEntry" >
            <g:if test="blogEntry.session">
                <g:if test="${blogEntry.session.group.competition}">
                    <div class="competitionBlogEntry">
                        <g:link controller="sessions" action="show" id="${blogEntry.session.id}" ><b>${blogEntry.session.name}</b></g:link>
                        <g:message code="on" /> <g:formatDate date="${blogEntry.date}" format="EEEEEEE dd MMMM yyyy (HH:mm)" />
                        <hr>
                        <g:render template="showBlogCommon" bean="${blogEntry}" var="blogEntry" />
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
                        <g:render template="showBlogCommon" bean="${blogEntry}" var="blogEntry" />
                    </div>
                </g:else>

            </g:if>
            <g:else>
                <div class="userBlogEntry">
                    <b>${blogEntry.title}</b> posted by ${blogEntry.user} on <g:formatDate date="${blogEntry.date}" format="EEEEEEE dd MMMM (HH:mm)" />:
                    <br />
                    ${blogEntry.body}
                </div>
            </g:else>

        </g:each>
    </g:if>
    <g:else>
        <g:message code="team.show.blogs.nothing"/>
    </g:else>
    <div class="pagination">
        <g:paginate id="${params.teamId}" total="${blogEntriesTotal}" />
    </div>