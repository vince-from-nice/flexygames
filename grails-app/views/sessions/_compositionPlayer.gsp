										
										<div id="compo-${compositionId}-player-${playerId}" class="draggableCompoPlayer" style="width: 60px; " >
												<g:if test="${avatarId > 0}">
													<img style="width: 45px; height: 45px;" src="${createLink(controller:'fileUploader', action:'show', id:avatarId)}" alt="User avatar"  />
												</g:if> 
												<g:else>
													<img style="width:45px; vertical-align: middle;" src="${resource(dir:'images/user',file:'no_avatar.jpg')}" alt="Anonymous avatar" />
												</g:else> 
												<g:set var="username" value="${playerUsername}" />
												<g:if test="${username.length() > 8}">
													<g:set var="username" value="${playerUsername.substring(0, 7)}.." />
												</g:if>
												<span style="font-size: x-small; vertical-align: top">${username}</span>
										</div>
										<g:javascript>moveCompositionPlayerElement(document.getElementById('compo-${compositionId}-player-${playerId}'), ${x}, ${y});</g:javascript>
										