
<%@ page import="flexygames.Session" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="desktop">
		<g:set var="entityName" value="${message(code: 'session.label', default: 'Session')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-session" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-session" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list session">
			
				<g:if test="${sessionInstance?.date}">
				<li class="fieldcontain">
					<span id="date-label" class="property-label"><g:message code="session.date.label" default="Date" /></span>
					
						<span class="property-value" aria-labelledby="date-label"><g:formatDate date="${sessionInstance?.date}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${sessionInstance?.duration}">
				<li class="fieldcontain">
					<span id="duration-label" class="property-label"><g:message code="session.duration.label" default="Duration" /></span>
					
						<span class="property-value" aria-labelledby="duration-label"><g:fieldValue bean="${sessionInstance}" field="duration"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sessionInstance?.rdvBeforeStart}">
				<li class="fieldcontain">
					<span id="rdvBeforeStart-label" class="property-label"><g:message code="session.rdvBeforeStart.label" default="Rdv Before Start" /></span>
					
						<span class="property-value" aria-labelledby="rdvBeforeStart-label"><g:fieldValue bean="${sessionInstance}" field="rdvBeforeStart"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sessionInstance?.lockingTime}">
				<li class="fieldcontain">
					<span id="lockingTime-label" class="property-label"><g:message code="session.lockingTime.label" default="Locking Time" /></span>
					
						<span class="property-value" aria-labelledby="lockingTime-label"><g:fieldValue bean="${sessionInstance}" field="lockingTime"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sessionInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="session.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${sessionInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sessionInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="session.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${sessionInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sessionInstance?.playground}">
				<li class="fieldcontain">
					<span id="playground-label" class="property-label"><g:message code="session.playground.label" default="Playground" /></span>
					
						<span class="property-value" aria-labelledby="playground-label"><g:link controller="playground" action="show" id="${sessionInstance?.playground?.id}">${sessionInstance?.playground?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${sessionInstance?.type}">
				<li class="fieldcontain">
					<span id="type-label" class="property-label"><g:message code="session.type.label" default="Type" /></span>
					
						<span class="property-value" aria-labelledby="type-label"><g:link controller="gameType" action="show" id="${sessionInstance?.type?.id}">${sessionInstance?.type?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${sessionInstance?.group}">
				<li class="fieldcontain">
					<span id="group-label" class="property-label"><g:message code="session.group.label" default="Group" /></span>
					
						<span class="property-value" aria-labelledby="group-label"><g:link controller="sessionGroup" action="show" id="${sessionInstance?.group?.id}">${sessionInstance?.group?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${sessionInstance?.participations}">
				<li class="fieldcontain">
					<span id="participations-label" class="property-label"><g:message code="session.participations.label" default="Participations" /></span>
					
						<g:each in="${sessionInstance.participations}" var="p">
						<span class="property-value" aria-labelledby="participations-label"><g:link controller="participation" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${sessionInstance?.reminders}">
				<li class="fieldcontain">
					<span id="reminders-label" class="property-label"><g:message code="session.reminders.label" default="Reminders" /></span>
					
						<g:each in="${sessionInstance.reminders}" var="r">
						<span class="property-value" aria-labelledby="reminders-label"><g:link controller="reminder" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${sessionInstance?.rounds}">
				<li class="fieldcontain">
					<span id="rounds-label" class="property-label"><g:message code="session.rounds.label" default="Rounds" /></span>
					
						<g:each in="${sessionInstance.rounds}" var="r">
						<span class="property-value" aria-labelledby="rounds-label"><g:link controller="sessionRound" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${sessionInstance?.votes}">
				<li class="fieldcontain">
					<span id="votes-label" class="property-label"><g:message code="session.votes.label" default="Votes" /></span>
					
						<g:each in="${sessionInstance.votes}" var="v">
						<span class="property-value" aria-labelledby="votes-label"><g:link controller="vote" action="show" id="${v.id}">${v?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${sessionInstance?.comments}">
				<li class="fieldcontain">
					<span id="comments-label" class="property-label"><g:message code="session.comments.label" default="Comments" /></span>
					
						<g:each in="${sessionInstance.comments}" var="c">
						<span class="property-value" aria-labelledby="comments-label"><g:link controller="sessionComment" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${sessionInstance?.imageUrl}">
				<li class="fieldcontain">
					<span id="imageUrl-label" class="property-label"><g:message code="session.imageUrl.label" default="Image Url" /></span>
					
						<span class="property-value" aria-labelledby="imageUrl-label"><g:fieldValue bean="${sessionInstance}" field="imageUrl"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sessionInstance?.galleryUrl}">
				<li class="fieldcontain">
					<span id="galleryUrl-label" class="property-label"><g:message code="session.galleryUrl.label" default="Gallery Url" /></span>
					
						<span class="property-value" aria-labelledby="galleryUrl-label"><g:fieldValue bean="${sessionInstance}" field="galleryUrl"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sessionInstance?.creation}">
				<li class="fieldcontain">
					<span id="creation-label" class="property-label"><g:message code="session.creation.label" default="Creation" /></span>
					
						<span class="property-value" aria-labelledby="creation-label"><g:formatDate date="${sessionInstance?.creation}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${sessionInstance?.creator}">
				<li class="fieldcontain">
					<span id="creator-label" class="property-label"><g:message code="session.creator.label" default="Creator" /></span>
					
						<span class="property-value" aria-labelledby="creator-label"><g:link controller="user" action="show" id="${sessionInstance?.creator?.id}">${sessionInstance?.creator?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${sessionInstance?.extraFieldName}">
				<li class="fieldcontain">
					<span id="extraFieldName-label" class="property-label"><g:message code="session.extraFieldName.label" default="Extra Field Name" /></span>
					
						<span class="property-value" aria-labelledby="extraFieldName-label"><g:fieldValue bean="${sessionInstance}" field="extraFieldName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sessionInstance?.extraFieldValue}">
				<li class="fieldcontain">
					<span id="extraFieldValue-label" class="property-label"><g:message code="session.extraFieldValue.label" default="Extra Field Value" /></span>
					
						<span class="property-value" aria-labelledby="extraFieldValue-label"><g:fieldValue bean="${sessionInstance}" field="extraFieldValue"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sessionInstance?.compositions}">
				<li class="fieldcontain">
					<span id="compositions-label" class="property-label"><g:message code="session.compositions.label" default="Compositions" /></span>
					
						<g:each in="${sessionInstance.compositions}" var="c">
						<span class="property-value" aria-labelledby="compositions-label"><g:link controller="composition" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${sessionInstance?.lastUpdate}">
				<li class="fieldcontain">
					<span id="lastUpdate-label" class="property-label"><g:message code="session.lastUpdate.label" default="Last Update" /></span>
					
						<span class="property-value" aria-labelledby="lastUpdate-label"><g:formatDate date="${sessionInstance?.lastUpdate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${sessionInstance?.lastUpdater}">
				<li class="fieldcontain">
					<span id="lastUpdater-label" class="property-label"><g:message code="session.lastUpdater.label" default="Last Updater" /></span>
					
						<span class="property-value" aria-labelledby="lastUpdater-label"><g:link controller="user" action="show" id="${sessionInstance?.lastUpdater?.id}">${sessionInstance?.lastUpdater?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${sessionInstance?.canceled}">
				<li class="fieldcontain">
					<span id="canceled-label" class="property-label"><g:message code="session.canceled.label" default="Canceled" /></span>
					
						<span class="property-value" aria-labelledby="canceled-label"><g:formatBoolean boolean="${sessionInstance?.canceled}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${sessionInstance?.cancelationLog}">
				<li class="fieldcontain">
					<span id="cancelationLog-label" class="property-label"><g:message code="session.cancelationLog.label" default="Cancelation Log" /></span>
					
						<span class="property-value" aria-labelledby="cancelationLog-label"><g:fieldValue bean="${sessionInstance}" field="cancelationLog"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sessionInstance?.cancelationUser}">
				<li class="fieldcontain">
					<span id="cancelationUser-label" class="property-label"><g:message code="session.cancelationUser.label" default="Cancelation User" /></span>
					
						<span class="property-value" aria-labelledby="cancelationUser-label"><g:link controller="user" action="show" id="${sessionInstance?.cancelationUser?.id}">${sessionInstance?.cancelationUser?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${sessionInstance?.cancelationDate}">
				<li class="fieldcontain">
					<span id="cancelationDate-label" class="property-label"><g:message code="session.cancelationDate.label" default="Cancelation Date" /></span>
					
						<span class="property-value" aria-labelledby="cancelationDate-label"><g:formatDate date="${sessionInstance?.cancelationDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${sessionInstance?.carpoolProposals}">
				<li class="fieldcontain">
					<span id="carpoolProposals-label" class="property-label"><g:message code="session.carpoolProposals.label" default="Carpool Proposals" /></span>
					
						<g:each in="${sessionInstance.carpoolProposals}" var="c">
						<span class="property-value" aria-labelledby="carpoolProposals-label"><g:link controller="carpoolProposal" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${sessionInstance?.carpoolRequests}">
				<li class="fieldcontain">
					<span id="carpoolRequests-label" class="property-label"><g:message code="session.carpoolRequests.label" default="Carpool Requests" /></span>
					
						<g:each in="${sessionInstance.carpoolRequests}" var="c">
						<span class="property-value" aria-labelledby="carpoolRequests-label"><g:link controller="carpoolRequest" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${sessionInstance?.tasks}">
				<li class="fieldcontain">
					<span id="tasks-label" class="property-label"><g:message code="session.tasks.label" default="Tasks" /></span>
					
						<g:each in="${sessionInstance.tasks}" var="t">
						<span class="property-value" aria-labelledby="tasks-label"><g:link controller="task" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${sessionInstance?.watchers}">
				<li class="fieldcontain">
					<span id="watchers-label" class="property-label"><g:message code="session.watchers.label" default="Watchers" /></span>
					
						<g:each in="${sessionInstance.watchers}" var="w">
						<span class="property-value" aria-labelledby="watchers-label"><g:link controller="sessionWatcher" action="show" id="${w.id}">${w?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:sessionInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${sessionInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
