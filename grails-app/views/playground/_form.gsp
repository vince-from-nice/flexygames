<%@ page import="flexygames.Playground" %>



<div class="fieldcontain ${hasErrors(bean: playgroundInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="playground.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${playgroundInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: playgroundInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="playground.description.label" default="Description" />
		
	</label>
	<g:textField name="description" maxlength="100" value="${playgroundInstance?.description}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: playgroundInstance, field: 'street', 'error')} ">
	<label for="street">
		<g:message code="playground.street.label" default="Street" />
		
	</label>
	<g:textField name="street" value="${playgroundInstance?.street}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: playgroundInstance, field: 'zip', 'error')} ">
	<label for="zip">
		<g:message code="playground.zip.label" default="Zip" />
		
	</label>
	<g:textField name="zip" value="${playgroundInstance?.zip}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: playgroundInstance, field: 'city', 'error')} ">
	<label for="city">
		<g:message code="playground.city.label" default="City" />
		
	</label>
	<g:textField name="city" value="${playgroundInstance?.city}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: playgroundInstance, field: 'country', 'error')} ">
	<label for="country">
		<g:message code="playground.country.label" default="Country" />
		
	</label>
	<g:textField name="country" value="${playgroundInstance?.country}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: playgroundInstance, field: 'latitude', 'error')} required">
	<label for="latitude">
		<g:message code="playground.latitude.label" default="Latitude" />
		<span class="required-indicator">*</span>
	</label>
	<!--g:field type="number" step="0.000001" name="latitude" required="" value="${fieldValue(bean: playgroundInstance, field: 'latitude')}"/-->
	<g:textField name="latitude" value="${fieldValue(bean: playgroundInstance, field: 'latitude')}" />
</div>

<div class="fieldcontain ${hasErrors(bean: playgroundInstance, field: 'longitude', 'error')} required">
	<label for="longitude">
		<g:message code="playground.longitude.label" default="Longitude" />
		<span class="required-indicator">*</span>
	</label>
	<!--g:field type="number" step="0.000001" name="longitude" required="" value="${fieldValue(bean: playgroundInstance, field: 'longitude')}"/-->
	<g:textField name="longitude" value="${fieldValue(bean: playgroundInstance, field: 'longitude')}" />
</div>

<div class="fieldcontain ${hasErrors(bean: playgroundInstance, field: 'phoneNumber', 'error')} ">
	<label for="phoneNumber">
		<g:message code="playground.phoneNumber.label" default="Phone Number" />
		
	</label>
	<g:textField name="phoneNumber" value="${playgroundInstance?.phoneNumber}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: playgroundInstance, field: 'websiteUrl', 'error')} ">
	<label for="websiteUrl">
		<g:message code="playground.websiteUrl.label" default="Website Url" />
		
	</label>
	<g:field type="url" name="websiteUrl" value="${playgroundInstance?.websiteUrl}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: playgroundInstance, field: 'gmapsUrl', 'error')} ">
	<label for="gmapsUrl">
		<g:message code="playground.gmapsUrl.label" default="Gmaps Url" />
		
	</label>
	<g:field type="url" name="gmapsUrl" value="${playgroundInstance?.gmapsUrl}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: playgroundInstance, field: 'flexymapUrl', 'error')} ">
	<label for="flexymapUrl">
		<g:message code="playground.flexymapUrl.label" default="Flexymap Url" />
		
	</label>
	<g:field type="url" name="flexymapUrl" value="${playgroundInstance?.flexymapUrl}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: playgroundInstance, field: 'forecastType', 'error')} ">
	<label for="forecastType">
		<g:message code="playground.forecastType.label" default="Forecast Type" />
		
	</label>
	<g:textField name="forecastType" value="${playgroundInstance?.forecastType}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: playgroundInstance, field: 'forecastToken', 'error')} ">
	<label for="forecastToken">
		<g:message code="playground.forecastToken.label" default="Forecast Token" />
		
	</label>
	<g:textField name="forecastToken" value="${playgroundInstance?.forecastToken}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: playgroundInstance, field: 'sessionGroups', 'error')} ">
	<label for="sessionGroups">
		<g:message code="playground.sessionGroups.label" default="Session Groups" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${playgroundInstance?.sessionGroups?}" var="s">
    <li><g:link controller="sessionGroup" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="sessionGroup" action="create" params="['playground.id': playgroundInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'sessionGroup.label', default: 'SessionGroup')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: playgroundInstance, field: 'sessions', 'error')} ">
	<label for="sessions">
		<g:message code="playground.sessions.label" default="Sessions" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${playgroundInstance?.sessions?}" var="s">
    <li><g:link controller="session" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="session" action="create" params="['playground.id': playgroundInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'session.label', default: 'Session')])}</g:link>
</li>
</ul>

</div>

