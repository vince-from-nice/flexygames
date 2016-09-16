
		<g:link controller="player" action="show" id="${player.id}">
			<g:if test="${!width}">
				<g:set var="maxWidth" value="40px" />
				<g:set var="maxHeight" value="40px" />
			</g:if>
			<g:else>
				<g:set var="maxWidth" value="${width}" />
				<g:set var="maxHeight" value="auto" />
			</g:else>
			<img style="maxWidth: ${maxWidth}; vertical-align: middle; max-width: 200px;  max-height: ${maxHeight};" src="${resource(dir:'images/user',file:player.avatarName)}" alt="User avatar" />
		</g:link>