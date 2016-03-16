<div class="sessionZone">
    <div class="sessionZoneHeader" onclick="toggleDisplay('infosSummaryZone'); toggleDisplay('infosDetailedZone'); return false">
        <h2 style="vertical-align: top; display: inline;">
            <g:message code="informations" />
        </h2>
        <span style="float:right; font-size: small;"><g:message code="clickForDetails" /></span>
    </div>
    <div class="sessionZoneContent">
        <g:set var="defaultDisplayForSummaryZone" value="none" />
        <g:set var="defaultDisplayForDetailedZone" value="block" />
        <div id="infosSummaryZone" style="display: ${defaultDisplayForSummaryZone};">
        </div>
        <div id="infosDetailedZone" style="display: ${defaultDisplayForDetailedZone};">
            <g:message code="session.show.date"/>:
            <b><g:formatDate date="${sessionInstance?.date}" format="EEEE dd MMMM yyyy"/></b>
            <br>
            <ul>
                <li><g:message code="session.show.date.locking" />: <b><g:formatDate date="${sessionInstance.lockingDate}" format="HH:mm"/></b></li>
                <li><g:message code="session.show.date.rdv" />: <b><g:formatDate date="${sessionInstance.rdvDate}" format="HH:mm"/></b></li>
                <li><g:message code="session.show.date.start" />: <b><g:formatDate date="${sessionInstance?.date}" format="HH:mm"/></b></li>
                <li><g:message code="session.show.date.end" />: <b><g:formatDate date="${sessionInstance.endDate}" format="HH:mm"/></b></li>
            </ul>
            <g:message code="playground" default="Playground" />:
            <g:link controller="playground" action="show" id="${sessionInstance?.playground?.id}" onclick="toggleDisplay('playgroundDiv'); return false" >
                ${sessionInstance?.playground?.encodeAsHTML()}
            </g:link>
            <div id="playgroundDiv" class="block" style="display: none;">
                ${sessionInstance?.playground?.postalAddress}
                <g:if test="${sessionInstance?.playground?.gmapsUrl}">
                    <br>
                    <g:message code="phoneNumber" /> : ${sessionInstance?.playground?.phoneNumber}
                </g:if>
                <br>
                <g:link controller="playgrounds" action="show" id="${sessionInstance?.playground?.id}"><g:message code="session.show.viewPlayground" /></g:link>
            </div>
            <br>
            <g:set var="defaultFirstTeam" value="${sessionInstance.group.defaultTeams?.first()}" scope="request" />
            <g:message code="session.show.relatedTeams" />:
            <g:link controller="teams" action="show" id="${defaultFirstTeam.id}">
                ${defaultFirstTeam}
            </g:link>
            <br>
            <g:message code="group" default="Group" />:
            <g:link controller="sessions" action="list" params="${['filteredSessionGroup':sessionInstance.group.id]}" >
                ${sessionInstance?.group?.encodeAsHTML()}
            </g:link>
            <g:if test="${sessionInstance.description}">
                <g:message code="session.description" default="Description" />
                ${fieldValue(bean: sessionInstance, field: "description")}
            </g:if>
            <br>
        </div>
    </div>
</div>


