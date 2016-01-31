
		<g:link controller="player" action="show" id="${player.id}">
			<g:set var="maxHeight" value="auto" />
			<g:if test="${!width}">
				<g:set var="width" value="40px" />
				<g:set var="maxHeight" value="40px" />
			</g:if>
			<img style="width: ${width}; vertical-align: middle; max-width: 200px;  max-height: ${maxHeight};" src="${resource(dir:'images/user',file:player.avatarName)}" alt="User avatar" />
		</g:link>