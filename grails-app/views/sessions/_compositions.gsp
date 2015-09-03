<g:set var="now" value="${java.lang.System.currentTimeMillis()}" />
<div class="sessionZone">
	<div class="sessionZoneHeader" onclick="toggleDisplay('compositionsSummaryZone'); toggleDisplay('compositionsDetailedZone'); return false">
		<h2 style="vertical-align: top; display: inline;">
			<g:message code="session.show.compositions" />
		</h2>
		<span style="float: right; font-size: small;"><g:message code="clickForDetails" /></span>
	</div>
	<div class="sessionZoneContent">
		<div id="compositionsSummaryZone" style="display: block;">
			<g:if test="${sessionInstance.compositions.size() > 0}">
				<g:message code="session.show.compositions.compositionsNbr" /> : <b> ${sessionInstance.compositions.size()}
				</b>
			</g:if>
			<g:else>
				<g:message code="session.show.compositions.noComposition" />
			</g:else>
		</div>
		<div id="compositionsDetailedZone" style="display: none;">
			<g:if test="${sessionInstance.compositions.size() > 0}">
				<g:each in="${sessionInstance.rounds}" var="round">
					<g:if test="${sessionInstance.isManagedBy(org.apache.shiro.SecurityUtils.subject.principal)}">

						<div>
							<g:form controller="manager">
								<g:hiddenField name="id" value="${composition.id}" />
								<div class="buttons">
									<input type="button" class="edit" onclick="toggleDisplay('composition${index}EditDiv')" value="${message(code:'edit')}" />
									<g:actionSubmit class="create" action="duplicateComposition" value="${message(code:'duplicate')}" />
									<g:actionSubmit class="delete" action="deleteComposition" value="${message(code:'delete')}" />
								</div>
							</g:form>
						</div>

					</g:if>
				</g:each>
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
						<g:if test="${sessionInstance.date.time > System.currentTimeMillis() }">
							<h2>
								<g:message code="session.show.compositions" />
							</h2>
						</g:if>
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