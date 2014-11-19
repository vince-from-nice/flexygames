<%@ page import="flexygames.Participation" %>



<div class="fieldcontain ${hasErrors(bean: participationInstance, field: 'player', 'error')} required">
	<label for="player">
		<g:message code="participation.player.label" default="Player" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="player" name="player.id" from="${flexygames.User.list()}" optionKey="id" required="" value="${participationInstance?.player?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: participationInstance, field: 'session', 'error')} required">
	<label for="session">
		<g:message code="participation.session.label" default="Session" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="session" name="session.id" from="${flexygames.Session.list()}" optionKey="id" required="" value="${participationInstance?.session?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: participationInstance, field: 'statusCode', 'error')} ">
	<label for="statusCode">
		<g:message code="participation.statusCode.label" default="Status Code" />
		
	</label>
	<g:select name="statusCode" from="${participationInstance.constraints.statusCode.inList}" value="${participationInstance?.statusCode}" valueMessagePrefix="participation.statusCode" noSelection="['': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: participationInstance, field: 'userLog', 'error')} ">
	<label for="userLog">
		<g:message code="participation.userLog.label" default="User Log" />
		
	</label>
	<g:textField name="userLog" maxlength="100" value="${participationInstance?.userLog}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: participationInstance, field: 'lastUpdate', 'error')} ">
	<label for="lastUpdate">
		<g:message code="participation.lastUpdate.label" default="Last Update" />
		
	</label>
	<g:datePicker name="lastUpdate" precision="day"  value="${participationInstance?.lastUpdate}" default="none" noSelection="['': '']" />
</div>

<div class="fieldcontain ${hasErrors(bean: participationInstance, field: 'lastUpdater', 'error')} ">
	<label for="lastUpdater">
		<g:message code="participation.lastUpdater.label" default="Last Updater" />
		
	</label>
	<g:textField name="lastUpdater" value="${participationInstance?.lastUpdater}"/>
</div>

