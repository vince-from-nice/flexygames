<g:set var="now" value="${java.lang.System.currentTimeMillis()}" />
<div class="sessionZone">
	<div class="sessionZoneHeader" onclick="toggleDisplay('compositionsSummaryZone'); toggleDisplay('compositionsDetailedZone'); return false">
		<h2 style="vertical-align: top; display: inline;">
			<g:message code="session.show.compositions" />
		</h2>
		<span style="float: right; font-size: small;"><g:message code="clickForDetails" /></span>
	</div>
	<div class="sessionZoneContent">
		<g:set var="defaultDisplayForSummaryZone" value="block" />
		<g:set var="defaultDisplayForDetailedZone" value="none" />
		<g:if test="${sessionInstance.comments.size() > 0}">
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
		<div id="compositionsDetailedZone" style="display: ${defaultDisplayForDetailedZone};">
			<g:if test="${sessionInstance.compositions.size() > 0}">
				<g:javascript>
// On attend que tout le DOM soit complètement chargé pour que les éléments compo-#id soient bien trouvables
/*document.addEventListener("DOMContentLoaded", function(event) {
    console.log("DOM fully loaded and parsed, adding restriction for composition drag and drop");
	initDragging();
});*/

function editComposition(compositionId) {
	initDragging(compositionId);
	toggleTableDisplay('edit-zone-for-compo-' + compositionId);
	var compoDescription = document.getElementById('description-for-compo-' + compositionId);
	compoDescription.removeAttribute('readonly');
}

function saveComposition(compositionId) {
	var compoForm = document.forms["form-for-composition-" + compositionId];
	//var compoForm = document.getElementById('form-for-composition-' + compositionId);
	//var compoDescription = document.getElementById('description-for-compo-' + compositionId);
	//compoDescription.setAttribute('readonly', 'readonly');
	compoForm["description"].setAttribute('readonly', 'readonly');
	toggleTableDisplay('edit-zone-for-compo-' + compositionId);
	var eligiblePlayers = document.querySelectorAll('[id^=compo-player-]');
	var eligiblePlayer, x = 0, y = 0, playerId = 0, xInput, yInput;
	for (var i = 0; i < eligiblePlayers.length; i++) {
		eligiblePlayer = eligiblePlayers[i];
    	x = (parseFloat(eligiblePlayer.getAttribute('data-x')) || 0);
    	y = (parseFloat(eligiblePlayer.getAttribute('data-y')) || 0);
    	playerId = eligiblePlayer.id.substring('compo-player-'.length);
    	//compoForm['compo-player-' + playerId + '-x'].value = x;
    	//compoForm['compo-player-' + playerId + '-y'].value = y;
		xInput = document.createElement('compo-player-' + playerId + '-x');
    	xInput.type = 'hidden';
    	xInput.name = 'compo-player-' + playerId + '-x';
    	xInput.value = x;
    	compoForm.appendChild(xInput);
		yInput = document.createElement('compo-player-' + playerId + '-y');
    	yInput.type = 'hidden';
    	yInput.name = 'compo-player-' + playerId + '-y';
    	yInput.value = y;
    	compoForm.appendChild(yInput);
    	//alert('player#' + i + ' id= ' + playerId + ' coords:' + x + ' ' + y);
    }
    compoForm.submit();
}

function initDragging(compositionId) {
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
	    onmove: dragMoveListener,
	    onend: function (event) {
	      var textEl = event.target.querySelector('p');
	      /*textEl && (textEl.textContent =
	        'moved a distance of '
	        + (Math.sqrt(event.dx * event.dx +
	                     event.dy * event.dy)|0) + 'px');*/
	    }
	  });
}

function dragMoveListener (event) {
  var target = event.target,
  x = (parseFloat(target.getAttribute('data-x')) || 0) + event.dx,
  y = (parseFloat(target.getAttribute('data-y')) || 0) + event.dy;

  target.style.webkitTransform =
  target.style.transform =
    'translate(' + x + 'px, ' + y + 'px)';

  target.setAttribute('data-x', x);
  target.setAttribute('data-y', y);
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
				</g:javascript>
				<center>
				<g:each in="${sessionInstance.compositions}" var="composition">
					<form name="form-for-composition-${composition.id}" method="post" action="../../manager/index">
					<!--g:form name="form-for-composition-${composition.id}" controller="manager"-->
						<g:hiddenField name="id" value="${composition.id}" />
						<g:hiddenField name="_action_updateComposition" value="save" />
						<table style="max-width: 600px; padding: 0px; margin: 0px;">
							<tr>
								<td>
									<g:textField name="description" id="description-for-compo-${composition.id}" maxlength="100" readonly="readonly" value="${composition.description}" style="width: 90%;" />
								</td>
								<td><b><g:message code="session.show.compositions.bench" /></b>:</td>
							</tr>
							<tr id="compo-${composition.id}" class="compoDropZone" >
								<td style="width: 400px;" >
									<img src="${resource(dir: 'images/composition',file: sessionInstance.type.name + 'Background.png')}" alt="Playground Background">
								</td>
								<td style="width: x; text-align: right; display: inline;">
									<g:each in="${sessionInstance.getParticipantsEligibleForComposition()}" var="player">
										<div id="compo-player-${player.id}" class="draggableCompoPlayer">
											<p>
												<g:if test="${player.avatar}">
													<img style="width: 30px; max-height: 30px;" src="${createLink(controller:'fileUploader', action:'show', id:player.avatar.id)}" alt="User avatar"  />
												</g:if> 
												<g:else>
													<img style="width:30px; vertical-align: middle;" src="${resource(dir:'images/user',file:'no_avatar.jpg')}" alt="Anonymous avatar" />
												</g:else> 
												<br />
												<span style="font-size: x-small; vertical-align: top">${player.username}</span>
											</p>
										</div>
									</g:each>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<g:message code="session.show.compositions.lastUpdateBy" 
									args="[composition.lastUpdater, grailsApplication.mainContext.getBean('flexygames.FlexyTagLib').formatDate(composition.lastUpdate.time, true)]"/>
								</td>
							</tr>
							<tr id="edit-zone-for-compo-${composition.id}" style="display: none; border: solid red 2px;">
								<td colspan="2">
									<g:message code="session.show.compositions.editMode"/>
									<g:actionSubmit class="edit" action="updateComposition" value="${message(code:'save')}" onclick="saveComposition(${composition.id}); return false; " />
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<g:if test="${sessionInstance.isManagedBy(org.apache.shiro.SecurityUtils.subject.principal)}">
										<div class="buttons">
											<input id="edit-button-for-compo-${composition.id}" type="button" class="edit" onclick="editComposition(${composition.id})" value="${message(code:'edit')}" />
											<g:actionSubmit class="create" action="duplicateComposition" value="${message(code:'duplicate')}" />
											<g:actionSubmit class="delete" action="deleteComposition" value="${message(code:'delete')}" />
										</div>
									</g:if>
								</td>
							</tr>
						</table>
					</form>
				</g:each>
				</center>
			</g:if>
			<g:else>
				<br />
				<i><g:message code="session.show.compositions.noComposition"/></i>
				<br />
				<br />
			</g:else>
			<g:if test="${sessionInstance.isManagedBy(org.apache.shiro.SecurityUtils.subject.principal)}">
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