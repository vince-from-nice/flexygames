<%@ page import="flexygames.CarpoolRequest" %>



<div class="fieldcontain ${hasErrors(bean: carpoolRequestInstance, field: 'enquirer', 'error')} required">
	<label for="enquirer">
		<g:message code="carpoolRequest.enquirer.label" default="Enquirer" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="enquirer" name="enquirer.id" from="${flexygames.User.list()}" optionKey="id" required="" value="${carpoolRequestInstance?.enquirer?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: carpoolRequestInstance, field: 'driver', 'error')} ">
	<label for="driver">
		<g:message code="carpoolRequest.driver.label" default="Driver" />
		
	</label>
	<g:select id="driver" name="driver.id" from="${flexygames.CarpoolProposal.list()}" optionKey="id" value="${carpoolRequestInstance?.driver?.id}" class="many-to-one" noSelection="['null': '']"/>

</div>

<div class="fieldcontain ${hasErrors(bean: carpoolRequestInstance, field: 'session', 'error')} required">
	<label for="session">
		<g:message code="carpoolRequest.session.label" default="Session" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="session" name="session.id" from="${flexygames.Session.list()}" optionKey="id" required="" value="${carpoolRequestInstance?.session?.id}" class="many-to-one"/>

</div>

