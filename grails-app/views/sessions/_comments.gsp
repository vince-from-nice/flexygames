<h2><g:message code="session.show.comments" /></h2>
<g:set var="now" value="${java.lang.System.currentTimeMillis()}" />
<g:if test="${session.currentUser != null}">
	<g:form action="watch" name="watchForm">
			<g:hiddenField name="id" value="${sessionInstance.id}" />
			<g:checkBox name="watch" value="${true}" checked="${session.currentUser.isWatchingSession(sessionInstance) }" 
				onclick="document.getElementById('watchForm').submit();" />
			<g:message code="session.show.comments.checkToWatch" />
		</g:form>
</g:if>
<br />
<shiro:notUser>
	<p><b><g:message code="session.show.comments.needLogin" /></b></p>
</shiro:notUser>
<shiro:user>
	<div style="text-align: left;">
		<g:form action="sessions">
			<g:hiddenField name="id" value="${sessionInstance.id}" />
			<g:textArea name="comment" value="" rows="4" cols="140" style="width: 600px; height: 100px" />
			<br />
			<g:actionSubmit class="save" action="post" value="${message(code:'session.show.comments.postComment')}" />
		</g:form>
	</div>
</shiro:user>
<br />
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
					${c.text}
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

