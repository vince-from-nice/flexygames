<div class="sessionZone">
	<g:if test="${sessionInstance.carpoolProposals.size() > 0 && sessionInstance.carpoolRequests.size() > 0}">
		<g:javascript>
			// On attend que tout le DOM soit complètement chargé afin que les éléments soient bien trouvables
			document.addEventListener("DOMContentLoaded", function(event) {
				//console.log("DOM fully loaded and parsed, adding restriction for composition drag and drop");
				initCarpoolRequestDragging();
				//translateCompositionPlayers();
			});

			function initCarpoolRequestDragging() {
				interact('.draggableCarpoolRequest')
						.draggable({
					inertia: true,
					restrict: {
						endOnly: true,
						elementRect: { top: 0, left: 0, bottom: 1, right: 1 },
						restriction: '#carpoolZone',
					},
					onmove: carpoolRequestDragMoveListener,
					onend: function (event) {
						//var textEl = event.target.querySelector('p');
					}
				});
			}

			function carpoolRequestDragMoveListener(event, x, y) {
				moveCarpoolRequestElement(event.target, event.dx, event.dy);
			}

			function moveCarpoolRequestElement(target, x, y) {
				var x = (parseFloat(target.getAttribute('data-x')) || 0) + x;
				var y = (parseFloat(target.getAttribute('data-y')) || 0) + y;
				target.style.webkitTransform =
						target.style.transform =
								'translate(' + x + 'px, ' + y + 'px)';
				target.setAttribute('data-x', x);
				target.setAttribute('data-y', y);
				//console.log('CarpoolRequest has been translated of [' + x + ', ' + y + ']');
			}

			interact('.carpoolDropZone').dropzone({
				// only accept elements matching this CSS selector
				accept: '.draggableCarpoolRequest',
				overlap: 1.0,
				ondropactivate: function (event) {
					// add active dropzone feedback
					event.target.classList.add('drop-active');
				},
				ondragenter: function (event) {
					var draggableElement = event.relatedTarget,
							dropzoneElement = event.target;
					// feedback the possibility of a drop
					dropzoneElement.classList.add('drop-target');
					draggableElement.classList.add('can-drop');
					//draggableElement.textContent = 'Dragged in';
				},
				ondragleave: function (event) {
					// remove the drop feedback style
					event.target.classList.remove('drop-target');
					event.relatedTarget.classList.remove('can-drop');
					//event.relatedTarget.textContent = 'Dragged out';
				},
				ondrop: function (event) {
					//event.relatedTarget.textContent = 'Dropped';
					var proposalId = event.target.id.substring('dropZoneForProposal'.length);
					proposalId = proposalId.substring(0, proposalId.indexOf('Seat'))
					var requestId = event.relatedTarget.id.substring('carpoolRequestOf'.length);
					var proposalForm = document.forms['formOfCarpoolProposal' + proposalId];
					var approvedRequestIds = proposalForm['approvedRequestIds'].value + requestId + ',';
					proposalForm['approvedRequestIds'].value = approvedRequestIds;
					//alert(event.target.id + ' ' + event.relatedTarget.id + ' ' + approvedRequestIds);
					document.getElementById('updateButtonForProposal' + proposalId).style.display = "inline";;
				},
				ondropdeactivate: function (event) {
					// remove active dropzone feedback
					event.target.classList.remove('drop-active');
					event.target.classList.remove('drop-target');
				}
			});

			// http://stackoverflow.com/questions/8840580/force-dom-redraw-refresh-on-chrome-mac
			var forceRedraw = function(element){
				if (!element) { return; }
				var n = document.createTextNode(' ');
				var disp = element.style.display;  // don't worry about previous display style
				element.appendChild(n);
				element.style.display = 'none';
				setTimeout(function(){
					element.style.display = disp;
					n.parentNode.removeChild(n);
				},20); // you can play with this timeout to make it as short as possible
			}
		</g:javascript>
	</g:if>
	<div class="sessionZoneHeader" onclick="toggleDisplay('carpoolSummaryZone'); toggleDisplay('carpoolDetailedZone'); return false">
		<h2 style="vertical-align: top; display: inline;">
			<g:message code="session.show.carpool" />
		</h2>
		<span style="float:right; font-size: small;"><g:message code="clickForShowOrHideDetails" /></span>
	</div>
	<div class="sessionZoneContent">
		<g:set var="defaultDisplayForSummaryZone" value="block" />
		<g:set var="defaultDisplayForDetailedZone" value="none" />
		<g:if test="${sessionInstance.comments.size() > 0}">
			<g:set var="defaultDisplayForSummaryZone" value="none" />
			<g:set var="defaultDisplayForDetailedZone" value="block" />
		</g:if>
		<div id="carpoolSummaryZone" style="display: ${defaultDisplayForSummaryZone};">
			<table style="width: 100%; border: 0px; margin: 0px;" >
				<tr>
					<td style="width: 50%">
						<g:if test="${sessionInstance.carpoolProposals.size() > 0}" >
							<g:message code="session.show.carpool.carpoolProposalsNbr" args="[sessionInstance.carpoolProposals.size()]"/>:
							<g:each in="${sessionInstance.carpoolProposals}" var="proposal">
								<g:link controller="players">
									${proposal.driver.username}
								</g:link>
							</g:each>
						</g:if>
						<g:else>
							<g:message code="session.show.carpool.noCarpoolProposal"/>
						</g:else>
					</td>
					<td style="width: 50%">
						<g:if test="${sessionInstance.carpoolRequests.size() > 0}" >
							<g:message code="session.show.carpool.carpoolRequestsNbr" args="[sessionInstance.carpoolRequests.size()]"/>:
							<g:each in="${sessionInstance.carpoolRequests}" var="request">
								<g:link controller="players">
									${request.enquirer.username}
								</g:link>
							</g:each>
						</g:if>
						<g:else>
							<g:message code="session.show.carpool.noCarpoolRequest"/>
						</g:else>
					</td>
				</tr>
			</table>
		</div>
		<div id="carpoolDetailedZone" style="display: ${defaultDisplayForDetailedZone};">
			<table style="width: 100%; border: 0px; margin: 0px;" >
				<tr>
					<td style="width: 50%">
						<g:if test="${sessionInstance.carpoolProposals.size() > 0}" >
							<g:message code="session.show.carpool.carpoolProposalsNbr" args="[sessionInstance.carpoolProposals.size()]"/> :
							<br>
							<br>
							<g:each in="${sessionInstance.carpoolProposals}" var="proposal">
								<div style="border: solid lightblue 1px; padding: 10px;">
									<g:render template="/common/avatar" model="[player:proposal.driver]" />
									<g:message code="session.show.carpool.proposal.userXCanTakeY" args="[proposal.driver.username, proposal.freePlaceNbr]"/>:
									<g:each in="${(1..proposal.freePlaceNbr).toList()}" var="i">
										<div id="dropZoneForProposal${proposal.id}Seat${i}" class="carpoolDropZone"
											 style="border: lightskyblue dashed 1px; width: 70px; height: 90px; display: inline-block; text-align: center;">
											<g:message code="session.show.carpool.proposal.seatNbr" args="[i]"/>
											<br>
										</div>&nbsp;
									</g:each>
									<g:if test="${proposal.rdvDescription}">
										<br>
										<g:message code="session.show.carpool.proposal.rdvDescription"/>:
										<b>${proposal.rdvDescription}</b>
									</g:if>
									<g:if test="${proposal.carDescription}">
										<br>
										<g:message code="session.show.carpool.proposal.carDescription"/>:
										<b>${proposal.carDescription}</b>
									</g:if>
								</div>
								<g:if test="${sessionIsManagedByCurrentUser || proposal.driver == session.currentUser}">
									<g:form name="formOfCarpoolProposal${proposal.id}">
										<g:hiddenField name="id" value="${proposal.id}" />
										<g:hiddenField name="approvedRequestIds" value="" />
										<div class="buttons">
											<g:actionSubmit class="save" id="updateButtonForProposal${proposal.id}" style="display: none"
															action="updateCarpoolProposal" value="${message(code:'update')}" />
											<g:actionSubmit class="delete"  action="removeCarpoolProposal" value="${message(code:'delete')}" />
										</div>
									</g:form>
								</g:if>
								<br>
							</g:each>
						</g:if>
						<g:else>
							<g:message code="session.show.carpool.noCarpoolProposal"/>
						</g:else>
					</td>
					<td style="width: 50%">
						<g:if test="${sessionInstance.carpoolRequests.size() > 0}" >
							<g:message code="session.show.carpool.carpoolRequestsNbr" args="[sessionInstance.carpoolRequests.size()]"/> :
							<br>
							<br>
							<g:each in="${sessionInstance.carpoolRequests}" var="request">
								<div id="carpoolRequestOf${request.id}" class="draggableCarpoolRequest drag-drop"
									 style="border: solid lightsalmon 1px; padding: 5px; display: inline-block;">
									<img style="max-width:45px; max-height: 45px; vertical-align: middle; " src="${resource(dir:'images/user',file:request.enquirer.avatarName)}" alt="Player avatar" />
									<br>
									<g:set var="username" value="${request.enquirer.username}" />
									<g:if test="${username.length() > 8}">
										<g:set var="username" value="${username.substring(0, 7)}.." />
									</g:if>
									<span style="font-size: x-small; vertical-align: top">${username}</span>
									<g:if test="${sessionIsManagedByCurrentUser || request.enquirer == session.currentUser}">
										<g:link action="removeCarpoolRequest" id="${request.id}" >
											<img src="${resource(dir:'images/skin',file:'database_delete.png')}" alt="Delete"  />
										</g:link>
									</g:if>
								</div>
							</g:each>
						</g:if>
						<g:else>
							<g:message code="session.show.carpool.noCarpoolRequest"/>
						</g:else>
					</td>
				</tr>
				<tr>
					<td>
						<shiro:notUser>
							<p><b><g:message code="session.show.carpool.proposal.needLogin" /></b></p>
						</shiro:notUser>
						<shiro:user>
							<div style="text-align: left; border: solid darkgray 1px; width: auto; background-color: lightblue; text-align: center; padding: 10px">
								<b><g:message code="session.show.carpool.proposal.title" /></b>
								<br>
								<br>
								<g:form action="proposeCarpool">
									<g:hiddenField name="id" value="${sessionInstance.id}" />
									<g:message code="session.show.carpool.proposal.freePlaces.prefix" />
									<g:field name="freePlaceNbr" type="number" value="3" required="" size="2" style="width: 2em;" />
									<g:message code="session.show.carpool.proposal.freePlaces.suffix" />
									<br>
									<g:message code="session.show.carpool.proposal.carDescription" />
									<g:field name="carDescription" value="Lada vert bouteille" required=""/>
									<br>
									<g:message code="session.show.carpool.proposal.rdvDescription" />
									<g:field name="rdvDescription" value="Parking du LIDL à 23h" required="" size="30"/>
									<br>
									<br>
									<g:actionSubmit class="save" action="addCarpoolProposal" value="${message(code:'session.show.carpool.proposal.validate')}"/>
								</g:form>
							</div>
						</shiro:user>
					</td>
					<td>
						<shiro:notUser>
							<p><b><g:message code="session.show.carpool.request.needLogin" /></b></p>
						</shiro:notUser>
						<shiro:user>
							<div style="text-align: left; border: solid darkgray 1px; width: auto; background-color: lightsalmon; text-align: center; padding: 10px">
								<b><g:message code="session.show.carpool.request.title" /></b>
								<br>
								<g:form action="proposeCarpool">
									<g:hiddenField name="id" value="${sessionInstance.id}" />
									<br>
									<g:actionSubmit class="save" action="addCarpoolRequest" value="${message(code:'session.show.carpool.request.validate')}" />
								</g:form>
							</div>
						</shiro:user>
					</td>
				</tr>
			</table>
		</div>
	</div>
</div>
