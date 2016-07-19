<div class="sessionZone">
	<div class="sessionZoneHeader" onclick="toggleDisplay('commentsSummaryZone'); toggleDisplay('commentsDetailedZone'); return false">
		<h2 style="vertical-align: top; display: inline;">
			<g:message code="session.show.comments" />
		</h2>
		<span style="float:right; font-size: small;"><g:message code="clickForShowOrHideDetails" /></span>
	</div>
	<div class="sessionZoneContent">
		<shiro:notUser>
			<p><b><g:message code="session.show.comments.needLogin" /></b></p>
		</shiro:notUser>
		<shiro:user>
			<div style="text-align: left;">
				<g:form action="sessions">
					<g:hiddenField name="id" value="${sessionInstance.id}" />
					<g:textArea name="comment" value="" rows="10" data-autogrow="false" />
					<g:actionSubmit class="save" action="post" value="${message(code:'session.show.comments.postComment')}" />
				</g:form>
			</div>
		</shiro:user>
		<br />
		<g:if test="${session.currentUser != null}">
			<g:form action="watch" name="watchForm">
				<g:hiddenField name="id" value="${sessionInstance.id}" />
				<g:checkBox name="watch" value="${true}" checked="${session.currentUser.isWatchingSession(sessionInstance) }"
							onclick="document.getElementById('watchForm').submit();" />
				<div style="position: relative; left: 40px; top: -15px"><g:message code="session.show.comments.checkToWatch" /></div>
			</g:form>
		</g:if>
		<br />
		<g:set var="defaultDisplayForSummaryZone" value="block" />
		<g:set var="defaultDisplayForDetailedZone" value="none" />
		<g:if test="${sessionInstance.comments.size() > 0}">
			<g:set var="defaultDisplayForSummaryZone" value="none" />
			<g:set var="defaultDisplayForDetailedZone" value="block" />
		</g:if>
		<div id="commentsSummaryZone" style="display: ${defaultDisplayForSummaryZone};">
			<g:if test="${sessionInstance.comments.size() > 0}" >
				<g:message code="session.show.comments.commentsNbr"/> : <b>${sessionInstance.comments.size()}</b>
			</g:if>
			<g:else>
				<g:message code="session.show.comments.noComment"/>
			</g:else>
		</div>
		<div id="commentsDetailedZone" style="display: ${defaultDisplayForDetailedZone};">
				<g:if test="${sessionInstance.comments.size() > 0}">
					<g:each var="c" in="${sessionInstance.comments}">
						<table style="width: auto;">
							<tr>
								<td>
									<a id="comment${c.id}"></a>
									<g:render template="/common/avatar" model="[player:c.user]" />
								</td>
								<td>
									<g:link controller="player" action="show" id="${c.user.id}"><i>${c.user}</i></g:link>
									<i> <g:message code="session.show.comments.hasPosted" /> <flexy:humanDate date="${c.date.time}" />:</i><br />
									<br />
									${c.enhancedText}
								</td>
								<!--td style="text-align: right; vertical-align: bottom;">
									<div class="buttons">
									<input type="button" class="edit" onclick="toggleDisplay('comment${c.id}EditDiv')" value="${message(code:'edit')}" />
									</div>
								</td-->
							</tr>
						</table>
						<br />
					</g:each>
				</g:if>
				<g:else>
					<i><g:message code="session.show.comments.noComment" /></i><br />
				</g:else>
		</div>
	</div>
</div>
