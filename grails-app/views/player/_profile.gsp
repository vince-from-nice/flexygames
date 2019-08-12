
<div class="dialog">
	<table>
		<tbody>
			<tr class="prop">
				<td valign="top" class="name"><g:message code="firstName" default="First Name" /></td>
				<td valign="top" class="value">${fieldValue(bean: playerInstance, field: "firstName")}</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name"><g:message code="lastName" default="Last Name" /></td>
				<td valign="top" class="value">${fieldValue(bean: playerInstance, field: "lastName")}</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name"><g:message code="company" default="Company" /></td>
				<td valign="top" class="value">${fieldValue(bean: playerInstance, field: "company")}</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name"><g:message code="city" default="City" /></td>
				<td valign="top" class="value">${fieldValue(bean: playerInstance, field: "city")}</td>
			</tr>
			<tr class="prop">
				<td valign="top" class="name"><g:message code="birthYear" default="Year Date" /></td>
				<td valign="top" class="value">${playerInstance?.yearBirthDate}</td>
			</tr>
			<g:if test="${playerInstance.isManagedBy(request.currentUser?.username)}" >
				<tr class="prop">
					<td valign="top" class="name"><g:message code="email" default="Email" /></td>
					<td valign="top" class="value"><a href="mailto:${playerInstance.email}">${fieldValue(bean: playerInstance, field: "email")}</a></td>
				</tr>
			</g:if>
		</tbody>
	</table>
</div>