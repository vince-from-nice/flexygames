<g:set var="now" value="${java.lang.System.currentTimeMillis()}" />
<div class="sessionZone">
	<div class="sessionZoneHeader" onclick="toggleDisplay('compositionsSummaryZone'); toggleDisplay('compositionsDetailedZone'); return false">
		<h2 style="vertical-align: top; display: inline;">
			<g:message code="session.show.compositions" />
		</h2>
		<span style="float:right; font-size: small;"><g:message code="clickForDetails" /></span>
	</div>
	<div class="sessionZoneContent">
		<div id="compositionsSummaryZone" style="display: block;">
			<g:if test="${sessionInstance.compositions.size() > 0}" >
				<g:message code="session.show.compositions.compositionsNbr"/> : <b>${sessionInstance.compositions.size()}</b>
			</g:if>
			<g:else>
				<g:message code="session.show.compositions.noComposition"/>
			</g:else>
		</div>
		<div id="compositionsDetailedZone" style="display: none;">
			<g:if test="${sessionInstance.compositions.size() > 0}" >
				
			</g:if>
			<g:else>
				<i>Work in progress...</i>
			</g:else>
		</div>
	</div>
</div>