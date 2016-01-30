
		<g:link controller="player" action="show" id="${player.id}">
			<g:set var="maxHeight" value="auto" />
			<g:if test="${!width}">
				<g:set var="width" value="40px" />
				<g:set var="maxHeight" value="40px" />
			</g:if>
			<g:if test="${player.avatar}">
				<g:if test="${player.avatarPath}">
					<img style="width: ${width}; max-width: 200px;  max-height: ${maxHeight};" src="${createLink(controller:'sessions', action:'showAvatar', id:player.avatarPath)}" alt="User avatar"  />
				</g:if>
				<g:else>
					<img style="width: ${width}; max-width: 200px;  max-height: ${maxHeight};" src="${createLink(controller:'fileUploader', action:'show', id:player.avatar.id)}" alt="User avatar"  />
				</g:else>
			</g:if> 
			<g:else>
				<img style="width: ${width}; vertical-align: middle;" src="${resource(dir:'images/user',file:'no_avatar.jpg')}" alt="Anonymous avatar" />
			</g:else> 
		</g:link> 