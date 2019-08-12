<div class="sessionZone">
	<g:if test="${sessionInstance.carpoolProposals.size() > 0 && sessionInstance.carpoolRequests.size() > 0}">
		<g:javascript>
			// On attend que tout le DOM soit complètement chargé afin que les éléments soient bien trouvables
			document.addEventListener("DOMContentLoaded", function(event) {
				//console.log("DOM fully loaded and parsed, adding restriction for composition drag and drop");
				initCarpoolRequestDragging();
				initApprovedCarpoolRequests(${approvedCarpoolRequestIds}, ${relatedCarpoolProposalIds}, ${relatedSeatIndexes}, ${relatedPickupTimes});
			});

			function initApprovedCarpoolRequests(approvedCarpoolRequestIds, relatedCarpoolProposalIds, relatedSeatIndex, relatedPickupTimes) {
			    var nextFreeSeatNbr = new Map()
			    for (var i = 0; i < approvedCarpoolRequestIds.length; i++) {
					var approvedCarpoolRequestId = approvedCarpoolRequestIds[i];
					var approvedCarpoolRequestElement = document.getElementById('carpoolRequestOf' + approvedCarpoolRequestId);
					var approvedCarpoolProposalId = relatedCarpoolProposalIds[i];
					var seatIndex = relatedSeatIndex[i];

					// Reset the approved request id into the form
					var proposalForm = document.forms['formOfCarpoolProposal' + approvedCarpoolProposalId];
					proposalForm['approvedRequestIds'].value = proposalForm['approvedRequestIds'].value + approvedCarpoolRequestId + ',';
					proposalForm['seatIndexes'].value = proposalForm['seatIndexes'].value + seatIndex + ',';

					// Determine a seat for that approved request
					if (nextFreeSeatNbr.get(approvedCarpoolProposalId)) {
					    nextFreeSeatNbr.set(approvedCarpoolProposalId, nextFreeSeatNbr.get(approvedCarpoolProposalId) + 1);
					} else {
					    nextFreeSeatNbr.set(approvedCarpoolProposalId, 1);
					}
					var seatNbr = nextFreeSeatNbr.get(approvedCarpoolProposalId);
					var seatElement = document.getElementById('dropZoneForProposal' + approvedCarpoolProposalId + 'Seat' + seatNbr);

					// Set the approved request position by moving it to its related seat
					var initialPosition = approvedCarpoolRequestElement.getBoundingClientRect();
					//console.log('position of carpool request ' + approvedCarpoolRequestId + ': ', initialPosition.top, initialPosition.right, initialPosition.bottom, initialPosition.left);
					var seatPosition = seatElement.getBoundingClientRect();
					//console.log('position of seat ' + seatNbr + ' of carpool approval ' + approvedCarpoolProposalId + ': ', seatPosition.top, seatPosition.right, seatPosition.bottom, seatPosition.left);
					moveCarpoolRequestElement(approvedCarpoolRequestElement, seatPosition.left - initialPosition.left + 9, seatPosition.top - initialPosition.top + 6)
					approvedCarpoolRequestElement.classList.remove('draggableCarpoolRequest');

					// Set the pickup time of the request inside the proposal form
					proposalForm['pickupTimeForProposal' + approvedCarpoolProposalId + 'Seat' + seatNbr].value = relatedPickupTimes[i];
				}
			}

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
				target.style.webkitTransform = target.style.transform = 'translate(' + x + 'px, ' + y + 'px)';
				target.setAttribute('data-x', x);
				target.setAttribute('data-y', y);
			}

			interact('.carpoolProposalDropZone').dropzone({
				accept: '.draggableCarpoolRequest',
				overlap: 1.0,
				ondropactivate: function (event) {
					event.target.classList.add('drop-active');
				},
				ondragenter: function (event) {
					var draggableElement = event.relatedTarget,
							dropzoneElement = event.target;
					dropzoneElement.classList.add('drop-target');
					draggableElement.classList.add('can-drop');
				},
				ondragleave: function (event) {
					event.target.classList.remove('drop-target');
					event.relatedTarget.classList.remove('can-drop');
				},
				ondrop: function (event) {
					var temp = event.target.id.substring('dropZoneForProposal'.length);
					var proposalId = temp.substring(0, temp.indexOf('Seat'))
					var seatIndex = event.target.id.substring(event.target.id.length - 1, event.target.id.length);
					var requestId = event.relatedTarget.id.substring('carpoolRequestOf'.length);
					var proposalForm = document.forms['formOfCarpoolProposal' + proposalId];
					// can be null if user drop on a non authorized proposal (button is not instancied)
					if (proposalForm == null) return
					proposalForm['approvedRequestIds'].value = proposalForm['approvedRequestIds'].value + requestId + ',';
					proposalForm['seatIndexes'].value = proposalForm['seatIndexes'].value + seatIndex + ',';
					//document.getElementById('updateButtonForProposal' + proposalId).style.display = "inline";;
				},
				ondropdeactivate: function (event) {
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
		<g:if test="${sessionInstance.date.getTime() > System.currentTimeMillis() || sessionInstance.carpoolProposals.size() > 0}">
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
							<g:message code="session.show.carpool.carpoolRequestsNbr" args="[sessionInstance.getNumberOfNonApprovedCarpoolRequest(), sessionInstance.carpoolRequests.size()]"/>:
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
								<g:form name="formOfCarpoolProposal${proposal.id}">
									<g:hiddenField name="id" value="${proposal.id}" />
									<g:hiddenField name="approvedRequestIds" value="" />
									<g:hiddenField name="seatIndexes" value="" />
									<table style="border: solid lightblue 2px; padding: 10px; border-radius: 5px;">
										<tr style="font-size: small">
											<td style="vertical-align: top; width: 250px;">
												<g:render template="/common/avatar" model="[player:proposal.driver]" />
												<g:message code="session.show.carpool.proposal.userXCanTakeY" args="[proposal.driver.username, proposal.freePlaceNbr]"/>
												<g:if test="${proposal.carDescription}">
													(${proposal.carDescription})
												</g:if>
											</td>
											<g:each in="${(1..proposal.freePlaceNbr).toList()}" var="i">
												<td style="text-align: center">
													<div id="dropZoneForProposal${proposal.id}Seat${i}" class="carpoolProposalDropZone">
														<g:message code="session.show.carpool.proposal.seatNbr" args="[i]"/>
													</div>
												</td>
											</g:each>
										</tr>
										<tr style="font-size: small;">
											<td style="padding-top: 0px;">
												<g:message code="session.show.carpool.request.pickupTime"/> :
											</td>
											<g:each in="${(1..proposal.freePlaceNbr).toList()}" var="i">
												<td style="text-align: center; padding: 0px;">
													<g:field name="pickupTimeForProposal${proposal.id}Seat${i}" placeholder="" style="width: 60px" />
												</td>
											</g:each>
										</tr>
										<tr>
											<td colspan="${1 + proposal.freePlaceNbr}">
												<g:if test="${sessionIsManagedByCurrentUser || proposal.driver == request.currentUser}">
													<div class="buttons" style="width: 100%">
														<g:actionSubmit class="save" id="updateButtonForProposal${proposal.id}" style="display: inline; text-align: right"
																		action="updateCarpoolProposal" value="${message(code:'update')}" />
														<g:actionSubmit class="create" action="cancelAllCarpoolAcceptances" value="${message(code:'session.show.carpool.proposal.seatCancel')}"
																		onclick="return confirm('${message(code:'session.show.carpool.proposal.areYouSureToReset')}')"/>
														<g:actionSubmit class="delete"  action="removeCarpoolProposal" value="${message(code:'delete')}"
																		onclick="return confirm('${message(code:'session.show.carpool.proposal.areYouSureToDelete')}')" />
													</div>
												</g:if>
											</td>
										</tr>
									</table>
								</g:form>
							</g:each>
						</g:if>
						<g:else>
							<g:message code="session.show.carpool.noCarpoolProposal"/>
						</g:else>
					</td>
					<td style="width: 50%">
						<g:if test="${sessionInstance.carpoolRequests.size() > 0}" >
							<g:message code="session.show.carpool.carpoolRequestsNbr"
									   args="[sessionInstance.getNumberOfNonApprovedCarpoolRequest(), sessionInstance.carpoolRequests.size()]"/> :
							<br>
							<br>
							<div class="carpoolRequestDropZone">
								<g:each in="${sessionInstance.carpoolRequests}" var="request">
									<div id="carpoolRequestOf${request.id}" class="draggableCarpoolRequest drag-drop"
										 style="border: solid lightsalmon 1px; padding: 5px; display: inline-block; width: 70px; height: 95px; text-align: center; line-height: 1.0; ">
										<img style="max-width:60px; max-height: 60px; vertical-align: middle; " src="${resource(dir:'images/user',file:request.enquirer.avatarName)}" alt="Player avatar" />
										<g:set var="username" value="${request.enquirer.username}" />
										<g:if test="${username.length() > 8}">
											<g:set var="username" value="${username.substring(0, 7)}.." />
										</g:if>
										<br>
										<span style="font-size: x-small; color: lightsalmon">${username}</span>
										<g:if test="${sessionIsManagedByCurrentUser || request.enquirer == request.currentUser}">
											<g:link action="removeCarpoolRequest" id="${request.id}"
													onclick="return confirm('${message(code:'session.show.carpool.request.areYouSureToDelete')}')" >
												<img src="${resource(dir:'images/skin',file:'database_delete.png')}" alt="Delete"  />
											</g:link>
										</g:if>
										<g:if test="${request.pickupLocation}">
											<br>
											<span style="font-size: xx-small; ">${request.pickupLocation}</span>
										</g:if>
									</div>
								</g:each>
							</div>
						</g:if>
						<g:else>
							<g:message code="session.show.carpool.noCarpoolRequest"/>
						</g:else>
					</td>
				</tr>
				<tr>
					<td style="text-align: left; border: solid darkgray 1px; width: auto; background-color: lightblue; text-align: center; padding: 10px">
						<shiro:notUser>
							<p><b><g:message code="session.show.carpool.proposal.needLogin" /></b></p>
						</shiro:notUser>
						<shiro:user>
						<b><g:message code="session.show.carpool.proposal.title" /></b>
						<br>
						<br>
						<g:form action="proposeCarpool">
							<g:hiddenField name="id" value="${sessionInstance.id}" />
							<g:message code="session.show.carpool.proposal.freePlaces.prefix" />
							<g:field name="freePlaceNbr" type="number" value="3" required="" size="2" min="1" max="9" style="width: 1.8em;" />
							<g:message code="session.show.carpool.proposal.freePlaces.suffix" />
							<br>
							<g:message code="session.show.carpool.proposal.carDescription" />
							<g:field name="carDescription" placeholder="ex: 307cc grise" required=""/>
							<!--
							<br>
							<g:message code="session.show.carpool.proposal.rdvDescription" />
							<g:field name="rdvDescription" placeholder="ex: Devant AirFrance à 11h55" required="" size="30"/>
							-->
							<br>
							<br>
							<g:actionSubmit class="save" action="addCarpoolProposal" value="${message(code:'session.show.carpool.proposal.validate')}"/>
						</g:form>
						</shiro:user>
					</td>
					<td style="text-align: left; border: solid darkgray 1px; width: auto; background-color: lightsalmon; text-align: center; padding: 10px">
						<shiro:notUser>
							<p><b><g:message code="session.show.carpool.request.needLogin" /></b></p>
						</shiro:notUser>
						<shiro:user>
						<g:form action="proposeCarpool">
							<g:hiddenField name="id" value="${sessionInstance.id}" />
							<b><g:message code="session.show.carpool.request.title" /></b>
							<br>
							<br>
							<g:message code="session.show.carpool.request.pickupLocation" />
							<g:field name="pickupLocation" placeholder="ex: Devant le portail d'Air France" required="" maxlength="30"/>
							<!--
							<br>
							<g:message code="session.show.carpool.request.pickupTimeRange" />
							<g:field name="pickupTime" placeholder="ex: 11h50-12h00" required=""/>
							-->
							<br>
							<br>
							<g:actionSubmit class="save" action="addCarpoolRequest" value="${message(code:'session.show.carpool.request.validate')}" />
						</g:form>
						</shiro:user>
					</td>
				</tr>
			</table>
		</div>
	</div>
</div>
