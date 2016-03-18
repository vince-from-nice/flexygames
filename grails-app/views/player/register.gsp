<%@ page import="flexygames.User"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<g:render template="/common/layout" />
<g:set var="entityName" value="${message(code: 'player.label', default: 'Player')}" />
</head>
<body>
    <div class="body">
        <h1><g:message code="register.title" default="Register" /></h1>
        <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
        </g:if>
        <g:hasErrors bean="${user}">
            <div class="errors">
                <g:renderErrors bean="${user}" as="list" />
            </div>
        </g:hasErrors>
        <g:form method="post">
            <g:hiddenField name="id" value="${user?.id}" />
            <g:hiddenField name="version" value="${user?.version}" />
            <div class="dialog">
                <table>
                    <tbody>
                        <tr class="prop">
                            <td valign="top" class="name">
                            	<nobr><label for="username">
                            		<g:message code="username" default="Username" />
                            		<font color="red">*</font>
                            		</label>
                            	</nobr>
                            </td>
                            <td valign="top" class="value ${hasErrors(bean: user, field: 'username', 'errors')}">
                            	<g:textField name="username" value="${user?.username}" />
                            </td>
                        	<td>
                        		<g:message code="register.username.desc"/>
                        	</td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name">
                            	<nobr>
	                            	<label for="passwordHash">
		                            	<g:message code="password" default="Password" /> 
		                            	<font color="red">*</font>
	                            	</label>
                            	</nobr>
							</td>
                            <td valign="top" class="">
                            	<g:passwordField name="password" value="" />
                            	<br />
                            	<g:passwordField name="passwordBis" value="" />
                            </td>
                        	<td>
                        		<g:message code="register.password.desc"/>
                        	</td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name">
                            	<nobr>
                            		<label for="email">
                            			<g:message code="player.email.label" default="Email" /> 
                            			<font color="red">*</font>
                            		</label>
                            	</nobr>
                            </td>
                            <td valign="top" class="value ${hasErrors(bean: user, field: 'email', 'errors')}">
                            	<g:textField name="email" value="${user?.email}" />
                            	<br />
                            	<g:textField name="emailBis" value="${user?.email}" />
                            </td>
                        	<td>
                        		<g:message code="register.email.desc"/>
                        	</td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name">
                            	<nobr>
                            		<label for="firstname">
                            		<g:message code="firstName" default="Firstname" />
                            		</label>
                            	</nobr>
                            </td>
                            <td valign="top" class="value ${hasErrors(bean: user, field: 'firstName', 'errors')}">
                            	<g:textField name="firstname" value="${user?.firstName}" />
                            </td>
                        	<td>
                        		<g:message code="register.firstname.desc"/>
                        	</td>
                        </tr>
                        <tr>
                        	<td>
                        		<nobr><g:message code="team"/> <font color="red">*</font></nobr>
                        	</td>
                        	<td>
                        		<g:select name="teamId" from="${flexygames.Team.list(sort:'name', order:'asc')}" optionKey="id" />
                        	</td>
                        	<td>
                        		<g:message code="register.team.desc"/>
                        	</td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="buttons">
            	<script type="text/javascript">
            	function checkForm(){
            		if(document.getElementById('email').value != document.getElementById('emailBis').value){
            			alert("Please enter the same email address twice !");
            			return false;
            		}
            		if(document.getElementById('password').value != document.getElementById('passwordBis').value){
            			alert("Please enter the same password twice !");
            			return false;
            		}
            	}
            	</script>
                <span class="button">
                    <g:actionSubmit onclick="return checkForm()" class="create" action="save"  value="${message(code:'register')}" /> 
                </span>
            </div>
        </g:form>
    </div>
</body>
</html>
