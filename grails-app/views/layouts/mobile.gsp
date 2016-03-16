<!doctype html>

<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->

	<head>
		<title><g:layoutTitle default="FlexyGames"/></title>
		
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

		<!--  Avoid HTTP caching from clients (and proxies) -->
		<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
		<meta http-equiv="Pragma" content="no-cache" />
		<meta http-equiv="Expires" content="0" />
		
		<link rel="shortcut icon" href="${resource(dir: 'images', file: 'flexygames_logo.32x32.png')}" type="image/png">
		<link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'flexygames_logo.32x32.png')}">
		<link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'flexygames_logo.114x114.png')}">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'main-20160208.css')}">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'mobile-20160208.css')}">
		<link rel="stylesheet" href="${resource(dir:'css',file:'flexygames-20160303.css')}" />
		
		<g:layoutHead/>

		<g:javascript library="application"/>
		<g:javascript library="flexygames" />

		<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
		<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
		<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>

		%{--<r:require modules="jquery-mobile"/>--}%
		<r:layoutResources />
	</head>

	<body onload="${pageProperty(name:'body.onload')}; ">
		<div data-role="page">
			<div data-role="header" style="background-color: white">
				<table style="width: 100%; margin: 0px; padding: 0px">
					<tr>
						<td style="width: 80%; text-align: left; vertical-align: middle">
							<a href="${createLink(controller:'site', action:'home')}">
								%{--<img src="${resource(dir:'images',file:'flexygames_logo.114x114.png')}" alt="Grails" border="0" />--}%
								<img src="${resource(dir:'images',file:'flexygames_header.png')}" alt="Grails" border="0" />
							</a>
						</td>
						<td style="text-align: left">
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
								<g:link controller="site" action="login">
									<g:message code="logbox.login" />
								</g:link>
							</shiro:notUser>
						</td>
					</tr>
				</table>
			</div>
			<div data-role="content">
				<g:layoutBody />
			</div>
			<div data-role="footer">
				<g:render template="/layouts/footer" />
			</div>
		</div>
	</body>

</html>
