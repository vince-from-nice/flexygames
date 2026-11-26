<%@ page import="flexygames.Participation" %>
<g:set var="legendGroups" value="${[
        [title: 'Players', statuses: [Participation.Status.REQUESTED, Participation.Status.AVAILABLE, Participation.Status.DECLINED]],
        [title: 'Managing', statuses: [Participation.Status.APPROVED, Participation.Status.APPROVED_EXTRA, Participation.Status.WAITING_LIST, Participation.Status.REMOVED]],
        [title: 'Reporting', statuses: [Participation.Status.DONE_GOOD, Participation.Status.DONE_LATE, Participation.Status.DONE_BAD, Participation.Status.UNDONE]]
]}" />
<div class="legend">
    <g:each in="${legendGroups}" var="legendGroup">
        <div class="legend-group">
            <h4>${legendGroup.title}</h4>
            <ul>
                <g:each in="${legendGroup.statuses}" var="status">
                    <li>
                        <span class="legend-dot" style="background-color: ${status.color};"></span>
                        <a class="tooltip"><g:message code="participation.status.${status}" /><span><g:message code="participation.status.${status}.infos" /></span></a>
                    </li>
                </g:each>
            </ul>
        </div>
    </g:each>
</div>
