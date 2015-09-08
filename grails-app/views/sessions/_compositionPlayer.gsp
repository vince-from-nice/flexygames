										
										<div id="compo-player-${playerId}" class="draggableCompoPlayer" >
												<g:if test="${avatarId > 0}">
													<img style="width: 40px; max-height: 40px;" src="${createLink(controller:'fileUploader', action:'show', id:avatarId)}" alt="User avatar"  />
												</g:if> 
												<g:else>
													<img style="width:40px; vertical-align: middle;" src="${resource(dir:'images/user',file:'no_avatar.jpg')}" alt="Anonymous avatar" />
												</g:else> 
												<g:set var="username" value="${playerUsername}" />
												<g:if test="${username.length() > 8}">
													<g:set var="username" value="${playerUsername.substring(0, 7)}.." />
												</g:if>
												<span style="font-size: x-small; vertical-align: top">${username}</span>
										</div>
										<g:javascript>moveCompositionPlayerElement(document.getElementById('compo-player-${playerId}'), ${x}, ${y});</g:javascript>
										