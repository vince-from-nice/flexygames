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

<div class="fieldcontain ${hasErrors(bean: carpoolRequestInstance, field: 'pickupLocation', 'error')} required">
	<label for="pickupLocation">
		<g:message code="carpoolRequest.pickupLocation.label" default="Pickup Location" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="pickupLocation" maxlength="100" required="" value="${carpoolRequestInstance?.pickupLocation}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: carpoolRequestInstance, field: 'pickupTimeRange', 'error')} ">
	<label for="pickupTimeRange">
		<g:message code="carpoolRequest.pickupTimeRange.label" default="Pickup Time Range" />
		
	</label>
	<g:textField name="pickupTimeRange" maxlength="20" value="${carpoolRequestInstance?.pickupTimeRange}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: carpoolRequestInstance, field: 'pickupTime', 'error')} ">
	<label for="pickupTime">
		<g:message code="carpoolRequest.pickupTime.label" default="Pickup Time" />
		
	</label>
	<g:textField name="pickupTime" maxlength="10" value="${carpoolRequestInstance?.pickupTime}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: carpoolRequestInstance, field: 'session', 'error')} required">
	<label for="session">
		<g:message code="carpoolRequest.session.label" default="Session" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="session" name="session.id" from="${flexygames.Session.list()}" optionKey="id" required="" value="${carpoolRequestInstance?.session?.id}" class="many-to-one"/>

</div>

