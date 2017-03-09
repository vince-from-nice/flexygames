<%@ page import="java.text.DateFormat" %>

    <table style="border: 0px;">
        <tr>
            <td style="width: 50%;">
                <g:render template="blogEntryFromSession" bean="${nextTraining}" var="blogEntry" model="[competition: false]" />
            </td>
            <td style="width: 50%;">
                <g:render template="blogEntryFromSession" bean="${nextCompetition}" var="blogEntry" model="[competition: true]" />
            </td>
        </tr>
    </table>

    <g:each in="${stickyUserBlogEntries}" var="blogEntry" >
        <div class="userBlogEntrySticky">
            <g:render template="blogEntryFromUser" bean="${blogEntry}" var="blogEntry" />
        </div>
    </g:each>

    <g:each in="${normalUserBlogEntries}" var="blogEntry" >
        <div class="userBlogEntry">
            <g:render template="blogEntryFromUser" bean="${blogEntry}" var="blogEntry" />
        </div>
    </g:each>

    <div class="pagination">
        <g:paginate id="${params.teamId}" total="${normalBlogEntriesTotal}" />
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