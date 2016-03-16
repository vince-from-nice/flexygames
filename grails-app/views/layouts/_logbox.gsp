<div class="block">
	<shiro:user>
		<h3>
			<g:message code="logbox.welcome" /> <shiro:principal />
		</h3>
		<ul>
			<li class="">
				<g:link controller="myself" action="mySessions">
					<g:message code="logbox.mySessions" />
				</g:link>
			</li>
			<li class="">
				<g:link controller="myself" action="myStats">
					<g:message code="logbox.myStats" />
				</g:link>
			</li>
			<li class="">
				<g:link controller="myself" action="myAccount">
					<g:message code="logbox.myAccount" />
				</g:link>
			</li>
			<li class="">
				<g:link controller="auth" action="signOut">
					<g:message code="logbox.logout" />
				</g:link>
			</li>
		</ul>
	</shiro:user>
	<shiro:notUser>
		<h3>
			<g:message code="logbox.title" />
		</h3>
		<g:form controller="auth" action="signIn" method="post" style="margin: 0px;">
			<table style="border: 0px; margin: 0px; padding: 0px">
				<tr>
					<td style="font-size: 12px; vertical-align: middle; padding-left: 5px">
						<g:message code="logbox.login" /></td>
					<td><input size="8" type='text' name='username' />
					<br></td>
				</tr>
				<tr>
					<td style="font-size: 12px; vertical-align: middle; padding-left: 5px">
						<g:message code="logbox.password" />
					</td>
					<td>
						<input size="8" type='password' name='password' />
					</td>
				</tr>
		        <tr>
		          <td colspan="2" style="font-size: 12px; vertical-align: middle">
		          	<g:message code="logbox.rememberMe" />
		          	<g:checkBox name="rememberMe" value="${rememberMe}" />
		          </td>
		        </tr>
				<tr>
					<td colspan="2" style="text-align: center;">
						<input type="submit" name="submitButton" value=" Login " style="margin-top: 0px; margin-bottom: 0px;" />
						<br>
						<br>
						<g:link controller="player" action="remindPassword" style="font-size: 12px">
							<g:message code="logbox.remindPassword" />
						</g:link>
						<br>
						<g:link controller="player" action="register" style="font-size: 12px">
							<g:message code="logbox.newAccount" />
						</g:link>
					</td>
				</tr>
			</table>
		</g:form>
	</shiro:notUser>
</div>

