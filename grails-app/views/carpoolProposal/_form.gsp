<%@ page import="flexygames.CarpoolProposal" %>



<div class="fieldcontain ${hasErrors(bean: carpoolProposalInstance, field: 'driver', 'error')} required">
	<label for="driver">
		<g:message code="carpoolProposal.driver.label" default="Driver" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="driver" name="driver.id" from="${flexygames.User.list()}" optionKey="id" required="" value="${carpoolProposalInstance?.driver?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: carpoolProposalInstance, field: 'freePlaceNbr', 'error')} required">
	<label for="freePlaceNbr">
		<g:message code="carpoolProposal.freePlaceNbr.label" default="Free Place Nbr" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="freePlaceNbr" type="number" min="1" max="9" value="${carpoolProposalInstance.freePlaceNbr}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: carpoolProposalInstance, field: 'carDescription', 'error')} required">
	<label for="carDescription">
		<g:message code="carpoolProposal.carDescription.label" default="Car Description" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="carDescription" maxlength="100" required="" value="${carpoolProposalInstance?.carDescription}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: carpoolProposalInstance, field: 'rdvDescription', 'error')} required">
	<label for="rdvDescription">
		<g:message code="carpoolProposal.rdvDescription.label" default="Rdv Description" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="rdvDescription" maxlength="100" required="" value="${carpoolProposalInstance?.rdvDescription}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: carpoolProposalInstance, field: 'approvedRequests', 'error')} ">
	<label for="approvedRequests">
		<g:message code="carpoolProposal.approvedRequests.label" default="Approved Requests" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${carpoolProposalInstance?.approvedRequests?}" var="a">
    <li><g:link controller="carpoolRequest" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="carpoolRequest" action="create" params="['carpoolProposal.id': carpoolProposalInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'carpoolRequest.label', default: 'CarpoolRequest')])}</g:link>
</li>
</ul>


</div>

<div class="fieldcontain ${hasErrors(bean: carpoolProposalInstance, field: 'session', 'error')} required">
	<label for="session">
		<g:message code="carpoolProposal.session.label" default="Session" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="session" name="session.id" from="${flexygames.Session.list()}" optionKey="id" required="" value="${carpoolProposalInstance?.session?.id}" class="many-to-one"/>

</div>

