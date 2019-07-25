<div class="sessionZone">
	<div class="sessionZoneHeader" onclick="toggleDisplay('compositionsSummaryZone'); toggleDisplay('compositionsDetailedZone'); return false">
		<h2 style="vertical-align: top; display: inline;">
			<g:message code="session.show.compositions" />
		</h2>
		<span style="float: right; font-size: small;"><g:message code="clickForShowOrHideDetails" /></span>
	</div>
	<div class="sessionZoneContent">
		<g:set var="defaultDisplayForSummaryZone" value="block" />
		<g:set var="defaultDisplayForDetailedZone" value="none" />
		<g:if test="${sessionInstance.compositions.size() > 0}">
			<g:set var="defaultDisplayForSummaryZone" value="none" />
			<g:set var="defaultDisplayForDetailedZone" value="block" />
		</g:if>
		<div id="compositionsSummaryZone" style="display: ${defaultDisplayForSummaryZone};">
			<g:if test="${sessionInstance.compositions.size() > 0}">
				<g:message code="session.show.compositions.compositionsNbr" /> : <b> ${sessionInstance.compositions.size()}
				</b>
			</g:if>
			<g:else>
				<g:message code="session.show.compositions.noComposition" />
			</g:else>
		</div>
		<div id="compositionsDetailedZone" style="display: ${defaultDisplayForDetailedZone}; ">
			<g:if test="${sessionInstance.compositions.size() > 0}">
				<g:javascript>
// On attend que tout le DOM soit complètement chargé afin que les éléments soient bien trouvables
document.addEventListener("DOMContentLoaded", function(event) {
    //console.log("DOM fully loaded and parsed, adding restriction for composition drag and drop");
	//initCompositionDragging();
	//translateCompositionPlayers();
});

function initCompositionDragging(compositionId) {
	interact('.draggableCompoPlayer')
	  .draggable({
	    inertia: true,
	    restrict: {
	      endOnly: true,
	      elementRect: { top: 0, left: 0, bottom: 1, right: 1 },
	      //restriction: "parent",
	      //restriction: ".compoDropZone",
	      restriction: '#compo-' + compositionId,
	      //restriction: document.getElementById('compo-148928'),
	      //restriction: document.getElementsByClassName("compoDropZone"),
	    },	
	    onmove: compositionPlayerDragMoveListener,
	    onend: function (event) {
	      var textEl = event.target.querySelector('p');
	      /*textEl && (textEl.textContent = 'moved a distance of ' + (Math.sqrt(event.dx * event.dx + event.dy * event.dy)|0) + 'px');*/
	    }
	  });
}

interact('.compoDropZone').dropzone({
  overlap: 0.75,
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
  },
  ondropdeactivate: function (event) {
    // remove active dropzone feedback
    event.target.classList.remove('drop-active');
    event.target.classList.remove('drop-target');
  }
});

function editComposition(compositionId) {
	initCompositionDragging(compositionId);
	toggleTableDisplay('edit-zone-for-compo-' + compositionId);
	//var compoDescription = document.getElementById('description-for-compo-' + compositionId);
	//compoDescription.removeAttribute('readonly');
	var compoForm = document.forms["form-for-composition-" + compositionId];
	compoForm["description"].removeAttribute('readonly');
}

function saveComposition(compositionId) {
	var compoForm = document.forms["form-for-composition-" + compositionId];
	//var compoDescription = document.getElementById('description-for-compo-' + compositionId);
	//compoDescription.setAttribute('readonly', 'readonly');
	compoForm["description"].setAttribute('readonly', 'readonly');
	toggleTableDisplay('edit-zone-for-compo-' + compositionId);
	var idPattern = 'compo-' + compositionId + '-player';
	var eligiblePlayers = document.querySelectorAll('[id^=' + idPattern + ']');
	var eligiblePlayer, x = 0, y = 0, playerId = 0, xInput, yInput, ids;
	var data = '{"compositionId": ' + compositionId + ', "players": [';
	for (var i = 0; i < eligiblePlayers.length; i++) {
		eligiblePlayer = eligiblePlayers[i];
    	x = (parseFloat(eligiblePlayer.getAttribute('data-x')) || 0);
    	y = (parseFloat(eligiblePlayer.getAttribute('data-y')) || 0);
    	//ids = eligiblePlayer.id.substring('compo-player-'.length);
    	//playerId = ids.substring(ids.indexOf('-') + 1);
    	playerId = eligiblePlayer.id.substring(idPattern.length + 1);
    	//compoForm['compo-player-' + playerId + '-x'].value = x;0000
    	//compoForm['compo-player-' + playerId + '-y'].value = y;
    	data += '{"id": '+ playerId + ', "x": ' + x + ', "y": ' + y + '}';
    	if (i < eligiblePlayers.length - 1) {
    		data += ', ';
    	}
    	//alert('player#' + i + ' id= ' + playerId + ' coords:' + x + ' ' + y);
    }
    data += ']}';
    compoForm['data'].value = data;
    compoForm.submit();
}

function compositionPlayerDragMoveListener(event, x, y) {
	moveCompositionPlayerElement(event.target, event.dx, event.dy);
}

function moveCompositionPlayerElement(target, x, y) {
  var x = (parseFloat(target.getAttribute('data-x')) || 0) + x;
  var y = (parseFloat(target.getAttribute('data-y')) || 0) + y;
  target.style.webkitTransform =
  target.style.transform =
    'translate(' + x + 'px, ' + y + 'px)';  
  target.setAttribute('data-x', x);
  target.setAttribute('data-y', y);  
  //console.log('Player has been translated of [' + x + ', ' + y + ']');
}

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
				<center>
				<table style="width: 400px; padding: 0px; margin: 0px; border: 0px; ">
					<tr>
					<g:each in="${sessionInstance.compositions}" var="composition">
						<td style="width: 400px; padding: 20px; margin: 0px; text-align: center; ">
							<!--form name="form-for-composition-${composition.id}" method="post" action="../../manager/index"-->
							<g:form name="form-for-composition-${composition.id}" controller="manager">
								<g:hiddenField name="id" value="${composition.id}" />
								<g:hiddenField name="data" value="[]" />
								<!--g:hiddenField name="_action_updateComposition" value="save" /-->
								<table style="width: 400px; padding: 20px; margin: 0px; ">
									<tr>
										<td style="width: 400px; padding: 10px; margin: 0px; text-align: center; ">
											<g:textField name="description" style="width: 90%;"  maxlength="100" readonly="readonly" value="${composition.description}" />
										</td>
									</tr>
									<tr>
										<td class="compoDropZone" style="width: 400px; padding: 0px; margin: 0px; ">
											<table id="compo-${composition.id}" style="width: 400px; padding: 0px; margin: 0px; border: 0px; ">
												<tr>
													<td style="width: 400px; height: 540px; padding: 0px; margin: 0px; " background="${resource(dir: 'images/composition',file: sessionInstance.type.name + 'Background.png')}"> </td>
												</tr>
												<tr>
													<td style="width: 400px; padding: 0px; margin: 0px; text-align: center; background-color: #EFEFEF">
														<h3><g:message code="session.show.compositions.bench" /> :</h3>
														<div >
															<g:each in="${composition.allPlayersIncludingEligibleNotYetPresent}" var="item">
																<div id="compo-${composition.id}-player-${item.player.id}" class="draggableCompoPlayer" style="width: 60px; " >
																	<img style="max-width:45px; max-height: 45px; vertical-align: middle; " src="${resource(dir:'images/user',file:item.player.avatarName)}" alt="Player avatar" />
																	<g:set var="username" value="${item.player.username}" />
																	<g:if test="${username.length() > 8}">
																	      <g:set var="username" value="${username.substring(0, 7)}.." />
																	</g:if>
																	<span style="font-size: x-small; vertical-align: top">${username}</span>
																</div>
																<g:javascript>moveCompositionPlayerElement(document.getElementById('compo-${composition.id}-player-${item.player.id}'), ${item.x}, ${item.y});</g:javascript>
															</g:each>
														</div>														
													</td>
												</tr>
											</table>
											<g:javascript>
// Try to recalculate table dimensions (for the bench TD) but nothing is working for now :(
var el = document.getElementById('compo-${composition.id}');

el.style.display='none';
el.offsetHeight; // no need to store this anywhere, the reference is enough
el.style.display='table';

el.style.cssText += ';-webkit-transform:rotateZ(0deg)';
el.offsetHeight;
el.style.cssText += ';-webkit-transform:none';

forceRedraw(el);
											</g:javascript>
										</td>
									</tr>
									<tr>
										<td style="font-size: small; text-align: center">
											<g:message code="session.show.compositions.lastUpdateBy" 
											args="[composition.lastUpdater, grailsApplication.mainContext.getBean('flexygames.FlexyTagLib').formatDate(composition.lastUpdate.time, true)]"/>
										</td>
									</tr>
									<tr id="edit-zone-for-compo-${composition.id}" style="display: none; border: solid red 2px;">
										<td>
											<g:message code="session.show.compositions.editMode"/>
											<g:actionSubmit class="edit" action="updateComposition" value="${message(code:'save')}" onclick="saveComposition(${composition.id}); return true; " />
										</td>
									</tr>
									<tr>
										<td style="padding: 0px; margin: 0px; ">
											<g:if test="${sessionIsManagedByCurrentUser}">
												<div class="buttons" style="margin: 5px; ">
													<input id="edit-button-for-compo-${composition.id}" type="button" class="edit" onclick="editComposition(${composition.id})" value="${message(code:'edit')}" />
													<g:actionSubmit class="create" action="duplicateComposition" value="${message(code:'duplicate')}" onclick="alert('Sorry, not yet implemented'); return false; " />
													<g:actionSubmit class="delete" action="deleteComposition" value="${message(code:'delete')}" onclick="return confirm('${message(code:'management.compositions.areYouSureToDelete')}')" />
												</div>
											</g:if>
										</td>
									</tr>
								</table>
							</g:form>
						</td>
					</g:each>
				</tr>
			</table>
			</center>
			</g:if>
			<g:else>
				<br />
				<i><g:message code="session.show.compositions.noComposition"/></i>
				<br />
				<br />
			</g:else>
			<g:if test="${sessionIsManagedByCurrentUser}">
				<tr>
					<td>
						<g:form controller="manager">
							<g:hiddenField name="id" value="${sessionInstance?.id}" />
							<div class="buttons">
								<g:actionSubmit class="create" action="addComposition" value="${message(code:'management.compositions.addNewCompositions')}" />
							</div>
						</g:form>
					</td>
				</tr>
			</g:if>

		</div>
	</div>
</div>