<table style="border: 0px">
    <tbody>
    <tr class="prop">
        <td valign="top" class="name"><g:message code="username" default="Username" /></td>
        <td valign="top" class="value">${fieldValue(bean: playerInstance, field: "username")}</td>
    </tr>
    <tr class="prop">
        <td valign="top" class="name"><g:message code="firstName" default="First Name" /></td>
        <td valign="top" class="value">${fieldValue(bean: playerInstance, field: "firstName")}</td>
    </tr>
    <tr class="prop">
        <td valign="top" class="name"><g:message code="lastName" default="Last Name" /></td>
        <td valign="top" class="value">${fieldValue(bean: playerInstance, field: "lastName")}</td>
    </tr>
    <tr class="prop">
        <td valign="top" class="name"><g:message code="email" default="Email" /></td>
        <td valign="top" class="value">${fieldValue(bean: playerInstance, field: "email")}</td>
    </tr>
    <tr class="prop">
        <td valign="top" class="name"><g:message code="phoneNumber" default="Phone Number" /></td>
        <td valign="top" class="value">${fieldValue(bean: playerInstance, field: "phoneNumber")}</td>
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
        <td valign="top" class="name"><g:message code="birthYear" default="Birth Year" /></td>
        <td valign="top" class="value">${playerInstance?.yearBirthDate}</td>
    </tr>
    <tr class="prop">
        <td valign="top" class="name"><g:message code="registrationDate" default="Registration Date" /></td>
        <td valign="top" class="value"><g:formatDate date="${playerInstance?.registrationDate}" format="yyyy-MM-dd" /></td>
    </tr>
    </tbody>
</table>