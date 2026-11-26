<div class="sessionZone">
	<div class="sessionZoneHeader" onclick="toggleDisplay('commentsSummaryZone'); toggleDisplay('commentsDetailedZone'); return false">
		<h2 style="vertical-align: top; display: inline;">
			<g:message code="session.show.comments" />
		</h2>
		<span style="float:right; font-size: small;"><g:message code="clickForShowOrHideDetails" /></span>
	</div>
	<div class="sessionZoneContent">
		<g:if test="${request.currentUser != null}">
			<g:form action="watch" name="watchForm" class="watch-row">
				<g:hiddenField name="id" value="${sessionInstance.id}" />
				<label class="check-row">
					<g:checkBox name="watch" value="${true}" checked="${request.currentUser.isWatchingSession(sessionInstance)}"
						onclick="document.getElementById('watchForm').submit();" />
					<g:message code="session.show.comments.checkToWatch" />
				</label>
			</g:form>
		</g:if>
		<shiro:notUser>
			<p class="muted"><g:message code="session.show.comments.needLogin" /></p>
		</shiro:notUser>
		<shiro:user>
			<g:form action="sessions" class="comment-form">
				<g:hiddenField name="id" value="${sessionInstance.id}" />
				<g:textArea name="comment" value="" rows="4" aria-label="${message(code: 'session.show.comments.postComment')}" />
				<g:actionSubmit class="save" action="post" value="${message(code:'session.show.comments.postComment')}" />
			</g:form>
		</shiro:user>
		<g:set var="defaultDisplayForSummaryZone" value="block" />
		<g:set var="defaultDisplayForDetailedZone" value="none" />
		<g:if test="${sessionInstance.comments.size() > 0}">
			<g:set var="defaultDisplayForSummaryZone" value="none" />
			<g:set var="defaultDisplayForDetailedZone" value="block" />
		</g:if>
		<div id="commentsSummaryZone" style="display: ${defaultDisplayForSummaryZone};">
			<g:if test="${sessionInstance.comments.size() > 0}">
				<g:message code="session.show.comments.commentsNbr"/> : <strong>${sessionInstance.comments.size()}</strong>
			</g:if>
			<g:else>
				<span class="muted"><g:message code="session.show.comments.noComment"/></span>
			</g:else>
		</div>
		<div id="commentsDetailedZone" style="display: ${defaultDisplayForDetailedZone};">
			<g:if test="${sessionInstance.comments.size() > 0}">
				<ol class="comment-list">
					<g:each var="c" in="${sessionInstance.comments}">
						<li class="comment" id="comment${c.id}">
							<div class="avatar-cell"><g:render template="/common/avatar" model="[player: c.user]" /></div>
							<div class="comment-body">
								<p class="comment-meta">
									<g:link controller="player" action="show" id="${c.user.id}" class="player-name">${c.user}</g:link>
									<span class="muted"><g:message code="session.show.comments.hasPosted" /> <flexy:humanDate date="${c.date.time}" /></span>
								</p>
								<div class="comment-text">${c.enhancedText}</div>
							</div>
						</li>
					</g:each>
				</ol>
			</g:if>
			<g:else>
				<p class="muted"><g:message code="session.show.comments.noComment" /></p>
			</g:else>
		</div>
	</div>
</div>
